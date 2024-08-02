// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_foto_consigna_cliente.dart';
import 'package:nseguridad/src/models/crea_foto_realiza_consigna_guardia.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/get_info_guardia_multa.dart';
import 'package:nseguridad/src/models/lista_allConsignas_clientes.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:provider/provider.dart';

// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_foto_consigna_cliente.dart';
// import 'package:sincop_app/src/models/crea_foto_realiza_consigna_guardia.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/get_info_guardia_multa.dart';
// import 'package:sincop_app/src/models/lista_allConsignas_clientes.dart';
// import 'package:sincop_app/src/service/notifications_service.dart' as snaks;

// import 'package:sincop_app/src/service/socket_service.dart';
import 'package:nseguridad/src/service/notifications_service.dart' as snaks;

import '../api/api_provider.dart';

class ConsignasClientesController extends ChangeNotifier {
  GlobalKey<FormState> consignasClienteFormKey = GlobalKey<FormState>();

  ConsignasClientesController() {
    getTodasLasConsignasClientes('', 'false');

    _listaFotos.clear;
  }

  resetValues() async {
    _listaFotosUrl.clear();
    _listaFotos.clear();
    _listaGuardiaInforme.clear();
    _listaFechaSeleccionada = [];
    _listaFotosRealizaConsigna = [];
  }

