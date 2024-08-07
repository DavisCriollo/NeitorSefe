import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/foto_url.dart';
import 'package:provider/provider.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/service/socket_service.dart';

class BitacoraController extends ChangeNotifier {
  GlobalKey<FormState> bitacoraFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bitacoraRegistroFormKey = GlobalKey<FormState>();
    GlobalKey<FormState> bitacoraObservacionFormKey = GlobalKey<FormState>();
 final _api = ApiProvider();
  bool validateForm() {
    if (bitacoraFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
   bool validateFormRegistro() {
    if (bitacoraRegistroFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
  bool validateFormObservacion() {
    if (bitacoraObservacionFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Map<String,dynamic>? _itemPersonaDestino = {};
  Map<String,dynamic>? get getItemPersonaDestinol => _itemPersonaDestino;
  void setItemPersonaDestino(Map<String,dynamic>? _val) {
    _itemPersonaDestino = _val;
    print('TIPO DE PERSONA DESTINO: $_itemPersonaDestino'); 
    notifyListeners();
  }


  // String? _itemTipoIngreso = '';
  // String? get getItemTipoIngreso => _itemTipoIngreso;
  // void setItemTipoIngreso(String? _val) {
  //   _itemTipoIngreso = _val;
  //   print('TIPO DE Ingreso: $_itemTipoIngreso'); 
  //   notifyListeners();
  // }

  String? _itemTipoPersona = '';
  String? get getItemTipoPersonal => _itemTipoPersona;
  void setItemTipoPersona(String? _val) {
    _itemTipoPersona = _val;
    print('TIPO DE PERSONA: $_itemTipoPersona'); 
    notifyListeners();
  }
  String? _itemCedula = '';
  String? get getItemCedula => _itemCedula;
  void setItemCedula(String? value) {
    _itemCedula = value;
  }

  String? _itemNombres = '';
  String? get getItemNombres => _itemNombres;
  void setItemNombres(String? value) {
    _itemNombres = value;
        print('_itemNombres: $_itemNombres'); 
    notifyListeners();
  }
  String? _itemTelefono = '';
  String? get getItemTelefono => _itemTelefono;
  void setItemTelefono(String? value) {
    _itemTelefono = value;
  }


  String? _itemSeDirigeA = '';
  String? get getItemSeDirigeA => _itemSeDirigeA;
  void setItemSeDirigeA(String? value) {
       _itemSeDirigeA = value;
         print('_itemSeDirigeA: $_itemSeDirigeA');
       notifyListeners();
  }
  String? _itemAutorizadoPor = '';
  String? get getItemAutorizadoPor => _itemAutorizadoPor;
  void setItemAutorizadoPor(String? value) {
    _itemAutorizadoPor = value;
       notifyListeners();
  }
  String? _itemMotivo = '';
  String? get getItemMotivo => _itemMotivo;
  void setItemMotivo(String? value) {
    _itemMotivo = value;
     print('_itemMotivo: $_itemMotivo');
     notifyListeners();
  }


String? _itemAsunto = '';
  String? get getItemAsunto => _itemAsunto;
  void setItemAsunto(String? value) {
    _itemAsunto = value;
     print('_itemAsunto: $_itemAsunto');
     notifyListeners();
  }


  String? _itemObservacion = '';
  String? get getItemObservacion => _itemObservacion;
  void setItemObservacion(String? value) {
    _itemObservacion = value;
       print('_itemObservacion: $_itemObservacion');
  }
  
  String? _itemCasaDepartamento = '';
  String? get getItemCasaDepartamento => _itemCasaDepartamento;
  void setItemCasaDepartamento(String? value) {
    _itemCasaDepartamento = value;
  }
//========================== CAJAS DE TEXTO INGRESAR BITACORA=======================//

  String? _itemCedulaVisitaBitacora = '';
  String? get getCedulaVisitaBitacora => _itemCedulaVisitaBitacora;
  void setCedulaVisitaBitacora(String? value) {
    _itemCedulaVisitaBitacora = value;
       print('_itemCedulaVisitaBitacora: $_itemCedulaVisitaBitacora');
  }
String? _itemNombreVisitaBitacora = '';
  String? get getNombreVisitaBitacora => _itemNombreVisitaBitacora;
  void setNombreVisitaBitacora(String? value) {
    _itemNombreVisitaBitacora = value;
       print('_itemNombreVisitaBitacora: $_itemNombreVisitaBitacora');
  }

String? _itemObservacionBitacora = '';
  String? get getItemObservacionBitacora => _itemObservacionBitacora;
  void setItemObservacionBitacora(String? value) {
    _itemObservacionBitacora = value;
       print('_itemObservacionBitacora: $_itemObservacionBitacora');
  }
  String? _itemCedulaPropietarioVehiculoBitacora = '';
  String? get getCedulaPropietarioVehiculoBitacora => _itemCedulaPropietarioVehiculoBitacora;
  void setCedulaPropietarioVehiculoBitacora(String? value) {
    _itemCedulaPropietarioVehiculoBitacora = value;
       print('_itemCedulaPropietarioVehiculoBitacora: $_itemCedulaPropietarioVehiculoBitacora');
  }
  
   String? _itemNombrePropietarioVehiculoBitacora = '';
  String? get getNombrePropietarioVehiculoBitacora => _itemNombrePropietarioVehiculoBitacora;
  void setNombrePropietarioVehiculoBitacora(String? value) {
    _itemNombrePropietarioVehiculoBitacora = value;
       print('_itemNombrePropietarioVehiculoBitacora: $_itemNombrePropietarioVehiculoBitacora');
  }
//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;
  List? _listaFotosUrl = [];
  List? get getListaFotosUrl => _listaFotosUrl;

  List<dynamic> _listaFotosCreabitacora = [];
  List<dynamic> get getListaFotosCreaBitacora => _listaFotosCreabitacora;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotosCreabitacora
        .add(CreaNuevaFotoBitacora(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotosCreabitacora.add(CreaNuevaFotoBitacora(id, path));

    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotosCreabitacora.removeWhere((element) => element!.id == id);

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
      final fotoUrl = responseFoto.urls[0];
      _listaFotosUrl!.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);

      notifyListeners();
    }
    for (var item in _listaFotosUrl!) {}
  }

  void eliminaFotoUrl(String url) {
    _listaFotosUrl!.removeWhere((e) => e['url'] == url);
  }


  //==================================+++++++++++++++++++++++++++++++ OBTENEMOS TODOS LOS AVISOS  =====++++++++++++++++++++++++++++++++++++++++++++=========================//
  List<dynamic> _listaBitacoras = [];
  List<dynamic> get getListaBitacoras => _listaBitacoras;

  void setListaBitacoras(List<dynamic> data) {
    // data.sort((a, b) => b['bitFecReg'].compareTo(a['bitFecReg']));
    // _listaBitacoras.add(data);
    _listaBitacoras.addAll(data);

 _listaBitacoras.sort((a, b) {
  if (a['bitEstado'] == 'ANULADA' && b['bitEstado'] != 'ANULADA') {
    return 1; // Mueve a 'a' al final
  } else if (a['bitEstado'] != 'ANULADA' && b['bitEstado'] == 'ANULADA') {
    return -1; // Mueve a 'a' al inicio
  } else {
    return 0; // Mantén el orden actual
  }
});

        // print('TENEMOS DATA:$_listaBitacoras');


    notifyListeners();
  }

  bool? _errorBitacoras; // sera nulo la primera vez
  bool? get getErrorBitacoras => _errorBitacoras;

  Future<dynamic> getBitacoras(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
     final idTurno = await Auth.instance.getIdRegistro();
    // final turno = jsonDecode(infoUserTurno);
// print('ESTE ES EL TUNO:$infoUserTurno');
String _tipo='';
if(dataUser!.rol!.contains('CLIENTE')){
_tipo='CLIENTE';

}
else if(dataUser.rol!.contains('RESIDENTE')){
_tipo='RESIDENTE';
}
else if(dataUser.rol!.contains('GUARDIA')){
_tipo='GUARDIA';
}
else if(dataUser.rol!.contains('SUPERVISOR')){
_tipo='SUPERVISOR';
}

    final response = await _api.getAllBitacoras(
      search: search,
      notificacion: notificacion,
      idTurno:idTurno,
      tipo:_tipo,
      token: '${dataUser.token}',
    );

    if (response != null) {
      _errorBitacoras = true;


      List dataSort = [];
      dataSort = response;
      dataSort.sort((a, b) => b['bitFecReg']!.compareTo(a['bitFecReg']!));
          _listaBitacoras=[];
      setListaBitacoras(dataSort);
      // setListaBitacoras(response);
      // print('object ${response}');

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorBitacoras = false;
      notifyListeners();
      return null;
    }
    return null;
  }


//=================OBTENEMOS LA INFO DELLA BITACORA===================//


 dynamic _itemBitacora;

 dynamic get getInfoBitacora=>_itemBitacora;

 void setInfoBitacora(dynamic _info){

   _itemAutorizadoPor = '';
  _itemBitacora=_info;

// _itemTipoPersona = '';
// setItemTipoPersona(_info['bitTipoPersona']);
// print(_info['bitTipoPersona']);

// _itemCedula = '';
// _itemNombres = '';
// _itemTelefono = '';
// _itemSeDirigeA = '';
// _itemMotivo = '';
// _itemObservacion = '';












notifyListeners();
 }
//==============================RESET LAS VARIABLES=======================================//
void resetValuesBitacora() {
_itemBitacora;
// _listaBitacoras.clear();


_itemTipoPersona = '';
_itemCedula = '';
_itemNombres = '';
_itemTelefono = '';
_itemSeDirigeA = '';
_itemMotivo = '';
_itemObservacion = '';
_listaFotosUrl=[];
_labelNombreEstadoBitacora;
_listaImages = [];
respuestasImagenes = [];
_infPersonaDirige;
_itemAutorizadoPor='';
setDirigidoAChange('');

notifyListeners();



}
//=====================================================================//

 //================================== CREA NUEVA BITACORA GUARDIA  ==============================//
  Future creaBitacoraGuardia(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

    final _pyloadNuevBitacoraGuardia = {

   "tabla": "bitacora", // defecto
   "rucempresa": infoUser!.rucempresa, //login
   "rol": infoUser.rol, // login

   "bitEmpresa": infoUser.rucempresa, //login
  "bitUser": infoUser.usuario, //login
  "regId": idTurno, //tomar el id del registro cuando inicia turno. (obligatorio)


  "bitId": "", //vacio
  "bitTipoPersona": _itemTipoPersona, //input (obligatorio)
  "bitDocumento":_itemCedula, //input (obligatorio)
  "bitNombres": _itemNombres, //input (obligatorio)
  "bitTelefono": _itemTelefono, //input
  "bitAsunto": _itemMotivo, //input (obligatorio)
  "bitDirige":_itemSeDirigeA, //input
  "bitFotos":_listaFotosUrl, //fotos max(3)
  "bitObservacion": _itemObservacion, //textarea (en todos los texteareas quitar enter y "")
  "bitCliId": "",//vacio
  "bitCliDocumento": "",//vacio
  "bitCliNombre": "", //vacio
  "bitCliUbicacion": "", //vacio
  "bitCliPuesto": "", //vacio
  "bitEstado": "INGRESO", //default (obligatorio)

  "bitEstadoIngreso": "",
	"bitEstadoSalida": "",

	"bitResId":getInfPersonaDirige['resId'],
	"bitAutoriza": _itemAutorizadoPor,
	"bitResCedula": getInfPersonaDirige['resCedula'],
	"bitResNombres": getInfPersonaDirige['resNombres'],
	"bitResTelefono": getInfPersonaDirige['resTelefono'],
	"bitResDepartamento": getInfPersonaDirige['resDepartamento'],
	"bitResUbicacion": getInfPersonaDirige['resUbicacion'],
	"bitFecReg": "",
	"bitFecUpd":"",
	"tregistros": "",


"bitUserApruebaIngreso":"",
"bitUserApruebaSalida":"",

//tomar el id del registro cuando inicia turno. (obligatorio)



    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevBitacoraGuardia);
   print('el PAYLOAD GUARDIA ${_pyloadNuevBitacoraGuardia}');
    
  }
 //================================== CREA NUEVO COMUNICADO  ==============================//
  Future creaBitacoraResidente(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

    final _pyloadNuevBitacoraResidente = {

   "tabla": "bitacora", // defecto
   "rucempresa": infoUser!.rucempresa, //login
   "rol": infoUser.rol, // login

   "bitEmpresa": infoUser.rucempresa, //login
  "bitUser": infoUser.usuario, //login
  "regId": idTurno, //tomar el id del registro cuando inicia turno. (obligatorio)

  "bitId": "", //vacio
  "bitTipoPersona": _itemTipoPersona, //input (obligatorio)
  "bitDocumento":_itemCedula, //input (obligatorio)
  "bitNombres": _itemNombres, //input (obligatorio)
  "bitTelefono": _itemTelefono, //input
  "bitAsunto": _itemMotivo, //input (obligatorio)
  "bitDirige":_itemSeDirigeA, //input
  "bitFotos":_listaFotosUrl, //fotos max(3)
  "bitObservacion": _itemObservacion, //textarea (en todos los texteareas quitar enter y "")
 
  "bitCliId": getInfoBitacora["resCliId"],
  "bitCliDocumento":getInfoBitacora['resCliDocumento'],
  "bitCliNombre": getInfoBitacora["resCliNombre"],
  "bitCliUbicacion": getInfoBitacora["resCliUbicacion"],
  "bitCliPuesto":getInfoBitacora['resCliPuesto'],

  "bitEstado": "PENDIENTE", //default (obligatorio)
  "bitEstadoIngreso": "PENDIENTE",
	
  "bitEstadoSalida": "",

	"bitResId":getInfoBitacora['resId'],
	"bitResCedula": getInfoBitacora['resCedula'],
	"bitResNombres": getInfoBitacora['resNombres'],
	"bitResTelefono": getInfoBitacora['resTelefono'],
	"bitAutoriza": _itemAutorizadoPor,
	"bitResDepartamento": getInfoBitacora['resDepartamento'],
	"bitResUbicacion": getInfoBitacora['resUbicacion'],
	"bitFecReg": "",
	"bitFecUpd":"",
	"tregistros": "",


"bitUserApruebaIngreso":"",
"bitUserApruebaSalida":"",

  
  // "bitId": "", // vacio=>interno
  // "bitTipoPersona": "PERSONAL PROPIO", //select => PERSONAL PROPIO, PROVEEDORES, VISITANTES, CONTRATISTA
  // "bitDocumento": "34242", // numero
  // "bitNombres": "lucas lucas", // string
  // "bitTelefono": "32432", // numero
  // "bitAsunto": "hhhhh ffff ddddd", // string
  // "bitFotos": [], //max 2,no obligatorio
  // "bitObservacion": "", // Textarea
  // "bitCliId": 1242, // data.resCliId =>interno
  // "bitCliDocumento": "2360006130001", // data.resCliDocumento => interno
  // "bitCliNombre": "INSTITUTO ECUATORIANO DE SEGÁTRICO", // data.resCliNombre => interno
  // "bitCliUbicacion": "SANTO DOMINGO", // data.resCliUbicacion => interno
  // "bitCliPuesto": "PISOS 1-4", // data.resCliPuesto => interno
  // "bitEmpresa": "PRUEBA", // login=>interno
  // "bitUser": "2350640682", // login=>interno
  // "bitUserApruebaIngreso": "", // vacio=>interno
  // "bitUserApruebaSalida": "",  // vacio=>interno
  // "bitEstado": "PENDIENTE",  // defecto=>interno
  // "bitEstadoIngreso": "PENDIENTE", // defecto=>interno
  // "bitEstadoSalida": "", // vacio=>interno
  // "bitResId": 2, // data.resId => interno
  // "bitResCedula": "1751120724", // data.resCedula
  // "bitResNombres": "VERA CUEVA ERICK AN", // data.resNombres
  // "bitResTelefono": ["0983324525"], // data.resTelefono => interno
  // "bitAutoriza": "GUERRERO MARIBE", // data.resPersonasAutorizadas
  // "bitResDepartamento": "REFERIDO POR VETERINARIO", // data.resDepartamento => interno
  // "bitResUbicacion": "REFERIDO POR VETERINARIO", //data.resUbicacion => interno
  // "bitFecReg": "", // vacio=>interno
  // "bitFecUpd": "" // vacio=>interno

//  "bitResId": 2, // data.resId => interno
//   "bitResCedula": "1751120724", // data.resCedula
//   "bitResNombres": "VERA CUEVA ERICK AN", // data.resNombres
//   "bitResTelefono": ["0983324525"], // data.resTelefono => interno
//   "bitAutoriza": "GUERRERO MARIBE", // data.resPersonasAutorizadas
//   "bitResDepartamento": "REFERIDO POR VETERINARIO", // data.resDepartamento => interno
//   "bitResUbicacion": "REFERIDO POR VETERINARIO", //data.resUbicacion => interno
 
//  "bitResId":getInfoBitacora['bitResId'],
// 	"bitAutoriza": _itemAutorizadoPor,
// 	"bitResCedula": getInfoBitacora['bitResCedula'],
// 	"bitResNombres": getInfoBitacora['bitResNombres'],
// 	"bitResTelefono": getInfoBitacora['bitResTelefono'],
// 	"bitResDepartamento": getInfoBitacora['bitResDepartamento'],
// 	"bitResUbicacion": getInfoBitacora['bitResUbicacion'],





    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevBitacoraResidente);
   print('el PAYLOAD  RESIDENTE ${_pyloadNuevBitacoraResidente}');
    
  }
 //========================== DROPDOWN =======================//
  String? _labelNombreEstadoBitacora;

  String? get labelNombreEstadoBitacora => _labelNombreEstadoBitacora;

  void setLabelNombreEstadoBitacora(String value) async {
    _labelNombreEstadoBitacora = value;

   print('el _labelNombreEstadoBitacora ${_labelNombreEstadoBitacora}');

    
    notifyListeners();
  }
 void resetEstadobitacora(){
  _labelNombreEstadoBitacora;
 }



//================================== CREA NUEVO COMUNICADO  ==============================//
  Future editaBitacora(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

    final _pyloadEditaBitacora = {



  "tabla": "bitacora", // defecto
   "rucempresa": infoUser!.rucempresa, //login
   "rol": infoUser.rol, // login


  "bitId": getInfoBitacora["bitId"],
  "bitTipoPersona": getInfoBitacora["bitTipoPersona"],
  "bitDocumento": getInfoBitacora["bitDocumento"],
  "bitNombres": getInfoBitacora["bitNombres"],
  "bitTelefono":getInfoBitacora['bitTelefono'],
  "bitAsunto":getInfoBitacora['bitAsunto'],
  "bitDirige": getInfoBitacora["bitDirige"],
  "bitFotos": getInfoBitacora["bitFotos"],
  "bitObservacion":getInfoBitacora['bitObservacion'],

  "bitCliId": getInfoBitacora["bitCliId"],
  "bitCliDocumento":getInfoBitacora['bitCliDocumento'],
  "bitCliNombre": getInfoBitacora["bitCliNombre"],
  "bitCliUbicacion": getInfoBitacora["bitCliUbicacion"],
  "bitCliPuesto":getInfoBitacora['bitCliPuesto'],
  "bitEstado":_labelNombreEstadoBitacora, // select => INGRESO, SALIDA, ANULADA

  "bitEstadoIngreso": getInfoBitacora['bitEstadoIngreso'],
	"bitEstadoSalida": getInfoBitacora['bitEstadoSalida'],
  
"bitUserApruebaIngreso":getInfoBitacora['bitUserApruebaIngreso'],
"bitUserApruebaSalida":getInfoBitacora['bitUserApruebaSalida'],




  "bitResId":getInfoBitacora['bitResId'],
	"bitAutoriza": _itemAutorizadoPor,
	"bitResCedula": getInfoBitacora['bitResCedula'],
	"bitResNombres": getInfoBitacora['bitResNombres'],
	"bitResTelefono": getInfoBitacora['bitResTelefono'],
	"bitResDepartamento": getInfoBitacora['bitResDepartamento'],
	"bitResUbicacion": getInfoBitacora['bitResUbicacion'],

  "bitFecReg": getInfoBitacora["bitFecReg"],
  "bitFecUpd": getInfoBitacora["bitFecUpd"],
  "bitEmpresa": infoUser.rucempresa, //login
  "bitUser": infoUser.usuario, //login/login
    };
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaBitacora);

    // print('estae es el JSON : $_pyloadEditaBitacora');


    
  }





//==================CARGA IMAGEN==========================//

 List<File> _listaImages = [];

  List<File> get listaImages => _listaImages;

  void addImage(File image) {
    _listaImages.add(image);
      print('Imagen  $_listaImages');
    notifyListeners();
  }

  void removeImage(File image) {
    _listaImages.remove(image);
    notifyListeners();
  }

//==================GUARDA IMAGENES AL SERVIDOR==========================//
List<String> respuestasImagenes = [];
Future<void> enviarImagenesAlServidor(BuildContext context,String _usuario)  async {

  // List<String> listaStrings = listaImages.map((file) => file.path).toList();

            //  print("la nueva lista: ${listaStrings}" );




   final dataUser = await Auth.instance.getSession();
  final url = Uri.parse('https://backsigeop.neitor.com/api/multimedias');


  var request = _http.MultipartRequest('POST', url);
     //for token
    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

  for (var i = 0; i < _listaImages.length; i++) {
    request.files.add(await _http.MultipartFile.fromPath('foto$i', _listaImages[i].path));
  }

  var response = await request.send();
 if (response.statusCode == 200) {
  String respuesta = await response.stream.bytesToString();
  respuestasImagenes.add(respuesta);
// Map<String, dynamic> mapa = json.decode(respuestasImagenes[0]);
Map<String, dynamic> mapa = json.decode(respuestasImagenes[0]);

List<dynamic> urls = mapa["urls"];

  for (var item in urls) {

      _listaFotosUrl!.addAll([
        {
          "nombre": item["nombre"],
             
          "url": item["url"],
        }
      ]);

  
  }
  //  print('La Urs Son  $_listaFotosUrl');
   if( _usuario=='GUARDIA'){

 creaBitacoraGuardia(context);

          }else  if( _usuario=='RESIDENTE'){
            creaBitacoraResidente(context);
          }


} else {
  print('Error al enviar la imagen ');
 
}


 
// print('FOTO: ${ listaImages}');

}
//  =================  CREO UN DEBOUNCE BUSCAR CLIENTES ==================//

  Timer? _deboucerSearchBuscaPersonaBitacora;

  String? _inputBuscaPersonaBitacora;
  get getInputBuscaPersonaBitacora => _inputBuscaPersonaBitacora;
  void onInputBuscaPersonaBitacoraChange(String? text) {
    _inputBuscaPersonaBitacora = text;
  
//================================================================================//
 
    if (_inputBuscaPersonaBitacora!.length >= 3) {
      _deboucerSearchBuscaPersonaBitacora?.cancel();
      _deboucerSearchBuscaPersonaBitacora =
          Timer(const Duration(milliseconds: 500), () {
        getTodasPersonasBitacora(_inputBuscaPersonaBitacora);
     });
    } else if (_inputBuscaPersonaBitacora!.isEmpty) {
      getTodasPersonasBitacora('');
    } else {
      getTodasPersonasBitacora('');
    }

    notifyListeners();
  }


//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//
  List<dynamic> _listaAutorizadosBitacora = [];
  List<dynamic> get getListaAutorizadosBitacora =>
      _listaAutorizadosBitacora;

  void setListaAutorizadosBitacora(List<dynamic> data) {
    _listaAutorizadosBitacora=[];
    _listaAutorizadosBitacora.addAll(data);
    // print('LA DATA: $_listaTodasPersonasBitacora');
    notifyListeners();
  }


  List<dynamic> _listaTodasPersonasBitacora = [];
  List<dynamic> get getListaTodasPersonasBitacora =>
      _listaTodasPersonasBitacora;

  void setListaTodasPersonasBitacora(List<dynamic> data) {
    _listaTodasPersonasBitacora=[];
    _listaTodasPersonasBitacora.addAll(data);
    // print('LA DATA: $_listaTodasPersonasBitacora');
    notifyListeners();
  }

  bool? _errorTodasPersonasBitacora; // sera nulo la primera vez
  bool? get getErrorTodasPersonasBitacora => _errorTodasPersonasBitacora;

  Future getTodasPersonasBitacora(String? search) async {
    final dataUser = await Auth.instance.getSession();
     final idTurno = await Auth.instance.getIdRegistro();

 final response = await _api.getAllPersonasBitacora(
     search: search,
     regId: '$idTurno',
     cliId:'',
    cliUbicacion:'',
    cliPuesto:'',
     token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorTodasPersonasBitacora = true;
     
      setListaTodasPersonasBitacora(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodasPersonasBitacora = false;
      notifyListeners();
      return null;
    }
    return null;
  }


dynamic _infPersonaDirige='';
dynamic get getInfPersonaDirige=>_infPersonaDirige;



 void setDirigidoAChange(dynamic _persona) {
  print('LA DATA ES: $_persona');
  // _itemSeDirigeA=_persona['resNombres'];
  _infPersonaDirige=_persona;


  //  for (var item in _persona) {
    
  // _listaAutorizadosBitacora.add(item);
  // }

// _listaAutorizadosBitacora=_persona;
// print('data : ${_infPersonaDirige['resPersonasAutorizadas'].runtimeType}');
// print('data : ${_persona['resPersonasAutorizadas'].runtimeType}');
print('data : ${_persona}');



  //   _idCliente = persona['perId'];
  //   infDocNumDirigido = persona['perDocNumero'];
  //   _textDirigidoA = '${persona['perApellidos']} ${persona['perNombres']}';
  // _infCorreosCliente = persona?['perEmail'];
 notifyListeners();
  }

//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//
  Map<String,dynamic> _listaTodasBitacoraResidente = {};
   Map<String,dynamic> get getListaTodasBitacoraResidente =>
      _listaTodasBitacoraResidente;

  void setListaTodasBitacoraResidente( Map<String,dynamic> data) {
    setInfoBitacora(data);
    _listaTodasBitacoraResidente={};
    _listaTodasBitacoraResidente.addAll(data);
    print('LA DATA: $_listaTodasBitacoraResidente');
    print('LA DATA: ${_listaTodasBitacoraResidente['resCliDocumento']}');
    // setItemSeDirigeA(_listaTodasBitacoraResidente['resCliDocumento']);
    _itemCedula = _listaTodasBitacoraResidente['resCedula'];
    _itemSeDirigeA=_listaTodasBitacoraResidente['resNombres'];
    _itemCasaDepartamento=_listaTodasBitacoraResidente['resDepartamento'];
  
    _listaAutorizadosBitacora=_listaTodasBitacoraResidente['resPersonasAutorizadas'];
    notifyListeners();
  }

  bool? _errorTodasBitacoraResidente; // sera nulo la primera vez
  bool? get getErrorTodasBitacoraResidente => _errorTodasBitacoraResidente;

  Future getInfoClienteResidente(String? search) async {
    final dataUser = await Auth.instance.getSession();
     final idTurno = await Auth.instance.getIdRegistro();

 final response = await _api.getAllClienteResidentes(
     search: search,
    
     token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorTodasBitacoraResidente = true;
     
      // setListaTodasBitacoraResidente(response);
      print('LA DATA de LISTA BITACORA: $response');

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodasBitacoraResidente = false;
      notifyListeners();
      return null;
    }
    return null;
  }



//*******************  NUEVA FORMA DE BITACORA **************************//
Map _residente ={};

Map get getResidente=>_residente;

void setResidente(Map _info){
_residente={};
_residente=_info;
  //  print('LA INFO DE RESIDENTE: $_residente'); 

  notifyListeners();
}

// final _residente={
// "id":"1",
// "cedula":"123456789",
// "cliente":"PEDRO EMILIO CORNEJO RAMIREZ",
// "piso":"2",
// "oficina":"5",
// };


 String? _itemTipoDocumento = '';
  String? get getItemTipoDocumento => _itemTipoDocumento;
  void setItemTipoDocumento(String? _val) {
    _itemTipoDocumento = _val;
    // print('TIPO DE Documento: $_itemTipoDocumento'); 
    notifyListeners();
  }

void resetFormBitacora(){

_itemTipoDocumento = '';
_itemTipoPersona = '';
_itemPersonaDestino = {};



notifyListeners();

}



//**********TOMA FOTOS CEDULA - PASAPORTE - PLACA*************//


//  XFile? _frontImage;
//   XFile? _backImage;
//     XFile? _placaImage;
//      XFile? _pasaporteImage;
  
//   bool _isPicking = false;

//   XFile? get frontImage => _frontImage;
//   XFile? get backImage => _backImage;
//     XFile? get placaImage => _placaImage;
//      XFile? get pasaporteImage => _pasaporteImage;
//   bool get isPicking => _isPicking;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickFrontImage() async {
//     if (_isPicking) return;
//     _isPicking = true;
//     notifyListeners();

//     try {
//       final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         _frontImage = pickedImage;
//         _imageCedulaFront=_frontImage!.path;
//       }
//     } finally {
//       _isPicking = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pickBackImage() async {
//     if (_isPicking) return;
//     _isPicking = true;
//     notifyListeners();

//     try {
//       final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         _backImage = pickedImage;
//         _imageCedulaBack=_backImage!.path;
//       }
//     } finally {
//       _isPicking = false;
//       notifyListeners();
//     }
//   }
// Future<void> pickPlacaImage() async {
//     if (_isPicking) return;
//     _isPicking = true;
//     notifyListeners();

//     try {
//       final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         _placaImage = pickedImage;
//         _imagePlaca=_placaImage!.path;
//       }
//     } finally {
//       _isPicking = false;
//       notifyListeners();
//     }
//   }




// Future<void> pickPasaporteImage() async {
//     if (_isPicking) return;
//     _isPicking = true;
//     notifyListeners();

//     try {
//       final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         _pasaporteImage = pickedImage;
//         _imagePasaporte=_pasaporteImage!.path;
//       }
//     } finally {
//       _isPicking = false;
//       notifyListeners();
//     }
//   }


void removeFrontBackPlacaImage() {
   
    _itemObservacionBitacora='';
      _itemTipoDocumento = '';
       _itemTipoPersona = '';
       _cedulas='';
   _dataCedula={};
    
      
   _controllerTextCedulaIngresoVisita.text='';
_itemCedulaVisitaBitacora = '';
_itemNombreVisitaBitacora = '';
_itemObservacionBitacora = '';


    notifyListeners();
  }

void removeFrontBackPlacaImageAll() {
   
    _itemObservacionBitacora='';
      _itemTipoDocumento = '';
       _itemTipoPersona = '';
       _cedulas='';
   _dataCedula={};
     _placas='';
   _dataPlaca={};
      
   
_itemCedulaVisitaBitacora = '';
_itemNombreVisitaBitacora = '';
_itemObservacionBitacora = '';
_itemCedulaPropietarioVehiculoBitacora = '';
_itemNombrePropietarioVehiculoBitacora = '';
_modeloVehiculoProp='';

    notifyListeners();
  }







 void removeFrontImage() {
    _frontImage = null;
   _cedulas='';
   _dataCedula={};
   setTextCedula('');
 
    notifyListeners();
  }

  void removeBackImage() {
    _backImage = null;
    notifyListeners();
  }
   void removePlacaImage() {
    _placaImage = null;
    _placas='';
   _dataPlaca={};
   _placaOk= false;
   setTextPlaca('');
   setPlacaPropVehiculo('');
   
    notifyListeners();
  }
 void removeVisitanteImage() {
    _visitanteImage = null;
     
    notifyListeners();
  }
   void removePasaporteImage() {
    _pasaporteImage = null;
    notifyListeners();
  }



 //  =================  RADIO BOTTON TIPO INGRESO  ==================//
 int _radioValueTipoIngreso = 1;
 String _opcionTipoIngreso = 'PARQUEADERO';
  int get radioValueTipoIngreso => _radioValueTipoIngreso;
String get getOpcionTipoIngreso => _opcionTipoIngreso;

  void setRadioTipoIngreso(int value) {
    _radioValueTipoIngreso = value;
    switch (_radioValueTipoIngreso) {
      case 0:
      _opcionTipoIngreso = 'RECEPCION';
       
        break;
      case 1:
        _opcionTipoIngreso = 'PARQUEADERO';
       
        break;
     
      default:
        _opcionTipoIngreso = 'PARQUEADERO';
    
    }    
    print('radio botton # : $_radioValueTipoIngreso');
        print('radio botton _opcionTipoIngreso # : $_opcionTipoIngreso');

    notifyListeners();
  }

 //  =================  RADIO BOTTON TIPO VEHCULO  ==================//
 int _radioValueVehiculo = 1;
 String _opcionVehiculo = 'NO';
  int get radioValueVehiculo => _radioValueVehiculo;
String get getOpcionVehiculo => _opcionVehiculo;

  void setRadioVehiculo(int value) {
    _radioValueVehiculo = value;
    switch (_radioValueVehiculo) {
      case 0:
      _opcionVehiculo = 'SI';
       
        break;
      case 1:
        _opcionVehiculo = 'NO';
       
        break;
     
      default:
        _opcionVehiculo = '';
    
    }    
    print('radio botton # : $_radioValueVehiculo');
        print('radio botton _opcionVehiculo # : $_opcionVehiculo');

    notifyListeners();
  }
  //*************************** LISTA DE VISITAS AL CREAR UNA BITACORA  *************************************/
String _imageCedulaFront='';
String _imageCedulaBack='';
String _imagePasaporte='';
String _imagePlaca='';
 String? _cedulaVisita = "";
  String? get getCedulaVisita => _cedulaVisita;
  void setCedulaVisita(String? value) {
    _cedulaVisita = value;
       print('_cedulaVisita: $_cedulaVisita');
       notifyListeners();
  }
   String? _pasaporteVisita = "eliminaItemVisita";
  String? get getPasaporteVisita => _pasaporteVisita;
  void setPasaporteVisita(String? value) {
    _pasaporteVisita = value;
       print('_pasaporteVisita: $_pasaporteVisita');
       notifyListeners();
  }
  String? _nombreVisita = '';
  String? get getnombreVisita => _nombreVisita;
  void setNombreVisita(String? value) {
    _nombreVisita = value;
       print('_nombreVisita: $_nombreVisita');
       notifyListeners();
  }
String? _dactilarVisita = '';
  String? get getdactilarVisita => _dactilarVisita;
  void setDactilarVisita(String? value) {
    _dactilarVisita = value;
       print('_dactilarVisita: $_dactilarVisita');
       notifyListeners();
  }
  String? _sexoVisita = '';
  String? get getsexoVisita => _sexoVisita;
  void setSexoVisita(String? value) {
    _sexoVisita = value;
       print('_sexoVisita: $_sexoVisita');
       notifyListeners();
  }

// List _listaVisitas=[];
// List get getListaVisitas=>_listaVisitas;
// void setVisitas(){

//   _listaVisitas.add({
// "id":_residente['id'],
// "cedula":"123456789",
// "cliente":"RODRIGUEZ LOOR JOSE EDUARDO",
// "piso":_residente['piso'],
// "oficina":_residente['oficina'],
// "cedulaVisita":_cedulaVisita,
// "fotoCedula":
// {
//   "cedulaFront":_imageCedulaFront,
//    "cedulaBack":_imageCedulaBack,
// },
// "pasaporteVisita":_pasaporteVisita,

// "fotoPasaporte":_imagePasaporte,
// "vehiculo":_opcionVehiculo,
// "fotoPlaca":_imagePlaca,
// "nombreVisita":"PEDRO EMILIO CORNEJO RAMIREZ",
// "dactilar":_dactilarVisita,
// "sexo":_sexoVisita,
// "observacion":_itemObservacion,

// });


//      print('LA INFORMACION DE LA LISTA VICITAS : $_listaVisitas');

// notifyListeners();
// }

void eliminaItemVisita(String _item){
    print('ID LISTA VICITAS : $_item');

_listaVisitas.removeWhere((e) => e['cedulaVisita']== _item,);

  notifyListeners();
}



void eliminaALLItemVisitas(){
   

_listaVisitas.clear();

  notifyListeners();
}


  XFile? _visitanteImage;
   XFile? _frontImage;
  XFile? _backImage;
  XFile? _placaImage;
  XFile? _pasaporteImage;
  bool _isPicking = false;

  List<Map<String, dynamic>> _listaVisitas = [];
  XFile? get visitanteImage => _visitanteImage;
  XFile? get frontImage => _frontImage;
  XFile? get backImage => _backImage;
  XFile? get placaImage => _placaImage;
  XFile? get pasaporteImage => _pasaporteImage;
  bool get isPicking => _isPicking;

  final ImagePicker _picker = ImagePicker();
 Future<void> pickVisitanteImage() async {
    await _pickImage((image)  async{
      _visitanteImage = image;
      // final file = File(_visitanteImage!.path);
  //  final foto= await upLoadImagens(file);
// setUrlVisitante(foto!);
      
     
    });
  }
  Future<void> pickFrontImage() async {
    await _pickImage((image) async{
      _frontImage = image;
      _readTextFromImage(_frontImage!,0);
//         final file = File(_visitanteImage!.path);
//    final foto= await upLoadImagens(file);
// setUrlCedulaFront(foto!);
      // _extractDataFromText(_frontImage);
    });
  }

  Future<void> pickBackImage() async {
    await _pickImage((image) async{
      _backImage = image;
       final file = File(_backImage!.path);
//    final foto= await upLoadImagens(file);
// setUrlCedulaBack(foto!);
        // _readTextFromImage(_backImage!,1);
    });
  }


  Future<void> pickPasaporteImage() async {
    await _pickImage((image) async{
      _pasaporteImage = image;
        _readTextFromImage(_pasaporteImage!,2);
//           final file = File(_pasaporteImage!.path);
//    final foto= await upLoadImagens(file);
// setUrlPasaporte(foto!);
    });
  }

  Future<void> pickPlacaImage() async {
    await _pickImage((image)async {
      _placaImage = image;
        _readTextFromImage(_placaImage!,3);
  //         final file = File(_visitanteImage!.path);
  //  final foto= await upLoadImagens(file);
  //  setUrlPlaca(foto!);
    });
  }


  Future<void> _pickImage(Function(XFile) setImage) async {
    if (_isPicking) return;
    _isPicking = true;
    notifyListeners();

    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera,imageQuality:70);
      if (pickedImage != null) {
        setImage(pickedImage);
      }
    } finally {
      _isPicking = false;
      notifyListeners();
    }
  }

  void addVisita(
    // Map<String, dynamic> visita
    ) {


  // Si todas las validaciones pasan, construye el mapa nuevoRegistro
  Map<String, dynamic> nuevoRegistro = {
    "id": getItemPersonaDestinol!['id'] ?? '',
    "cedula": getResidente['resCliDocumento'] ?? '',
    "cliente": getResidente['resCliNombre'] ?? '',
    "numeroDepartamento": getResidente['resDepartamento'][0]['nombre_dpt'] ?? '',
    "depatamento":getResidente['resDepartamento'][0]['numero']?? '',
     "tipoPersona":getItemTipoPersonal,
     "asunto":getItemAsunto,
    "fotoVisitante": getUrlVisitante,
    
    "cedulaVisita": getCedulaVisitantes,
    "nombreVisita": getNombreVisitantes,
     "telefonoVisita": getTelefonoVisitantes,
   
      "fotoCedulaFront": getUrlCedulaFront, //frontImage?.path ?? '',
      "fotoCedulaBack":   getUrlCedulaBack,//backImage?.path ?? '',
   
    "pasaporteVisita": getPasaporteVisita,
    "fotoPasaporte": getUrlPasaporte,
    "bitTipoIngreso":getOpcionTipoIngreso,
    //pasaporteImage?.path ?? '',
    "vehiculo": getOpcionVehiculo,
    "fotoPlaca":getUrlPlaca,// placaImage?.path ?? '',
    "cedulaPropietarioVehiculo": getCedulaPropVehiculo,
    "nombrePropietarioVehiculo": getNombrePropVehiculo,
    "placa": getPlacaPropVehiculo,
    "modelo": getModeloPropVehiculo,
    "observacion": getItemObservacionBitacora,
  };


  print('LA DATA PARA LA LISTA VISITA ============> $nuevoRegistro');

  // Agregar el registro al provider
  // _controller.addVisita(nuevoRegistro);

if (getDataVehiculo.isEmpty) {
  setDataVehiculo(
  {
"dni":getCedulaPropVehiculo,
"fullname":getNombrePropVehiculo,
"carRegistration":getPlacaPropVehiculo,
"model":getModeloPropVehiculo,
"fotoPlaca":'',
  }
);
}










     _listaVisitas.insert(0, nuevoRegistro); 
   
      print('LA INFORMACION DE LA LISTAS VISITAS : $_listaVisitas');
    notifyListeners();
  }

  void clearData() {
      _visitanteImage = null;
    _frontImage = null;
    _backImage = null;
    _placaImage = null;
    _pasaporteImage = null;
    _extractedText = '';
    notifyListeners();
  }

  List<Map<String, dynamic>> get listaVisitas => _listaVisitas;


//************  OCR  *****************//
  String _extractedText = '';
 String get extractedText => _extractedText;
  List<String> extractedTexts = [];

//  Future<String?>_readTextFromImage(XFile _image) async {
//      final _imageFile= File(_image.path);
//     // if (imageProvider.imageFile != null) {

//         final textRecognizer =TextRecognizer(script: TextRecognitionScript.latin);

//       final inputImage = InputImage.fromFile(_imageFile);
//       final RecognizedText recognizedText= await textRecognizer.processImage(inputImage);
//       String text=recognizedText.text;
//       textRecognizer.close();
     
//       // print('LA IMAGEN ESCANEADA TIPO----> : ${text.runtimeType}');
//       //  print('LA IMAGEN ESCANEADA JSON----> : ${text}');
//       //   print('LA IMAGEN ESCANEADA JSON--6--> : ${text[6]}');
//       //   print('LA IMAGEN ESCANEADA JSON--7--> : ${text[7]}');
//       //   print('LA IMAGEN ESCANEADA JSON--8--> : ${text[8]}');
//       //   print('LA IMAGEN ESCANEADA JSON--9--> : ${text[9]}');
//       //   print('LA IMAGEN ESCANEADA JSON--10--> : ${text[10]}');

//       return text;
  
//   }

 // Crear un mapa para almacenar las claves y valores extraídos
  // Map<String, String> _extractedDataCedulaA = {};
  // Map<String, String> get getExtractedDataCedulaA => _extractedDataCedulaA;
  //   Map<String, String> _extractedDataCedulaB = {};
  // Map<String, String> get getExtractedDataCedulaB => _extractedDataCedulaB;

  //   Map<String, String> _extractedData = {};
  // Map<String, String> get getExtractedData => _extractedData;

  //   Map<String, String> _extractedData = {};
  // Map<String, String> get getExtractedData => _extractedData;




//  Future<String?> _readTextFromImage(XFile image,int tipo) async {
 
//   // _extractedDataCedulaB = {};
//     final File imageFile = File(image.path);
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final inputImage = InputImage.fromFile(imageFile);
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//      String text=recognizedText.text;
//     textRecognizer.close();
//     //  final text = await _readTextFromImage(image);
//       extractedTexts = text.split('\n'); 
//       print('LA IMAGEN ESCANEADA TIPO----> : ${extractedTexts.runtimeType}');
//        print('LA IMAGEN ESCANEADA JSON----> : ${extractedTexts}');
//        // Definir las claves que queremos extraer

//     if (tipo==0) {
//  _extractedDataCedulaA = {};

//         List<String> keys = ['NUL', 'APELLIDOS','NOMBRES','SEXO'];
//   // Recorrer la lista y extraer las claves y sus valores
//   for (int i = 0; i < extractedTexts.length; i++) {
//     for (String key in keys) {
//       if (extractedTexts[i].startsWith(key)) {
//         // Extraer el valor correspondiente a la clave
//         String value = '';
//         if (key == 'NUL') {
//           value = extractedTexts[i].substring(extractedTexts[i].indexOf('.') + 1);
//         } else {
//           value = extractedTexts[i + 1];
//         }
//         _extractedDataCedulaA[key] = value;
//       }
//     }
//   }
//    // Imprimir los datos extraídos
//     print('DATA EXTRAIDA -- 0 --> : ${_extractedDataCedulaA}');
//  notifyListeners();
//     // return recognizedText.text;
      
//     } else  if (tipo==1) {
     

//   // Definir los parámetros que queremos extraer
//   List<String> keys = ['CÓDIGO DACTILAR'];

//   // Crear un mapa para almacenar los parámetros y valores extraídos
//   _extractedDataCedulaB = {};

//   // Recorrer la lista y extraer los parámetros y sus valores
//   for (int i = 0; i < extractedTexts.length; i++) {
//     if (keys.contains(extractedTexts[i])) {
//       String key = extractedTexts[i];
//       if (i + 1 < extractedTexts.length) {
//         String value = extractedTexts[i + 1];
//         _extractedDataCedulaB[key] = value;
//       }
//     }
//   }

//  // Imprimir los datos extraídos
//     print('DATA EXTRAIDA -- 1 --> : ${_extractedDataCedulaB}');
//  notifyListeners();
//     // return recognizedText.text;


//     }

 
//   }

 String _cedulas='';

 String get getCedulas=>_cedulas;
void setCedulaVerificar( String cedulas )
{

_cedulas=cedulas;
 print('LA LA CEDULA ESCANEADA----> : ${_cedulas}');
 setTextCedula(_cedulas);

// getCedulaVisitante(_cedulas);
  notifyListeners();
}

 String _placas='';

 String get getPlacas=>_placas;
void setPlacaVerificar( String _placa )
{
// _placas='';
_placas=_placa;
 print('LA LA PLACA ESCANEADA----> : ${_placas}');


  setTextPlaca(_placas);
// getCedulaVisitante(_cedulas);
  notifyListeners();
}


// Future _readTextFromImage(XFile image,int tipo) async {
 
//   // _extractedDataCedulaB = {};
//     final File imageFile = File(image.path);
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final inputImage = InputImage.fromFile(imageFile);
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//      String text=recognizedText.text;
//     textRecognizer.close();
//     //  print('LA IMAGEN ESCANEADA TEXT----> : ${text.runtimeType}');
//     //   print('LA IMAGEN ESCANEADA TEXT----> : ${text}');
//       extractedTexts = text.split('\n'); 
//       // print('LA IMAGEN ESCANEADA TIPO----> : ${extractedTexts.runtimeType}');
//       //  print('LA IMAGEN ESCANEADA JSON----> : ${extractedTexts}');
//        // Definir las claves que queremos extraer
//  String cedulaInfo = extraerCedula(extractedTexts);

//    cedulaInfo.replaceAll('-','');

//  setCedulaVerificar(cedulaInfo);
  
// }

Future _readTextFromImage(XFile image, int tipo) async {
 
  final File imageFile = File(image.path);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final inputImage = InputImage.fromFile(imageFile);
  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  String text = recognizedText.text;
  textRecognizer.close();

  List<String> extractedTexts = text.split('\n');
    print('LA IMAGEN ESCANEADA TIPO----> : ${extractedTexts.runtimeType}');
       print('LA IMAGEN ESCANEADA JSON----> : ${extractedTexts}');
  
  if (tipo == 0) {
    String cedulaInfo = extraerCedula(extractedTexts);
    cedulaInfo = cedulaInfo.replaceAll('-','');
    setCedulaVerificar(cedulaInfo.trim());
  //        final file = File(image.path);
  //  final foto= await upLoadImagens(file);
  //  setUrlCedulaFront(foto!);




  } else if (tipo == 3) {
    String placaInfo = extraerPlaca(extractedTexts);
    setPlacaVerificar(placaInfo);
//        final file = File(image.path);
//    final foto= await upLoadImagens(file);
// setUrlPlaca(foto!);
  }
}




String extraerCedula(List<String> lista) {
  // Unir la lista en un solo String
  String texto = lista.join(' ');

  // Definir la expresión regular para encontrar la cédula
  RegExp regExp = RegExp(r'\b\d{9}-?\d{1}\b');

  // Buscar coincidencias en el texto
  Match? match = regExp.firstMatch(texto);

  // Devolver solo el número de cédula sin guion
  return match != null ? match.group(0)?.replaceAll('-', '') ?? '' : '';
}

// String extraerPlaca(List<String> lista) {
//   String texto = lista.join(' ');
//   RegExp regExp = RegExp(r'\b[A-Z]{3}-\d{3,4}\b');
//   Match? match = regExp.firstMatch(texto);
//   return match != null ? match.group(0) ?? 'No se encontró placa' : 'No se encontró placa';
// }

// String extraerPlaca(List<String> lista) {
//   String texto = lista.join(' ');
//   // Expresión regular para coincidir con placas de automóviles y motocicletas
//   RegExp regExp = RegExp(r'\b[A-Z]{2,3}-\d{3,4}\b');
//   Match? match = regExp.firstMatch(texto);
//   return match != null ? match.group(0) ?? 'No se encontró placa' : 'No se encontró placa';
// }
String extraerPlaca(List<String> lista) {
  // Combinar las líneas dos a dos para capturar posibles placas de motocicletas
  List<String> combinaciones = [];
  for (int i = 0; i < lista.length - 1; i++) {
    combinaciones.add(lista[i] + lista[i + 1]);
  }

  // Unir la lista completa en un solo string
  String texto = lista.join(' ') + ' ' + combinaciones.join(' ');

  // Expresión regular para coincidir con placas de automóviles y motocicletas
  RegExp regExp = RegExp(r'\b([A-Z]{2,3}-?\d{3,4}[A-Z]?)\b');
  Match? match = regExp.firstMatch(texto);
  return match != null ? match.group(1) ?? '' : '';
}

// String extraerPlaca(List<String> lista) {
//   // Unir la lista en un solo String
//   String texto = lista.join(' ');

//   // Definir la expresión regular para encontrar la placa
//   RegExp regExp = RegExp(r'\b[A-Z]{3}-\d{3,4}\b');

//   // Buscar coincidencias en el texto
//   Match? match = regExp.firstMatch(texto);

//   // Devolver la placa encontrada o indicar que no se encontró
//   return match != null ? match.group(0) ?? 'No se encontró placa' : 'No se encontró placa';
// }
//  Future<String?> _readTextFromImage(XFile image,int tipo) async {
 
//   // _extractedDataCedulaB = {};
//     final File imageFile = File(image.path);
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final inputImage = InputImage.fromFile(imageFile);
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//      String text=recognizedText.text;
//     textRecognizer.close();
//     //  print('LA IMAGEN ESCANEADA TEXT----> : ${text.runtimeType}');
//     //   print('LA IMAGEN ESCANEADA TEXT----> : ${text}');
//       extractedTexts = text.split('\n'); 
//       // print('LA IMAGEN ESCANEADA TIPO----> : ${extractedTexts.runtimeType}');
//       //  print('LA IMAGEN ESCANEADA JSON----> : ${extractedTexts}');
//        // Definir las claves que queremos extraer
//  String cedulaInfo = extraerCedula(extractedTexts);
//   // String cedula2 = extraerCedula(extractedTexts);


//    cedulaInfo.replaceAll('-','');

//  setCedulaVerificar(cedulaInfo);
//   //  cedula2.replaceAll('-','');

//   // print('Cédula extraída de lista 1: $cedula1');



//   // print('Cédula extraída de lista 2: $cedula2');
// // extraeData(text);
// //********************/

//   // Encontrar el índice de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'
//   // int startIndex = extractedTexts.indexWhere((element) => element.startsWith("APELLIDOS Y NOMBRES") || element.startsWith("APELLIDOS YNOMBRES")|| element.startsWith("APELLIDOS"));
//   // if (startIndex != -1) {
//   //   startIndex++; // Avanzar al siguiente elemento después de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'
//   //   // Encontrar el índice de 'LUGAR DE NACIMIENTO' después del índice de inicio
//   //   int endIndex = extractedTexts.indexOf("LUGAR DE NACIMIENTO", startIndex);
//   //   if (endIndex != -1) {
//   //     // Extraer la información entre 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES' y 'LUGAR DE NACIMIENTO'
//   //     List<String> extractedData = extractedTexts.sublist(startIndex, endIndex);
//   //     // Convertir la lista en una cadena separada por espacios
//   //     String extractedInfo = extractedData.join(' ');
//   //     // Imprimir la información extraída
//   //     print("Información extraída:");
//   //     print(extractedInfo);
//   //   } else {
//   //     print("No se encontró 'LUGAR DE NACIMIENTO' después de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'.");
//   //   }
//   // } else {
//   //   print("No se encontró 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES' en la lista.");
//   // }

// // Encontrar el índice de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'




//   // int startIndex = extractedTexts.indexWhere((element) => element.startsWith("APELLIDOS Y NOMBRES") || element.startsWith("APELLIDOS YNOMBRES"));
//   // if (startIndex != -1) {
//   //   startIndex++; // Avanzar al siguiente elemento después de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'

//   //   // Encontrar el índice de 'LUGAR DE NACIMIENTO' después del índice de inicio
//   //   int endIndex = extractedTexts.indexOf("LUGAR DE NACIMIENTO", startIndex);
//   //   if (endIndex != -1) {
//   //     // Extraer la información entre 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES' y 'LUGAR DE NACIMIENTO'
//   //     List<String> extractedData = extractedTexts.sublist(startIndex, endIndex);

//   //     // Convertir la lista en una cadena separada por espacios
//   //     String extractedInfo = extractedData.join(' ');

//   //     // Manejar la variación de 'No.' o 'No' o 'NUL'
//   //     int noIndex = extractedTexts.indexWhere((element) => element.startsWith("No.") || element.startsWith("No") || element.startsWith("Na.")|| element.startsWith("N ")|| element.startsWith("NUL"));
//   //     if (noIndex != -1) {
//   //       // Agregar también el elemento que sigue a 'No.' o 'No' o 'NUL'
//   //       extractedInfo = extractedTexts[noIndex] + " " + extractedInfo;
//   //     }

//   //     // Buscar el índice de 'SEXO'
//   //     int sexoIndex = extractedTexts.indexWhere((element) => element.startsWith("SEXO"));
//   //     if (sexoIndex != -1) {
//   //       // Agregar también el elemento que sigue a 'SEXO'
//   //       extractedInfo += " " + extractedTexts[sexoIndex];
//   //     }
//   //     // Imprimir la información extraída
//   //     print("Información extraída:");
//   //     print(extractedInfo);
//   //   } else {
//   //     print("No se encontró 'LUGAR DE NACIMIENTO' después de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'.");
//   //   }
//   // } else {
//   //   print("No se encontró 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES' en la lista.");
//   // }

// // // Función para encontrar el índice de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'
// //   int findStartIndex(List<String> texts) {
// //     return texts.indexWhere((element) =>
// //         element.startsWith("APELLIDOS Y NOMBRES") ||
// //         element.startsWith("APELLIDOS YNOMBRES"));
// //   }

// //   // Función para extraer la información desde 'APELLIDOS Y NOMBRES' hasta 'LUGAR DE NACIMIENTO'
// //   String extractInfoBetween(List<String> texts, int startIndex) {
// //     if (startIndex != -1) {
// //       // Encontrar el índice de 'LUGAR DE NACIMIENTO' después del índice de inicio
// //       int endIndex = texts.indexOf("LUGAR DE NACIMIENTO", startIndex);
// //       if (endIndex != -1) {
// //         // Extraer la información desde 'APELLIDOS Y NOMBRES' hasta 'LUGAR DE NACIMIENTO'
// //         List<String> extractedData = texts.sublist(startIndex + 1, endIndex);

// //         // Unir los elementos de la lista desde startIndex + 1 hasta endIndex
// //         String extractedInfo = extractedData.join(' ');

// //         return extractedInfo;
// //       }
// //     }
// //     return '';
// //   }

// //   // Función para manejar la variación de 'No.' o 'No' o 'NUL'
// //   String handleNoVariation(List<String> texts) {
// //     int noIndex = texts.indexWhere((element) =>
// //         element.startsWith("No.") ||
// //         element.startsWith("No") ||
// //         element.startsWith("Na.") ||
// //         element.startsWith("N ") ||
// //         element.startsWith("NUL"));
// //     if (noIndex != -1) {
// //       // Retorna el elemento que sigue a 'No.' o 'No' o 'NUL'
// //       return texts[noIndex];
// //     }
// //     return '';
// //   }

// //   // Función para manejar la búsqueda de 'SEXO'
// //   String handleSexo(List<String> texts) {
// //     int sexoIndex = texts.indexWhere((element) => element.startsWith("SEXO"));
// //     if (sexoIndex != -1) {
// //       // Retorna el elemento que sigue a 'SEXO'
// //       return texts[sexoIndex];
// //     }
// //     return '';
// //   }

// //   // Código Principal para 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'
// //   int startIndex = findStartIndex(extractedTexts);
// //   if (startIndex != -1) {
// //     // Extraer la información desde 'APELLIDOS Y NOMBRES' hasta 'LUGAR DE NACIMIENTO'
// //     String extractedInfo = extractInfoBetween(extractedTexts, startIndex);

// //     if (extractedInfo != null) {
// //       // Imprimir la información extraída principal
// //       print("Información extraída principal:");
// //       print(extractedInfo);
// //     } else {
// //       print("No se encontró 'LUGAR DE NACIMIENTO' después de 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES'.");
// //     }
// //   } else {
// //     print("No se encontró 'APELLIDOS Y NOMBRES' o 'APELLIDOS YNOMBRES' en la lista.");
// //   }

// //   // Manejar la variación de 'No.' o 'No' o 'NUL'
// //   String noInfo = handleNoVariation(extractedTexts);
// //   if (noInfo != null) {
// //     // Imprimir la información extraída para 'No.' o 'No' o 'NUL'
// //     print("Información extraída para 'No.' o 'No' o 'NUL':");
// //     print(noInfo);
// //   } else {
// //     print("No se encontró 'No.' o 'No' o 'NUL' en la lista.");
// //   }

// //   // Manejar la búsqueda de 'SEXO'
// //   String sexoInfo = handleSexo(extractedTexts);
// //   if (sexoInfo != null) {
// //     // Imprimir la información extraída para 'SEXO'
// //     print("Información extraída para 'SEXO':");
// //     print(sexoInfo);
// //   } else {
// //     print("No se encontró 'SEXO' en la lista.");
// //   }

// // //***********************/

// //  _extractedDataCedulaA = {};

// //         List<String> keys = ['NUL', 'APELLIDOS','NOMBRES','SEXO'];
// //   // Recorrer la lista y extraer las claves y sus valores
// //   for (int i = 0; i < extractedTexts.length; i++) {
// //     for (String key in keys) {
// //       if (extractedTexts[i].startsWith(key)) {
// //         // Extraer el valor correspondiente a la clave
// //         String value = '';
// //         if (key == 'NUL') {
// //           value = extractedTexts[i].substring(extractedTexts[i].indexOf('.') + 1);
// //         } else {
// //           value = extractedTexts[i + 1];
// //         }
// //         _extractedDataCedulaA[key] = value;
// //       }
// //     }
// //   }
// //    // Imprimir los datos extraídos
// //     print('DATA EXTRAIDA -- 0 --> : ${_extractedDataCedulaA}');
// //  notifyListeners();
// //     // return recognizedText.text;

// //   }



// // String extractDataAfter(List<String> dataList, String keyword) {
// //   String data = "";
// //   int index = dataList.indexOf(keyword);
// //   if (index != -1 && index + 1 < dataList.length) {
// //     data = dataList[index + 1];
// //   }
// //   return data;
// // }

// // String extractNumberAfter(List<String> dataList, String keyword) {
// //   String number = "";
// //   for (String item in dataList) {
// //     if (item.startsWith(keyword)) {
// //       // Extract the number part after "No"
// //       number = item.substring(keyword.length).trim();
// //       break;
// //     }
// //   }
// //   return number;
// }




// // String extraerCedula(List<String> lista) {
// //   // Unir la lista en un solo String
// //   String texto = lista.join(' ');

// //   // Definir la expresión regular para encontrar la cédula
// //   RegExp regExp = RegExp(r'(?:NUI\.|No\.|Na)?\s*\b\d{6}\s*\d{3}-?\d{1}\b');

// //   // Buscar coincidencias en el texto
// //   Match? match = regExp.firstMatch(texto);

// //   // Devolver la coincidencia encontrada o un mensaje de error si no se encuentra
// //   return match != null ? match.group(0) ?? 'No se encontró cédula' : 'No se encontró cédula';
// // }




// String extraerCedula(List<String> lista) {
//   // Unir la lista en un solo String
//   String texto = lista.join(' ');

//   // Definir la expresión regular para encontrar la cédula
//   RegExp regExp = RegExp(r'\b\d{9}-?\d{1}\b');

//   // Buscar coincidencias en el texto
//   Match? match = regExp.firstMatch(texto);

//   // Devolver solo el número de cédula sin guion
//   return match != null ? match.group(0)?.replaceAll('-', '') ?? '' : '';
// }


//*************CONSULTA CEDULA VISITANTE***********//

Map<String,dynamic> _dataCedula={};
Map<String,dynamic> get getDataCedula=>_dataCedula;
void setDataCedula(Map<String,dynamic> _data){

//============INFO DE VISITANTE============//



if (_data.isNotEmpty) {
  _cedulaVisitantes='';


_nombreVisitantes='';
_telefonoVisitantes='';


_dataCedula={};
_dataCedula=_data;

 _cedulaVisitantes=_dataCedula['perDocNumero'];
 _nombreVisitantes='${_dataCedula['perApellidos']} ${_dataCedula['perNombres']}';
 _telefonoVisitantes=_dataCedula['perTelefono'].isNotEmpty?_dataCedula['perTelefono'][0]:"";
}else {
  _cedulaVisitantes='';


_nombreVisitantes='';

 _telefonoVisitantes='';

_dataCedula={};

}




print('DATA DE LA CEDULA API --> : ${_dataCedula}');
notifyListeners();

}


Future<dynamic> getCedulaVisitante(
    String? search,
   
  ) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getCedulaVisita(
      search: search,
      tipo:_itemTipoPersona ,
      token: '${dataUser!.token}',
    );

    if (response != null) {
     

     

      setDataCedula(response);
   

      notifyListeners();
      return response;
    }
    if (response == null) {
    
      notifyListeners();
      return null;
    }
    return null;
  }



//*************************//

//*************CONSULTA CEDULA VISITANTE***********//

Map<String,dynamic> _dataPaca={};
Map<String,dynamic> get getDataPaca=>_dataPaca;
void setDataPaca(Map<String,dynamic> _data){
_dataPaca={};
_dataPaca=_data;
print('DATA DE LA Placa API --> : ${_dataPaca}');
notifyListeners();

}


Future<dynamic> getVehiculoPlavaVisitante(
    String? search,
   
  ) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getPlacaVehiculoVisita(
     
      placa:_placas ,
      token: '${dataUser!.token}',
    );

    if (response != null) {
     

     

      setDataPlaca(response);
   

      notifyListeners();
      return response;
    }
    if (response == null) {
    
      notifyListeners();
      return null;
    }
    return null;
  }



//*************************//

 bool _cedulaOk= false;

 bool get getCedulaOK=>_cedulaOk;
void setCedulaOk( bool _isCed )
{

_cedulaOk=_isCed;
 

// getCedulaVisitante(_cedulas);
  notifyListeners();
}

 bool _placaOk= false;

 bool get getPlacaOk=>_placaOk;
void setPlacaOk( bool _isPlac )
{

_placaOk=_isPlac;
 

// getCedulaVisitante(_cedulas);
  notifyListeners();
}

Map<String,dynamic> _dataPlaca={};
Map<String,dynamic> get getDataPlaca=>_dataPlaca;
void setDataPlaca(Map<String,dynamic> _data){

if (_data.isNotEmpty) {
  _dataPlaca={};
 _cedulaPropVehiculo='';
 _nombrePropVehiculo='';
 _placaVehiculoProp='';
  _modeloVehiculoProp='';

_dataPlaca=_data;

 _cedulaPropVehiculo=_dataPlaca['dni'];
 _nombrePropVehiculo=_dataPlaca['fullname'];
 _placaVehiculoProp=_dataPlaca['carRegistration'];
  _modeloVehiculoProp=_dataPlaca['model'];
}else {
   _dataPlaca={};
 _cedulaPropVehiculo='';
 _nombrePropVehiculo='';
 _placaVehiculoProp='';
  _placaVehiculoProp='';

}

print('DATA DE LA Placa API --> : ${_dataPlaca}');

notifyListeners();

}


Map<String,dynamic> _dataVihiculo={};
Map<String,dynamic> get getDataVehiculo=>_dataPlaca;
void setDataVehiculo(Map<String,dynamic> _data){
_dataVihiculo={};
_dataVihiculo=_data;
print('_dataVihiculo --================== > : ${_dataVihiculo}');
notifyListeners();
}

void setDataVehiculoAddFoto(String _data){

_dataVihiculo['fotoPlaca']=_data;
print('_dataVihiculo --================== > : ${_dataVihiculo}');
notifyListeners();
}





//============INFO DE VISITANTE============//
String _cedulaVisitantes='';
String get getCedulaVisitantes=>_cedulaVisitantes;
void setCedulaVisitantes(String _ced){
  _cedulaVisitantes=_ced;

print('_cedulaVisita --> : ${_cedulaVisitantes}');
notifyListeners();
}

String _nombreVisitantes='';
String get getNombreVisitantes=>_nombreVisitantes;
void setNombreVisitantes(String _nom){
 
_nombreVisitantes=_nom;
print('_nombreVisitante --> : ${_nombreVisitantes}');
notifyListeners();
}

String _telefonoVisitantes='';
String get getTelefonoVisitantes=>_telefonoVisitantes;
void setTelefonoVisitantes(String _tel){
 
_telefonoVisitantes=_tel;
print('_telefonoVisitante --> : ${_telefonoVisitantes}');
notifyListeners();
}



//============INFO DE PROPIETARIOVEHICULO============//
String _cedulaPropVehiculo='';
String get getCedulaPropVehiculo=>_cedulaPropVehiculo;
void setCedulaPropVehiculo(String _ced){
  
_cedulaPropVehiculo=_ced;
print('_cedulaPropVehiculo --> : ${_cedulaPropVehiculo}');
notifyListeners();
}

String _nombrePropVehiculo='';
String get getNombrePropVehiculo=>_nombrePropVehiculo;
void setNombrePropVehiculo(String _nom){
 
_nombrePropVehiculo=_nom;
print('_nombrePropVehiculo --> : ${_nombrePropVehiculo}');
notifyListeners();
}

String _placaVehiculoProp='';
String get getPlacaPropVehiculo=>_placaVehiculoProp;
void setPlacaPropVehiculo(String _placa){
  
_placaVehiculoProp=_placa;
print('_placaVehiculoProp --> : ${_placaVehiculoProp}');
notifyListeners();
}
String _modeloVehiculoProp='';
String get getModeloPropVehiculo=>_modeloVehiculoProp;
void setModeloPropVehiculo(String _placa){
  
_modeloVehiculoProp=_placa;
print('_modeloVehiculoProp --> : ${_modeloVehiculoProp}');
notifyListeners();
}


//============ACTIVA OPCION TOMAR VISITANTE============//
bool _isFotoVisita=false;
bool get getIsFotoVisita=>_isFotoVisita;
void setIsFotoVisita(bool _isOk){

_isFotoVisita=_isOk;
print('_isFotoVisita --> : ${_isFotoVisita}');
notifyListeners();

}

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
    _controllerTextCedula.dispose();
    super.dispose();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    // print('_nameSearch --> : ${_nameSearch}');
    if (_nameSearch.length >= 3) {
      _deboucerSearchCompras?.cancel();
      _deboucerSearchCompras = Timer(const Duration(milliseconds: 500), () {
        // getTodosLosComunicadosClientes(_nameSearch);
      });
    } else {
      // getTodosLosComunicadosClientes('');
    }
  }

//============LISTA TEMPORAR BITACORA===============//
List<Map<String, dynamic>> get getListaVisitantes =>_listaVisitantes;
final List<Map<String, dynamic>>  _listaVisitantes = [
  {
    "id": "0",
    "residenteCedula": "78965412367",
    "residenteNombre": "JOSE MARIA NORMAN PEREZ",
    "departamento": "Casa 5 pisos",
    "numero": "98",
    "ubicacion": "Dentro de la urbanización",
    "visitaCedula": "6547852214",
    "visitaNombre": "ADRIAN REINALDO PRIETO GARCIA",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "TRE894",
    "propietarioVihiculoCedula": "12124547",
    "propietarioVihiculoNombre": "LUZ MARIA ROJAS VELEZ",
    "fechaIngreso": "2024-07-2024 18:37",
  },
  {
    "id": "1",
    "residenteCedula": "45678912345",
    "residenteNombre": "ANA MARIA LOPEZ GOMEZ",
    "departamento": "Apartamento 2A",
    "numero": "12",
    "ubicacion": "Edificio Central",
    "visitaCedula": "7896543211",
    "visitaNombre": "JUAN CARLOS MARTINEZ LOPEZ",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "ABC123",
    "propietarioVihiculoCedula": "45456456434",
    "propietarioVihiculoNombre": "CARLOS ANDRES LOPEZ",
    "fechaIngreso": "2024-07-20 14:20",
  },
  {
    "id": "2",
    "residenteCedula": "12345678901",
    "residenteNombre": "MARIA ELENA RODRIGUEZ",
    "departamento": "Casa 1 piso",
    "numero": "5",
    "ubicacion": "Al frente de la piscina",
    "visitaCedula": "1472583690",
    "visitaNombre": "PEDRO ALFONSO MORALES",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "XYZ789",
    "propietarioVihiculoCedula": "08905756756",
    "propietarioVihiculoNombre": "ALICIA VEGA",
    "fechaIngreso": "2024-07-20 16:45",
  },
  {
    "id": "3",
    "residenteCedula": "36985214785",
    "residenteNombre": "CARLOS JAVIER MENDEZ",
    "departamento": "Casa 3 pisos",
    "numero": "23",
    "ubicacion": "Cerca del parque",
    "visitaCedula": "9517538524",
    "visitaNombre": "MARIO LOPEZ PEREZ",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "JKL456",
    "propietarioVihiculoCedula": "34567787978",
    "propietarioVihiculoNombre": "GLORIA MENDEZ",
    "fechaIngreso": "2024-07-20 12:30",
  },
  {
    "id": "4",
    "residenteCedula": "75395185247",
    "residenteNombre": "ANDREA PEREZ GONZALEZ",
    "departamento": "Apartamento 5B",
    "numero": "45",
    "ubicacion": "Torre Norte",
    "visitaCedula": "4561237890",
    "visitaNombre": "SANTIAGO TORRES",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "GHJ234",
    "propietarioVihiculoCedula": "VIC21212124547",
    "propietarioVihiculoNombre": "VICTOR TORRES",
    "fechaIngreso": "2024-07-20 10:00",
  },
  {
    "id": "5",
    "residenteCedula": "78945612332",
    "residenteNombre": "RICARDO DIAZ",
    "departamento": "Casa 4 pisos",
    "numero": "67",
    "ubicacion": "Cerca del lago",
    "visitaCedula": "3216549870",
    "visitaNombre": "MARTA RAMIREZ",
    "foto": "",
    "fotoCedulaFront": "",
    "fotoCedulaBack": "",
    "fotoPasaporte": "",
    "fotoPlaca": "",
    "placa": "LMN678",
    "propietarioVihiculoCedula": "21212124547",
    "propietarioVihiculoNombre": "JULIA DIAZ",
    "fechaIngreso": "2024-07-20 11:15",
  },
];

//***********************/
// List _filterVisitas=[];

// List get getFilterVisitas=>_filterVisitas;

// void setFilterVisitas(List _list)
// {
// _filterVisitas.addAll(_list);
// notifyListeners();

// }
//========================//


