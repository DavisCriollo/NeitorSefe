import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';

// import 'package:sincop_app/src/service/socket_service.dart';

class CambioDePuestoController extends ChangeNotifier {
  GlobalKey<FormState> cambioPuestoFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesCambioPuesto() {
    _idGuardia;
    _cedulaGuardia = '';
    _nombreGuardia = '';
    _nombreNuevoCliente = '';
    _inputDetalle = '';
    _idCliente;
    _cedulaCliente = '';
    _clienteNombre = '';
    _labelIntervaloTurno = null;
    _puestoServicioGuardia = [];
    _inputFecha =
        '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';

    notifyListeners();
  }

  bool validateForm() {
    if (cambioPuestoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//==================== LISTO TODOS  LOS CAMBIOS DE PUESTO====================//
  List _listaCambioPuesto = [];
  List get getListaCambioPuesto => _listaCambioPuesto;

  void setInfoBusquedaCambioPuesto(List data) {
    _listaCambioPuesto = data;
    notifyListeners();
  }

  bool? _errorCambioPuesto; // sera nulo la primera vez
  bool? get getErrorCambioPuesto => _errorCambioPuesto;
  set setErrorCambioPuesto(bool? value) {
    _errorCambioPuesto = value;
    notifyListeners();
  }

  Future buscaCambioPuesto(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllCambioPuesto(
      search: _search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorCambioPuesto = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['camFecReg']!.compareTo(a['camFecReg']!));

      setInfoBusquedaCambioPuesto(dataSort);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorCambioPuesto = false;
      notifyListeners();
      return null;
    }
  }

//================================== FECHA Y HORA DEL COMUNICADO  ==============================//
  String? _inputFecha =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfecha => _inputFecha;
  void onInputFechaChange(String? date) {
    _inputFecha = date;

    notifyListeners();
  }

  String? _inputHora;
  get getInputHora => _inputHora;
  void onInputHoraChange(String? date) {
    _inputHora = date;

    notifyListeners();
  }

  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }

  Map<String, dynamic>? _nuevoPuesto;
//========================== DROPDOWN PERIODO CONSIGNA CLIENTE =======================//
  String? _labelIntervaloTurno;

  String? get labelIntervaloTurno => _labelIntervaloTurno;

  void setLabelIntervaloTurno(String value) {
    _labelIntervaloTurno = value;
    notifyListeners();
  }

//========================== DROPDOWN NUEVO PUESTO=======================//
  String? _labelPuestoNuevo;

  String? get getlabelPuestoNuevo => _labelPuestoNuevo;
  set setLabelNuevoPuesto(String value) {
    _labelPuestoNuevo = value;
    notifyListeners();
  }

//========================== DROPDOWN SELECCIONA PUESTO =======================//
// TOMO TODOS LOS DATOS DEL PUESTO
  String? _ubicacion;
  String? _puesto;
  String? _supervisor;
  String? _guardias;
  String? _horasservicio;
  String? _tipoinstalacion;
  String? _vulnerabilidades;
  List? _consignas;
//=======================//

  void resetDropDown() {
    _labelNuevoPuesto = null;
    _listaPuestoNuevoCliente = [];
  }

  String? _labelNuevoPuesto;

  String? get labelNuevoPuesto => _labelNuevoPuesto;
  dynamic _itemSelect;
  void setLabelINuevoPuesto(String? value) {
    _labelNuevoPuesto = value;

    for (var e in _listaPuestoNuevoCliente) {
      if (e['puesto'] == labelNuevoPuesto) {
        _nuevoPuesto = {
          "ubicacion": e['ubicacion'],
          "puesto": e['puesto'],
          "supervisor": e['supervisor'],
          "guardias": e['guardias'],
          "horasservicio": e['horasservicio'],
          "tipoinstalacion": e['tipoinstalacion'],
          "vulnerabilidades": e['vulnerabilidades'],
          "consignas": e['consignas'],
        };
      }
    }
    notifyListeners();
  }

//========================== DROPDOWN SELECCIONA PUESTO =======================//
  var _dataItems;

  String? get getDataItems => _dataItems;

