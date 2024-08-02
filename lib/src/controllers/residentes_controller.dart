import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/service/socket_service.dart';

class ResidentesController extends ChangeNotifier {
  GlobalKey<FormState> residentesFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> correoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> telefonoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> personaFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  bool validateForm() {
    if (residentesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormCorreo() {
    if (correoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormTelefono() {
    if (telefonoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormPersona() {
    if (personaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetValuesResidentes() {
    // _idGuardia;
    // _cedulaGuardia;
    // _nombreGuardia = '';
    // _inputDetalle;
    _idCliente = '';

    _cedulaCliente = '';

    _nombreCliente = '';

    _nombreUbicacion = '';
    _nombrePuesto = '';

    _datosOperativos.clear();

    _itemCedulaResidente = '';

    _itemNombresResidentes = '';

    _itemCasaDepartamentoResidente = '';

    _itemUbicacionResidente = '';

    _email = '';

    _listaCorreoResidente.clear();

    _telefono = '';

    _listaTelefonosResidente.clear();
    _persona = '';
    _listaPersonasAutorizadasResidente.clear();

    // _listaVideosUrl.clear();
    // _listaGuardiaInformacion.clear();
    // _labelAvisoSalida = '';
    // _listFechas.clear();
    // _fechaAvisoSalida ='';
    notifyListeners();
  }

//==================================+++++++++++++++++++++++++++++++ OBTENEMOS TODOS LOS RESIDENTES  =====++++++++++++++++++++++++++++++++++++++++++++=========================//
   List<dynamic> _listaTodosLosResidentes = [];
   List<dynamic> get getListaTodosLosResidentes => _listaTodosLosResidentes;

  void setListaTodosLosResidentes( List<dynamic> data) {
    _listaTodosLosResidentes = [];
    _listaTodosLosResidentes = data;

    print('TENEMOS DATA:${_listaTodosLosResidentes}');
    _listaTodosLosResidentes.sort((a, b) {
  if (a['resEstado'] == 'INACTIVA' && b['resEstado'] != 'INACTIVA') {
    return 1; // Mueve a 'a' al final
  } else if (a['resEstado'] != 'INACTIVA' && b['resEstado'] == 'INACTIVA') {
    return -1; // Mueve a 'a' al inicio
  } else {
    return 0; // Mantén el orden actual
  }
});
setListFilter(_listaTodosLosResidentes);

    notifyListeners();
  }

  bool? _errorTodosLosResidentes; // sera nulo la primera vez
  bool? get getErrorTodosLosResidentes => _errorTodosLosResidentes;

  Future<dynamic> getTodosLosResidentes(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllResidentes(
      search: search,
      idCli: '${dataUser!.id}',
      notificacion: notificacion,
      token: '${dataUser.token}',
    );

    if (response != null) {
      _errorTodosLosResidentes = true;

       List<Map<String,dynamic>> dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['resFecReg']!.compareTo(a['resFecReg']!));

      // setListaTodosLosResidentes(response['data']);
      setListaTodosLosResidentes(dataSort);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodosLosResidentes = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  Future<dynamic> getTodosLosResidentesGuardia(
    String? search,
    String? notificacion,
  ) async {
    final dataUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();
    final response = await _api.getAllResidentesGuardia(
      search: search,
      regId: '${dataUser!.regId}',
      cliId: '',
      cliUbicacion: '',
      cliPuesto: '',
      token: '${dataUser.token}',
    );

    if (response != null) {
      _errorTodosLosResidentes = true;

      List dataSort = [];
      // dataSort = response['data'];
      // dataSort.sort((a, b) => b['resFecReg']!.compareTo(a['resFecReg']!));

      setListaTodosLosResidentes(response['data']);
      // setListaTodosLosResidentes(dataSort);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodosLosResidentes = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//==================================+++++++++++++++++++++++++++++++ OBTENEMOS EL CLIENTE POR ID  =====++++++++++++++++++++++++++++++++++++++++++++=========================//
  List<dynamic> _listaClientePorId = [];
  List<dynamic> get getListaClientePorId => _listaClientePorId;

  void setListaClientePorId(List<dynamic> data) {
    _listaClientePorId = data;

    // print('el cliente es: ${_listaClientePorId[0]} ');

    setidCliente(_listaClientePorId[0]['cliId'].toString());
    setCedulaCliente(_listaClientePorId[0]['cliDocNumero']);
    setNombreCliente(_listaClientePorId[0]['cliRazonSocial']);
    for (var item in _listaClientePorId[0]['cliDatosOperativos']) {
      //  _datosOperativos.addAll({item});
      setDatosOperativos(item);
    }
// print('object: $_datosOperativos');

    notifyListeners();
  }

  bool? _errorClientePorId; // sera nulo la primera vez
  bool? get getErrorClientePorId => _errorClientePorId;

  Future<dynamic> getInfoClientePorId() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getClientePorId(
      idCli: '${dataUser!.id}',
      token: '${dataUser.token}',
    );

    if (response != null) {
      _errorClientePorId = true;

      setListaClientePorId(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClientePorId = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//====================OBTENEMOS INFO DE RESIDENTE=========================//
  int? _idResidente;
  int? _idPer;

  dynamic _infoResidente;
  dynamic get getInfoResidente => _infoResidente;

  void setInfoResidente(dynamic _residente) {
     _infoResidente = {};
    _infoResidente = _residente;

    // _idResidente = _infoResidente['resId']; // vacio
    // _idPer = _infoResidente['resPerId']; // vacio
    // _idCliente = _infoResidente['resCliId'].toString(); // vacio

    // _cedulaCliente = _infoResidente['resCliDocumento'];
    // _nombreCliente = _infoResidente['resCliNombre'];
    // setLabelNombreEstadoResidente(_infoResidente['resEstado']);
    // // _estadoResidente = _infoResidente['resEstado'];

    // _nombreUbicacion = _infoResidente['resCliUbicacion'];
    // _nombrePuesto = _infoResidente['resCliPuesto'];

    // // _datosOperativos = [];

    // _itemCedulaResidente = _infoResidente['resCedula'];

    // _itemNombresResidentes = _infoResidente['resNombres'];

    // _itemCasaDepartamentoResidente = _infoResidente['resDepartamento'];

    // _itemUbicacionResidente = _infoResidente['resUbicacion'];

    // for (var item in _infoResidente['resCorreo']) {
    //   setListaCorreoResidente(item);
    // }

    // for (var item in _infoResidente['resTelefono']) {
    //   setListaTelefonosResidente(item);
    // }
    // for (var item in _infoResidente['resPersonasAutorizadas']) {
    //   setListaPersonasAutorizadasResidente(item);
    // }
//  print('DATO INFO RESIDENTE: $_infoResidente');
    notifyListeners();
  }

//====================OBTENEMOS INFO DE CLIENTE=========================//
  String? _estadoResidente = '';
  String? get getEstadoResidente => _estadoResidente;
  void setEstadoResidente(String? _val) {
    _estadoResidente = _val;
    print('_estadoResidente: $_estadoResidente');
    notifyListeners();
  }

  String? _idCliente = '';
  String? get getIdCliente => _idCliente;
  void setidCliente(String? _val) {
    _idCliente = _val;
    print('_idCliente: $_idCliente');
    notifyListeners();
  }

  String? _cedulaCliente = '';
  String? get getCedulaCliente => _cedulaCliente;
  void setCedulaCliente(String? value) {
    _cedulaCliente = value;
    print('_cedulaCliente: $_cedulaCliente');
    notifyListeners();
  }

  String? _nombreCliente = '';
  String? get getNombreCliente => _nombreCliente;
  void setNombreCliente(String? value) {
    _nombreCliente = value;
    print('_cedulaCliente: $_cedulaCliente');
    notifyListeners();
  }

  // Map<String, dynamic>? _nombrePuesto = {};
  // Map<String, dynamic>? get getNombrePuesto => _nombrePuesto;
  // void setNombrePuesto(Map<String, dynamic>? value) {
  //   _nombrePuesto!.addAll(value!);
  //   print('_cedulaPuesto: $_nombrePuesto');
  //   notifyListeners();
  // }
  String? _nombrePuesto = '';
  String? get getNombrePuesto => _nombrePuesto;
  void setNombrePuesto(String? value) {
    _nombrePuesto = value;
    print('_nombrePuesto: $_nombrePuesto');
    notifyListeners();
  }

  String? _nombreUbicacion = '';
  String? get getNombreUbicacion => _nombreUbicacion;
  void setNombreUbicacion(String? value) {
    _nombreUbicacion = value;
    print('_nombreUbicacion: $_nombreUbicacion');
    notifyListeners();
  }

  List<Map<String, dynamic>> _datosOperativos = [];
  List get getDatosOperativos => _datosOperativos;
  void setDatosOperativos(Map<String, dynamic> value) {
    _datosOperativos.addAll({value});
    print('_datosOperativos: $_datosOperativos');
    notifyListeners();
  }

//=======================INPUTS DEL RESIDENTE==============================//

  String? _itemCedulaResidente = '';
  String? get getItemCedula => _itemCedulaResidente;
  void setItemCedulaResidente(String? value) {
    _itemCedulaResidente = value;
  }

  String? _itemNombresResidentes = '';
  String? get getItemNombresResidentes => _itemNombresResidentes;
  void setItemNombresResidentes(String? value) {
    _itemNombresResidentes = value;
    print('_itemNombresResidentes: $_itemNombresResidentes');
    notifyListeners();
  }

  String? _itemCasaDepartamentoResidente = '';
  String? get getItemCasaDepartamentoResidente =>
      _itemCasaDepartamentoResidente;
  void setItemCasaDepartamentoResidente(String? value) {
    _itemCasaDepartamentoResidente = value;
    print('_itemCasaDepartamentoResidente: $_itemCasaDepartamentoResidente');
    notifyListeners();
  }

  String? _itemUbicacionResidente = '';
  String? get getItemUbicacionResidente => _itemUbicacionResidente;
  void setItemUbicacionResidente(String? value) {
    _itemUbicacionResidente = value;
    print('_itemUbicacionResidente: $_itemUbicacionResidente');
    notifyListeners();
  }

//======================= VALIDA CORREO==============================//

  String _email = '';

  String get getEmail => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  List _listaCorreoResidente = [];
  List get getListaCorreoResidente => _listaCorreoResidente;
  void setListaCorreoResidente(String email) {
    _listaCorreoResidente.removeWhere((e) => e == email);
    _listaCorreoResidente.add(email);
    notifyListeners();
  }

  void deleteCorreoResidente(String _email) {
    _listaCorreoResidente.removeWhere((e) => e == _email);

    notifyListeners();
  }

//======================= AGREGA TELEFONO==============================//

  String _telefono = '';

  String get getTelefono => _telefono;

  void setTelefono(String telefono) {
    _telefono = telefono;
    notifyListeners();
  }

  List _listaTelefonosResidente = [];
  List get getListaTelefonosResidente => _listaTelefonosResidente;
  void setListaTelefonosResidente(String tel) {
    _listaTelefonosResidente.removeWhere((e) => e == tel);
    _listaTelefonosResidente.add(tel);
    notifyListeners();
  }

  void deleteTelefonosResidente(String _email) {
    _listaTelefonosResidente.removeWhere((e) => e == _email);

    notifyListeners();
  }
//======================= AGREGA PERSONA AUTORIZADA==============================//

  String _persona = '';

  String get getPersona => _persona;

  void setPersona(String Persona) {
    _persona = Persona;
    notifyListeners();
  }

  List _listaPersonasAutorizadasResidente = [];
  List get getListaPersonasAutorizadasResidente =>
      _listaPersonasAutorizadasResidente;
  void setListaPersonasAutorizadasResidente(String email) {
    _listaPersonasAutorizadasResidente.removeWhere((e) => e == email);
    _listaPersonasAutorizadasResidente.add(email);
    notifyListeners();
  }

  void deletePersonasAutorizadasResidente(String _email) {
    _listaPersonasAutorizadasResidente.removeWhere((e) => e == _email);

    notifyListeners();
  }

  //================================== CREA NUEVO COMUNICADO  ==============================//
  Future creaResidente(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();

    final _pyloadNuevoResidente = {
      "tabla": "residente", // defecto
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login

      "resId": _idResidente, // vacio
      "resPerId": "", // vacio
      "resCliId": _idCliente, //endpoint consumido
      "resCliDocumento": _cedulaCliente, //endpoint consumido
      "resCliNombre": _nombreCliente, //endpoint consumido
      "resCliUbicacion": _nombreUbicacion,
      "resCliPuesto": _nombrePuesto, //endpoint consumido
      "resCedula":
          _itemCedulaResidente, //num.parse(_itemCedulaResidente!.trim().toString()), //number
      "resNombres": _itemNombresResidentes, //string
      "resTelefono": _listaTelefonosResidente, // array telefonos
      "resCorreo": _listaCorreoResidente, // array correos
      "resEstado": "ACTIVA", //defecto interno
      "resDepartamento": _itemCasaDepartamentoResidente, //string
      "resUbicacion": _itemUbicacionResidente, //string
      "resPersonasAutorizadas": _listaPersonasAutorizadasResidente, //array

      "resUser": infoUser.usuario, //login
      "resEmpresa": infoUser.rucempresa,
      "resFecReg": "", // vacio
      "resFecUpd": "" // vacio
    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoResidente);
    print('el PAYLOAD ${_pyloadNuevoResidente}');
  }

  //================================== CREA NUEVO COMUNICADO  ==============================//
  Future creaResidenteGuardia(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
    final idTurno = await Auth.instance.getIdRegistro();

    final _pyloadNuevoResidenteGuardia = {
      "tabla": "residente", // defecto
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login

      "resId": _idResidente,
      "resCliId": "",
      "resCliDocumento": "",
      "resCliNombre": "",
      "resCliUbicacion": "",
      "resCliPuesto": "",
      "resCedula": _itemCedulaResidente,
      "resNombres": _itemNombresResidentes, //string
      "resTelefono": _listaTelefonosResidente, // array telefonos
      "resCorreo": _listaCorreoResidente,
      "resEstado": "ACTIVA",
      "resDepartamento": _itemCasaDepartamentoResidente, //string
      "resUbicacion": _itemUbicacionResidente, //string
      "resPersonasAutorizadas": _listaPersonasAutorizadasResidente, //array

      "resUser": infoUser.usuario, //login
      "resEmpresa": infoUser.rucempresa,
      "resFecReg": "", // vacio
      "resFecUpd": "", // vacio
      "regId": idTurno, // regId
    };
    serviceSocket.socket!
        .emit('client:guardarData', _pyloadNuevoResidenteGuardia);
    print('el PAYLOAD ${_pyloadNuevoResidenteGuardia}');
  }

  //========================== DROPDOWN ESTADO RESIDENTE=======================//
  String? _labelNombreEstadoResidente;

  String? get labelNombreEstadoResidente => _labelNombreEstadoResidente;

  void setLabelNombreEstadoResidente(String value) async {
    _labelNombreEstadoResidente = value;

    // print('el _labelNombreEstadoResidente ${_labelNombreEstadoResidente}');

    notifyListeners();
  }

  void resetEstadoResidente() {
    _labelNombreEstadoResidente;
  }

  Future editaResidente(
    BuildContext context,
  ) async {
    final serviceSocket = context.read<SocketService>();
    final infoUser = await Auth.instance.getSession();
      final idTurno = await Auth.instance.getIdRegistro();

    final _pyloadEditaResidente = {
      "tabla": "residente", // defecto
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login

      "resId": _idResidente, // vacio
      "resPerId": _idPer, // vacio
      "resCliId": _idCliente, //endpoint consumido
      "resCliDocumento": _cedulaCliente, //endpoint consumido
      "resCliNombre": _nombreCliente, //endpoint consumido
      "resCliUbicacion": _nombreUbicacion,
      "resCliPuesto": _nombrePuesto, //endpoint consumido
      "resCedula":_itemCedulaResidente, //num.parse(_itemCedulaResidente!.trim().toString()), //number
      "resNombres": _itemNombresResidentes, //string
      "resTelefono": _listaTelefonosResidente, // array telefonos
      "resCorreo": _listaCorreoResidente, // array correos
      "resEstado": _labelNombreEstadoResidente, //defecto interno
      "resDepartamento": _itemCasaDepartamentoResidente, //string
      "resUbicacion": _itemUbicacionResidente, //string
      "resPersonasAutorizadas": _listaPersonasAutorizadasResidente, //array
      "regId": idTurno,

  //  "resId": "",
  //  "resCliId": "",
  // "resCliDocumento": "",
  // "resCliNombre": "",
  // "resCliUbicacion": "",
  // "resCliPuesto": "",
  // "resCedula": "0202626291",
  // "resNombres": "1010",
  // "resTelefono": ["aaa"],
  // "resCorreo": ["s.cmelara12@gmail.com"],
  // "resEstado": _labelNombreEstadoResidente, //defecto interno
  // "resDepartamento": "sa",
  // "resUbicacion": "aa",
  // "resPersonasAutorizadas": ["aaa"],
  
 







      "resUser": infoUser.usuario, //login
      "resEmpresa": infoUser.rucempresa,
      "resFecReg": "", // vacio
      "resFecUpd": "" // vacio
    };
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaResidente);
    // print('el PAYLOAD ${_pyloadEditaResidente}');
  }








 //===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
  //===================BOTON SEARCH MORE CLIENTE==========================//

  // bool _btnSearchMore = false;
  // bool get btnSearchMore => _btnSearchMore;

  // void setBtnSearchMore(bool action) {
  //   _btnSearchMore = action;

  //   notifyListeners();
  // }
 List<dynamic> _filteredList=[];
   List<dynamic> get filteredList => _filteredList;
   void setListFilter( List<dynamic> _list){
  _filteredList = [];
_filteredList.addAll(_list);


// print('LA LISTA PARA FILTRAR: $_filteredList'); 
  notifyListeners();
 }

  void search(String query) {
      List<Map<String, dynamic>> originalList = List.from(_listaTodosLosResidentes); // Copia de la lista original
    if (query.isEmpty) {
      _filteredList = originalList;
    } else {
      _filteredList = originalList.where((resident) {
        return 
        // resident['resCedula'].toLowerCase().contains(query.toLowerCase()) ||
               resident['resNombres'].toLowerCase().contains(query.toLowerCase()) ||
               resident['resApellidos'].toLowerCase().contains(query.toLowerCase())||
               resident['resCedulaPropietario'].toLowerCase().contains(query.toLowerCase())||
              resident['resNombrePropietario'].toLowerCase().contains(query.toLowerCase())||
               resident['resApellidoPropietario'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }




//**********************//

List _listaVisitasResidente = [];
  List get getListaVisitasResidente => _listaVisitasResidente;
  void setListaVisitasResidente(List _info) {
    _listaVisitasResidente=[];
    _listaVisitasResidente.addAll(_info);

print('LA LISTA visitantes a residente: $_listaVisitasResidente'); 


    notifyListeners();
  }


 Future getTodasLasVisitasDelResidente() async {

    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllVisitasResidente(
      propietario: _infoResidente["resPerId"].toString(),
      residente:  _infoResidente["resPerIdPropietario"].toString(),
      token: '${dataUser!.token}',
    );
    if (response != null) {
       List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['bitFecReg']!.compareTo(a['bitFecReg']!));
      setListaVisitasResidente(dataSort);
        notifyListeners();
      return response;
    }
    if (response == null) {
     
      notifyListeners();
      return null;
    }
    return null;
  }







}