  List _filteredList = [];


 void setListFilter( _list){
  _filteredList = [];
_filteredList.addAll(_list);


// print('LA LISTA PARA FILTRAR: $_filteredList'); 
  notifyListeners();
 }



  List get filteredList => _filteredList;

  // void search(String query) {
  //   // if (query.isEmpty) {
  //   //   _filteredList = _listaVisitantes;
  //   // } else {
  //   //   _filteredList = _listaVisitantes.where((visitante) {
  //   //     return visitante['residenteNombre'].toLowerCase().contains(query.toLowerCase()) ||
  //   //            visitante['visitaNombre'].toLowerCase().contains(query.toLowerCase()) ||
  //   //            visitante['placa'].toLowerCase().contains(query.toLowerCase());
  //   //   }).toList();
  //   // }
  //    List originalList = List.from(_listaVisitasBitacoras) ;// Copia de la lista original
  //   if (query.isEmpty) {
  //     _filteredList = originalList;
  //   } else {
  //     _filteredList = originalList.where((visitante) {
  //       return visitante['bitVisitanteNombres'].toLowerCase().contains(query.toLowerCase()) ||
  //              visitante['bitVisitanteCedula'].toLowerCase().contains(query.toLowerCase()) ;
  //     }).toList();
  //   }
  //   notifyListeners();
  // }
//   void search(String query,) {
//   List originalList = List.from(_listaVisitasBitacoras); 
  
//    DateTime fechaInicioDateTime = DateTime.parse(_inputFechaInicio!);
//    DateTime fechaFinDateTime = DateTime.parse(_inputFechaFin!);

//   if (query.isEmpty && fechaInicioDateTime == null && fechaFinDateTime == null) {
//     _filteredList = originalList;
//   } else {
//     _filteredList = originalList.where((visitante) {
//       bool matchesQuery = query.isEmpty || visitante['bitVisitanteNombres'].toLowerCase().contains(query.toLowerCase()) ||
//                           visitante['bitVisitanteCedula'].toLowerCase().contains(query.toLowerCase());

//       DateTime fechaIngreso = DateTime.parse(visitante['bitFechaIngreso']);
//       bool matchesFechaInicio = fechaInicioDateTime == null || fechaIngreso.isAfter(fechaInicioDateTime) || fechaIngreso.isAtSameMomentAs(fechaInicioDateTime);
//       bool matchesFechaFin = fechaFinDateTime == null || fechaIngreso.isBefore(fechaFinDateTime) || fechaIngreso.isAtSameMomentAs(fechaFinDateTime);

//       return matchesQuery && matchesFechaInicio && matchesFechaFin;
//     }).toList();
//   }

//   notifyListeners();
// }

void search(String query) {
  List originalList = List.from(_listaVisitasBitacoras);

  DateTime? fechaInicioDateTime;
  DateTime? fechaFinDateTime;

  // Convertir las cadenas de fecha a DateTime
  try {
    if (_inputFechaInicio != null && _inputFechaInicio!.isNotEmpty) {
      fechaInicioDateTime = DateTime.parse(_inputFechaInicio!).toLocal();
    }
    if (_inputFechaFin != null && _inputFechaFin!.isNotEmpty) {
      fechaFinDateTime = DateTime.parse(_inputFechaFin!).toLocal();
    }
  } catch (e) {
    print('Invalid date format in parameters: $e');
    fechaInicioDateTime = null;
    fechaFinDateTime = null;
  }

  if (query.isEmpty && fechaInicioDateTime == null && fechaFinDateTime == null) {
    _filteredList = originalList;
  } else {
    _filteredList = originalList.where((visitante) {
      bool matchesQuery = query.isEmpty ||
                          visitante['bitVisitanteNombres'].toLowerCase().contains(query.toLowerCase()) ||
                          visitante['bitVisitanteCedula'].toLowerCase().contains(query.toLowerCase());

      DateTime? fechaIngreso;
      try {
        fechaIngreso = DateTime.parse(visitante['bitFechaIngreso']).toLocal();
      } catch (e) {
        print('Invalid date format in data: $e');
        fechaIngreso = null;
      }

      DateTime? fechaSalida;
      try {
        if (_ingresoSalida == 1) {
          fechaSalida = DateTime.parse(visitante['bitFechaSalida']).toLocal();
        }
      } catch (e) {
        print('Invalid date format in data: $e');
        fechaSalida = null;
      }

      bool matchesFechaInicio = fechaInicioDateTime == null || fechaIngreso == null || !fechaIngreso.isBefore(fechaInicioDateTime);
      bool matchesFechaFin = fechaFinDateTime == null || (fechaIngreso != null && !fechaIngreso.isAfter(fechaFinDateTime)) ||
                             (fechaSalida != null && !fechaSalida.isAfter(fechaFinDateTime));

      return matchesQuery && matchesFechaInicio && matchesFechaFin;
    }).toList();
  }

  notifyListeners();
}


// void searchParametro() {
//   List originalList = List.from(_listaVisitasBitacoras);

//   DateTime? fechaInicioDateTime = _inputFechaInicio != null ? DateTime.parse(_inputFechaInicio!) : null;
//   DateTime? fechaFinDateTime = _inputFechaFin != null ? DateTime.parse(_inputFechaFin!) : null;

//   if (fechaInicioDateTime == null && fechaFinDateTime == null) {
//     _filteredList = originalList;
//   } else {
//     _filteredList = originalList.where((visitante) {
//       DateTime? fechaComparar;
      
//       if (_ingresoSalida == 0) {
//         fechaComparar = DateTime.parse(visitante['bitFechaIngreso']).toLocal();
//       } else if (_ingresoSalida == 1) {
//         fechaComparar = DateTime.parse(visitante['bitFechaSalida']).toLocal();
//       }
      
//       if (fechaComparar == null) {
//         return false; // O cualquier lógica adecuada si la fecha es nula
//       }

//       // Comparar solo las fechas (ignorando la hora)
//       bool matchesFechaInicioSinHora = fechaInicioDateTime == null || !DateTime(fechaComparar.year, fechaComparar.month, fechaComparar.day).isBefore(fechaInicioDateTime);
//       bool matchesFechaFinSinHora = fechaFinDateTime == null || !DateTime(fechaComparar.year, fechaComparar.month, fechaComparar.day).isAfter(fechaFinDateTime);

//       return matchesFechaInicioSinHora && matchesFechaFinSinHora;
//     }).toList();
//   }

//   notifyListeners();
// }
// void searchParametro(String query) {
//   List originalList = List.from(_listaVisitasBitacoras);

//   DateTime? fechaInicioDateTime = _inputFechaInicio != null ? DateTime.parse(_inputFechaInicio!).toLocal() : null;
//   DateTime? fechaFinDateTime = _inputFechaFin != null ? DateTime.parse(_inputFechaFin!).toLocal() : null;

//   if (query.isEmpty && fechaInicioDateTime == null && fechaFinDateTime == null) {
//     _filteredList = originalList;
//   } else {
//     _filteredList = originalList.where((visitante) {
//       DateTime? fechaComparar;
      
//       if (_ingresoSalida == 0) {
//         fechaComparar = visitante['bitFechaIngreso'] != null ? DateTime.parse(visitante['bitFechaIngreso']).toLocal() : null;
//       } else if (_ingresoSalida == 1) {
//         fechaComparar = visitante['bitFechaSalida'] != null ? DateTime.parse(visitante['bitFechaSalida']).toLocal() : null;
//       }
      
//       if (fechaComparar == null) {
//         return false; // O cualquier lógica adecuada si la fecha es nula
//       }

//       // Comparar solo las fechas (ignorando la hora)
//       bool matchesFechaInicioSinHora = fechaInicioDateTime == null || !DateTime(fechaComparar.year, fechaComparar.month, fechaComparar.day).isBefore(fechaInicioDateTime);
//       bool matchesFechaFinSinHora = fechaFinDateTime == null || !DateTime(fechaComparar.year, fechaComparar.month, fechaComparar.day).isAfter(fechaFinDateTime);
      
//       bool matchesQuery = query.isEmpty || visitante['bitVisitanteNombres'].toLowerCase().contains(query.toLowerCase()) ||
//                           visitante['bitVisitanteCedula'].toLowerCase().contains(query.toLowerCase());

//       return matchesQuery && matchesFechaInicioSinHora && matchesFechaFinSinHora;
//     }).toList();
//   }

//   notifyListeners();
// }

void searchParametro(String query) {
  List originalList = List.from(_listaVisitasBitacoras);

  DateTime? fechaInicioDateTime;
  DateTime? fechaFinDateTime;

  try {
    fechaInicioDateTime = _inputFechaInicio != null && _inputFechaInicio!.isNotEmpty ? DateTime.parse(_inputFechaInicio!) : null;
    fechaFinDateTime = _inputFechaFin != null && _inputFechaFin!.isNotEmpty ? DateTime.parse(_inputFechaFin!) : null;
  } catch (e) {
    fechaInicioDateTime = null;
    fechaFinDateTime = null;
  }

  if (query.isEmpty && fechaInicioDateTime == null && fechaFinDateTime == null) {
    _filteredList = originalList;
  } else {
    _filteredList = originalList.where((visitante) {
      DateTime? fechaComparar;
      
      if (_ingresoSalida == 0) {
        fechaComparar = visitante['bitFechaIngreso'] != null ? DateTime.parse(visitante['bitFechaIngreso'].substring(0, 10)) : null;
      } else if (_ingresoSalida == 1) {
        fechaComparar = visitante['bitFechaSalida'] != null ? DateTime.parse(visitante['bitFechaSalida'].substring(0, 10)) : null;
      }
      
      if (fechaComparar == null) {
        return false; // O cualquier lógica adecuada si la fecha es nula
      }

      bool matchesFechaInicio = fechaInicioDateTime == null || !fechaComparar.isBefore(fechaInicioDateTime);
      bool matchesFechaFin = fechaFinDateTime == null || !fechaComparar.isAfter(fechaFinDateTime);

      bool matchesQuery = query.isEmpty || visitante['bitVisitanteNombres'].toLowerCase().contains(query.toLowerCase()) ||
                          visitante['bitVisitanteCedula'].toLowerCase().contains(query.toLowerCase());

      return matchesQuery && matchesFechaInicio && matchesFechaFin;
    }).toList();
  }

  notifyListeners();
}

void filterByDates() {
  searchParametro('');
}


//============LLENA LA CAJA DE TEXTO CEDULA PARA BUSCAR============//
TextEditingController _controllerTextCedula = TextEditingController();

