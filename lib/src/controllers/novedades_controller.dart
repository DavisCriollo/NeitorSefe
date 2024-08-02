import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/models/crea_fotos_detalle_novedad.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class ActividadesController extends ChangeNotifier {
  GlobalKey<FormState> actividadesFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  stt.SpeechToText? _speech;
  stt.SpeechToText? get getSpeech => _speech;

  ActividadesController() {
    _speech = stt.SpeechToText();
    checkGPSStatus();
  }

  bool validateForm() {
    if (actividadesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  int? opcionMulta;

  int? get getOpcionMulta => opcionMulta;
  void setOpcionMulta(int? value) {
    opcionMulta = value;
    notifyListeners();
  }

  //====== CAMPO BUSQUEDAS NOMINA =========//
  //===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
  //===================BOTON SEARCH MORE CLIENTE==========================//

  bool _btnSearchMore = false;
  bool get btnSearchMore => _btnSearchMore;

  void setBtnSearchMore(bool action) {
    _btnSearchMore = action;
    notifyListeners();
  }

  //  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchCompras;

  @override
  void dispose() {
    _deboucerSearchCompras?.cancel();
    super.dispose();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
  }
  //===================LEE CODIGO QR==========================//

  String? _infoQR = '';
  String? get getInfoQR => _infoQR;

  void setInfoQR(String? value) {
    _infoQR = value;
    // print('INFO QR ==========> : $_infoQR ');
    notifyListeners();
  }
  //===================SELECCIONAMOS EL LA OBCION DE LA MULTA==========================//

  String _textoMulta = '';

  var _itemMulta;
  get getItemMulta => _itemMulta;
  get getTextoMulta => _textoMulta;
  void setItenMulta(value, text) {
    _itemMulta = value;
    _textoMulta = text;
    notifyListeners();
  }
  //===================CONTROLAMOS EL BOTON DE ESCRIBIR MEDIANTE LA VOZ==========================//

  double _confidence = 1.0;
  double get getconfidenceg => _confidence;

  void setConfidence(double value) {
    _confidence = value;
    notifyListeners();
  }

  bool _isListening = false;
  bool get getIsListenig => _isListening;

  void setIsListenig(bool value) {
    _isListening = value;
    notifyListeners();
  }

  String? _textSpeech = '';
  String? get getTextSpeech => _textSpeech;
  void setTextSpeech(String? text) {
    _textSpeech = text;
    notifyListeners();
  }

  //=============================BOTONES CAMARA Y VIDEO=================================//
  bool _isCamera = false;
  bool get getIsCamera => _isCamera;
  void setIsCamera(bool value) {
    _isCamera = value;

    notifyListeners();
  }

  bool _isVideo = false;
  bool get getIsVideo => _isVideo;
  void setIsVideo(bool value) {
    _isVideo = value;
    notifyListeners();
  }

//========================== GEOLOCATOR =======================//
  String? _coordenadas = "";
  Geolocator.Position? _position;
  Geolocator.Position? get position => _position;
  String? _selectCoords = "";
  String? get getCoords => _selectCoords;
  set setCoords(String? value) {
    _selectCoords = value;
  }

  Future<bool?> checkGPSStatus() async {
    final isEnable = await Geolocator.Geolocator.isLocationServiceEnabled();
    Geolocator.Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1) ? true : false;
    });
    return isEnable;
  }

  Future<void> getCurrentPosition() async {
    late LocationSettings locationSettings;

    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _position =
        await Geolocator.GeolocatorPlatform.instance.getCurrentPosition();
    _position = position;
    _selectCoords = ('${position!.latitude},${position!.longitude}');
    _coordenadas = _selectCoords;
    notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;

  List<CreaNuevaFotoNovedad?> _listaFotos = [];
  List<CreaNuevaFotoNovedad?> get getListaFotos => _listaFotos;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    _listaFotos.add(CreaNuevaFotoNovedad(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotos.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  void opcionesDecamara(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    setNewPictureFile(pickedFile.path);
  }

  //===================CODIGO DE ACCESO A MULTAS==========================//
  String _textoCodigAccesoMultas = '';
  String? get getCodigoAccesoMultas => _textoCodigAccesoMultas;
  void onChangeCodigoAccesoMultas(String text) {
    _textoCodigAccesoMultas = text;
  }
}
