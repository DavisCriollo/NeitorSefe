import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';

// import 'package:sincop_app/src/service/socket_service.dart';

class CapacitacionesController extends ChangeNotifier {
  GlobalKey<FormState> capacitacionesFormKey = GlobalKey<FormState>();
  final serviceSocket = SocketService();
  final _api = ApiProvider();
  bool validateForm() {
    if (capacitacionesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetValuesCapacitaciones() {
    _dataQR = '';
    _messageAsistencia = {};
    _scanData = '';
    _getDataCapacitacion = '';
    _listaPreguntas = {};
  }

//=========================OBTENEMOS TODAS LAS CAACITACIONESS==============================//

  List _listaCapacitaciones = [];
  List get getListaCapacitaciones => _listaCapacitaciones;
  void setListataCapacitaciones(List data) {
    _listaCapacitaciones = data;
    notifyListeners();
  }

  bool? _errorListaCapacitaciones; // sera nulo la primera vez
  bool? get getErrorListaCapacitaciones => _errorListaCapacitaciones;
  set setErrLrlistaCapacitaciones(bool? value) {
    _errorListaCapacitaciones = value;
    notifyListeners();
  }

  Future buscaListaCapacitaciones(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllCapacitaciones(
      search: _search,
      notificacion: 'false',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaCapacitaciones = true;

         List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['capaFecReg']!.compareTo(a['capaFecReg']!));


      // setListataCapacitaciones(response['data']);
      setListataCapacitaciones(dataSort);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaCapacitaciones = false;
      notifyListeners();
      return null;
    }
  }

  dynamic _getDataCapacitacion = '';
  dynamic get getDataCapacitacion => _getDataCapacitacion;

  void setDataCapacitacion(dynamic _data) {
    _getDataCapacitacion = _data;
    notifyListeners();
  }

//==== CAMBIAMOS EL VALOS REL QR======//
  String _dataQR = '';
  String get getDataQR => _dataQR;
  void setDataQR(String _data) {
    _dataQR = _data;
    notifyListeners();
  }

//==== CAMBIAMOS EL VALOS REL QR======//
  Map<String, dynamic> _messageAsistencia = {};
  Map<String, dynamic> get getMessageAsistencia => _messageAsistencia;
  void setMessageAsistencia(Map<String, dynamic> _data) {
    _messageAsistencia = _data;
    notifyListeners();
  }

//=========================OBTENEMOS INFORMACION DEL SCAN PARA REGISTRAR ASISTENCIA==============================//

  String _scanData = '';
  String get getScanData => _scanData;
  void setScanData(String _info, BuildContext _context) {
    _scanData = '';
    _scanData = _info;

    if (_scanData.isNotEmpty || _scanData != '') {
      registraAsistencia(_context, int.parse(_scanData));
    }

    notifyListeners();
  }

  Future registraAsistencia(BuildContext context, int _idCapacitador) async {
    final infoUserLogin = await Auth.instance.getSession();

    final _pyloadGuardaAsistencia = {
      "tabla": "asistencia_capacitacion",
      "rucempresa": infoUserLogin!.rucempresa, //login
      "capaId": _idCapacitador, // id del registro capacitación, tomarlo del QR
      "id_persona": infoUserLogin.id, // del login propiedad id
      "rol": infoUserLogin.rol, //login
    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadGuardaAsistencia);

    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      setMessageAsistencia(data);
      if (data['encId'] != 0) {
        buscaPreguntas(data['encId'].toString());
      }
    });
  }
//==================== LISTO TODAS LAS PREGUNTAS====================//
Map<String,dynamic> _listaPreguntas ={};
Map<String,dynamic> get getPreguntas => _listaPreguntas;

  bool? _errorPreguntas; // sera nulo la primera vez
  bool? get getErrorPreguntas => _errorPreguntas;
  set setErrorPreguntas(bool? value) {
    _errorPreguntas = value;
    notifyListeners();
  }

  Future buscaPreguntas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getSearchPreguntas(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPreguntas = true;
      _listaPreguntas = {};
    
      _listaPreguntas.addAll(response['data']);
     

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPreguntas = false;
      notifyListeners();
      return null;
    }
  }

//========================== CAMBIA ESTADO CAPACITACION ===============================');

  Future cambiaEstadoCapacitacion(
      BuildContext context, dynamic _capacitacion) async {
    final infoUserLogin = await Auth.instance.getSession();

    final _pyloadEditaCapacitacion = {
      "tabla": "capacitacion", // login
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, // login,

      "capaId": _capacitacion['capaId'],
      "capaEncId": _capacitacion['capaEncId'],
      "capaDetalles": _capacitacion['capaDetalles'],
      "capaGuardias": _capacitacion['capaGuardias'],

      "capaSupervisores": _capacitacion['capaSupervisores'],

      "capaAdministracion": _capacitacion['capaAdministracion'],

      "capaFecUpd": _capacitacion['capaFecUpd'],
      "capaFecReg": _capacitacion['capaFecReg'],
      "capaIdCliente": _capacitacion['capaIdCliente'],
      "capaNombreCliente": _capacitacion['capaNombreCliente'],
      "capaIdCapacitador": _capacitacion['capaIdCapacitador'],
      "capaNombreCapacitador": _capacitacion['capaNombreCapacitador'],
      "capaTitulo": _capacitacion['capaTitulo'],
      "capaPrioridad": _capacitacion['capaPrioridad'],
      "capaFecDesde": _capacitacion['capaFecDesde'],
      "capaFecHasta": _capacitacion['capaFecHasta'],
      "capaEstado": "FINALIZADA",
      "capaDocumento": _capacitacion['capaDocumento'],
      "capaFotos": _capacitacion['capaFotos'],
      "capaUser": infoUserLogin.usuario,
      "capaEmpresa": infoUserLogin.rucempresa
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEditaCapacitacion);
  }
}
