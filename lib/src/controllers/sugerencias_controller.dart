import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/service/socket_service.dart';


class SugerenciasController extends ChangeNotifier {

  GlobalKey<FormState> sugerenciasFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesSugerencias() {
  _inputFechaCreacion ='${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  _inputFechaInicio ='${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  _inputFechaFin ='${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  _labelArea='';
  _labelMotivoSugerencia='SUGERENCIA';
  _receptor='';
  _listaDataArea = [];
  }

  bool validateForm() {
    if (sugerenciasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaSugerencia;

  @override
  void dispose() {
    _deboucerSearchBuscaSugerencia?.cancel();
 super.dispose();
  }

//===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
  //===================BOTON SEARCH MORE CLIENTE==========================//

  bool _btnSearchSugerencias = false;
  bool get btnSearchSugerencias => _btnSearchSugerencias;

  void setBtnSearchSugerencias(bool action) {
    _btnSearchSugerencias = action;
    notifyListeners();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    if (_nameSearch.length >= 3) {
      _deboucerSearchBuscaSugerencia?.cancel();
      _deboucerSearchBuscaSugerencia = Timer(const Duration(milliseconds: 700), () {
        
        // buscaAusencias(_nameSearch, 'false');
      });
    } else {
      // buscaAusencias('', 'false');
    }
   
  }

  //================================== OBTENEMOS TODAS LAS SUGERENCIAS  =====++++++++++++++++++++++++++++++++++++++++++++=========================//
  List<dynamic> _listaTodasLasSugerencias = [];
  List<dynamic> get getListaTodasLasSugerencias => _listaTodasLasSugerencias;

  void setListaTodasLasSugerencias(List<dynamic> data) {
    data.sort((a, b) => b['mejFecReg'].compareTo(a['mejFecReg']));
    _listaTodasLasSugerencias = data;
    notifyListeners();
  }

  bool? _errorTodasLasSugerencias; // sera nulo la primera vez
  bool? get getErrorTodasLasSugerencias => _errorTodasLasSugerencias;

  Future<dynamic> getTodasLasSugerencias(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllSugerencias(
      search: search,
      tipo: 'RECLAMO',
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorTodasLasSugerencias = true;

      // List dataSort = [];
      // dataSort = response['data'];
      // dataSort.sort((a, b) => b['mejFecReg']!.compareTo(a['mejFecReg']!));

      setListaTodasLasSugerencias(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodasLasSugerencias = false;
      notifyListeners();
      return null;
    }
    return null;
  }



//OBTENEMOS LA INFORMACION DE LA SUGERENCIA

dynamic _dataSugerencia='';
get getdataSugerencia=>_dataSugerencia;
void getDataSugerencia(dynamic _data){
_dataSugerencia=_data;
onInputFechaCreacionChange(_data['mejFecha']);
setLabelArea(_data['mejProceso']);
setReceptor(_data['mejNombreReceptor']);

onAsuntoChange(_data['mejAsunto']);
onDetalleChange(_data['mejDetalles']);

setLabelMotivoSugerencia(_data['mejMotivo']);
onInputFechaInicioChange(_data['mejFecDesde']);
onInputFechaFinChange(_data['mejFecHasta']);


// "mejId": getdataSugerencia[''], // defecto
//   "mejTipo": "RECLAMO", // defecto
//   "mejSecuencia": getdataSugerencia[''], // defecto
//   "": getdataSugerencia[''], // textarea
//   "mejDetalleAcciones": getdataSugerencia[''], // defecto
//   "mejFecReg": getdataSugerencia[''], // defecto
//   "mejFecUpd": getdataSugerencia[''], // defecto
//   "": getdataSugerencia[''], // input
//   "":getdataSugerencia[''],//"ADMINISTRACION", //select=> LOGISTICA || ADMINISTRACION || GERENTE || ASISTENTE DE GERENCIA || JEFE DE OPERACIONES || COMPRAS PUBLICAS || CONTADOR || SECRETARIA || SERVICIOS VARIOS || OTROS
//   "mejIdEmisor": getdataSugerencia[''], // login
//   "mejNombreEmisor": getdataSugerencia[''], // login
//   "mejIdReceptor":getdataSugerencia[''],//333", // endpoint
//   "mejDocumentoReceptor": getdataSugerencia[''],//"0302626288", // endpoint
//   "": getdataSugerencia[''],//"MARTINEZ BRUNO", // endpoint
//   "": getdataSugerencia[''],//"SUJERENCIA", // select => QUEJA || RECLAMO
//   "mejIdCliente": getdataSugerencia[''], // defecto
//   "mejDocumentoCliente": getdataSugerencia[''], // defecto
//   "mejNombreCliente": getdataSugerencia[''], // defecto
//   "": getdataSugerencia[''],// defecto
//   "mejDocumento": getdataSugerencia[''], // defecto
//   "": getdataSugerencia[''],//"2023-04-20", // input
//   "": getdataSugerencia[''],//"2023-04-28", // input
//   "mejMetodo": getdataSugerencia[''], // defecto
//   "mejGuardias":getdataSugerencia[''], // defecto
//   "mejSupervisores":getdataSugerencia[''], // defecto
//   "mejAdministracion":getdataSugerencia[''], // defecto
//   "mejFechas":getdataSugerencia[''], // defecto
//   "mejFechasDB":getdataSugerencia[''], // defecto
//   "mejFotos":getdataSugerencia[''], 








  notifyListeners();
}
//========================== VALIDA CAMPO  FECHA CREACION=======================//
  String? _inputFechaCreacion =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaCreacion => _inputFechaCreacion;
  void onInputFechaCreacionChange(String? date) {
    _inputFechaCreacion = date;

    notifyListeners();
  }
//========================== VALIDA CAMPO  FECHA INICIO  =======================//
  String? _inputFechaInicio =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaInicio => _inputFechaInicio;
  void onInputFechaInicioChange(String? date) {
    _inputFechaInicio = date;

    notifyListeners();
  }
//========================== VALIDA CAMPO  FECHA FIN  =======================//
  String? _inputFechaFin =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaFin => _inputFechaFin;
  void onInputFechaFinChange(String? date) {
    _inputFechaFin = date;

    notifyListeners();
  }

//========================== SELECT  =======================//
  String? _labelArea='';

  String? get getLabelArea => _labelArea;

  void setLabelArea(String value) {
    _labelArea = value;
    notifyListeners();
  }

  String? _labelMotivoSugerencia;
  String? get labelMotivoSugerencia => _labelMotivoSugerencia;

  void setLabelMotivoSugerencia(String value) {
    _labelMotivoSugerencia = value;
    notifyListeners();
  }
//=======OBTENEMOS URL DEL DOCUMENTO PDF =========
  String? _documento;
  String? get getDocumento => _documento;

  void setDocumento(String value) {
    _documento = value;
    notifyListeners();
  }








  String? _documentoUrl;
  String? get getDocumentoUrl => _documentoUrl;

  void setDocumentoUrl(String value) {
    _documentoUrl = value;
    notifyListeners();
  }
//========================== INPUTS =======================//

  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    print('====> $_inputDetalle');
    notifyListeners();
  }
  String? _inputAsunto;
  String? get getAsunto => _inputAsunto;
  void onAsuntoChange(String? text) {
    _inputAsunto = text;
    print('====> ASUNTO $_inputAsunto');
    notifyListeners();
  }

 
 
  String? _receptor;
  String? get getReceptor => _receptor;
  void setReceptor(String? text) {
    _receptor = text;
    // print('RECEPTOR:$_receptor');
    notifyListeners();
  }
//=========================OBTENEMOS LA INFORMACION DE JEFE DE OPERACIONES ==============================//

  List _listaDataArea = [];
  List get getListaDataArea => _listaDataArea;
  void setListataDataArea(List data) {
    _listaDataArea = data;
    notifyListeners();
  }



String _idReceptor="";
  String? get getIdReceptor => _idReceptor;
  void setIdReceptor(String text) {
    _idReceptor = text;
    // print('RECEPTOR:$_receptor');
    notifyListeners();
  }
String _cedReceptor="";
 String? get getCedReceptor => _cedReceptor;
  void setCedReceptor(String text) {
    _cedReceptor = text;
    // print('RECEPTOR:$_receptor');
    notifyListeners();
  }



  bool? _errorListaData_listaDataArea; // sera nulo la primera vez
  bool? get getErrLrlistaData_listaDataArea => _errorListaData_listaDataArea;
  set setErrorlistaData_listaDataArea(bool? value) {
    _errorListaData_listaDataArea = value;
    notifyListeners();
  }

  Future buscaListaDataArea(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getDataJefeOperaciones(
      search: _search,
      notificacion: 'false',
      estado: getLabelArea,//'JEFE DE OPERACIONES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaData_listaDataArea = true;
      if(response['data'].isNotEmpty){
      setListataDataArea(response['data']);

        // _idReceptor=response['data'][0]['perId'].toString();
        // _cedReceptor=response['data'][0]['perDocNumero'].toString();
  

      // setReceptor(
      //     "${response['data'][0]['perNombres']} ${response['data'][0]['perApellidos']}");
      }
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaData_listaDataArea = false;
      notifyListeners();
      return null;
    }
  }


  Future creaSugerencia(BuildContext context) async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final _pyloadNuevoSugerencia = {
      "tabla": "mejoracontinua", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //login
     
  "mejId": "", // defecto
  "mejTipo": "RECLAMO", // defecto
  "mejSecuencia": "", // defecto
  "mejDetalles": _inputDetalle, // textarea
  "mejDetalleAcciones": "", // defecto
  "mejFecReg": "", // defecto
  "mejFecUpd": "", // defecto
  "mejFecha": _inputFechaCreacion, // input
  "mejProceso":_labelArea,//"ADMINISTRACION", //select=> LOGISTICA || ADMINISTRACION || GERENTE || ASISTENTE DE GERENCIA || JEFE DE OPERACIONES || COMPRAS PUBLICAS || CONTADOR || SECRETARIA || SERVICIOS VARIOS || OTROS
  "mejIdEmisor": infoUserLogin.id, // login
  "mejNombreEmisor": infoUserLogin.nombre, // login
  "mejIdReceptor": _idReceptor,//333", // endpoint
  "mejDocumentoReceptor": _cedReceptor,//"0302626288", // endpoint
  "mejNombreReceptor": _receptor,//"MARTINEZ BRUNO", // endpoint
  "mejMotivo": _labelMotivoSugerencia,//"SUJERENCIA", // select => QUEJA || RECLAMO
  "mejIdCliente": "", // defecto
  "mejDocumentoCliente": "", // defecto
  "mejNombreCliente": "", // defecto
  "mejAsunto": _inputAsunto, // defecto
  "mejDocumento": "", // defecto
  "mejFecDesde": _inputFechaInicio,//"2023-04-20", // input
  "mejFecHasta": _inputFechaFin,//"2023-04-28", // input
  "mejMetodo": [], // defecto
  "mejGuardias": [], // defecto
  "mejSupervisores": [], // defecto
  "mejAdministracion": [], // defecto
  "mejFechas": [], // defecto
  "mejFechasDB": [], // defecto
  "mejFotos": [], // defecto

  "mejUser":infoUserLogin.usuario, // login
  "mejEmpresa":infoUserLogin.rucempresa, // login

    };
    // print('=================  CREA SUGERENCIA ==================');
    // print('================= $_pyloadNuevoSugerencia ==================');
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoSugerencia);
  }

  Future editarSugerencia(BuildContext context) async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final _pyloadEditaSugerencia = {
      "tabla": "mejoracontinua", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //login
     
  "mejId": getdataSugerencia["mejId"], // defecto
  "mejTipo": "RECLAMO",// defecto
  "mejSecuencia": getdataSugerencia["mejSecuencia"], // defecto
  "mejDetalles": _inputDetalle, // textarea
  "mejDetalleAcciones": getdataSugerencia["mejDetalleAcciones"], // defecto
  "mejFecReg": getdataSugerencia["mejFecReg"], // defecto
  "mejFecUpd": getdataSugerencia["mejFecUpd"], // defecto
  "mejFecha": _inputFechaCreacion, // input
  "mejProceso":_labelArea,//"ADMINISTRACION", //select=> LOGISTICA || ADMINISTRACION || GERENTE || ASISTENTE DE GERENCIA || JEFE DE OPERACIONES || COMPRAS PUBLICAS || CONTADOR || SECRETARIA || SERVICIOS VARIOS || OTROS
  "mejIdEmisor": getdataSugerencia["mejIdEmisor"], // login
  "mejNombreEmisor": getdataSugerencia["mejNombreEmisor"], // login
  "mejIdReceptor":getdataSugerencia["mejIdReceptor"],//333", // endpoint
  "mejDocumentoReceptor": getdataSugerencia["mejDocumentoReceptor"],//"0302626288", // endpoint
  "mejNombreReceptor": _receptor,//"MARTINEZ BRUNO", // endpoint
  "mejMotivo":_labelMotivoSugerencia,//"SUJERENCIA", // select => QUEJA || RECLAMO
  "mejIdCliente": getdataSugerencia["mejIdCliente"], // defecto
  "mejDocumentoCliente": getdataSugerencia["mejDocumentoCliente"], // defecto
  "mejNombreCliente": getdataSugerencia["mejNombreCliente"], // defecto
  "mejAsunto": _inputAsunto,// defecto
  "mejDocumento": getdataSugerencia["mejDocumento"], // defecto
  "mejFecDesde": _inputFechaInicio,//"2023-04-20", // input
  "mejFecHasta": _inputFechaFin,//"2023-04-28", // input
  "mejMetodo": getdataSugerencia["mejMetodo"], // defecto
  "mejGuardias":getdataSugerencia["mejGuardias"], // defecto
  "mejSupervisores":getdataSugerencia["mejSupervisores"], // defecto
  "mejAdministracion":getdataSugerencia["mejAdministracion"], // defecto
  "mejFechas":getdataSugerencia["mejFechas"], // defecto
  "mejFechasDB":getdataSugerencia["mejFechasDB"], // defecto
  "mejFotos":getdataSugerencia["mejFotos"], // defecto

  "mejUser":infoUserLogin.usuario, // login
  "mejEmpresa":infoUserLogin.rucempresa, // login

    };
    // print('=================  EDITAR SUGERENCIA ==================');
    // print('================= $_pyloadEditaSugerencia ==================');
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaSugerencia);
  }




}