  final _api = ApiProvider();
  bool validateForm() {
    if (consignasClienteFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool _estadoConsigna = false;
  int? _itemConsigna = 0;
  get getItemConsigna => _itemConsigna;

  bool get getEstadoConsigna => _estadoConsigna;
  void setEstadoConsigna(bool value, int item) {
    _estadoConsigna = value;
    _itemConsigna = item;

    notifyListeners();
  }

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

  //========================== VALIDA CAMPO  FECHA INICIO CONSIGNA =======================//
  String? _inputFechaInicioConsigna;
  get getInputfechaInicioConsigna => _inputFechaInicioConsigna;
  void onInputFechaInicioConsignaChange(String? date) {
    _inputFechaInicioConsigna = date;

    notifyListeners();
  }

  String? _inputHoraInicioConsigna;
  get getInputHoraInicioConsigna => _inputHoraInicioConsigna;
  void onInputHoraInicioConsignaChange(String? date) {
    _inputHoraInicioConsigna = date;

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

  //========================== VALIDA CAMPO  FECHA FIN CONSIGNA =======================//
  String? _inputFechaFinConsigna;
  get getInputfechaFinConsigna => _inputFechaFinConsigna;
  void onInputFechaFinConsignaChange(String? date) {
    _inputFechaFinConsigna = date;
    notifyListeners();
  }

  String? _inputHoraFinConsigna;
  get getInputHoraFinConsigna => _inputHoraFinConsigna;
  void onInputHoraFinConsignaChange(String? date) {
    _inputHoraFinConsigna = date;
    notifyListeners();
  }

//========================== DROPDOWN PERIODO CONSIGNA CLIENTE =======================//
  String? _labelConsignaCliente = '1';

  String? get labelConsignaCliente => _labelConsignaCliente;

  set setLabelConsignaCliente(String value) {
    _labelConsignaCliente = value;

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

  //========================== VALIDA REPETIR =======================//

  bool _diaValueLunes = false;
  bool _diaValueMartes = false;
  bool _diaValueMiercoles = false;
  bool _diaValueJueves = false;
  bool _diaValueViernes = false;
  bool _diaValueSabado = false;
  bool _diaValueDomingo = false;
  bool get getDiaLunes => _diaValueLunes;
  bool get getDiaMartes => _diaValueMartes;
  bool get getDiaMiercoles => _diaValueMiercoles;
  bool get getDiaJueves => _diaValueJueves;
  bool get getDiaViernes => _diaValueViernes;
  bool get getDiaSabado => _diaValueSabado;
  bool get getDiaDomingo => _diaValueDomingo;

//================================== OBTENEMOS TODAS LAS CONSIGNAS  ==============================//
  List<dynamic> _listaTodasLasConsignasCliente = [];
  List<dynamic> get getListaTodasLasConsignasCliente =>
      _listaTodasLasConsignasCliente;

  void setListaTodasLasConsignasCliente(List<dynamic> data) {
    _listaTodasLasConsignasCliente = data;
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

//========================================================= OBTENEMOS LA INFO DE LA CONSIGNA PARA EDITAR ==============================//

  dynamic _consigna;
  dynamic get getConsigna => _consigna;
  void getInformacionConsigna(dynamic data) {
    _consigna = data;
    notifyListeners();
  }

  List<Guardia> _listaInfoGuardiaConsigna = [];

  List<Guardia> get getListaInfoGuardiaConsigna => _listaInfoGuardiaConsigna;

  void setInfoBusquedaGuardiaConsigna(List<Guardia> data) {
    _listaInfoGuardiaConsigna = data;

    notifyListeners();
  }

  bool? _errorLoadPersonal; // sera nulo la primera vez
  bool? get getErrorLoadPersonal => _errorLoadPersonal;

  List<dynamic> _listaGuardiaInforme = [];
  List<dynamic> get getListaGuardiasConsigna => _listaGuardiaInforme;
  void setGuardiaConsigna(Guardia guardia) {
    _listaGuardiaInforme.removeWhere((e) => (e['id'] == guardia.perId));
    _listaGuardiaInforme.add({
      "docnumero":
          guardia.perDocNumero, // al consumir el endpoint => perDocNumero
      "nombres": '${guardia.perNombres} ${guardia.perApellidos}',
      "asignado": true, // si esta marcado el check
      "id": guardia.perId, // al consumir el endpoint => perId
      "foto": guardia.perFoto,
    });
    notifyListeners();
  }

  void eliminaGuardiaConsigna(int id) {
    _listaGuardiaInforme.removeWhere((e) => (e['id'] == id));
    _listaGuardiaInforme.forEach(((element) {}));
    notifyListeners();
  }

  String? _textDocNumDirigidoA = '';

  Future<AllGuardias?> buscaGuardiasConsigna(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInfoGuardias(
      search: _search,
      docnumero: _textDocNumDirigidoA,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorLoadPersonal = true;
      setInfoBusquedaGuardiaConsigna(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorLoadPersonal = false;
      notifyListeners();
      return null;
    }
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future creaConsignaCliente(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();
    final _pyloadNuevaConsigna = {
      "tabla": "consigna", // defecto
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, //login
      "conIdCliente": infoUser.id, // login => id
      "conNombreCliente": infoUser.nombre, // login => nombre
      "conAsunto": _asunto,
      "conDetalle": _detalle,
      "conDesde": '$_inputFechaInicioConsigna $_inputHoraInicioConsigna',
      "conHasta": ' $_inputFechaFinConsigna $_inputHoraFinConsigna',
      "conFrecuencia": _labelConsignaCliente,
      "conPrioridad": _prioridadCliente,
      "conEstado": "ACTIVA", // con valor ACTIVA porque es un registro nuevo
      "conProgreso": "NO REALIZADO", // con valor 0 porque es un registro nuevo
      "conDiasRepetir": _diaSemanas,
      "conAsignacion": _listaGuardiaInforme,
      "conFotosCliente": _listaFotosUrl,
      "conLeidos": [],
      "conUser": infoUser.usuario, //login
      "conEmpresa": infoUser.rucempresa, //login
    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaConsigna);
  }

  //================================== ELIMINAR  COMUNICADO  ==============================//
  Future consignaLeidaGuardia(int? _idConsigna, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();
    final _pyloadConsignaLeidaGuardia = {
      "tabla": "consignaleido", // defecto
      "rucempresa": infoUser!.rucempresa, // login
      "rol": infoUser.rol, // login
      "comId": _idConsigna, // id del registro
      "comIdPersona": infoUser.id, // login
      "comNombrePersona": infoUser.nombre, //login nombre
      "comUser": infoUser.rucempresa // login
    };
    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadConsignaLeidaGuardia);
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'comunicadoleido') {
        getTodasLasConsignasClientes('', 'false');
        serviceSocket.socket?.clearListeners();
        notifyListeners();
      }
    });
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

//========================== EDITAR FORMULARIO CONSIGNA =======================//
  void datosConsigna(Result? infoConsignaCliente) {
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
      _listaFotosUrl.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);

    }
    for (var item in _listaFotosUrl) {
    
    }

//========================================//
  }

  Future eliminaConsignaCliente(BuildContext context, Result? consigna) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaConsignaCliente = {
      "tabla": "consigna", // defecto
      "conId": consigna!.conId,
      "rucempresa": infoUser!.rucempresa, //login
    };

    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaConsignaCliente);
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        getTodasLasConsignasClientes('', 'false');
        snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
        serviceSocket.socket?.clearListeners();
        notifyListeners();
      }
    });
  }

  void resetVariablesRealizarConsigna() {
    _inputObservacionesRealizaConsigna = '';
    _listaFotosRealizaConsigna = [];
    notifyListeners();
  }