  TextEditingController get getControllerCedula => _controllerTextCedula;

  String get textCedula => _controllerTextCedula.text;

  void setTextCedula(String _text) {
      final _cedula=_text.replaceAll('-', '');
    if ( _controllerTextCedula.text != _cedula) {
       _controllerTextCedula.text = _cedula;
      notifyListeners();
    }
   
  }
//============LLENA LA CAJA DE TEXTO CEDULA PARA INGRESAR============//
TextEditingController _controllerTextCedulaIngresoVisita = TextEditingController();

  TextEditingController get getControllerCedulaIngresoVisita => _controllerTextCedulaIngresoVisita;

  String get textCedulaIngresoVisita => _controllerTextCedulaIngresoVisita.text;

  void setTextCedulaIngresoVisita(String _text) {
      final _cedula=_text.replaceAll('-', '');
    if ( _controllerTextCedulaIngresoVisita.text != _cedula) {
       _controllerTextCedulaIngresoVisita.text = _cedula;
      notifyListeners();
    }
   
  }
 //============LLENA LA CAJA DE TEXTO PLACA PARA BUSCAR============//
TextEditingController _controllerTextPlaca = TextEditingController();

  TextEditingController get getControllerPlaca => _controllerTextPlaca;

  String get textPlaca => _controllerTextPlaca.text;

