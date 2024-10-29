import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as _http;

class CierreBitacoraController extends ChangeNotifier {
  GlobalKey<FormState> cierreBitacoraFormKey = GlobalKey<FormState>();

  final _api = ApiProvider();

  bool validateForm() {
    if (cierreBitacoraFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


//===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }

List _bitacoras = [];
List _bitacotasCierradas = [];

List get getBitacotasCierradasFiltradas => _bitacotasCierradas;
bool noResults = false; // Bandera para indicar si hay resultados o no

void setBtacotasCierradas(List bitsC) {
  _bitacotasCierradas = [];
  _bitacotasCierradas = bitsC;
  // print('LA RESPUESTA DEL getAllCierreBitacoras: $_bitacotasCierradas');
  notifyListeners();
}

List<dynamic> _allItemsFilters = [];
List<dynamic> get allItemsFilters => _allItemsFilters;

void setListFilter(List<dynamic> list) {
  _allItemsFilters = [];
  _allItemsFilters.addAll(list);
  noResults = list.isEmpty; // Actualiza la bandera de resultados
  // print('LA RESPUESTA DEL getAllCierreBitacoras: $_bitacotasCierradas');
  notifyListeners();
}

void search(String query) {
  List<Map<String, dynamic>> originalList = List.from(_bitacotasCierradas); // Copia de la lista original

  if (query.isEmpty) {
    // Restablece la lista completa si no hay búsqueda
    _allItemsFilters = originalList;
    noResults = false;
  } else {
    // Filtra según el término de búsqueda
    _allItemsFilters = originalList.where((item) {
      return item['bitcFecha'].toLowerCase().contains(query.toLowerCase()) ||
             item['cliDocNumero'].toLowerCase().contains(query.toLowerCase()) ||
             item['cliRazonSocial'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    
    // Verifica si hay resultados
    noResults = _allItemsFilters.isEmpty;
  }

  notifyListeners();
}

Future buscaBitacorasCierre(String? _search, String? notificacion) async {
  final dataUser = await Auth.instance.getSession();
  final response = await _api.getAllCierreBitacoras(
    token: '${dataUser!.token}',
  );

  if (response != null) {
    List dataSort = [];
    dataSort = response;
    dataSort.sort((a, b) => b['bitcFecha']!.compareTo(a['bitcFecha']!));
    setBtacotasCierradas(dataSort);
    setListFilter(dataSort); // Llama a la función para actualizar la lista filtrada
    notifyListeners();
    return response;
  }
  if (response == null) {
    notifyListeners();
    return null;
  }
}



String _fechaActual='';
 
String get getFechaActual=>_fechaActual;


void obtieneFechaActual() {

 final now = DateTime.now();
  final  _currentDateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
_fechaActual='';
_fechaActual=_currentDateTime;
print('la fecha es: $_fechaActual');
notifyListeners();
 

  }

//*************************//


  String? _inputObservacion;
  String? get getInputObservacion => _inputObservacion;
  void onObservacionChange(String? text) {
    _inputObservacion = text;
    notifyListeners();
  }

//************FOTOS*****************/
final List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  List<XFile> get photos => _photos;
  bool get isPicking => _isPicking;

  String compressedImagePath = "/storage/emulated/0/Download/";

  Future<void> pickImageFromCamera() async {
    await _pickAndCompressImage(ImageSource.camera);
  }

  Future<void> pickImageFromGallery() async {
    await _pickAndCompressImage(ImageSource.gallery);
  }

  Future<void> _pickAndCompressImage(ImageSource source) async {
    if (_isPicking) return;
    _isPicking = true;
    notifyListeners();

    try {
      final XFile? pickedImage = await _picker.pickImage(source: source, imageQuality: 70);
      if (pickedImage != null) {
        // Comprime la imagen
        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          pickedImage.path,
          "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
          quality: 20,
        );

        if (compressedFile != null) {
          // Añade la imagen comprimida a la lista
          _photos.add(XFile(compressedFile.path));
          notifyListeners();
        }
      }
    } finally {
      _isPicking = false;
      notifyListeners();
    }
  }

  void removePhoto(int index) {
    _photos.removeAt(index);
    notifyListeners();
  }
Future<void> deleteOriginalFiles(String photoPath) async {
  try {
    final originalFile = File(photoPath);
    if (await originalFile.exists()) {
      await originalFile.delete();
      print("Imagen original eliminada.");
    }
  } catch (e) {
    print("Error eliminando las imágenes originales: $e");
  }
}


//***********   CREAR CIERRE BITACORA *******************//
  List<Map<String, String>> _listaFotosUrl = [];
Future crearCierreBitacora(BuildContext context) async {
    final serviceSocket = context.read<SocketService>();
  final infoUserLogin = await Auth.instance.getSession();


final _pyloadNuevoCierreBitacora = {

  "bitcId": 0,
  "bitcFecha": _fechaActual,
  "bitcFotos": _listaFotosUrl,
  "bitcEstado": "APERTURA",
  "bitcObservacion": _inputObservacion,
  "bitcUsuario": infoUserLogin!.usuario,
  "tabla": "bitacora_cierre",
  "rucempresa": infoUserLogin.rucempresa, //login
  "rol": infoUserLogin.rol,
};

//  print('_pyloadNuevTurnoExtra :$_pyloadNuevoCierreBitacora');

 serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoCierreBitacora);
 
}

//==================GUARDA IMAGENES AL SERVIDOR==========================//
List<String> respuestasImagenes = [];

Future<bool> enviarImagenesAlServidor() async {
  _listaFotosUrl = [];

  final dataUser = await Auth.instance.getSession();
  final url = Uri.parse('https://backsigeop.neitor.com/api/multimedias');

  var request = _http.MultipartRequest('POST', url);
  // Agregar token al encabezado
  request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

  // Agregar las fotos al request
  for (var i = 0; i < _photos.length; i++) {
    request.files.add(await _http.MultipartFile.fromPath('foto$i', _photos[i].path));
  }

  // Enviar la solicitud
  var response = await request.send();
  if (response.statusCode == 200) {
    String respuesta = await response.stream.bytesToString();
    respuestasImagenes.add(respuesta);

    // Convertir la respuesta en un mapa
    Map<String, dynamic> mapa = json.decode(respuestasImagenes[0]);

    List<dynamic> urls = mapa["urls"];
    for (var item in urls) {
      _listaFotosUrl.add({
        "nombre": item["nombre"],
        "url": item["url"],
      });
    }

    // print('Las URLs son: $_listaFotosUrl');

    // Verificar si _listaFotosUrl tiene datos
    if (_listaFotosUrl.isNotEmpty) {
      // Realiza la acción que desees aquí
      // print('Se han recibido ${_listaFotosUrl.length} URLs.');
      // Aquí puedes realizar cualquier otra acción, como almacenar las URLs o mostrar un mensaje al usuario
    } else {
      // print('No se recibieron URLs.');
    }

    return true; // Retorna true si la petición fue exitosa
  } else {
    print('Error al enviar la imagen');
    return false; // Retorna false si hubo un error
  }
}




Future eliminaUrlServer( String _url) async {


final _urlImageDelete=
[
		{
			"nombre": "foto",
			"url": _url,
		}
	];
// print('ES LOS URLSTEMP: ${_urlImageDelete}');

    final dataUser = await Auth.instance.getSession();

    final response = await _api.deleteUrlDelServidor(
         datos:_urlImageDelete,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      // _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response['urls'][0]}');
      // setUrlImge(response.toString());
      notifyListeners();
      return 'true';
      // return response;
    }
    if (response == null) {
      // _errorUrl = false;
      notifyListeners();
      return 'false';

    }
 
  }




}