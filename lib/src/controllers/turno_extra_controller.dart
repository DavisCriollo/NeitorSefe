import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';

import 'package:nseguridad/src/models/lista_allInforme_guardias.dart';
import 'package:nseguridad/src/service/socket_service.dart';

class TurnoExtraController extends ChangeNotifier {
  GlobalKey<FormState> turnoExtraFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesTurnoExtra() {
    _idGuardia;
    _cedulaGuardia = "";
    _nombreGuardia = "";

    _idCliente;
    _cedulaCliente = "";
    _nombreNuevoCliente = "";
    _labelNuevoPuesto = null;
    _listaPuestosCliente = [];
    _labelNuevoPuesto = null;
    _listaPuestosCliente = [];
    _nombreNuevoCliente;
    _labelMotivoTurnoExtra = '';
    _labelNuevoPuesto;
    _labelMotivoAusencia;
    _inputDetalle;

    _inputNumeroDias = '';
    _inputFechaInicio = '';
    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraInicio =
        '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
    _inputFechaFin = '';
    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraFin = '';
    // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
    _listFechasTurnoExtra = [];
    _listFechasMilisegundosTurnoExtra = [];

    _listTurPuesto = [];
    _listaIdPersona = {};

    notifyListeners();
  }

  bool validateForm() {
    if (turnoExtraFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  //==========================inputs================//
  int? _idGuardia;
  String? _cedulaGuardia;
  String? _nombreGuardia;
  String? _turnoIdMulta = '';
  String? _turnoIdPermisos = '';
  String? get nombreGuardia => _nombreGuardia;

  void setNombreGuardia(String? _nombre) {
    _nombreGuardia = _nombre;

    notifyListeners();
  }

  void setIdGuardia(int? _id) {
    _idGuardia = int.parse(_id.toString());
    notifyListeners();
  }

  void setDocuGuardia(String? _docu) {
    _cedulaGuardia = _docu;

    notifyListeners();
  }

  List? _puestoServicioGuardia;
  List? get puestosServicioGuardia => _puestoServicioGuardia;
  String? _clienteNombre;

  void setPuestos(List? _puestos) {
    _puestoServicioGuardia = _puestos;
  }

  String? get clienteNombre => _clienteNombre;

  String? _inputAutorizadoPor;
  String? get getInputAutorizadoPor => _inputAutorizadoPor;
  void onAutorizadoPorChange(String? text) {
    _inputAutorizadoPor = text;
    notifyListeners();
  }

  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }
  // SELECCIONA EL PUESTO DEL GUARDIA//

//========================================//
  List _listaInfoGuardia = [];
  List get getListaInfoGuardia => _listaInfoGuardia;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardia = data;
    notifyListeners();
  }

  late Informe _informeGuardia;
  Informe get getInforme => _informeGuardia;