  void setTextPlaca(String _text) {
    final _placa=_text.replaceAll('-', '');
    if ( _controllerTextPlaca.text != _placa) {
       _controllerTextPlaca.text = _placa;
      notifyListeners();
    }
   
  }

//============LLENA LA CAJA DE TEXTO CEDULA PARA INGRESAR============//
TextEditingController _controllerTextPlacaVehiculoPropietarioVisita = TextEditingController();

  TextEditingController get getControllerPlacaVehiculoPropietarioVisita => _controllerTextPlacaVehiculoPropietarioVisita;

  String get getPlacaVehiculoPropietarioVisita => _controllerTextPlacaVehiculoPropietarioVisita.text;

  void setTextPlacaVehiculoPropietarioVisita(String _text) {
      final _placa=_text.replaceAll('-', '');
    if ( _controllerTextPlacaVehiculoPropietarioVisita.text != _placa) {
       _controllerTextPlacaVehiculoPropietarioVisita.text = _placa;
      notifyListeners();
    }
   
  }
//*****************URLS DE FOTOS*********************//

//=================VISITANTE======================//
String _urlImageVisitante = "";
  String get getUrlVisitante => _urlImageVisitante;

  void setUrlVisitante(String _data) {
    _urlImageVisitante = "";
    _urlImageVisitante = _data;
    print('_urlImageVisitante URL: $_urlImageVisitante');

    notifyListeners();
  }

//=================CEDULA FRONT======================//
String _urlImageCedulaFront = "";
  String get getUrlCedulaFront => _urlImageCedulaFront;