  void setDataItem(dynamic value) {
    _dataItems = value;
    notifyListeners();
  }

  int? _idGuardia;
  String? _cedulaGuardia;
  String? _nombreGuardia;
  String? get nombreGuardia => _nombreGuardia;
  List? _puestoServicioGuardia;
  List? get puestosServicioGuardia => _puestoServicioGuardia;
  String? _clienteNombre;
  String? get clienteNombre => _clienteNombre;
//==============================================================//

  void getInfoGuardia(dynamic guardia) {
    _idGuardia = guardia['perId'];
    _cedulaGuardia = guardia['perDocNumero'];
    _nombreGuardia = '${guardia['perNombres']} ${guardia['perApellidos']}';
    _puestoServicioGuardia = guardia['perPuestoServicio'];
  }

  int? _idCliente;
  String? _cedulaCliente;
  String? _nombreNuevoCliente;
  String? get nombreCliente => _nombreNuevoCliente;
  String? _puestoNuevo;
  String? get getPuestosNuevoCliente => _puestoNuevo;
  void setPuestoNuevoCliente(String data) {
    _puestoNuevo = data;
    notifyListeners();
  }

  List _listaPuestoNuevoCliente = [];
  List get getListaPuestosNuevoCliente => _listaPuestoNuevoCliente;
  void setListaPuestoNuevoCliente(List data) {
    _listaPuestoNuevoCliente = data;
    notifyListeners();
  }

  void getInfoCliente(dynamic cliente) {
    _idCliente = cliente['cliId'];
    _cedulaCliente = cliente['cliDocNumero'];
    _nombreNuevoCliente = cliente['cliRazonSocial'];
    _listaPuestoNuevoCliente = cliente['cliDatosOperativos']!;
  }

//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//
  List _listaTodosLosClientes = [];
  List get getListaTodosLosClientes => _listaTodosLosClientes;

  void setListaTodosLosClientes(List data) {
    _listaTodosLosClientes = data;
    notifyListeners();
  }

  bool? _errorClientes; // sera nulo la primera vez
  bool? get getErrorClientes => _errorClientes;