  void setinformeGuardia(Informe data) {
    _listaInfoGuardia.add(data);

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

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaTurno;

  @override
  void dispose() {
    _deboucerSearchBuscaTurno?.cancel();
    super.dispose();
  }

  String? _inputBuscaGuardia;
  get getInputBuscaGuardia => _inputBuscaGuardia;
  void onInputBuscaGuardiaChange(String? text) {
    _inputBuscaGuardia = text;
  }

  int? _idCliente;
  String? _cedulaCliente;
  String? _nombreNuevoCliente;
  String? get getCedulaCliente => _cedulaCliente;
  String? get nombreCliente => _nombreNuevoCliente;
  void setCedulaCliente(String? _ced) {
    _cedulaCliente = _ced;
  }

  void setNombreCliente(String? _name) {
    _nombreNuevoCliente = _name;
  }

  void setIdCliente(int? _ced) {
    _idCliente = _ced;
  }

  String? _puestoNuevo;
  String? get getPuestosNuevoCliente => _puestoNuevo;
  void setPuestoNuevoCliente(String data) {
    _puestoNuevo = data;
    notifyListeners();
  }
  // SELECCIONA EL PUESTO DEL CLIENTE//

  List _listaPuestosCliente = [];
  List get getListaPuestosCliente => _listaPuestosCliente;
  void setListaPuestoCliente(List data) {
    _listaPuestosCliente = data;
    notifyListeners();
  }

  void resetDropDown() {
    _labelNuevoPuesto = null;
    _listaPuestosCliente = [];
    _nombreNuevoCliente;
  }

  Map<String, dynamic>? _nuevoPuesto;
  String? _labelNuevoPuesto;

  String? get labelNuevoPuesto => _labelNuevoPuesto;
  dynamic _itemSelect;
  void setLabelINuevoPuesto(String? value) {
    _labelNuevoPuesto = value;
    //  print('labelNuevoPuesto:  $labelNuevoPuesto');
    notifyListeners();
  }
  String? _puestoAlterno;
  String? get getPuestoAlterno => _puestoAlterno;
 
  void setPuestoAlterno(String? value) {
    _puestoAlterno = value;
    //  print('_puestoAlterno:  $_puestoAlterno');
    notifyListeners();
  }

//========================================//

  void getInfoGuardia(dynamic guardia) {
    _idGuardia = guardia['perId'];
    _cedulaGuardia = guardia['perDocNumero'];
    _nombreGuardia = '${guardia['perApellidos']} ${guardia['perNombres']}';
    _puestoServicioGuardia = guardia['perPuestoServicio'];

    notifyListeners();
  }

  void getInfoCliente(dynamic cliente) {
    buscaClienteQR(cliente['cliId'].toString());
    _idCliente = cliente['cliId'];
    _cedulaCliente = cliente['cliDocNumero'];
    _nombreNuevoCliente = cliente['cliRazonSocial'];
    _listaPuestosCliente = cliente['cliDatosOperativos'];
  }

  void getInfoClienteTurnoEmergente(dynamic cliente) {
    // print('object:$cliente');
    _idCliente = cliente[0]['cliId'];
    _cedulaCliente = cliente[0]['cliDocNumero'];
    _nombreNuevoCliente = cliente[0]['cliRazonSocial'];
    _listaPuestosCliente = cliente[0]['cliDatosOperativos'];
  }

//========================== DROPDOWN MOTIVO AUSENCIA =======================//
  String? _labelMotivoTurnoExtra;

  String? get labelMotivoTurnoExtra => _labelMotivoTurnoExtra;

  void setLabelMotivoTurnoExtra(String value) {
    _labelMotivoTurnoExtra = value;
    notifyListeners();
  }

  //========================== VALIDA CAMPO  FECHA INICIO   =======================//
  String? _inputFechaInicio = '';
  // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaInicio => _inputFechaInicio;
  void onInputFechaInicioChange(String? date) {
    _inputFechaInicio = date;
    // var _date = DateTime.parse(_inputFechaInicio.toString());
    // final _later = _date.add(const Duration(hours: 12));

    // print( 'la fecha actual es $_date');

    // print( 'la fecha final es $_later');
    // onInputFechaFinChange(
    //     '${_later.year}-${(_later.month) < 10 ? '0${_later.month}' : '${_later.month}'}-${(_later.day) < 10 ? '0${_later.day}' : '${_later.day}'}'
    //   //  '$_later'
    //     );

    notifyListeners();
  }

  String? _inputHoraInicio = '';
  // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
  get getInputHoraInicio => _inputHoraInicio;
  void onInputHoraInicioChange(String? date) {
    _inputHoraInicio = date;

    final _fechaActual = '${_inputFechaInicio} ${_inputHoraInicio}';

    final _later = DateTime.parse(_fechaActual).add(const Duration(hours: 24));
    // print('la fecha _later es $_later');
    onInputFechaFinChange(
        '${_later.year}-${(_later.month) < 10 ? '0${_later.month}' : '${_later.month}'}-${(_later.day) < 10 ? '0${_later.day}' : '${_later.day}'}'
        //  '$_later'
        );

    onInputHoraFinChange(
        '${(_later.hour) < 10 ? '0${DateTime.now().hour}' : '${_later.hour}'}:${(_later.minute) < 10 ? '0${_later.minute}' : '${_later.minute}'}');

    notifyListeners();
  }

  //========================== VALIDA CAMPO  FECHA FIN   =======================//
  String? _inputFechaFin = '';
  // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaFin => _inputFechaFin;
  void onInputFechaFinChange(String? date) {
    _inputFechaFin = date;
    // var _dateIni = DateTime.parse(_inputFechaInicio.toString());
    // var _dateFin = DateTime.parse(date.toString());

    // var _nDias = _dateFin.difference(_dateIni);
    // onNumeroDiasChange(_nDias.inDays == 0 ? '1' : '${_nDias.inDays + 1}');

    notifyListeners();
  }

  String? _inputHoraFin = '';
  // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
  get getInputHoraFin => _inputHoraFin;
  void onInputHoraFinChange(String? date) {
    _inputHoraFin = date;

    notifyListeners();
  }

  //========================== OBTIENE TURNO EXTRA  =======================//

  String? _inputNumeroDias = '';
  String? get getInputNumeroDias => _inputNumeroDias;
  void onNumeroDiasChange(String? text) {
    _inputNumeroDias = text!.isEmpty ? '' : text;
    //  print('_inputNumeroDias   $_inputNumeroDias');

    // notifyListeners();
  }

//========================== DROPDOWN MOTIVO AUSENCIA =======================//
  String? _labelMotivoAusencia;

  String? get labelMotivoAusencia => _labelMotivoAusencia;

  void setLabelMotivoAusencia(String value) {
    _labelMotivoAusencia = value;
    notifyListeners();
  }

//==================== LISTO TODOS  LOS TURNOS====================//
  List _listaTurnoExtra = [];
  List get getListaTurnoExtra => _listaTurnoExtra;

  void setInfoBusquedaTurnoExtra(List data) {
    _listaTurnoExtra = data;
    notifyListeners();
  }

//============================================= LISTA DE FECHAS QUE SE AGREGAN AL CREAR EL TURNO====================//
  List<Map<String, dynamic>> _listFechasTurnoExtra = [];
  List<Map<String, dynamic>> get getListFechasTurnoExtra =>
      _listFechasTurnoExtra;

  void setListFechasTurnoExtra(Map<String, dynamic> _data) {
    _listFechasTurnoExtra.clear();
    _listFechasTurnoExtra.removeWhere((e) => e['desde'] == _data['desde']);
    _listFechasTurnoExtra.add(_data);
    // print('_listFechasTurnoExtra ======>   $_listFechasTurnoExtra');
    // notifyListeners();
  }
  void setListFechasDeTurnosAusencias(Map<String, dynamic> _datos) {
    // _listFechasTurnoExtra.removeWhere((e) => e == _datos);
    _listFechasTurnoExtra.addAll([_datos]);
    // print('_TurnoExtraFecha   $_listFechasTurnoExtra');
    notifyListeners();
  }








//============================================= LISTA DE FECHAS QUE SE AGREGAN AL CREAR EL TURNO====================//
  List<Map<String, dynamic>> _listFechasMilisegundosTurnoExtra = [];
  List<Map<String, dynamic>> get getListFechasMilisegundosTurnoExtra =>
      _listFechasMilisegundosTurnoExtra;

  void setListFechasMilisegundosTurnoExtra(Map<String, dynamic> _data) {
    _listFechasMilisegundosTurnoExtra.removeWhere((e) => e == _data);
    _listFechasMilisegundosTurnoExtra.addAll([_data]);
    // print('_listFechasMilisegundosTurnoExtra   $_listFechasMilisegundosTurnoExtra');
    notifyListeners();
  }

//======================ELIMINA FECHA TURNO EXTRA=========================//
  void deleteItemFecha(Map<String, dynamic> _val) {
    _listFechasTurnoExtra.removeWhere((e) => e == _val);
    notifyListeners();
  }
//======================ELIMINA FECHA TURNO EXTRA=========================//
  void deleteItemFechaAusencias(Map<String, dynamic> _val) {

    notifyListeners();
  }

//======================ELIMINA FECHA TURNO EXTRA=========================//
  void deleteItemFechaMilisegundo(Map<String, dynamic> _val) {
    _listFechasMilisegundosTurnoExtra.removeWhere((e) => e == _val);
    notifyListeners();
  }

//===================================================================================================================//
  bool? _errorTurnoExtra; // sera nulo la primera vez
  bool? get getErrorTurnoExtra => _errorTurnoExtra;
  set setErrorTurnoExtra(bool? value) {
    _errorTurnoExtra = value;
    notifyListeners();
  }

  Future buscaTurnoExtra(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllTurnosExtras(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorTurnoExtra = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['turFecReg']!.compareTo(a['turFecReg']!));

      setInfoBusquedaTurnoExtra(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTurnoExtra = false;
      notifyListeners();
      return null;
    }
  }


String _idMulta='';
String get  getIdMulta=>_idMulta;
void setIdMulta(String _id){
  _idMulta=_id;
  //  print('id de la multa: $_idMulta');


}

  Future crearTurnoExtra(BuildContext context ,Map<String, dynamic> _fecha) async {
    final serviceSocket = SocketService();
    final infoUserLogin = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

//     for (var item in _listFechasTurnoExtra) {
//       DateTime _fDesdeMilisegundos = DateTime.parse(item['desde'].toString().replaceAll('T',' '));
//           //  print('DESDE SIN T :$_fDesdeMilisegundos');

// DateTime fecha = DateTime.parse(_fDesdeMilisegundos.toString()); // Ejemplo de fecha actual
  
//   int milisegundos = fecha.millisecondsSinceEpoch;
            
//       _listFechasMilisegundosTurnoExtra.addAll([
//         {"desde": "$milisegundos", "hasta": ""}
//       ]);
//     }


      // _listFechasTurnoExtra.add({"desde":_fecha});
      _listFechasTurnoExtra.add(_fecha);

      DateTime _fDesdeMilisegundos = DateTime.parse(_fecha['desde'].toString().substring(0, 10));
          //  print('DESDE SIN T :$_fDesdeMilisegundos');

DateTime fecha = DateTime.parse(_fDesdeMilisegundos.toString()); // Ejemplo de fecha actual
  
  int milisegundos = fecha.millisecondsSinceEpoch;
            
      _listFechasMilisegundosTurnoExtra.addAll([
        {"desde": "$milisegundos", "hasta": ""}
      ]);
 


    // print('FECHA  MILISEGUNDOS :$_listFechasMilisegundosTurnoExtra');

    final _pyloadNuevoTurnoExtra = {
      "tabla": "turnoextra", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin
      "turDetalle": _inputDetalle,
      "turStatusDescripcion": "",
      "turIdPersona": _idGuardia,
      "turDocuPersona": _cedulaGuardia,
      "turNomPersona": _nombreGuardia,
      "turIdCliente": _idCliente,
      "turDocuCliente": _cedulaCliente,
      "turNomCliente": _nombreNuevoCliente,
      "turPuesto": _puestoServicioGuardia,
      "turMotivo":
          _labelMotivoTurnoExtra, // select=> FALTA INJUSTIFICADA, PERMISO MEDICO, PATERNIDAD, EVENTO ESPECIAL
      "turAutorizado": _inputAutorizadoPor, // input
      "turDiasTurno": _listFechasTurnoExtra.length.toString(),
      "turUser":
          infoUserLogin.usuario, // iniciado turno // usuario iniciado turno
      "turEmpresa": infoUserLogin.rucempresa, //login
      "turEstado": "EN PROCESO",

      "permisosAcubrir": _listFechasTurnoExtra.length.toString(),
      "camActualPuesto": [],
      "turIdPermiso": "",
      "turIdMulta": _idMulta,
      "turFechas": _listFechasMilisegundosTurnoExtra,
      "turFechasConsultaDB": _listFechasTurnoExtra,
      "turPuesto": [_listTurPuesto[0]]
    };
// 
    // print('===============> TURNO ${_listTurPuesto[0]}');
    // print('===============> TURNO ${_pyloadNuevoTurnoExtra['turIdMulta']}');
    // print('===============> TURNO ${_pyloadNuevoTurnoExtra}');

    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoTurnoExtra);
  }