  void setUrlCedulaFront(String _data) {
    _urlImageCedulaFront = "";
    _urlImageCedulaFront = _data;
    print('_urlImageCedulaFront URL: $_urlImageCedulaFront');

    notifyListeners();
  }

//=================CEDULA BACK======================//
String _urlImageCedulaBack = "";
  String get getUrlCedulaBack => _urlImageCedulaBack;

  void setUrlCedulaBack(String _data) {
    _urlImageCedulaBack = "";
    _urlImageCedulaBack = _data;
    print('_urlImageCedulaBack URL: $_urlImageCedulaBack');

    notifyListeners();
  }

//=================PASAPORTE======================//
String _urlImagePasaporte = "";
  String get getUrlPasaporte => _urlImagePasaporte;

  void setUrlPasaporte(String _data) {
    _urlImagePasaporte = "";
    _urlImagePasaporte = _data;
    print('_urlImagePasaporte URL: $_urlImagePasaporte');

    notifyListeners();
  }
  //=================placa======================//
String _urlImagePlaca = "";
  String get getUrlPlaca => _urlImagePlaca;

  void setUrlPlaca(String _data) {
    _urlImagePlaca = "";
    _urlImagePlaca = _data;
    print('_urlImagePlaca URL: $_urlImagePlaca');

    notifyListeners();
  }