//========================== VALIDA CAMPO  FECHA INICIO CONSIGNA =======================//
  String? _inputObservacionesRealizaConsigna;
  get getInputObservacionesRealizaConsigna =>
      _inputObservacionesRealizaConsigna;
  void onInputObservacionesRealizaConsignaChange(String? date) {
    _inputObservacionesRealizaConsigna = date;
   notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA REALIZAR CONSIGNA=======================//
  int idFotoRealizaConsigna = 0;
  File? _newPictureFileRealizaConsigna;
  File? get getNewPictureFileRealizaConsigna => _newPictureFileRealizaConsigna;

  List<CreaNuevaFotoRealizaConsignaGuardia?> _listaFotosRealizaConsigna = [];
  List<CreaNuevaFotoRealizaConsignaGuardia?>
      get getListaFotosListaFotosRealizaConsigna => _listaFotosRealizaConsigna;
  void setNewPictureFileRealizaConsigna(String? path) {
    _newPictureFileRealizaConsigna = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFileRealizaConsigna);
    _listaFotosRealizaConsigna.add(CreaNuevaFotoRealizaConsignaGuardia(
        idFotoRealizaConsigna, _newPictureFileRealizaConsigna!.path));

    idFotoRealizaConsigna = idFotoRealizaConsigna + 1;
    notifyListeners();
  }

  void eliminaFotoRealizaConsigna(int id) {
   _listaFotosRealizaConsigna.removeWhere((element) => element!.id == id);

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

//=============================SELECCIONA DIA DE LA SEMANA===============================//

  List<String>? _diaSemanasTepmporal = [];
  List<String>? get getDiaSemanasTepmporal => _diaSemanasTepmporal;
  void setDiaSemanasTepmporal(List<String>? diasTemporal) {
    _diaSemanasTepmporal = diasTemporal;
   notifyListeners();
  }

  void persisteSemanaOriginal() {
    _diaSemanas = _diaSemanasTepmporal;
    notifyListeners();
  }

  List<String>? _diaSemanas = [];

  List<String>? get getDiaSemana => _diaSemanas;
  void setDiaSemanas(List<String>? dias) {
    _diaSemanas = dias;
   for (var e in _diaSemanas!) {
     
    }

    for (var e in _diaSemanas!) {
      if (e == 'LUNES' && _diaValueLunes == true) {
        _diaValueLunes = false;
      } else if (e == 'LUNES' && _diaValueLunes == false) {
        _diaValueLunes = true;
       
      }
    }
    for (var e in _diaSemanas!) {
      if (e == 'MARTES' && _diaValueMartes == true) {
        _diaValueMartes = false;
      } else if (e == 'MARTES' && _diaValueMartes == false) {
        _diaValueMartes = true;
      }
    }
    for (var e in _diaSemanas!) {
      if (e == 'MIERCOLES' && _diaValueMiercoles == true) {
        _diaValueMiercoles = false;
      } else if (e == 'MIERCOLES' && _diaValueMiercoles == false) {
        _diaValueMiercoles = true;
      }
    }
    for (var e in _diaSemanas!) {
      if (e == 'JUEVES' && _diaValueJueves == true) {
        _diaValueJueves = false;
      } else if (e == 'JUEVES' && _diaValueJueves == false) {
        _diaValueJueves = true;
      }
    }
    for (var e in _diaSemanas!) {
      if (e == 'VIERNES' && _diaValueViernes == true) {
        _diaValueViernes = false;
      } else if (e == 'VIERNES' && _diaValueViernes == false) {
        _diaValueViernes = true;
      }
    }
    for (var e in _diaSemanas!) {
      if (e == 'SABADO' && _diaValueSabado == true) {
        _diaValueSabado = false;
      } else if (e == 'SABADO' && _diaValueSabado == false) {
        _diaValueSabado = true;
      }
    }

    for (var e in _diaSemanas!) {
      if (e == 'DOMINGO' && _diaValueDomingo == true) {
        _diaValueDomingo = false;
      } else if (e == 'DOMINGO' && _diaValueDomingo == false) {
        _diaValueDomingo = true;
      }
    }
  }

  void setDiaLunes(String dia) {
    _diaSemanas!.add(dia);
    _diaValueLunes = true;
    notifyListeners();
  }

  void setDiaMartes(String dia) {
    _diaSemanas!.add(dia);
    _diaValueMartes = true;

    notifyListeners();
  }

  void setDiaMiercoles(String dia) {
    _diaSemanas!.add(dia);
    _diaValueMiercoles = true;

    notifyListeners();
  }

  void setDiaJueves(String dia) {
    _diaSemanas!.add(dia);
    _diaValueJueves = true;

    notifyListeners();
  }

  void setDiaViernes(String dia) {
    _diaSemanas!.add(dia);
    _diaValueViernes = true;

    notifyListeners();
  }

  void setDiaSabado(String dia) {
    _diaSemanas!.add(dia);
    _diaValueSabado = true;

    notifyListeners();
  }

  void setDiaDomingo(String dia) {
    _diaSemanas!.add(dia);
    _diaValueDomingo = true;

    notifyListeners();
  }

  void semanaDiaOnChange(String dia) {
    
    notifyListeners(); // for (var i = 0; i < diaSemana.length; i++) {
  }

  void eliminaDia(String dia) {
    _diaSemanas!.remove(dia);
    if (dia == 'LUNES') {
      _diaValueLunes = false;
      notifyListeners();
    }
    if (dia == 'MARTES') {
      _diaValueMartes = false;
      notifyListeners();
    }
    if (dia == 'MIERCOLES') {
      _diaValueMiercoles = false;
      notifyListeners();
    }
    if (dia == 'JUEVES') {
      _diaValueJueves = false;
      notifyListeners();
    }
    if (dia == 'VIERNES') {
      _diaValueViernes = false;
      notifyListeners();
    }
    if (dia == 'SABADO') {
      _diaValueSabado = false;
      notifyListeners();
    }
    if (dia == 'DOMINGO') {
      _diaValueDomingo = false;
      notifyListeners();
    }
  }

  void loadDias() {
    for (var e in _diaSemanas!) {
     
    }
    for (var e in _diaSemanas!) {
      if (e == 'MARTES' && _diaValueMartes == true) {
        _diaValueMartes = false;
      } else if (e == 'MARTES' && _diaValueMartes == false) {
        _diaValueMartes = true;
      }
      notifyListeners();
    }
    for (var e in _diaSemanas!) {
      if (e == 'MIERCOLES' && _diaValueMiercoles == true) {
        _diaValueMiercoles = false;
      } else if (e == 'MIERCOLES' && _diaValueMiercoles == false) {
        _diaValueMiercoles = true;
      }
      notifyListeners();
    }
    for (var e in _diaSemanas!) {
      if (e == 'JUEVES' && _diaValueJueves == true) {
        _diaValueJueves = false;
      } else if (e == 'JUEVES' && _diaValueJueves == false) {
        _diaValueJueves = true;
      }
      notifyListeners();
    }
    for (var e in _diaSemanas!) {
      if (e == 'VIERNES' && _diaValueViernes == true) {
        _diaValueViernes = false;
      } else if (e == 'VIERNES' && _diaValueViernes == false) {
        _diaValueViernes = true;
      }
      notifyListeners();
    }
    for (var e in _diaSemanas!) {
      if (e == 'SABADO' && _diaValueSabado == true) {
        _diaValueSabado = false;
      } else if (e == 'SABADO' && _diaValueSabado == false) {
        _diaValueSabado = true;
      }
      notifyListeners();
    }

    for (var e in _diaSemanas!) {
      if (e == 'DOMINGO' && _diaValueDomingo == true) {
        _diaValueDomingo = false;
      } else if (e == 'DOMINGO' && _diaValueDomingo == false) {
        _diaValueDomingo = true;
      }
      notifyListeners();
    }
  }

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaGuardiasConsigna;

  @override
  void dispose() {
    _deboucerSearchBuscaGuardiasConsigna?.cancel();
    
    super.dispose();
  }

  String? _inputBuscaGuardia;
  get getInputBuscaGuardia => _inputBuscaGuardia;
  void onInputBuscaGuardiaChange(String? text) {
    _inputBuscaGuardia = text;
   
//================================================================================//
    if (_inputBuscaGuardia!.length >= 3) {
      _deboucerSearchBuscaGuardiasConsigna?.cancel();
      _deboucerSearchBuscaGuardiasConsigna =
          Timer(const Duration(milliseconds: 500), () {
        buscaGuardiasConsigna(_inputBuscaGuardia);
       
      });
    } else if (_inputBuscaGuardia!.isEmpty) {
      buscaGuardiasConsigna('');
    } else {
      buscaGuardiasConsigna('');
    }

    notifyListeners();
  }

//====================================EDITAR CONSIGNA============================================//
  void getInfoEdit(Result consigna) {
    _labelConsignaCliente = consigna.conFrecuencia;
    _prioridadCliente = consigna.conPrioridad!;
    _prioridadValueCliente = (consigna.conPrioridad == 'ALTA')
        ? 1
        : (consigna.conPrioridad == 'MEDIA')
            ? 2
            : 3;
    for (var e in consigna.conAsignacion!) {
      _listaGuardiaInforme.add({
        "docnumero": e.docnumero, // al consumir el endpoint => perDocNumero
        "nombres": e.nombres,
        "asignado": e.asignado, // si esta marcado el check
        "id": e.id, // al consumir el endpoint => perId
        "foto": e.foto,
      });
    }

    for (var e in consigna.conFotosCliente!) {
      _listaFotosUrl.addAll([
        {"nombre": e.nombre, "url": e.url}
      ]);
    }
  }

  //================================== ELIMINAR  COMUNICADO  ==============================//
  Future relizaGuardiaConsigna(int? _idConsigna, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

   final _pyloadRealizaGuardiaConsigna = {
      "tabla": "consignatrabajo", // defecto
      "rucempresa": infoUser!.rucempresa, // login
      "rol": infoUser.rol, // login
      "conId": _idConsigna, // id de registro
      "id_persona": infoUser.id, //  login
      "detalle": _inputObservacionesRealizaConsigna,
      "fotos": _listaFotosUrl


    };

   serviceSocket.socket!
        .emit('client:actualizarData', _pyloadRealizaGuardiaConsigna);
        
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'consignatrabajo') {
        getTodasLasConsignasClientes('', 'false');
        
        // snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
       notifyListeners();
      }
    });
  }

//====================================SELECCIONA FECHA DE CONSIGNAS====================================================//

  List<DateTime>? _listaFechaSeleccionada = [];
  List<DateTime>? get getLitaSeleccionada => _listaFechaSeleccionada;
 void setListMultiSelect(List<DateTime>? select) {
    _listaFechaSeleccionada = select;
 notifyListeners();
  }



//========================================================================================//

}