  void getTurnoEmergente() async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

    final _pyloadTurnoEmergente = {
      "tabla": "turnoextra", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin
      "turIdPersona": _idGuardia,
      "turDocuPersona": _cedulaGuardia,
      "turNomPersona": _nombreGuardia,
      "turIdCliente": _idCliente,
      "turDocuCliente": _cedulaCliente,
      "turNomCliente": _nombreNuevoCliente,
      "turPuesto": _puestoServicioGuardia,

      "turDiasTurno": _inputNumeroDias,

      "turMotivo":
          _labelMotivoTurnoExtra, // select=> FALTA INJUSTIFICADA, PERMISO MEDICO, PATERNIDAD, EVENTO ESPECIAL
      "turAutorizado": _inputAutorizadoPor, // input
      "turFechaDesde":
          '${_inputFechaInicio}T$_inputHoraInicio', // fecha hora// fecha hora
      "turFechaHasta":
          '${_inputFechaFin}T$_inputHoraFin', // fecha hora fecha hora
      "turDetalle": _inputDetalle, // textarea
      "turUser":
          infoUserLogin.usuario, // iniciado turno // usuario iniciado turno
      "turEmpresa": infoUserLogin.rucempresa, //login

      "turIdPermiso": "",
      "turIdMulta": ""
    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadTurnoEmergente);
  }