  Future getTodosLosClientes(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllClientesMultas(
      search: search,
      estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorClientes = true;
      setListaTodosLosClientes(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClientes = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaClientes;

  @override
  void dispose() {
    _deboucerSearchBuscaClientes?.cancel();

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

  bool _btnSearchCambioPuesto = false;
  bool get btnSearcCambioPuesto => _btnSearchCambioPuesto;

  void setBtnSearcCambioPuesto(bool action) {
    _btnSearchCambioPuesto = action;
    notifyListeners();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    if (_nameSearch.length >= 3) {
      _deboucerSearchBuscaClientes?.cancel();
      _deboucerSearchBuscaClientes =
          Timer(const Duration(milliseconds: 700), () {
        buscaCambioPuesto(_nameSearch, 'false');
      });
    } else {
      buscaCambioPuesto('', 'false');
    }
  }

  Future crearCambioPuesto(BuildContext context) async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final _pyloadNuevoCambioPuesto = {
      "tabla": "cambiopuesto", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //login
      "camTipo": "CAMBIO PUESTO",
      "camIdPersona": _idGuardia,
      "camDocuPersona": _cedulaGuardia,
      "camNomPersona": _nombreGuardia,
      "camFecha": _inputFecha, //'${_inputFecha}T$_inputHora',
      "camMotivo": _inputDetalle,
      "camEstado": 'EN PROCESO', // es pendiente
      "camIdCliente": _idCliente,
      "camDocuCliente": _cedulaCliente,
      "camNomCliente": _nombreNuevoCliente,
      "camActualPuesto": _puestoServicioGuardia,
      'camNuevoPuesto': [_nuevoPuesto],
      "camNuevoTurno": _labelIntervaloTurno,
      "camUser": infoUserLogin.usuario, // iniciado turno
      "camEmpresa": infoUserLogin.rucempresa //login
    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoCambioPuesto);
  }

  //================================== ELIMINAR   ==============================//
  Future eliminaCambioPuesto(int? idCambioPuesto) async {
    final serviceSocket = SocketService();
    final infoUser = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();
    final turno = jsonDecode(infoUserTurno);

    final _pyloadEliminaCambiouesto = {
      {
        "tabla": 'cambiopuesto',
        "rucempresa": infoUser!.rucempresa,
        "camId": idCambioPuesto,
      }
    };
    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaCambiouesto);
  }

  int? _idCambioPuesto;
  void getDataCambioPuesto(dynamic puesto) {
    _idCambioPuesto = puesto['camId'];
    _idGuardia = int.parse(puesto['camIdPersona']);
    _cedulaGuardia = puesto['camDocuPersona'];
    _nombreGuardia = puesto['camNomPersona'];
    _inputFecha = puesto['camFecha'];
    _labelNuevoPuesto = puesto['camMotivo'];
    _inputDetalle = puesto['camMotivo'];
    _idCliente = int.parse(puesto['camIdCliente']);
    _cedulaCliente = puesto['camDocuCliente'];
    _clienteNombre = puesto['camNomCliente'];
    _labelIntervaloTurno = puesto['camNuevoTurno'];
    for (var e in puesto['camNuevoPuesto']) {
      _nuevoPuesto = {
        "ubicacion": e['ubicacion'],
        "puesto": e['puesto'],
        "supervisor": e['supervisor'],
        "guardias": e['guardias'],
        "horasservicio": e['horasservicio'],
        "tipoinstalacion": e['tipoinstalacion'],
        "vulnerabilidades": e['vulnerabilidades'],
        "consignas": e['consignas']
      };
    }
  }

  Future editarCambioTurno(BuildContext context) async {
    final serviceSocket = SocketService();
    final infoUserLogin = await Auth.instance.getSession();
    final _pyloadEditaCambioPuesto = {
      {
        "tabla": "cambiopuesto", // defecto
        "camId": _idCambioPuesto,
        "rucempresa": infoUserLogin!.rucempresa, //login
        "rol": infoUserLogin.rol, //login
        "camTipo": "CAMBIO PUESTO",
        "camEstado": _labelNombreEstadoCambioPuesto,
        "camIdPersona": _idGuardia,
        "camDocuPersona": _cedulaGuardia,
        "camNomPersona": _nombreGuardia,
        "camFecha": _inputFecha, // '${_inputFecha}T$_inputHora',
        "camMotivo": _inputDetalle,
        "camIdCliente": _idCliente,
        "camDocuCliente": _cedulaCliente,
        "camNomCliente": _clienteNombre,
        "camActualPuesto": _puestoServicioGuardia,
        'camNuevoPuesto': [_nuevoPuesto],
        "camNuevoTurno": _labelIntervaloTurno,
        "camUser": infoUserLogin.usuario, // iniciado turno
        "camEmpresa": infoUserLogin.rucempresa //login
      }
    };
    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEditaCambioPuesto);
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
      _listaPuestoNuevoCliente = response['data'][0]['cliDatosOperativos'];

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

//========================== DROPDOWN PERIODO  CLIENTE =======================//
  String? _labelNombreEstadoCambioPuesto;

  String? get labelNombreEstadoCambioPuesto => _labelNombreEstadoCambioPuesto;

  void setLabelNombreEstadoCambioPuesto(String value) async {
    _labelNombreEstadoCambioPuesto = value;
    notifyListeners();
  }

//========================== SELECCIONAMOS LA INFORMACION DEL PUESTO =======================//

  dynamic getPuesto;
  dynamic get getInfoPuesto => getPuesto;

  void getInformacionPuesto(dynamic _puesto) {
    getPuesto = _puesto;
  }

  //===================BOTON SEARCH CLIENTE==========================//
  String textoBusquda = '';
  void onInputBuscaClienteChange(String texto) {
    textoBusquda = texto;

    if (textoBusquda.length >= 3) {
      _deboucerSearchBuscaClientes?.cancel();
      _deboucerSearchBuscaClientes =
          Timer(const Duration(milliseconds: 700), () {
        getTodosLosClientes(textoBusquda);
      });
    } else {
      getTodosLosClientes('');
    }
  }
}