 //================================== CREA NUEVA BITACORA GUARDIA  ==============================//
  Future creaBitacoraVisitante(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

final List<Map<String, dynamic>> _listaVisitasTemp=[];

       for (var e in _listaVisitas) {

        _listaVisitasTemp.addAll([
         
         
            {
   
            "bitResId": e['id'], //id Residente o Propietario
            "bitVisitanteCedula": e['cedulaVisita'], // del endpoint a consumir
            "bitVisitanteNombres": e['nombreVisita'], // del endpoint a consumir
            "bitVisitanteTelefono": e['telefonoVisita'], // del endpoint a consumir
            "bitTipoPersona": e['tipoPersona'], // select
            "bitAsunto": e['asunto'],
            "bitNombre_dpt": e['depatamento'], // del residente o propietario seleccionado => resDepartamento
            "bitNumero_dpt": e['numeroDepartamento'], // del residente o propietario seleccionado => resDepartamento
            "bitPoseeVehiculo": e['vehiculo'],
            "bitPlaca": e['placa'],
            "bitInformacionVehiculo": 
            {
              "dni":e['cedulaPropietarioVehiculo'],
              "fullname":e['nombrePropietarioVehiculo'],
              "model":e['modelo'],
            },
            "bitFotoCedulaFrontal":  e['fotoCedulaFront'],
            "bitFotoCedulaReverso":  e['fotoCedulaBack'],
            "bitFotoPersona":  e['fotoVisitante'],
            "bitFotoVehiculo":  e['fotoPlaca'],
            "bitObservacion":  e['observacion'],
            "bitTipoIngreso":  e['bitTipoIngreso'],
            
            "bitUser": infoUser!.usuario, //login
            "bitEstado": "INGRESO" //default
        
        
              },
        
          ]);
        
      }





    final _pyloadNuevBitacoraVisitante = {
   "fromapp": true, //default
    "regId": idTurno, //login
    "tabla": "bitacora", //login
    "rucempresa": infoUser!.rucempresa, //login
    "rol": infoUser.rol,//login
    "visitantes": _listaVisitasTemp
    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevBitacoraVisitante);
  //  print('el PAYLOAD GUARDIA ${_pyloadNuevBitacoraVisitante}');
    
  }

 



//*********************//

List<dynamic> _listaVisitasBitacoras = [];
   List<dynamic> get getListaVisitasBitacoras => _listaVisitasBitacoras;