//================================== ELIMINAR  MULTA  ==============================//
  Future eliminaTurnoExtra(int? idTurno) async {
    final serviceSocket = SocketService();
    final infoUser = await Auth.instance.getSession();
    final _pyloadEliminaTurnoExtra = {
      "tabla": 'turnoextra',
      "rucempresa": infoUser!.rucempresa,
      "turId": idTurno,
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaTurnoExtra);
    // print('ELIMINAMOS EL TURNO:$_pyloadEliminaTurnoExtra');
  
  }

  int? _idTurno;
  String? _nuevoMotivo;
  String? _turEstado;
  String? _turTipoTurno; // A LA ESPERA SI SE AGREGA EN EDITAR

  dynamic _turnoExtra;
  dynamic get getTurnoExtra => _turnoExtra;
  List<String>? _dataFechaInicio = [];
  List<String>? _dataFechaFin = [];
  void getDataTurnoExtra(dynamic turno) {
    _turnoExtra = turno;
    // if (turno['turFechaDesde']!.contains('T')) {
    //   _dataFechaInicio = turno['turFechaDesde']!.split('T');
    // } else if (turno['turFechaDesde']!.contains(' ')) {
    //   _dataFechaInicio = turno['turFechaDesde']!.split(' ');
    // }
    // if (turno['turFechaHasta']!.contains('T')) {
    //   _dataFechaFin = turno['turFechaHasta']!.split('T');
    // } else if (turno['turFechaHasta']!.contains(' ')) {
    //   _dataFechaFin = turno['turFechaHasta']!.split(' ');
    // }

    _idTurno = int.parse(turno['turId'].toString());
    _idGuardia = int.parse(turno['turIdPersona'].toString());
    _cedulaGuardia = turno['turDocuPersona'];
    _nombreGuardia = turno['turNomPersona'];

    _idCliente = int.parse(turno['turIdCliente'].toString());
    _cedulaCliente = turno['turDocuCliente'];

    _nombreNuevoCliente = turno['turNomCliente'];

  //  if(turno['turPuesto'].isNotEmpty){

  //   _labelNuevoPuesto =turno['turPuesto'][0]['puesto'];


  //  }else{
  //   _labelNuevoPuesto='';
  //  }


    _labelMotivoTurnoExtra = turno['turMotivo'];
    _inputAutorizadoPor = turno['turAutorizado'];
    _inputDetalle = turno['turDetalle'];
    // _inputFechaInicio = _dataFechaInicio![0];
    // _inputHoraInicio = _dataFechaInicio![1];

    // _inputFechaFin = _dataFechaFin![0];
    // _inputHoraFin = _dataFechaFin![1];

    // _puestoServicioGuardia = turno['turPuesto'];
    _inputNumeroDias = turno['turDiasTurno'].toString();

    _turnoIdMulta = turno['turIdMulta'].toString();
    _turnoIdPermisos = turno['turIdPermiso'].toString();
    _turEstado = turno['turEstado'];
  }

  Future editarTurnoExtra(BuildContext context) async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

    final _pyloadEditaTurnoExtra = {
      "tabla": "turnoextra", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin
      "turId": _idTurno,
      "turIdPersona": _idGuardia,
      "turDocuPersona": _cedulaGuardia,
      "turNomPersona": _nombreGuardia,
      "turIdCliente": _idCliente,
      "turDocuCliente": _cedulaCliente,
      "turNomCliente": _nombreNuevoCliente,
      "turPuesto": _puestoServicioGuardia,

      "turMotivo": (_labelMotivoTurnoExtra!.isNotEmpty)
          ? _labelMotivoTurnoExtra
          : _nuevoMotivo, // select=> FALTA INJUSTIFICADA, PERMISO MEDICO, PATERNIDAD, EVENTO ESPECIAL

      "turDiasTurno": _inputNumeroDias,
      "turAutorizado": _inputAutorizadoPor, // input
      "turFechaDesde":
          '${_inputFechaInicio}T$_inputHoraInicio', // fecha hora// fecha hora
      "turFechaHasta":
          '${_inputFechaFin}T$_inputHoraFin', // fecha hora fecha hora

      "turDetalle": _inputDetalle, // textarea
      "turUser":
          infoUserLogin.usuario, // iniciado turno // usuario iniciado turno
      "turEmpresa": infoUserLogin.rucempresa,
      "turIdMulta": _turnoIdMulta,
      "turIdPermiso": _turnoIdPermisos,
      "turEstado": _turEstado // DEBO TOMR EL VALOR ASIGNADO
    };
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaTurnoExtra);
  }

  //===================LEE CODIGO QR GUARDIA==========================//
  String? _infoQRGuardia = '';
  String? get getInfoQRGuardia => _infoQRGuardia;

  void setInfoQRGuardia(String? value) {
    _infoQRGuardia = value;
    final split = _infoQRGuardia!.split('-');
    buscaGuardiaQR(split[0]);
    notifyListeners();
  }

