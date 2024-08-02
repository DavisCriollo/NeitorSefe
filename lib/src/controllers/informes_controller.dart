import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/get_info_guardia_multa.dart';
import 'package:nseguridad/src/models/lista_allClientes.dart';
import 'package:nseguridad/src/models/lista_allInforme_guardias.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/socket_service.dart';

// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/get_info_guardia_multa.dart';
// import 'package:sincop_app/src/models/lista_allClientes.dart';
// import 'package:sincop_app/src/models/lista_allInforme_guardias.dart';
// import 'package:sincop_app/src/models/session_response.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';
// import 'package:sincop_app/src/service/socket_service.dart';
import 'package:provider/provider.dart';

class InformeController extends ChangeNotifier {
  GlobalKey<FormState> informesGuardiasFormKey = GlobalKey<FormState>();
    GlobalKey<FormState> informeRespondeFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  bool validateForm() {
    if (informesGuardiasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
  bool validateFormRespondeInforme() {
    if (informeRespondeFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetValuesInformes() {
    _labelInformePara = null;
    _inputFechaInformeGuardia;
    _inputHoraInformeGuardia;
    infDocNumDirigido = '';
    _textDirigidoA = '';
    _inputAsunto = '';
    _inputTipoNovedad = '';
    _inputLugar = '';
    _inputPejudicado = '';
    _inputMotivo = '';
    _inputDetalle = '';
    _listaGuardiasInforme.clear();
    _listaFotosUrl!.clear();
    _listaVideosUrl.clear();
    _listaFotosCrearInforme.clear();
    _listaGuardiaInforme.clear();
    _pathVideo = '';
    _urlVideo = '';

    notifyListeners();
  }

  void resetListaGuardiasInformes() {
    _textDirigidoA = '';
    _listaGuardiaInforme.clear();
    notifyListeners();
  }

  //================================== FECHA Y HORA DEL COMUNICADO  ==============================//
  String? _inputFechaInformeGuardia;
  get getInputfechaInformeGuardia => _inputFechaInformeGuardia;
  void onInputFechaInformeGuardiaChange(String? date) {
    _inputFechaInformeGuardia = date;

    notifyListeners();
  }

  String? _inputHoraInformeGuardia;
  get getInputHoraInformeGuardia => _inputHoraInformeGuardia;
  void onInputHoraInformeGuardiaChange(String? date) {
    _inputHoraInformeGuardia = date;

    notifyListeners();
  }

  String? _textoPrueba;
  get getTextoPrueba => _textoPrueba;
  void setTextoPrueba(String? date) {
    _textoPrueba = date;
   notifyListeners();
  }

//  =================  AGREGA CORREOS CLIENTE MULTAS ==================//

  List<dynamic> _listaGuardiasInforme = [];
  List<dynamic> get getListaGuardiasInforme => _listaGuardiasInforme;

  void setListaGuardiasInforme(
      int? id, String? documento, String? nombres, List<String>? correo) {
   _listaGuardiasInforme.addAll([
      {
        "id": id!.toInt(),
        "docnumero": documento,
        "nombres": nombres,
        "compartido": true,
        "email": correo,
      }
    ]);
   notifyListeners();
  }

  void eliminaGuardiaInforme(int id) {
   _listaGuardiaInforme.removeWhere((e) => (e['id'] == id));
    _listaGuardiasInforme.forEach(((element) {
    
    }));

    notifyListeners();
   
  }

//============================= SELECCIONA DATOS PARA A ==================================//

  String? _textDirigidoA;
  String? infDocNumDirigido;
  String? _textDocNumDirigidoA;
  int? _idCliente;

  List<dynamic>? _infCorreosCliente;
  String? get getTextDirigido => _textDirigidoA;
set setTextDirigido(String? value) {
    _textDirigidoA = value;
    notifyListeners();
  }
  
  String? _inputAsunto = '';
  String? get getInputAsunto => _inputAsunto;
  void setInputAsuntoChange(String? text) {
    _inputAsunto = text;
  notifyListeners();
  }

  String? _inputTipoNovedad = '';
  String? get getInputTipoNovedad => _inputTipoNovedad;
  void setInputTipoNovedadChange(String? text) {
    _inputTipoNovedad = text;
   notifyListeners();
  }

  String? _inputLugar = '';
  String? get getInputLugar => _inputLugar;
  void setInputLugarChange(String? text) {
    _inputLugar = text;
   notifyListeners();
  }

  String? _inputPejudicado = '';
  String? get getInputPejudicado => _inputPejudicado;
  void setInputPejudicadoChange(String? text) {
    _inputPejudicado = text;
    notifyListeners();
  }

  String? _inputMotivo = '';
  String? get getInputMotivo => _inputMotivo;
  void setInputMotivoChange(String? text) {
    _inputMotivo = text;
  notifyListeners();
  }

  String? _inputDetalle = '';
  String? get getInputDetalle => _inputDetalle;
  void setInputDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }

  String? _inputConclusiones = '';
  String? get getInputConclusiones => _inputConclusiones;
  void setInputConclusionesChange(String? text) {
    _inputConclusiones = text;
    notifyListeners();
  }

  String? _inputRecomendaciones = '';
  String? get getInputRecomendaciones => _inputRecomendaciones;
  void setInputRecomendacionesChange(String? text) {
    _inputRecomendaciones = text;
  notifyListeners();
  }

//========================== DROPDOWN DIRIGIDO A  =======================//
  String? _labelInformePara;

  String? get labelInformePara => _labelInformePara;

  void setLabelInformePara(String value) {
    _labelInformePara = value;
    _textDirigidoA = '';
    _listaGuardiaInforme = [];
  notifyListeners();
  }
//========================== RECUPERA PERFIL DE USUARIO =======================//

  Session? _usuario;
  String? _perfilUsuario;

  Session? get getUsuario => _usuario;
  String? get getPerfilUsuario => _perfilUsuario;

  void setUsuario(Session? users) {
    _usuario = users;

  if(_usuario!.rol!.contains('SUPERVISOR')){
    _perfilUsuario='SUPERVISOR';
    _labelInformePara='JEFE DE OPERACIONES';
notifyListeners();
  }else if(_usuario!.rol!.contains('GUARDIA')){
 _perfilUsuario='GUARDIA';
  }

    notifyListeners();
  }






//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;
  List? _listaFotosUrl = [];
  List? get getListaFotosUrl => _listaFotosUrl;

  List<dynamic> _listaFotosCrearInforme = [];
  List<dynamic> get getListaFotosInforme => _listaFotosCrearInforme;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotosCrearInforme
        .add(CreaNuevaFotoInformeGuardias(id, _newPictureFile!.path));
  id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotosCrearInforme.add(CreaNuevaFotoInformeGuardias(id, path));

    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotosCrearInforme.removeWhere((element) => element!.id == id);

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
    for (var item in _listaFotosUrl!) {
      
    }
  }

//======================================================OBTIENE DATOS DEL GUARDIAMULTA============================================//
  int? _idPersonaInforme;
  String? _cedPersonaInforme;
  String? _nombrePersonaInforme;

  int? get getIdPersonaInforme => _idPersonaInforme;
  String? get getCedPersonaInforme => _cedPersonaInforme;
  String? get getNomPersonaInforme => _nombrePersonaInforme;

  set setIdPersonaInforme(int? id) {
    _idPersonaInforme = id;
   
    notifyListeners();
  }

  set setCedPersonaInforme(String? cedula) {
    _cedPersonaInforme = cedula;
    // print('CEDULA GUARDIA Informe: $_cedPersonaInforme');
    notifyListeners();
  }

  set setNomPersonaInforme(String? nombre) {
    _nombrePersonaInforme = nombre;
   
    notifyListeners();
  }

  //===================LEE CODIGO QR==========================//
  
  String? _infoQRGuardiaInforme;
  String? get getInfoQRMultaGuardia => _infoQRGuardiaInforme;

  Future setInfoQRMultaGuardia(String? value) async {
    _infoQRGuardiaInforme = value;
    if (_infoQRGuardiaInforme != null) {
      _errorInfoGuardiaInforme = true;
      final split = _infoQRGuardiaInforme!.split('-');
      setIdPersonaInforme = int.parse(split[0]);
      setCedPersonaInforme = split[1];
      setNomPersonaInforme = split[2];

      notifyListeners();
    } else {
      _errorInfoGuardiaInforme = false;
    }
  }

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaGuardiasInforme;

  @override
  void dispose() {
    _deboucerSearchBuscaGuardiasInforme?.cancel();
    _deboucerSearchBuscaClienteInformes?.cancel();
    super.dispose();
  }


// //================================================================================//


  List<Guardia> _listaInfoGuardiaInforme = [];
  List<Guardia> get getListaInfoGuardiaInforme => _listaInfoGuardiaInforme;

  void setInfoBusquedaGuardiaInforme(List<Guardia> data) {
    _listaInfoGuardiaInforme=[];
    _listaInfoGuardiaInforme = data;
  notifyListeners();
  }

  bool? _errorInfoGuardiaInforme; // sera nulo la primera vez
  bool? get getErrorInfoGuardiaInforme => _errorInfoGuardiaInforme;
  set setErrorInfoGuardiaInforme(bool? value) {
    _errorInfoGuardiaInforme = value;
    notifyListeners();
  }

  Future<AllGuardias?> buscaGuardiaInforme(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
final response = await _api.getAllInfoGuardias(
      search: _search,
      docnumero: _textDocNumDirigidoA,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardiaInforme = true;
  setInfoBusquedaGuardiaInforme(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardiaInforme = false;
      notifyListeners();
      return null;
    }
  }

//========================================//
  
  List _listaInformesGuardia = [];
 List get getListaInformesInforme => _listaInformesGuardia;

  void setInfoBusquedaInformesGuardia(List data) {
    _listaInformesGuardia = data;
  notifyListeners();
  }

  late Informe _informeGuardia;
  Informe get getInforme => _informeGuardia;

  void setinformeGuardia(Informe data) {
    _listaInformesGuardia.add(data);

    notifyListeners();
  }

  bool? _errorInformesGuardia; // sera nulo la primera vez
  bool? get getErrorInformesGuardia => _errorInformesGuardia;
  set setErrorInformesGuardia(bool? value) {
    _errorInformesGuardia = value;
    notifyListeners();
  }

  Future buscaInformeGuardias(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllInformesGuardia(
      search: _search, notificacion: notificacion,
     token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInformesGuardia = true;
    setInfoBusquedaInformesGuardia(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardiaInforme = false;
      notifyListeners();
      return null;
    }
  }


//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//
  List<InfoCliente> _listaTodosLosClientesInformes = [];
  List<InfoCliente> get getListaTodosLosClientesInfomes =>
      _listaTodosLosClientesInformes;

  void setListaTodosLosClientesInformes(List<InfoCliente> data) {
    _listaTodosLosClientesInformes = data;
    notifyListeners();
  }

  bool? _errorClientesInformes; // sera nulo la primera vez
  bool? get getErrorClientesInformes => _errorClientesInformes;

  Future<AllClientes?> getTodosLosClientesInformes(String? search) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllClientesMultas(
     search: search,
     estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorClientesInformes = true;
      setListaTodosLosClientesInformes(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClientesInformes = false;
      notifyListeners();
      return null;
    }
    return null;
  }
//  =================  CREO UN DEBOUNCE BUSCAR CLIENTES ==================//

  Timer? _deboucerSearchBuscaClienteInformes;

  String? _inputBuscaClienteInformes;
  get getInputBuscaClienteInformes => _inputBuscaClienteInformes;
  void onInputBuscaClienteInformesChange(String? text) {
    _inputBuscaClienteInformes = text;
  
//================================================================================//
 
    if (_inputBuscaClienteInformes!.length >= 3) {
      _deboucerSearchBuscaClienteInformes?.cancel();
      _deboucerSearchBuscaClienteInformes =
          Timer(const Duration(milliseconds: 500), () {
        getTodosLosClientesInformes(_inputBuscaClienteInformes);
     });
    } else if (_inputBuscaClienteInformes!.isEmpty) {
      getTodosLosClientesInformes('');
    } else {
      getTodosLosClientesInformes('');
    }

    notifyListeners();
  }

//========================================================= SELECCIONA  ==============================//

  List _listaGuardiaInforme = [];
  List get getListaGuardiaInforme => _listaGuardiaInforme;
  void setGuardiaInforme(dynamic guardia) {
  _listaGuardiaInforme.removeWhere((e) => (e['id'] == guardia['perId']));

    _listaGuardiaInforme.add({
      "perPuestoServicio": guardia['perPuestoServicio'],
      "docnumero": guardia['perDocNumero'],
      "nombres": '${guardia['perNombres']} ${guardia['perApellidos']}',
      "asignado": true,
      "id": guardia['perId'],
      "foto": guardia['perFoto'],
      "correo": guardia['perEmail']
    });
    notifyListeners();
  }
//========================================================= SELECCIONA guardia por cliente ==============================//


  void setDirigidoAChange(dynamic persona) {
    _idCliente = persona['perId'];
    infDocNumDirigido = persona['perDocNumero'];
    _textDirigidoA = '${persona['perApellidos']} ${persona['perNombres']}';
  _infCorreosCliente = persona?['perEmail'];
 notifyListeners();
  }

  void setDirigidoAClienteChange(dynamic persona) {
    _idCliente = persona.cliId;
    infDocNumDirigido = persona.cliDocNumero;
    _textDirigidoA = persona.cliRazonSocial;
    _infCorreosCliente = persona?.perEmail;
 notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future crearInforme(
    BuildContext context,
  ) async {
    final serviceSocket = SocketService();
 final infoUser = await Auth.instance.getSession();
   
    final _pyloadNuevoInforme = {
      "tabla": "informe", //DEFECTO
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "infIdDirigido": _idCliente, // perId
      "infRol": infoUser.rol, // del login
      "infPara":
          _labelInformePara, // de select ################################
      "infDocNumDirigido": infDocNumDirigido, // perDocNumero
      "infNomDirigido": _textDirigidoA, // perApellidos- perNombres

      "infGenerado": "",
      "infDocumento": "",

      "infAsunto": _inputAsunto, // input
      "infTipoNovedad": _inputTipoNovedad, // input

      "infCorreo": _infCorreosCliente,
      "infFechaSuceso":
          '${_inputFechaInformeGuardia}T$_inputHoraInformeGuardia', // input y hora
      "infLugar": _inputLugar, // input
      "infPerjudicado": _inputPejudicado, // input
      "infPorque": _inputMotivo, // input
      "infSucedido": _inputDetalle, // textarea
      "infConclusiones": _inputConclusiones, // textarea
      "infRecomendaciones": _inputRecomendaciones, // textarea
      "infGuardias":
          _listaGuardiaInforme, // array para los guardias asignados (LLenar con los mismos parametros que se utilizo en consigna)
      "infFotos": _listaFotosUrl,
      "infVideo": _listaVideosUrl,
      "infUser": infoUser.usuario, //LOGIN
      "infEmpresa": infoUser.rucempresa //LOGIN
    };
      serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoInforme);
  }

  //================================== ELIMINAR  MULTA  ==============================//
  Future eliminaInformeGuardia(BuildContext context, int? idInforme) async {
   final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final infoUser = await Auth.instance.getSession();

  final _pyloadEliminaInformeGuardia = {
      {
        "tabla": 'informe',
        "rucempresa": infoUser!.rucempresa,
        "infId": idInforme,
      }
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaInformeGuardia);
    buscaInformeGuardias('','false');
   
  }

  //==========================TRABAJAMOS CON VIDEO  ===============================//

  String? _pathVideo =
      'https://movietrailers.apple.com/movies/independent/unhinged/unhinged-trailer-1_h720p.mov';
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

  List<dynamic> _listaVideosUrl = [];
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
    // final responseData = json.decode(responsed.body);

    if (responsed.statusCode == 200) {
      final responseVideo = FotoUrl.fromJson(responsed.body);
      final _urlVideo = responseVideo.urls[0];
      setUrlVideo(responseVideo.urls[0].url);
     _listaVideosUrl.addAll([
        {
          "nombre": responseVideo
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseVideo.urls[0].url
        }
      ]);

    }
    for (var item in _listaVideosUrl) {
    }
  }

  void eliminaVideo() {
    _listaVideosUrl.clear();
    _urlVideo = '';
    _pathVideo = '';
    notifyListeners();
  }

//====================================TOMAMO LOS DATOS PARA EDITAR INFORME  ============================================//
  int? _idInforme;
  String? _infIdDirigido = '';
  String? get getInfIdDirigido => infDocNumDirigido;
  String? _infGenerado = '';
  String? _infFechaSuceso = '';
  void getDataInformeGuardia(Informe informe) {
    //============================= INPUTS ==================================//
    _idInforme = informe.infId;
    _infIdDirigido = informe.infIdDirigido;
    _textDocNumDirigidoA = informe.infDocNumDirigido;
    _textDirigidoA = informe.infNomDirigido;
    _infCorreosCliente = informe.infCorreo;
    _infFechaSuceso = informe.infFechaSuceso;
    _inputAsunto = informe.infAsunto;
    _inputTipoNovedad = informe.infTipoNovedad;
    _inputLugar = informe.infLugar;
    _inputPejudicado = informe.infPerjudicado;
    _inputMotivo = informe.infPorque;
    _inputDetalle = informe.infSucedido;
    _inputHoraInformeGuardia = informe.infFechaSuceso;

    informe.infFotos!.map((e) {
      return _listaFotosUrl!.addAll([
        {
          "nombre": e.nombre,
          "url": e.url
        }
      ]);
    });
    notifyListeners();
   for (var e in informe.infGuardias!) {
      _listaGuardiaInforme.add({
        "perPuestoServicio": e.perPuestoServicio!.map((x) {
          return {
            "ruccliente": x.ruccliente,
            "razonsocial": x.razonsocial,
            "ubicacion": x.ubicacion,
            "puesto": x.puesto,
          };
        }).toList(),
        "docnumero": e.docnumero,
        "nombres": e.nombres,
        "asignado": true,
        "id": e.id,
        "foto": e.foto,
        "correo": e.correo
      });
    }
   
  }

  void getDataInformes(dynamic informe) {
    //============================= INPUTS ==================================//
    _idInforme = informe['infId'];
    _infIdDirigido = informe['infIdDirigido'];
    _textDocNumDirigidoA = informe['infDocNumDirigido'];
    _textDirigidoA = informe['infNomDirigido'];
    _infCorreosCliente = informe['infCorreo'];
    _infGenerado = informe['infGenerado'];
    _infFechaSuceso = informe['infFechaSuceso'];
    _inputAsunto = informe['infAsunto'];
    _inputTipoNovedad = informe['infTipoNovedad'];
    _inputLugar = informe['infLugar'];
    _inputPejudicado = informe['infPerjudicado'];
    _inputMotivo = informe['infPorque'];
    _inputDetalle = informe['infSucedido'];
    _inputHoraInformeGuardia = informe['infFechaSuceso'];
    _labelInformePara = informe['infPara'];
    _listaFotosUrl = informe['infFotos'];
    _listaVideosUrl = informe['infVideo'];
    _inputConclusiones = informe["infConclusiones"]; // textarea
    _inputRecomendaciones = informe["infRecomendaciones"]; // textarea
 notifyListeners();
//  if(informe['infGuardias'].isNotEmpty){

  // for (var e in informe['infGuardias']!) {
  //     _listaGuardiaInforme.add({
  //       "perPuestoServicio": e['perPuestoServicio']!.map((x) {
  //         return {
  //           "ruccliente": x['ruccliente'],
  //           "razonsocial": x['razonsocial'],
  //           "ubicacion": x['ubicacion'],
  //           "puesto": x['puesto'],
  //         };
  //       }).toList(),
  //       "docnumero": e['docnumero'],
  //       "nombres": e['nombres'],
  //       "asignado": true,
  //       "id": e['id'],
  //       "foto": e['foto'],
  //       "correo": e['correo']
  //     });
  //   }
//  }
  
  }

  void eliminaFotoUrl(String url) {
    _listaFotosUrl!.removeWhere((e) => e['url'] == url);
  }
  //================================== CREA NUEVA CONSIGNA  ==============================//
  Future editarInforme(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();
   
    final _pyloadEditaInforme = {
      "tabla": "informe", //DEFECTO
      "infId": _idInforme,
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, //LOGIN

      "infRol": infoUser.rol, // del login
      "infIdDirigido": _idCliente, // perId
      "infPara":
          _labelInformePara, // de select ################################
      "infDocNumDirigido": infDocNumDirigido, // perDocNumero
      "infNomDirigido": _textDirigidoA, // perApellidos- perNombres
      "infDocumento": "",
      "infGenerado": _infGenerado,

      "infConclusiones": _inputConclusiones, // textarea
      "infRecomendaciones": _inputRecomendaciones, // textarea
 "infAsunto": _inputAsunto, // input
      "infTipoNovedad": _inputTipoNovedad, // input
      "infCorreo": _infCorreosCliente,
      "infFechaSuceso": _infFechaSuceso, // input y hora
      "infLugar": _inputLugar, // input
      "infPerjudicado": _inputPejudicado, // input
      "infPorque": _inputMotivo, // input
      "infSucedido": _inputDetalle, // textarea
      "infGuardias":
          _listaGuardiaInforme, // array para los guardias asignados (LLenar con los mismos parametros que se utilizo en consigna)
      "infFotos": _listaFotosUrl,
      "infVideo": _listaVideosUrl,
      "infUser": infoUser.usuario, //LOGIN
      "infEmpresa": infoUser.rucempresa //LOGIN
    };
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaInforme);
  }
//=======================================================================//

//===============LISTAMOS TODOS LOS GUARDIAS =========================//
  List _listaInfoGuardia = [];
  List get getListaInfoGuardia => _listaInfoGuardia;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardia = data;
  notifyListeners();
  }

  bool? _errorInfoGuardia; // sera nulo la primera vez
  bool? get getErrorInfoGuardia => _errorInfoGuardia;
  set setErrorInfoGuardia(bool? value) {
    _errorInfoGuardia = value;
    notifyListeners();
  }

  Future buscaInfoGuardias(String? _search) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllGuardias(
      search: _search,
      estado: 'GUARDIAS',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardia = true;
 setInfoBusquedaInfoGuardia(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardia = false;
      notifyListeners();
      return null;
    }
  }

//==================OBTENEMOS A LOS GUARDIAS POR CLIENTES======================//
  List _listaInfoGuardiaPorCliente = [];
  List get getListaInfoGuardiaPorCliente => _listaInfoGuardiaPorCliente;

  void setInfoBusquedaInfoGuardiaPorCliente(List data) {
    _listaInfoGuardiaPorCliente = data;
   notifyListeners();
  }

  bool? _errorInfoGuardiaPorCliente; // sera nulo la primera vez
  bool? get getErrorInfoGuardiaPorCliente => _errorInfoGuardiaPorCliente;
  set setErrorInfoGuardiaPorCliente(bool? value) {
    _errorInfoGuardiaPorCliente = value;
    notifyListeners();
  }

  Future buscaInfoGuardiasPorCliente(String? _search) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllGuardiasPorCliente(
      search: _search,
     docnumero: infDocNumDirigido,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardiaPorCliente = true;
setInfoBusquedaInfoGuardiaPorCliente(response['data']);
     notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardiaPorCliente = false;
      notifyListeners();
      return null;
    }
  }

//===================BUSCAR PERSONA DIRIGIDO A=====================//
  List _listaPersonaDirigidoA = [];
 List get getListaPersonaDirigidoA => _listaPersonaDirigidoA;

