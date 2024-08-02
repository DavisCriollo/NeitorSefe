import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_foto_consigna_cliente.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/service/socket_service.dart';

import 'package:provider/provider.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_foto_consigna_cliente.dart';

// import 'package:sincop_app/src/models/foto_url.dart';

// import 'package:sincop_app/src/service/socket_service.dart';

import 'package:http/http.dart' as _http;

class ConsignasController extends ChangeNotifier {
  GlobalKey<FormState> consignasClienteFormKey = GlobalKey<FormState>();

  resetValues() async {
    _listaFotosUrl.clear();
    _listaFotos.clear();
    _listaGuardiaConsignas.clear();
    _listaFechaSeleccionada = [];
  }

  final _api = ApiProvider();
  bool validateForm() {
    if (consignasClienteFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//=========================================================================//
  String? _asunto;
  String? get getAsunto => _asunto;
  void onChangeAsunto(String? text) {
    _asunto = text;
  }

  String? _detalle;
  String? get getDetalle => _detalle;
  void onChangeDetalle(String? text) {
    _detalle = text;
  }

//====================================SELECCIONA FECHA DE CONSIGNAS ====================================================//

  List<DateTime>? _listaFechaSeleccionada = [];
  List<DateTime>? get getLitaSeleccionada => _listaFechaSeleccionada;

  List<dynamic>? _listaMapMiliSegundos = [];
  List<dynamic>? get getLitaMapMiliSegundos => _listaMapMiliSegundos;
  List<dynamic>? _listaMapSelect = [];
  List<dynamic>? get getLitaMapSelect => _listaMapSelect;

  void setListMultiSelect(List<DateTime>? select) {
    _listaMapSelect!.clear();
    _listaMapMiliSegundos!.clear();
    _listaFechaSeleccionada!.removeWhere((e) => (e == select));
    _listaFechaSeleccionada = select;

//======== AGREGAMOS LAS FECHA SELECCIONADA A UNA LISTA DE MAPAS =====//
    for (var i = 0; i < _listaFechaSeleccionada!.length; i++) {
      _listaMapSelect?.add({
        "desde": '${_listaFechaSeleccionada![i]}',
        "hasta": '${_listaFechaSeleccionada![i]}'
      });
    }
//======== AGREGAMOS LAS FECHA SELECCIONADA A UNA LISTA DE MAPAS EN MILISEGUNDOS =====//
    for (var i = 0; i < _listaFechaSeleccionada!.length; i++) {
      _listaMapMiliSegundos?.add({
        "desde": '${_listaFechaSeleccionada![i].millisecondsSinceEpoch}',
        "hasta": '${_listaFechaSeleccionada![i].millisecondsSinceEpoch}'
      });
    }
    notifyListeners();
  }

  //========================== VALIDA PRIORIDAD ALTA MEDIA BAJA CLIENTE =======================//
  var _prioridadCliente = 'BAJA';
  var _prioridadValueCliente = 3;
  get getprioridadValueCliente => _prioridadValueCliente;
  get getPrioridadCliente => _prioridadCliente;
  void onPrioridadClienteChange(text) {
    _prioridadValueCliente = text;
    _prioridadCliente = (text == 1)
        ? 'ALTA'
        : (text == 2)
            ? 'MEDIA'
            : 'BAJA';

    notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;
  final List _listaFotosUrl = [];

  List<CreaNuevaFotoConsignaCliente?> _listaFotos = [];
  List<CreaNuevaFotoConsignaCliente?> get getListaFotos => _listaFotos;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotos.add(CreaNuevaFotoConsignaCliente(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotos.add(CreaNuevaFotoConsignaCliente(id, path));

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
      final fotoUrl = responseFoto.urls[0];
      _listaFotosUrl.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
    }
    for (var item in _listaFotosUrl) {}

//========================================//
  }

  List<dynamic> _listaGuardiaConsignas = [];
  List<dynamic> get getListaGuardiasConsigna => _listaGuardiaConsignas;
  void setGuardiaConsigna(dynamic guardia) {
   _listaGuardiaConsignas.removeWhere((e) => (e['id'] == guardia['perId']));
    _listaGuardiaConsignas.add({
      "docnumero":
          guardia['perDocNumero'], // al consumir el endpoint => perDocNumero
      "nombres": '${guardia['perApellidos']} ${guardia['perNombres']} ',
      "asignado": true, // si esta marcado el check
      "id": guardia['perId'], // al consumir el endpoint => perId
      "foto": guardia['perFoto'],
      "trabajos": []
    });
    notifyListeners();
  }

  void eliminaGuardiaConsigna(int id) {
  _listaGuardiaConsignas.removeWhere((e) => (e['id'] == id));
    _listaGuardiaConsignas.forEach(((element) {
   }));

    notifyListeners();
 }

//========================================================================================//
  List _listaInfoGuardiaConsigna = [];
 List get getListaInfoGuardiaConsigna => _listaInfoGuardiaConsigna;

  void setInfoBusquedaGuardiaConsigna(List data) {
    _listaInfoGuardiaConsigna = data;
   notifyListeners();
  }

  bool? _errorListaGuardiasConsignas; // sera nulo la primera vez
  bool? get getErrorListaGuardiasConsignas => _errorListaGuardiasConsignas;
  Future buscaGuardiasConsigna(String? _search) async {
    final dataUser = await Auth.instance.getSession();
final response = await _api.getAllInfoGuardiasConsignas(
      search: _search,
    
      docnumero: '${dataUser!.usuario}',
      token: '${dataUser.token}',
    );
    if (response != null) {
      _errorListaGuardiasConsignas = true;
      setInfoBusquedaGuardiaConsigna(response['data']);
return response;
    }
    if (response == null) {
      _errorListaGuardiasConsignas = false;
      notifyListeners();
      return null;
    }
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future creaConsignaCliente(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
  final infoUser = await Auth.instance.getSession();
 final _pyloadNuevaConsigna = {
      "tabla": "consigna", // defecto
      "rucempresa": infoUser!.rucempresa, // login => rucempresa
      "rol": infoUser.rol, //login
      "conId": "", // vacio
      "conIdCliente": infoUser.id, // login => id
      "conNombreCliente": infoUser.nombre, // login => nombre
      "conAsunto": _asunto, // asunto
      "conDetalle": _detalle, // textarea
      "conTipoCalendario": "MULTIPLE", // defecto
      "conFechasConsigna":
          _listaMapMiliSegundos, //, jsonDecode( '$_listaMapMiliSegundos'),

      "conFechasConsignaConsultaDB":
          _listaMapSelect, //jsonDecode('$_listaMapSelect'),

      "conPrioridad": "MEDIA", // defecto
      "conEstado": "ACTIVA", // defecto
      "conProgreso": "NO REALIZADO", // defecto
      "conDocumento": "", //input documento.
      "conFotosCliente": _listaFotosUrl, // fotos
      "conLeidos": [], // vacio
      "conAsignacion": _listaGuardiaConsignas,
      "conSupervisores": [], // supervisores seleccionados
      "conUser": infoUser.usuario, // login => usuario
      "conEmpresa": infoUser.rucempresa, // login => rucempresa
    };
serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaConsigna);
  }

//================================== ELIMINA CONSIGNAS  ==============================//

  Future eliminaConsignaCliente(BuildContext context, dynamic consigna) async {
    final serviceSocket = context.read<SocketService>();

    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaConsignaCliente = {
      "tabla": "consigna", // defecto
      "conId": consigna!['conId'],
      "rucempresa": infoUser!.rucempresa, //login
    };

    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaConsignaCliente);
  }

//================================== OBTENEMOS TODAS LAS CONSIGNAS  ==============================//
  List<dynamic> _listaTodasLasConsignasCliente = [];
  List<dynamic> get getListaTodasLasConsignasCliente =>
      _listaTodasLasConsignasCliente;

  void setListaTodasLasConsignasCliente(List<dynamic> data) {
    List<dynamic> dataTemp = [];
    dataTemp = data;
    dataTemp.sort((a, b) => b['conId'].compareTo(a['conId']));
    _listaTodasLasConsignasCliente = [];
    _listaTodasLasConsignasCliente = dataTemp;


// print('  $_listaTodasLasConsignasCliente  ');

notifyListeners();
  }

  bool? _errorAllConsignas; // sera nulo la primera vez
  bool? get getErrorAllConsignas => _errorAllConsignas;

  Future getTodasLasConsignasClientes(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllConsignasClientes(
   search: search,
      notificacion: notificacion,
  token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorAllConsignas = true;
      setListaTodasLasConsignasCliente(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllConsignas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//=========================================================obtengo la consigna para editarla ==============================//

  dynamic _consigna;
  dynamic get getConsigna => _consigna;

  List<DateTime>? _listaMultiSelect = [];
  List<DateTime>? get getLitaMultiSelect => _listaMultiSelect;
  void setFechasConsigna(List<DateTime>? dataFecha) {
    _listaMultiSelect = dataFecha;
   notifyListeners();
  }

  Future getInfoConsigna(dynamic data) async {
    _consigna = data;
    _listaMultiSelect!.clear();
    _asunto = data['conAsunto'];
    _detalle = data['conDetalle'];
    dynamic fechaRecivida = data['conFechasConsignaConsultaDB'];

//======== AGREGAMOS LAS FECHA SELECCIONADA A UNA LISTA DE MAPAS =====//
    for (var i = 0; i < fechaRecivida!.length; i++) {
      _listaMultiSelect!.add(DateTime.parse(
          fechaRecivida[i]['desde'].replaceAll("T", " ").substring(0, 19)));
    }
 notifyListeners();
  }

  void eliminaFechaConsigna(DateTime date) {
    _listaMultiSelect!.removeWhere((e) => (e == date));

    notifyListeners();
  }

//================================= ENVIA JSON DE CONSIGNA LEIDA========================================//
 
//   Future consignaLeidaGuardia(int? _idConsigna, BuildContext context) async {
//     final serviceSocket = Provider.of<SocketService>(context, listen: false);

//     final infoUser = await Auth.instance.getSession();
//  final _pyloadConsignaLeidaGuardia = {
//       "tabla": "consignaleido", // defecto
//       "rucempresa": infoUser!.rucempresa, // login
//       "rol": infoUser.rol, // login
//       "conId": _idConsigna, // id del registro
//       "conIdPersona": infoUser.id, // login
//       "conNombrePersona": infoUser.nombre, //login nombre
//       "conUser": infoUser.rucempresa // loginogin
//     };
//   serviceSocket.socket!.emit('client:actualizarData', _pyloadConsignaLeidaGuardia);
   
//   }
  Future consignaLeidaGuardia(int? _idConsigna, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();
 final _pyloadConsignaLeidaGuardia = {
      "tabla": "consignaleido", // defecto
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol, // login
      "id_persona": infoUser.id, // login
      "conId": _idConsigna, // id del registro
      
     
    };

    // print('LA DATA: $_pyloadConsignaLeidaGuardia');
  serviceSocket.socket!.emit('client:actualizarData', _pyloadConsignaLeidaGuardia);

   
  }
//=========================================================================//

}