//==================== LISTO INFORMACION DEL GUARDIA  QR====================//
  List _listaGuardiaQR = [];
  List get getListaGuardiaQR => _listaGuardiaQR;
  void setInfoBusquedaGuardiaQR(List data) {
    _listaGuardiaQR = data;
    notifyListeners();
  }

  bool? _errorGuardiaQR; // sera nulo la primera vez
  bool? get getErrorGuardiaQR => _errorGuardiaQR;
  set setErrorGuardiaQR(bool? value) {
    _errorGuardiaQR = value;
    notifyListeners();
  }

  Future buscaGuardiaQR(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getGuardiaQR(
      codigoQR: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _idGuardia = response['data'][0]['perId']!;
      _cedulaGuardia = response['data'][0]['perDocNumero'];
      _nombreGuardia =
          '${response['data'][0]['perNombres']} ${response['data'][0]['perApellidos']}';
      _puestoServicioGuardia = response['data'][0]['perPuestoServicio'];

      _errorGuardiaQR = true;

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorGuardiaQR = false;
      notifyListeners();
      return null;
    }
  }

  //===================LEE CODIGO QR CLIENTE==========================//
  String? _infoQRCliente = '';
  String? get getInfoQRCliente => _infoQRCliente;

  void setInfoQRCliente(String? value) {
    _infoQRCliente = value;
    final split = _infoQRCliente!.split('-');
    buscaClienteQR(split[0]);
    notifyListeners();
  }