  void setInfoBusquedaPersonaDirigidoA(List data) {
    _listaPersonaDirigidoA = data;
  notifyListeners();
  }

  bool? _errorPersonaDirigidoA; // sera nulo la primera vez
  bool? get getErrorPersonaDirigidoA => _errorPersonaDirigidoA;
  set setErrorPersonaDirigidoA(bool? value) {
    _errorPersonaDirigidoA = value;
    notifyListeners();
  }

  Future buscaPersonaDirigidoAs(String? _search) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllPersonasDirigidoA(
      search: _search,
      estado: _labelInformePara,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPersonaDirigidoA = true;
setInfoBusquedaPersonaDirigidoA(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPersonaDirigidoA = false;
      notifyListeners();
      return null;
    }
  }


 //================================== RESPONDER COMUNICADO  ==============================//
  String? _inputRespondeInforme;
  get getInputRespondeInforme => _inputRespondeInforme;
  void onInputRespondeInformeChange(String? date) {
    _inputRespondeInforme = date;
    // print('INPUT RESPONDE: ===================+> $_inputRespondeInforme');
    notifyListeners();
  }
//=======================================================================================================//

  //================================== LEE  Informe  ==============================//
  Future respondeInforme(
      int? _idInforme, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadRespondeInforme = {


      "tabla": "respuestainforme",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "infId": _idInforme,
      "infIdPersona": infoUser.id,

      "docnumero": infoUser.usuario, //login.usuario
      "nombres": infoUser.nombre, //login.nombre

      "respuestaTexto": _inputRespondeInforme,
     



    };
    serviceSocket.socket! .emit('client:actualizarData', _pyloadRespondeInforme);
    // print('LA DATA QUE ENVIO $_pyloadRespondeInforme');


    //    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   print('EL MENSAJE ==============<> : ${data}');
    //   // if (data['tabla'] == 'informe') {
    //   //   // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   // }
    // });


  }










}