  void setListaVisitasBitacoras( List<dynamic> data) {
    _listaVisitasBitacoras = [];
   _listaVisitasBitacoras = data;

   
  setListFilter(_listaVisitasBitacoras);
    
    
    notifyListeners();
  }
  Future<dynamic> getAllVisitasBitacoras(
    String? search,
    String? notificacion,
    //  String? _estado,
     String? tipo
  ) async {
    final dataUser = await Auth.instance.getSession();
    
    final response = await _api.getAllBitacorasVisitas(
      search: search,
     
      token: '${dataUser!.token}',
    );
if (response != null) {

  List<Map<String, dynamic>> ingresoList = [];
  List<Map<String, dynamic>> salidaList = [];

  if (response != null) {
    for (var item in response) {
      // Preguntar el tipo de dato (INGRESO o SALIDA)
      if (tipo == 'INGRESO') {
        // Verificar si el tipo es 'INGRESO' y bitFechaSalida es null
        if (item['bitEstado'] == 'INGRESO' && item['bitFechaSalida'] == null) {
          ingresoList.add(item);
        }
      } else if (tipo == 'SALIDA') {
        // Verificar si el tipo es 'SALIDA' y bitFechaSalida no es null
        if (item['bitEstado'] == 'SALIDA' && item['bitFechaSalida'] != null) {
          salidaList.add(item);
        }
      }
    }

    // Ordenar la lista por bitFechaIngreso
    ingresoList.sort((a, b) => DateTime.parse(a['bitFechaIngreso']).compareTo(DateTime.parse(b['bitFechaIngreso'])));
    salidaList.sort((a, b) => DateTime.parse(a['bitFechaIngreso']).compareTo(DateTime.parse(b['bitFechaIngreso'])));

    // Dependiendo del tipo, asignar la lista correspondiente
    if (tipo == 'INGRESO') {
      setListaVisitasBitacoras(ingresoList);
      // print('Ingreso List Sorted: $ingresoList');
    } else if (tipo == 'SALIDA') {
      setListaVisitasBitacoras(salidaList);
      // print('Salida List Sorted: $salidaList');
    }

    // Notificar cambios y devolver respuesta si es necesario
}
    if (response == null) {
    
      notifyListeners();
      return null;
    }
    return null;
  }
  }
//*********************//
Map<String,dynamic> _infoVisitante={};
Map<String,dynamic> get getInfoVisitante=>_infoVisitante;
void setInfoVisitante(Map<String,dynamic> _info){

_infoVisitante={};
_infoVisitante=_info;

// print('LA DATA PARA SALIDA VISITANTE: $_infoVisitante');


  notifyListeners();
}