//==================== LISTO INFORMACION DEL CLIENTE  QR====================//
  List _listaClienteQR = [];
  List get getListaClienteQR => _listaClienteQR;
  void setInfoBusquedaClienteQR(List data) {
    _listaClienteQR = data;
    notifyListeners();
  }

  bool? _errorClienteQR; // sera nulo la primera vez
  bool? get getErrorClienteQR => _errorClienteQR;
  set setErrorClienteQR(bool? value) {
    _errorClienteQR = value;
    notifyListeners();
  }

  Future buscaClienteQR(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getClienteQR(
      codigoQR: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _idCliente = response['data'][0]['cliId']!;
      _cedulaCliente = response['data'][0]['cliDocNumero'];
      _nombreNuevoCliente = response['data'][0]['cliRazonSocial'];
      _listaPuestosCliente = response['data'][0]['cliDatosOperativos'];

      _errorClienteQR = true;

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClienteQR = false;
      notifyListeners();
      return null;
    }
  }

  //===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
  //===================BOTON SEARCH MORE CLIENTE==========================//

  bool _btnSearchTurnoExtra = false;
  bool get btnSearchTurnoExtra => _btnSearchTurnoExtra;

  void setBtnSearchTurnoExtra(bool action) {
    _btnSearchTurnoExtra = action;
    notifyListeners();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    if (_nameSearch.length >= 3) {
      _deboucerSearchBuscaTurno?.cancel();
      _deboucerSearchBuscaTurno = Timer(const Duration(milliseconds: 700), () {
        buscaTurnoExtra(_nameSearch);
      });
    } else {
      buscaTurnoExtra('');
    }
  }

