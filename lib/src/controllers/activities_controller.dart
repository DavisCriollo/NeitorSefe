import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';

import 'package:provider/provider.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';

// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/session_response.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';
// import 'package:sincop_app/src/service/socket_service.dart';

class ActivitiesController extends ChangeNotifier {
  GlobalKey<FormState> actividadesFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> actividadesRondaFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  bool validateForm() {
    if (actividadesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormRonda() {
    if (actividadesRondaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetValuesActividades() {
    _listaFotos.clear();
    _listaFotosRealizaActividades.clear();
    _listaFotosUrl.clear();
    _listaVideosUrl.clear();
    _urlVideo = '';
    _pathVideo = '';
    _infoQR = '';
    _detallePuntoPuesto = '';
    _nombrePuntoPuesto = '';
    dataRondas.clear();
    _rondaSave = '';
    _rondaGet = '';
    _listaPuestos.clear();
    _listaRespMovil.clear();
    _rondaCompleta = false;
    _elementoQR = {};
    notifyListeners();
  }

//================================== OBTENEMOS TODAS LAS NOVEDADES  ==============================//
  List _listaTodasLasActividades = [];
  List get getListaTodasLasActividades => _listaTodasLasActividades;

  void setListaTodasLasActividades(List data) {
    _listaTodasLasActividades = data;
    notifyListeners();
  }

  bool? _errorActividades; // sera nulo la primera vez
  bool? get getErrorActividades => _errorActividades;

  Future getTodasLasActividades(String? search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllActividades(
      search: search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorActividades = true;
      setListaTodasLasActividades(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorActividades = false;
      notifyListeners();
      return null;
    }

    return null;
  }

//========================== VALIDA CAMPO  FECHA INICIO CONSIGNA =======================//
  String? _inputObservacionesRealizaActivities;
  get getInputObservacionesRealizaActivities =>
      _inputObservacionesRealizaActivities;
  void onInputObservacionesRealizaActivitiesChange(String? date) {
    _inputObservacionesRealizaActivities = date;
    notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA REALIZAR CONSIGNA=======================//
  int idFotoRealizaActividades = 0;
  File? _newPictureFileRealizaActividades;
  File? get getNewPictureFileRealizaActividades =>
      _newPictureFileRealizaActividades;

  final List<CreaNuevaFotoRealizaActividadGuardia?>
      _listaFotosRealizaActividades = [];
  List<CreaNuevaFotoRealizaActividadGuardia?>
      get getListaFotosListaFotosRealizaActividades =>
          _listaFotosRealizaActividades;
  void setNewPictureFileRealizaActividades(String? path) {
    _newPictureFileRealizaActividades = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFileRealizaActividades);
    _listaFotosRealizaActividades.add(CreaNuevaFotoRealizaActividadGuardia(
        idFotoRealizaActividades, _newPictureFileRealizaActividades!.path));

    idFotoRealizaActividades = idFotoRealizaActividades + 1;
    notifyListeners();
  }

  void eliminaFotoRealizaActividades(int id) {
    _listaFotosRealizaActividades.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  void opcionesDecamaraRealizaConsigna(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFileRealizaConsigna = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFileRealizaConsigna == null) {
      return;
    }
    setNewPictureFile(pickedFileRealizaConsigna.path);
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;
  final List _listaFotosUrl = [];

  final List<CreaNuevaFotoRealizaActividadGuardia?> _listaFotos = [];
  List<CreaNuevaFotoRealizaActividadGuardia?> get getListaFotos => _listaFotos;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotos
        .add(CreaNuevaFotoRealizaActividadGuardia(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotos.add(CreaNuevaFotoRealizaActividadGuardia(id, path));

    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotos.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  Future<String?> upLoadImagen(File? _newPictureFile) async {
    final dataUser = await Auth.instance.getSession();

    //for multipartrequest
    var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    //for token
    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

    request.files
        .add(await _http.MultipartFile.fromPath('foto', _newPictureFile!.path));
    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);

    if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      _listaFotosUrl.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
    }
  }

  void eliminaFotoRealizaConsigna(int id) {
    _listaFotosRealizaActividades.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  //================================== ELIMINAR  COMUNICADO  ==============================//
  Future relizaGuardiaActividad(int? _idActividad, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadRealizaGuardiaActividad = {
      "tabla": "actividadtrabajo", // defecto
      "rucempresa": infoUser!.rucempresa, // login
      "rol": infoUser.rol, //login
      "actId": _idActividad, // id de actividad
      "actIdPersona": infoUser.id, // login
      "detalle": _inputObservacionesRealizaActivities,
      "fotos": _listaFotosUrl,
      "video": _urlVideo,
      "qr": _infoQR,
      "rondas": []
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadRealizaGuardiaActividad);
  }

  String? _pathVideo = '';
  String? get getPathVideo => _pathVideo;

  void setPathVideo(String? path) {
    _pathVideo = path;
    upLoadVideo(_pathVideo);
    notifyListeners();
  }

  String? _urlVideo = '';
  String? get getUrlVideo => _urlVideo;

  void setUrlVideo(String? url) {
    _urlVideo = url;
    notifyListeners();
  }
//============================LOAD VIDEO===========================================//

  final List<dynamic> _listaVideosUrl = [];
  List<dynamic> get getVideoUrl => _listaVideosUrl;

  Future<String?> upLoadVideo(String? path) async {
    final dataUser = await Auth.instance.getSession();

    //for multipartrequest
    var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    //for token
    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

    request.files.add(await _http.MultipartFile.fromPath('video', path!));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);

    if (responsed.statusCode == 200) {
      final responseVideo = FotoUrl.fromJson(responsed.body);
      setUrlVideo(responseVideo.urls[0].url);
      _listaVideosUrl.addAll([
        {
          "nombre": responseVideo
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseVideo.urls[0].url
        }
      ]);
    }
  }

  void eliminaVideo() {
    _listaVideosUrl.clear();
    _urlVideo = '';
    _pathVideo = '';
    notifyListeners();
  }

  //===================LEE CODIGO QR==========================//

  String? _nombrePuestoQR = '';
  String? get getNombrePuestoQR => _nombrePuestoQR;
  void setNombrePuestoQR(String? value) {
    _nombrePuestoQR = value;
  }

  Map<int, String>? _elementoQR = {};
  String? _elementoPuestoQR = '';
  Map<int, String>? get getElementoQR => _elementoQR;
  String? _infoQR = '';
  String? get getInfoQR => _infoQR;
  List<String>? splitData;

  void setInfoQR(String? value) {
    if (value!.isNotEmpty) {
      if (value == 'http') {
        value = '';
      } else {
        splitData = value.split('-');

        _elementoPuestoQR = splitData![3].trim();
      }
    } else {
      value = '';
    }

    if (_elementoPuestoQR == _nombrePuestoQR) {
      _elementoQR = {
        for (int i = 0; i < splitData!.length; i++) i: splitData![i]
      };
    } else {
      _elementoQR = {};
      NotificatiosnService.showSnackBarError('Puesto no Asignado');
    }
    notifyListeners();
  }

//================== VALIDA CODIGO QR INICIA TURNO ===========================//
  Future<void> validaCodigoQR(BuildContext context) async {}
// ===========================REALIZAZ RONDA ACTIVIDAD=============================================//
  List<dynamic> dataRondas = [];

  String _nombrePuntoPuesto = '';
  String? _fechaActualParse;

  String get getNombrePuntoPuesto => _nombrePuntoPuesto;
  void set getNombrePuntoPuesto(String nombrePunto) {
    _fechaActualParse =
        '${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm').format(DateTime.now())}';
    _nombrePuntoPuesto = nombrePunto;

    notifyListeners();
  }

  String _rondaSave = '';
  String _rondaGet = '';
  bool _rondaCompleta = false;
  bool get getRondaCompleta => _rondaCompleta;
  List<dynamic> _listaPuestos = [];
  final List<dynamic> _listaRespMovil = [];
  List<dynamic> get getlistaRespMovil => _listaRespMovil;
  List<dynamic> _listaCompletaParaGuardar = [];
  List<dynamic> get getlistaCompletaParaGuardar => _listaCompletaParaGuardar;
  int? _actividadId;
  int? get getRondaId => _actividadId;
  int? _numLugares;
  int? get getNumLugares => _numLugares;
  void setNumLugares(int? idAct, int? numLugares) {
    _numLugares = numLugares;
    _actividadId = idAct;
  }

//******************************** VALIDA DATA DEL DISPOSITIVO ********************************** */

  void validaDataDispositivo() async {
    final tablaResponspMovil = await Auth.instance.getRondasActividad();
    if (tablaResponspMovil != null) {
      _listaPuestos = json.decode(tablaResponspMovil);
      for (var item in _listaPuestos) {
        if (item['idActividad'] == _actividadId &&
            item['rondas'].length == _numLugares) {
          _listaCompletaParaGuardar = _listaPuestos;
          _rondaCompleta = true;

          notifyListeners();
        } else {}
      }
    } else {}
  }

//****************************************************** AGREGA RONDA AL DISPOSITIVO ********************************** */

  Future<void> realizaRondaPunto(int? idRonda) async {
    if (_listaPuestos.isNotEmpty) {
      List result =
          _listaPuestos.where((o) => o['idActividad'] == idRonda).toList();
      if (result.isNotEmpty) {
        result[0]['rondas']
            .removeWhere((e) => (e['nombre'] == _nombrePuntoPuesto));
        result[0]['rondas'].add({
          "nombre": _nombrePuntoPuesto,
          "detalle": _detallePuntoPuesto,
          "fotos": _listaFotosUrl,
          "video": _urlVideo,
          "qr": _infoQR,
          "fecha": _fechaActualParse
        });

        _listaPuestos.removeWhere((e) => (e['idActividad'] == idRonda));
        _listaPuestos.add(result[0]);
        _rondaSave = jsonEncode(_listaPuestos);
        await Auth.instance.saveRondasActividad(_rondaSave);
      } else {
        _listaPuestos.add(
          {
            "idActividad": idRonda,
            "rondas": [
              {
                "nombre": _nombrePuntoPuesto,
                "detalle": _detallePuntoPuesto,
                "fotos": _listaFotosUrl,
                "video": _urlVideo,
                "qr": _infoQR,
                "fecha": _fechaActualParse
              },
            ]
          },
        );
        _rondaSave = jsonEncode(_listaPuestos);
        await Auth.instance.saveRondasActividad(_rondaSave);
        notifyListeners();
      }
    } else {
      _listaPuestos.add(
        {
          "idActividad": idRonda,
          "rondas": [
            {
              "nombre": _nombrePuntoPuesto,
              "detalle": _detallePuntoPuesto,
              "fotos": _listaFotosUrl,
              "video": _urlVideo,
              "qr": _infoQR,
              "fecha": _fechaActualParse
            },
          ]
        },
      );
      _rondaSave = jsonEncode(_listaPuestos);
      await Auth.instance.saveRondasActividad(_rondaSave);
      notifyListeners();
    }
  }

// ******************************************************************************************************************************************//

  String? _detallePuntoPuesto = '';
  String? get getInputPuntoPuesto => _detallePuntoPuesto;
  void setInputPuntoPuestoChange(String? text) {
    _detallePuntoPuesto = text;
    notifyListeners();
  }

//================================== OBTENEMOS TODAS LOS PUESTOS DE LA ACTIVIDAD  ==============================//

  List _listaTodosLosPuntosDeRonda = [];
  List get getListaTodosLosPuntosDeRonda => _listaTodosLosPuntosDeRonda;

  void setListaTodosLosPuntosDeRonda(List data) {
    _listaTodosLosPuntosDeRonda = data;
    notifyListeners();
  }

  bool? _errorPuntosRonda; // sera nulo la primera vez
  bool? get getErrorPuntosRonda => _errorPuntosRonda;

  Future getTodosLosPuntosDeRonda(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllActividades(
      search: search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPuntosRonda = true;

      setListaTodosLosPuntosDeRonda(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPuntosRonda = false;
      notifyListeners();
      return null;
    }

    return null;
  }

//========================== ENVIA  LA RONDA AL SERVIDOR  CUANDO YA ESTA COMPLETA ===============//
  Future guardarRonda(int? idRonda, BuildContext context) async {
    for (var item in _listaPuestos) {
      if (item['idActividad'] == idRonda) {
        final serviceSocket =
            Provider.of<SocketService>(context, listen: false);

        final infoUser = await Auth.instance.getSession();

        // print(
        //     '==========================JSON PARA CREAR NUEVA COMPRA ===============================');
        final _pyloadGuardiaRondaCompleta = {
          "tabla": "actividadtrabajo", // defecto
          "rucempresa": infoUser!.rucempresa, // login
          "rol": infoUser.rol, //login
          "actId": idRonda, // id de actividad
          "actIdPersona": infoUser.id, // login
          "detalle": _inputObservacionesRealizaActivities,
          "fotos": _listaFotosUrl,
          "video": _urlVideo,
          "qr": _infoQR,
          "rondas": item['rondas']
        };

        serviceSocket.socket!
            .emit('client:actualizarData', _pyloadGuardiaRondaCompleta);
      } else {}
    }
  }

  //================================== OBTENGO ACTIVIDAD  ==============================//

  String? _fechaInicio = '';
  String? get getFechaInicio => _fechaInicio;

  String? _fechaFin = '';
  String? get getFechaFin => _fechaFin;

  int? _numeroDias;
  int? get getNumeroDias => _numeroDias;

  String? _trabajoCumplido;
  String? get getTrabajoCumplido => _trabajoCumplido;

  void getActividad(
    dynamic actividad,
    Session? usuario,
  ) {
    if (actividad['actFechasActividadConsultaDB'].isNotEmpty) {
      DateTime fechaInicio =
          DateTime.parse(actividad['actFechasActividadConsultaDB'][0]);
      DateTime fechafin = DateTime.parse(
          actividad['actFechasActividadConsultaDB']
              [actividad['actFechasActividadConsultaDB'].length - 1]);

      _fechaInicio = fechaInicio.toString().substring(0, 10);
      _fechaFin = fechafin.toString().substring(0, 10);
      Duration dias = fechafin.difference(fechaInicio);
      int diasTrabajar = dias.inDays;

      _numeroDias = (diasTrabajar == 0) ? (diasTrabajar + 1) : diasTrabajar;

      bool? _asignado;

      int? _progreso;

      if (usuario!.rol!.contains('SUPERVISOR')) {
        for (var e in actividad['actSupervisores']) {
          if (e['docnumero'] == usuario.usuario && e['asignado'] == true) {
            _asignado = true;
            _progreso = e['trabajos'].length;
            if (_numeroDias! > _progreso!) {
              _trabajoCumplido = 'EN PROGRESO';
            } else if (_numeroDias == _progreso) {
              _trabajoCumplido = 'REALIZADO';
            } else if (_numeroDias! < _progreso) {
              _trabajoCumplido = 'NO REALIZADO';
            }
          } else {}
        }
      }
      if (usuario.rol!.contains('GUARDIA')) {
        for (var e in actividad['actAsignacion']) {
          if (e['docnumero'] == usuario.usuario && e['asignado'] == true) {
            _asignado = true;
            _progreso = e['trabajos'].length;
            if (_numeroDias! > _progreso!) {
              _trabajoCumplido = 'EN PROGRESO';
            } else if (_numeroDias == _progreso) {
              _trabajoCumplido = 'REALIZADO';
            } else if (_numeroDias! < _progreso) {
              _trabajoCumplido = 'NO REALIZADO';
            }
          } else {}
        }
      }

      notifyListeners();
    }
  }

  //======================================================================================');

}