 //================================== REGISTRAR SALIDA VISITANTE BITACORA   ==============================//
  Future creaSalidaBitacoraVisitante(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

  
    final _pyloadSalidaBitacoraVisitante = {
  //  "fromapp": true, //default
  //   "regId": idTurno, //login
  //   "tabla": "bitacora", //login
  //   "rucempresa": infoUser!.rucempresa, //login
  //   "rol": infoUser.rol,//login
  //   "visitantes":{
   
  //           "bitResId": _infoVisitante['bitResId'],
  //           "bitVisitanteCedula": _infoVisitante['bitVisitanteCedula'],
  //           "bitVisitanteNombres": _infoVisitante['bitVisitanteNombres'],
  //           "bitVisitanteTelefono": _infoVisitante['bitVisitanteTelefono'],
  //           "bitTipoPersona": _infoVisitante['bitTipoPersona'],
  //           "bitAsunto": _infoVisitante['bitAsunto'],
  //           "bitNombre_dpt": _infoVisitante['bitNombre_dpt'],
  //           "bitNumero_dpt": _infoVisitante['bitNumero_dpt'],
  //           "bitPoseeVehiculo": _infoVisitante['bitPoseeVehiculo'],
  //           "bitPlaca": _infoVisitante['bitPlaca'],
  //           "bitInformacionVehiculo": 
  //           {
  //             "dni":_infoVisitante['bitInformacionVehiculo']['dni'],
  //             "fullname":_infoVisitante['bitInformacionVehiculo']['fullname'],
  //             "model":_infoVisitante['bitInformacionVehiculo']['model'],
  //           },
  //           "bitFotoCedulaFrontal":  _infoVisitante['bitFotoCedulaFrontal'],
  //           "bitFotoCedulaReverso":  _infoVisitante['bitFotoCedulaReverso'],
  //           "bitFotoPersona":  _infoVisitante['bitFotoPersona'],
  //           "bitFotoVehiculo":  _infoVisitante['bitFotoVehiculo'],
  //           "bitObservacion":  _infoVisitante['bitObservacion'],

  //           "bitUser": infoUser.usuario, //login
  //           "bitEstado": "SALIDA" //default
        
        
  //             },
  

   "tabla": "bitacora", //login
    "rucempresa": infoUser!.rucempresa, //login
    "rol": infoUser.rol,//login


  "bitId": _infoVisitante["bitId"],
  "bitCliId": _infoVisitante["bitCliId"],
  "bitResId": _infoVisitante["bitResId"],
  "bitTipoPersona": _infoVisitante["bitTipoPersona"],
  "bitVisitanteCedula": _infoVisitante["bitVisitanteCedula"],
  "bitVisitanteNombres": _infoVisitante["bitVisitanteNombres"],
  "bitVisitanteTelefono": _infoVisitante["bitVisitanteTelefono"],
  "bitAsunto": _infoVisitante["bitAsunto"],
  "bitCliUbicacion": _infoVisitante["bitCliUbicacion"],
  "bitCliPuesto": _infoVisitante["bitCliPuesto"],
  "bitNombre_dpt": _infoVisitante["bitNombre_dpt"],
  "bitNumero_dpt": _infoVisitante["bitNumero_dpt"],
  "bitPoseeVehiculo": _infoVisitante["bitPoseeVehiculo"],
  "bitPlaca": _infoVisitante["bitPlaca"],
  "bitInformacionVehiculo":  _infoVisitante["bitInformacionVehiculo"],
  "bitFotoCedulaFrontal": _infoVisitante["bitFotoCedulaFrontal"],
  "bitFotoCedulaReverso": _infoVisitante["bitFotoCedulaReverso"],
  "bitFotoPersona": _infoVisitante["bitFotoPersona"],
  "bitFotoVehiculo": _infoVisitante["bitFotoVehiculo"],
  "bitObservacion": _infoVisitante["bitObservacion"],

 
  "bitEstadoIngreso": _infoVisitante["bitEstadoIngreso"],
  "bitEstadoSalida": _infoVisitante["bitEstadoSalida"],
  "bitAutoriza": _infoVisitante["bitAutoriza"],
  "bitUserApruebaIngreso": _infoVisitante["bitUserApruebaIngreso"],
  "bitUserApruebaSalida": _infoVisitante["bitUserApruebaSalida"],
 
  "bitFechaIngreso":  _infoVisitante["bitFechaIngreso"],
  "bitFechaSalida":  _infoVisitante["bitFechaSalida"],
  "bitFecReg":  _infoVisitante["bitFecReg"],
  "bitFecUpd":  _infoVisitante["bitFecUpd"],
  "bituuid":  _infoVisitante["bituuid"],

 
    
   "bitEstado": "SALIDA", //default
   "bitUser": infoUser.usuario, //login    
   "bitEmpresa": infoUser.nomEmpresa,

    };

    serviceSocket.socket!.emit('client:actualizarData', _pyloadSalidaBitacoraVisitante);
  //  print('el PAYLOAD GUARDIA ${_pyloadSalidaBitacoraVisitante}');
    
  }

 //***********************//
 int _ingresoSalida=0;
int get getingresoSalida=>_ingresoSalida;
void setingresoSalida(int _tipo){
 
_ingresoSalida=_tipo;
print('_ingresoSalida --> : ${_ingresoSalida}');
notifyListeners();
}


 //========================== VALIDA CAMPO  FECHA INICIO TURNO =======================//
  String? _inputFechaInicio ='';
      // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaInicio => _inputFechaInicio;
  void onInputFechaInicioChange(String? date) {
    _inputFechaInicio = date;
    print('_inputFechaInicio =======>  :$_inputFechaInicio');

    // var _date = DateTime.parse(_inputFechaInicio.toString());
    onInputFechaFinChange(_inputFechaInicio);
    notifyListeners();
  }

 //========================== VALIDA CAMPO  FECHA FIN  =======================//

  String? _inputFechaFin =
      ''; // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaFin => _inputFechaFin;
  // void onInputFechaFinChange(String? date) {
  //   _inputFechaFin = date;

  //   var _dateIni = DateTime.parse(_inputFechaInicio.toString());
  //   var _dateFin = DateTime.parse(date.toString());

  //   var _nDias = _dateFin.difference(_dateIni);
  //   onNumeroDiasChange(_nDias.inDays == 0 ? '1' : '${_nDias.inDays + 1}');

  //   notifyListeners();
  // }
  void onInputFechaFinChange(String? date) {
    _inputFechaFin = date;
    // print('_inputFechaFin :$_inputFechaFin');

    // var _dateIni = DateTime.parse(_inputFechaInicio.toString());
    // var _dateFin = DateTime.parse(date.toString());

    // var _nDias = _dateFin.difference(_dateIni);
    // onNumeroDiasChange(_nDias.inDays == 0 ? '1' : '${_nDias.inDays + 1}');

    notifyListeners();
  }

  String? _inputHoraFin = '';
// ;      '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
  get getInputHoraFin => _inputHoraFin;
  void onInputHoraFinChange(String? date) {
    _inputHoraFin = date;
    // print('_inputHoraFin :$_inputHoraFin');

    notifyListeners();
  }



  String? _inputHoraInicio = '';
  
  String? get getInputHoraInicio => _inputHoraInicio;

 void onInputHoraInicioChange(String? date) {
    _inputHoraInicio = date;
    // print('_inputHoraInicio :$_inputHoraInicio');

    final _fechaActual = '${_inputFechaInicio} ${_inputHoraInicio}';

    final _later = DateTime.parse(_fechaActual);
    // print('la fecha _later es $_later');
    onInputFechaFinChange(_inputFechaInicio);

    onInputHoraFinChange(_inputHoraInicio);
    notifyListeners();
  }


//*********OBTENEMOS LA INFORMACION DE LA VISITA *********//

  Map<String,dynamic> _infoVisita = {};
// ;      '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
  Map<String,dynamic> get getInfoVisita => _infoVisita;
  void setInfoVisita( Map<String,dynamic> _info) {
   _infoVisita = {};
    _infoVisita=_info;
      // print('INFO DE LA VISITA :$_infoVisita');
    notifyListeners();
  }





    //********************//

Map<String, String?> _urlsVisitas = {};

Map<String, String?> get getUrlsVisitas => _urlsVisitas;
Future<bool> uploadImagesAndPrintUrls() async {
  final dataUser = await Auth.instance.getSession();

  // Crear un mapa para asociar los nombres de las imágenes con sus URLs
  final Map<String, String?> urlsVisitas = {};

  // Función auxiliar para subir una imagen y obtener su URL
  Future<String?> uploadImage(File imageFile) async {
    var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});
    request.files.add(await _http.MultipartFile.fromPath('foto', imageFile.path));

    var response = await request.send();
    var responsed = await _http.Response.fromStream(response);

    if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      final url = responseFoto.urls[0].url;
      return url;
    } else {
      return null;
    }
  }

  // Verificar y almacenar las imágenes solo si no son null
  if (_visitanteImage != null) {
    final visitanteImage = File(_visitanteImage!.path);
    urlsVisitas['visitanteImage'] = await uploadImage(visitanteImage);
    setUrlVisitante(urlsVisitas['visitanteImage'] ?? 'No URL');
  }

  if (_frontImage != null) {
    final frontImage = File(_frontImage!.path);
    urlsVisitas['frontImage'] = await uploadImage(frontImage);
    setUrlCedulaFront(urlsVisitas['frontImage'] ?? 'No URL');
  }

  if (_backImage != null) {
    final backImage = File(_backImage!.path);
    urlsVisitas['backImage'] = await uploadImage(backImage);
    setUrlCedulaBack(urlsVisitas['backImage'] ?? 'No URL');
  }

  if (_pasaporteImage != null) {
    final pasaporteImage = File(_pasaporteImage!.path);
    urlsVisitas['pasaporteImage'] = await uploadImage(pasaporteImage);
    setUrlPasaporte(urlsVisitas['pasaporteImage'] ?? 'No URL');
  }

  if (_placaImage != null) {
    final placaImage = File(_placaImage!.path);
    urlsVisitas['placaImage'] = await uploadImage(placaImage);
    setUrlPlaca(urlsVisitas['placaImage'] ?? 'No URL');
  }

  // Imprimir todas las URLs recibidas
  print('****** URLS RECIBIDAS ******');
  urlsVisitas.forEach((name, url) {
    print('URL de $name: ${url ?? 'No URL'}');
  });

  // Validar si todas las URLs son válidas
  bool allUrlsReceived = urlsVisitas.values.every((url) => url != null);

  return allUrlsReceived;
}


// Future<bool> uploadImagesAndPrintUrls(

// ) async {
//   final dataUser = await Auth.instance.getSession();

//    File? visitanteImage=File(_visitanteImage!.path);
//   File? frontImage=File(_frontImage!.path);
//   File? backImage=File(_backImage!.path);
//   File? pasaporteImage=File(_pasaporteImage!.path);
//   File? placaImage=File(_placaImage!.path);
//   // Crear un mapa para asociar los nombres de las imágenes con sus URLs
//   // final Map<String, String?> urls = {};

//   // Función auxiliar para subir una imagen y obtener su URL
//   Future<String?> uploadImage(File imageFile, String imageName) async {
//     var request = _http.MultipartRequest(
//         'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

//     request.headers.addAll({"x-auth-token": '${dataUser!.token}'});
//     request.files.add(await _http.MultipartFile.fromPath('foto', imageFile.path));

//     var response = await request.send();
//     var responsed = await _http.Response.fromStream(response);

//     if (responsed.statusCode == 200) {
//       final responseFoto = FotoUrl.fromJson(responsed.body);
//       final url = responseFoto.urls[0].url;
//       return url;
//     } else {
//       return null;
//     }
//   }

//   // Subir cada imagen y almacenar su URL si la imagen no es null
//   if (visitanteImage != null) {
//     _urlsVisitas['visitanteImage'] = await uploadImage(visitanteImage, 'visitanteImage');
// setUrlVisitante('${_urlsVisitas['visitanteImage']}');

//   } else {
//     _urlsVisitas['visitanteImage'] = null;
//   }
  
//   if (frontImage != null) {
//     _urlsVisitas['frontImage'] = await uploadImage(frontImage, 'frontImage');
//     setUrlCedulaFront('${_urlsVisitas['frontImage']}');
//   } else {
//     _urlsVisitas['frontImage'] = null;
//   }
  
//   if (backImage != null) {
//     _urlsVisitas['backImage'] = await uploadImage(backImage, 'backImage');
//      setUrlCedulaBack('${_urlsVisitas['backImage']}');
//   } else {
//     _urlsVisitas['backImage'] = null;
//   }
  
//   if (pasaporteImage != null) {
//     _urlsVisitas['pasaporteImage'] = await uploadImage(pasaporteImage, 'pasaporteImage');
//      setUrlPasaporte('${_urlsVisitas['pasaporteImage']}');
//   } else {
//     _urlsVisitas['pasaporteImage'] = null;
//   }
  
//   if (placaImage != null) {
//     _urlsVisitas['placaImage'] = await uploadImage(placaImage, 'placaImage');
//      setUrlPlaca('${_urlsVisitas['placaImage']}');
//   } else {
//     _urlsVisitas['placaImage'] = null;
//   }

//   // Imprimir todas las URLs recibidas
//   print('****** URLS RECIBIDAS ******');
//   _urlsVisitas.forEach((name, url) {
//     print('URL de $name: ${url ?? 'No URL'}');
//   });

//   // Validar si todas las URLs son válidas
//   bool allUrlsReceived = _urlsVisitas.values.every((url) => url != null);

//   return allUrlsReceived;
// }

// Future<bool> uploadImagesAndGetsUrlsVisita(
//   // {
//   // File? visitanteImage,
//   // File? frontImage,
//   // File? backImage,
//   // File? pasaporteImage,
//   // File? placaImage,
// // }
// ) async {
//   final dataUser = await Auth.instance.getSession();

//   // Crear un mapa para asociar los nombres de las imágenes con sus URLs
// _urlsVisitas = {};

//   File? visitanteImage=File(_visitanteImage!.path);
//   File? frontImage=File(_frontImage!.path);
//   File? backImage=File(_backImage!.path);
//   File? pasaporteImage=File(_pasaporteImage!.path);
//   File? placaImage=File(_placaImage!.path);




//   // Función auxiliar para subir una imagen y obtener su URL
//   Future<String?> uploadImage(File imageFile, String imageName) async {
//     var request = _http.MultipartRequest(
//         'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

//     request.headers.addAll({"x-auth-token": '${dataUser!.token}'});
//     request.files.add(await _http.MultipartFile.fromPath('foto', imageFile.path));

//     var response = await request.send();
//     var responsed = await _http.Response.fromStream(response);

//     if (responsed.statusCode == 200) {
//       final responseFoto = FotoUrl.fromJson(responsed.body);
//       final url = responseFoto.urls[0].url;
//       _urlsVisitas[imageName] = url;
//       print('URL de $imageName: $url');
//       return url;
//     } else {
//       _urlsVisitas[imageName] = null;
//       return null;
//     }
//   }

//   // Subir cada imagen y almacenar su URL
//   if (visitanteImage != null) await uploadImage(visitanteImage, 'visitanteImage');
//   if (frontImage != null) await uploadImage(frontImage, 'frontImage');
//   if (backImage != null) await uploadImage(backImage, 'backImage');
//   if (pasaporteImage != null) await uploadImage(pasaporteImage, 'pasaporteImage');
//   if (placaImage != null) await uploadImage(placaImage, 'placaImage');

//   // Imprimir todas las URLs recibidas
//   print('****** URLS RECIBIDAS ******');
//   _urlsVisitas.forEach((name, url) {
//     print('URL de $name: ${url ?? 'No URL'}');
//   });

//   // Validar si todas las URLs son válidas
//   bool allUrlsReceived = _urlsVisitas.values.every((url) => url != null);

//   return allUrlsReceived;
// }




    //********************//









}