//=========================OBTENEMOS LA INFORMACION DE JEFE DE OPERACIONES PARA TOMAR APELLIDO Y NOMBRES==============================//

  List _listaDataJefeOperaciones = [];
  List get getListaDataJefeOperaciones => _listaDataJefeOperaciones;
  void setListataDataJefeOperaciones(List data) {
    _listaDataJefeOperaciones = data;
    notifyListeners();
  }

  bool? _errorListaDataJefeOperaciones; // sera nulo la primera vez
  bool? get getErrLrlistaDataJefeOperaciones => _errorListaDataJefeOperaciones;
  set setErrLrlistaDataJefeOperaciones(bool? value) {
    _errorListaDataJefeOperaciones = value;
    notifyListeners();
  }

  Future buscaLstaDataJefeOperaciones(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getDataJefeOperaciones(
      search: _search,
      notificacion: 'false',
      estado: 'JEFE DE OPERACIONES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaDataJefeOperaciones = true;
      setListataDataJefeOperaciones(response['data']);
      onAutorizadoPorChange(
          "${response['data'][0]['perNombres']} ${response['data'][0]['perApellidos']}");

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaDataJefeOperaciones = false;
      notifyListeners();
      return null;
    }
  }




 //============================================= AGREGAMOS LA UBICACUON Y PUESTO DEL TURNO TURNO====================//
  List<Map<String, dynamic>> _listTurPuesto = [];
  List<Map<String, dynamic>> get getListTurPuesto => _listTurPuesto;

  void setListTurPuesto(Map<String, dynamic> _data) {
    _listTurPuesto.removeWhere((e) => e['id'] == _data['id']);
    _listTurPuesto.addAll([_data]);
    // print('_listTurPuesto  TURNO xxxxxxxxxx  ${_listTurPuesto}');
    notifyListeners();
  }
  void deleteItemTurPuesto(Map<String, dynamic>_item) {
  
    _listTurPuesto.removeWhere((e) => e['id'] == _item['id']);
    //  print('_listTurPuesto CURRENT  ${_listTurPuesto}');

   
    notifyListeners();
  }


  Map<String, dynamic> _infoGuardiaVerificaTurno = {};
  Map<String, dynamic> get getInfoGuardiaVerificaTurno =>
      _infoGuardiaVerificaTurno;

  void setInfoGuardiaVerificaTurno(Map<String, dynamic> _guardia) {
    _infoGuardiaVerificaTurno = _guardia;
    // print('ESTA ES LA DATA: $_infoGuardiaVerificaTurno');

    notifyListeners();
  }



//======================LISTA ELGUARDIA QUE REEMPLAZO AL GUARDIA EN LA MULTA ASIGNADA ==================//
  List _listaIdTurnoAsignado = [];
  List get getListaIdTurnoAsignado => _listaIdTurnoAsignado;

  void setIdTurnoAsignado(List data) {
    _listaIdTurnoAsignado = [];
    _listaIdTurnoAsignado = data;

    // print('la data es:$_listaIdTurnoAsignado');
    notifyListeners();
  }

  bool? _errorIdTurnoAsignado; // sera nulo la primera vez
  bool? get getErrorIdTurnoAsignado => _errorIdTurnoAsignado;
  set setErrorIdTurnoAsignado(bool? value) {
    _errorIdTurnoAsignado = value;
    notifyListeners();
  }

  Future buscaIdTurnoAsignado(String? _idTurno) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getIdTurnoMultas(
     
      idTurno: _idTurno.toString(),
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorIdTurnoAsignado = true;

      setIdTurnoAsignado(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorIdTurnoAsignado = false;
      notifyListeners();
      return null;
    }
  }
//======================LISTA ELGUARDIA QUE REEMPLAZO AL GUARDIA EN LA MULTA ASIGNADA ==================//
  Map<String ,dynamic> _listaIdPersona = {};
   Map<String ,dynamic> get getListaIdPersona => _listaIdPersona;

  void setIdPersona( Map<String ,dynamic> data) {
    _listaIdPersona = {};
    _listaIdPersona = data;
// print('$_listaIdPersona');
 
    notifyListeners();
  }

  bool? _errorIdPersona; // sera nulo la primera vez
  bool? get getErrorIdPersona => _errorIdPersona;
  set setErrorIdPersona(bool? value) {
    _errorIdPersona = value;
    notifyListeners();
  }

  Future buscaIdPersona(String? _idTurno) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getIdPersona(
     
      idTurno: _idTurno.toString(),
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorIdPersona = true;
 _listaIdPersona = {};
      setIdPersona(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorIdPersona = false;
      notifyListeners();
      return null;
    }
  }

// void resetInfoGuardiaturno(){
// _listaIdPersona = {};
// notifyListeners();

// }








}
