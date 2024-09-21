import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as _http;
import 'package:intl/intl.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/socket_service.dart';

// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/session_response.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';
// import 'package:sincop_app/src/service/socket_service.dart';

class AusenciasController extends ChangeNotifier {
  GlobalKey<FormState> ausenciasFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesAusencias() {
    _idAusencia;
    _idGuardia;
    _cedulaGuardia = "";
    _nombreGuardia = '';

    _labelMotivoAusencia = '';
    _inputDetalle = "";

    _inputFechaInicio = "";
    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraInicio = '';
    // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
    _inputFechaFin = '';
    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';

    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraFin = "";
    //  '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';

    // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
    _turnoId = [];
    _listaFotosUrl = [];
    _puestoServicioGuardia = [];
    _inputNumeroDias = '0';
    _idCliente;
    _cedulaCliente;
    _nombreCliente;
    _listFechasAusencia = [];
    _listaGuardiasSeleccionados =[];
    _listFechasAusenciaSeleccionadas = [];

    _listFechasMilisegundosAusencia = [];
    _turnoEmergenteGuardado = false;
    _guardiaReemplazo = false;
    _dataTurnoEmergente;
    _idTurnoEmergente = '';
    _idsTurnosEmergente = [];
    _listTurPuesto=[];
    _listaTodosLosClientes = [];
    _diasDePermiso = 0;
    _diasReemplazo = 0;
    _sumaDiasPermiso = 0;
    _estadoAusencia = "EN PROCESO";
    setNombreCliente('');

    notifyListeners();
  }

  bool validateForm() {
    if (ausenciasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetDropDown() {
    _labelMotivoAusencia = null;
  }

  Session? _usuario;

  get getUsuarioLogin => _usuario;

  void setUsuarioLogin(Session? _usua) {
    _usuario = _usua;
    notifyListeners();
  }

//==========================inputs================//
  int? _idGuardia;
  String? _cedulaGuardia;
  String? get cedulaGuardia => _cedulaGuardia;
  String? _nombreGuardia;
  String? get nombreGuardia => _nombreGuardia;
  List? _puestoServicioGuardia;
  List? get puestosServicioGuardia => _puestoServicioGuardia;
  String? _clienteNombre;
  String? get clienteNombre => _clienteNombre;

  String? _inputNumeroDias = '0';
  String? get getInputNumeroDias => _inputNumeroDias;
  void onNumeroDiasChange(String? text) {
    _inputNumeroDias = text!.isEmpty ? '0' : text;

    // notifyListeners();
  }

  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }

  //==== TIPO TURNO ======//
  String? _tipoTurno;
  String? get getTipoTurno => _tipoTurno;
  void serTipoTurno(String? text) {
    _tipoTurno = text;
    notifyListeners();
  }

  //==== DIAS PERMIDO DE GUARDIA SELECCIONADO====//
  int? _diasDePermiso = 0;
  int? get getDiasDePermiso => _diasDePermiso;
  void setDiasDePermiso(int? text) {
    _diasDePermiso = _diasDePermiso! + text!;
    notifyListeners();
  }

  void resetDiasDePermiso() {
    _diasDePermiso = 0;
    notifyListeners();
  }

//==================== LISTO TODOS  LOS CAMBIOS DE PUESTO====================//
  List _listaAusencias = [];
  List get getListaAusencias => _listaAusencias;

  void setInfoBusquedaAusencias(List data) {
    _listaAusencias = data;
    notifyListeners();
  }

  bool? _errorAusencias; // sera nulo la primera vez
  bool? get getErrorAusencias => _errorAusencias;
  set setErrorAusencias(bool? value) {
    _errorAusencias = value;
    notifyListeners();
  }

  Future buscaAusencias(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllAusencias(
      search: _search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorAusencias = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['ausFecReg']!.compareTo(a['ausFecReg']!));

      setInfoBusquedaAusencias(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAusencias = false;
      notifyListeners();
      return null;
    }
  }
  //======================================================OBTIENE DATOS DEL CLIENTE============================================//

  String? _idClienteMulta;
  String? _cedClienteMulta;
  String? _nombreClienteMulta;
  String? get getIdClienteAusencia => _idClienteMulta;
  String? get getCedClienteAusencia => _cedClienteMulta;
  String? get getNomClienteAusencia => _nombreClienteMulta;
  String? get getIdGuardia => _idGuardia.toString();
  String? get getIdCliente => _idClienteMulta;

  dynamic _guardiaInfo;
  dynamic get getGuardiaInfo => _guardiaInfo;

  void getInfomacionGuardia(dynamic guardia) {
    _guardiaInfo = guardia;
    _idGuardia = guardia['perId'];
    _cedulaGuardia = guardia['perDocNumero'];
    _nombreGuardia = '${guardia['perApellidos']} ${guardia['perNombres']}';
    _puestoServicioGuardia = guardia['perPuestoServicio'];
    _idClienteMulta = guardia['perIdCliente'];
    setCedulaCliente(guardia['perDocuCliente']);
    setNombreCliente(guardia['perNombreCliente']);
    getTodosLosClientes(guardia['perDocuCliente']);
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

  String? _inputHoraInicio = '';
  //     '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';

  // String? _inputHoraFin =
  //     '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';

  get getInputHoraInicio => _inputHoraInicio;

  // void onInputHoraInicioChange(String? date) {
  //   _inputHoraInicio = date;
  //   print('_inputHoraInicio :$_inputHoraInicio');

  //   final _fechaActual = '${_inputFechaInicio} ${_inputHoraInicio}';

  //   final _later = DateTime.parse(_fechaActual).add(const Duration(hours: 24));
  //   // print('la fecha _later es $_later');
  //   onInputFechaFinChange(
  //       '${_later.year}-${(_later.month) < 10 ? '0${_later.month}' : '${_later.month}'}-${(_later.day) < 10 ? '0${_later.day}' : '${_later.day}'}'
  //       //  '$_later'
  //       );

  //   onInputHoraFinChange(
  //       '${(_later.hour) < 10 ? '0${DateTime.now().hour}' : '${_later.hour}'}:${(_later.minute) < 10 ? '0${_later.minute}' : '${_later.minute}'}');

  //   notifyListeners();
  // }
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

  //========================== VALIDA CAMPO  FECHA FIN CONSIGNA =======================//

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

//========================== DROPDOWN MOTIVO AUSENCIA =======================//
  String? _labelMotivoAusencia;

  String? get labelMotivoAusencia => _labelMotivoAusencia;

  void setLabelMotivoAusencia(String value) {
    _labelMotivoAusencia = value;
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
        .add(CreaNuevaFotoausencias(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotosCrearInforme.add(CreaNuevaFotoausencias(id, path));

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
      _listaFotosUrl!.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
      notifyListeners();
    }
  }

  void eliminaFotoUrl(String url) {
    _listaFotosUrl!.removeWhere((e) => e['url'] == url);
  }

  List<dynamic> _turnoId = [];
  List<Map<String,dynamic>> _fechasBDD = [];
 
 //============================================= LISTA DE FECHAS QUE SE AGREGAN AL CREAR EL TURNO====================//
  List<Map<String, dynamic>> _listTurPuesto = [];
  List<Map<String, dynamic>> get getListTurPuesto => _listTurPuesto;

  void setListTurPuesto(Map<String, dynamic> _data) {
    _listTurPuesto.removeWhere((e) => e['idDelete'] == _data['idDelete']);
    _listTurPuesto.addAll([_data]);
    print('_listTurPuesto xxxxxxxxxx  ${_listTurPuesto}');
    notifyListeners();
  }
  void deleteItemTurPuesto(Map<String, dynamic>_item) {
    if(_listFechasAusencia.isEmpty){
    _listTurPuesto.removeWhere((e) => e['idDelete'] == _item['idDelete']);
     print('_listTurPuesto CURRENT  ${_listTurPuesto}');

    }
    notifyListeners();
  }

  

  Future crearAusencia(BuildContext context) async {
    final serviceSocket = SocketService();

 _turnoId = [];
 _fechasBDD = [];
//  "turPuesto": [
//     {
//       "ruccliente": "1760004060001",
//       "razonsocial": "GOBIERNO AUTONOMO DESCENTRALIZADO MUNICIPAL DE SANTO DOMINGO",
//       "ubicacion": "SANTO DOMINGO",
//       "puesto": "INFOCENTRO COOP. PLAN DE VIVIENDA "
//     }
//   ]


        if(_listaGuardiasSeleccionados.isNotEmpty){

    for (var item in _listaGuardiasSeleccionados) {
      _turnoId.add(item['turId']);
     
        _fechasBDD.add(item['fechas']);
    }
  
    for (var item in _fechasBDD) {
          item.remove('isSelect');  
    }
    for (var item in _listTurPuesto) {
          item.remove('idDelete');  
    }


    for (var item in _listaGuardiasSeleccionados) {
     
      DateTime _fDesdeMilisegundos =
      DateTime.parse(item['fechas']['desde'].toString().replaceAll('T', ' '));

      DateTime fecha = DateTime.parse(
          _fDesdeMilisegundos.toString()); // Ejemplo de fecha actual

      int milisegundos = fecha.millisecondsSinceEpoch;

      _listFechasMilisegundosAusencia.addAll([
        {"desde": "$milisegundos", "hasta": ""}
      ]);

    }
        }



    if(_listaGuardiasSeleccionados.isEmpty){

              _turnoId=[];

    for (var item in getListFechasAusencia) {
    
     
        _fechasBDD.add(item);
    }
  
    for (var item in _fechasBDD) {
          item.remove('isSelect');  
    }
    for (var item in _listTurPuesto) {
          item.remove('idDelete');  
    }


    for (var item in getListFechasAusencia) {
     
      DateTime _fDesdeMilisegundos =
      DateTime.parse(item['desde'].toString().replaceAll('T', ' '));

      DateTime fecha = DateTime.parse(
          _fDesdeMilisegundos.toString()); // Ejemplo de fecha actual

      int milisegundos = fecha.millisecondsSinceEpoch;

      _listFechasMilisegundosAusencia.addAll([
        {"desde": "$milisegundos", "hasta": ""}
      ]);

    }
        }



      


    final infoUserLogin = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

    final _pyloadNuevaAusencia = {
      "tabla": "ausencia", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin

      "ausIdPersona": _idGuardia,
      "ausDocuPersona": _cedulaGuardia,
      "ausNomPersona": _nombreGuardia,
      "ausPuesto": [],
      "ausMotivo":
          _labelMotivoAusencia, // select=> ENFERMEDADES IESS, PERMISO PERSONAL,PATERNIDAD,DEFUNCION FAMILIAR, INJUSTIFICADA
      "ausEstado": "EN PROCESO",

      "ausPerIdCliente": _idClienteMulta, //_idCliente,
      "ausPerDocuCliente": _cedulaCliente,
      "ausPerNombreCliente": _nombreCliente,
      "ausDiasPermiso": _listFechasAusencia.length,
    
      "ausDetalle": _inputDetalle, // textarea
      "ausDocumento": "", // input file
      "ausFotos": _listaFotosUrl,
      "ausIdMulta": "", // interno
      "ausUser":
          infoUserLogin.usuario, // iniciado turno // usuario iniciado turno
      "ausEmpresa": infoUserLogin.rucempresa, //login //login
      "idTurno": _turnoId,
      "ausStatusDescripcion": "",
      "ausTipoTurno": "DIA",

      "ausFechas": _listFechasMilisegundosAusencia,
      "ausFechasConsultaDB": _fechasBDD,

        // "turPuesto": _listTurPuesto


    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaAusencia);
    // print('crea pruesto _listTurPuesto:$_pyloadNuevaAusencia');

    // print('_listFechasMilisegundosAusencia:$_listFechasMilisegundosAusencia');
    // print('_fechasBDD:$_fechasBDD');

    // print('_listTurPuesto:$_listTurPuesto');
    // print('VALOR:$_pyloadNuevaAusencia');
    
    // print('VALOR:$_listaGuardiasSeleccionados');
    // print('_turnoId:${_turnoId.length}');
    // print('_turnoId:${_turnoId}');
    // print('_fechasBDD:${_fechasBDD.length}');
    // print('_fechasBDD:${_fechasBDD}');
  }

//================================== ELIMINAR  MULTA  ==============================//
  Future eliminaAusencia(int? idAusencia) async {
    final serviceSocket = SocketService();
    final infoUser = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();
    final _pyloadEliminaAusenciao = {
      {
        "tabla": 'ausencia',
        "rucempresa": infoUser!.rucempresa,
        "ausId": idAusencia,
      }
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaAusenciao);
  }

  String? _estadoAusencia = "EN PROCESO";
  String? get getEstadoAusencia => _estadoAusencia;
  void setEstadoAusencia(String? text) {
    _estadoAusencia = text;
    notifyListeners();
  }

  int? _idAusencia;

  dynamic _getInfoAusencia;
  get getInfoAusencia => _getInfoAusencia;
  String? _ausenciaEstadoDescripcion = '';
  void getDataAusencia(dynamic ausencia) {
    _getInfoAusencia = ausencia;
    _idAusencia = ausencia['ausId'];
    _idGuardia = int.parse(ausencia['ausIdPersona'].toString());
    _cedulaGuardia = ausencia['ausDocuPersona'];
    _nombreGuardia = ausencia['ausNomPersona'];
    _labelMotivoAusencia = ausencia['ausMotivo'];
    _inputNumeroDias = ausencia['ausDiasPermiso'].toString();
    _inputDetalle = ausencia['ausDetalle'];

    _estadoAusencia = ausencia['ausEstado'];
    _turnoId = ausencia['idTurno'];

    if (ausencia["ausFechasConsultaDB"].isNotEmpty) {
      for (var item in ausencia["ausFechasConsultaDB"]) {
        // print('fechas BD :$item');
        _listFechasAusencia.addAll([item]);
      }
    }

    _listaFotosUrl = ausencia['ausFotos'];
    _puestoServicioGuardia = ausencia['ausPuesto'];

    _idCliente = int.parse(ausencia['ausPerIdCliente'].toString());
    _cedulaCliente = ausencia['ausPerDocuCliente'];
    _nombreCliente = ausencia['ausPerNombreCliente'];
    _ausenciaEstadoDescripcion = ausencia['ausStatusDescripcion'];
    _tipoTurno = ausencia['ausTipoTurno'];

// sumaDias() ;
// _sumaDiasPermiso=int.parse(ausencia['ausDiasPermiso'].toString());
  }

  Future editaAusencia(BuildContext context) async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

    final _pyloadEditaAusencia = {
      "tabla": "ausencia", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin
      "ausId": _idAusencia,
      "ausIdPersona": _idGuardia,
      "ausDocuPersona": _cedulaGuardia,
      "ausNomPersona": _nombreGuardia,
      "ausPuesto": _puestoServicioGuardia,
      "ausMotivo":
          _labelMotivoAusencia, // select=> ENFERMEDADES IESS, PERMISO PERSONAL,PATERNIDAD,DEFUNCION FAMILIAR, INJUSTIFICADA
      "ausEstado": _estadoAusencia,

      "ausPerIdCliente": _idCliente,
      "ausPerDocuCliente": _cedulaCliente,
      "ausPerNombreCliente": _nombreCliente,

      "ausFechaDesde": '${_inputFechaInicio}T$_inputHoraInicio', // fecha hora
      "ausFechaHasta": '${_inputFechaFin}T$_inputHoraFin', // fecha hora
      "ausDiasPermiso": _inputNumeroDias, // textarea
      "ausDetalle": _inputDetalle, // textarea
      "ausDocumento": "", // input file
      "ausFotos": _listaFotosUrl,
      "ausIdMulta": "", // interno
      "ausUser":
          infoUserLogin.usuario, // iniciado turno // usuario iniciado turno
      "ausEmpresa": infoUserLogin.rucempresa, //login //login
      "idTurno": _turnoId,
      "ausStatusDescripcion":
          _ausenciaEstadoDescripcion, // tomar el valor que llega de la api
      "ausTipoTurno": _tipoTurno
    };
    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaAusencia);
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

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaTurno;

  @override
  void dispose() {
    _deboucerSearchBuscaTurno?.cancel();
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
        buscaAusencias(_nameSearch, 'false');
      });
    } else {
      buscaAusencias('', 'false');
    }
  }

// =============================obtenemos la informacion de cliente==================================//
  int? _idCliente;
  String? _cedulaCliente;
  String? get getCedulaCliente => _cedulaCliente;
  String? _nombreCliente;
  String? get nombreCliente => _nombreCliente;
  void setNombreCliente(String data) {
    _nombreCliente = data;
  }

  void setCedulaCliente(String data) {
    _cedulaCliente = data;
  }

  void getInfoClientes(dynamic cliente) {
    _idCliente = cliente['cliId'];
    _cedulaCliente = cliente['cliDocNumero'];
    _nombreCliente = cliente['cliRazonSocial'];
  }

//===================== VALIDA REGITRO DE TURNO EMERGENTE ========================//

  bool _turnoEmergenteGuardado = false;

  bool get getTurnoEmergenteGuardado => _turnoEmergenteGuardado;

  void setTurnoEmergenteGuardado(bool _value) {
    _turnoEmergenteGuardado = _value;
    notifyListeners();
  }
//===================== VALIDA REGITRO DE TURNO EMERGENTE ========================//

  bool _guardiaReemplazo = false;

  bool get getGuardiaReemplazo => _guardiaReemplazo;

  void setGuardiaReemplazo(bool _value) {
    _guardiaReemplazo = _value;
  }

//================================================================================//
//===================== OBTENEMOS INFO DEL  TURNO EMERGENTE ========================//

  dynamic _dataTurnoEmergente;
  dynamic get getDataTurnoEmergente => _dataTurnoEmergente;
  void setDataTurnoEmergente(dynamic _value) {
    _dataTurnoEmergente = _value;
  }

  String _idTurnoEmergente = '';
  void setIdTurnoEmergente(String _value) {
    _idTurnoEmergente = _value;
    notifyListeners();
  }

  List<Map<String, dynamic>> _idsTurnosEmergente = [];
  List<Map<String, dynamic>> get getIdsTurnosEmergente => _idsTurnosEmergente;

  void setIdsTurnoEmergente(Map<String, dynamic> _value) {
    _idsTurnosEmergente
        .removeWhere((element) => element['fechas'] == _value['fechas']);

    _idsTurnosEmergente.add(_value);
    print('ESTA ES LA DATA DE  LOS ID; $_idsTurnosEmergente');

    // sumaDias();
    setDiasReemplazo();

    notifyListeners();
  }

//========== SUMA DIAS DE PERMISO ====================//
  List<Map<String, dynamic>> _listaGuardiasSeleccionados = [];
  List<Map<String, dynamic>> get getlistaGuardiasSeleccionados => _listaGuardiasSeleccionados;

  void setGuardiasSeleccionados(Map<String, dynamic> _value) {
    //  print('ESTA ES LA DATA DE  LOS ID======> $_value');

  
    _listaGuardiasSeleccionados
        .removeWhere((element) => element['fechas']['desde'] == _value['fechas']['desde']);

    _listaGuardiasSeleccionados.add(_value);
    // print('ESTA ES LA DATA DE  LOS ID======> $_listaGuardiasSeleccionados');

    // sumaDias();
    setDiasReemplazo();

    notifyListeners();
  }

//========== SUMA DIAS DE PERMISO ====================//
  int _sumaDiasPermiso = 0;
  int get getSumaDiasPermiso => _sumaDiasPermiso;
  void sumaDias() {
    int _diasTurnos = 0;
    for (var item in getIdsTurnosEmergente) {
      _diasTurnos = _diasTurnos + int.parse(item['numDias']);
    }
    _sumaDiasPermiso = _diasTurnos;
    // print('LOS DIAS SUMADOS $_sumaDiasPermiso');
    notifyListeners();
  }

//========== ELIMINA ELEMENTO GUARDIA DESIGNADO EN TURNO EXTRA ====================//
  void eliminaGuardiaTurnoExtra(int id) {
    _idsTurnosEmergente.removeWhere((element) => element['turIdPersona'] == id);
       print('dato a eliminar  $id');

    notifyListeners();
  }
//========== ELIMINA ELEMENTO GUARDIA DESIGNADO EN TURNO EXTRA ====================//
  void eliminalistaGuardiasSeleccionados(int id) {
    _listaGuardiasSeleccionados.removeWhere((element) => element['turId'] == id);

    notifyListeners();
  }

//================================ FUNCION DIAS =============================================//
  Future? calculaFechaPermiso(String _dias) async {
    if (_dias == '0') {
      onInputFechaInicioChange(
          '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}');
      var _dateFin = DateTime.parse(_inputFechaFin.toString())
          .add(Duration(days: int.parse(_dias)));
      onInputFechaFinChange(
          '${_dateFin.year}-${(_dateFin.month) < 10 ? '0${_dateFin.month}' : '${_dateFin.month}'}-${(_dateFin.day) < 10 ? '0${_dateFin.day}' : '${_dateFin.day}'}');
    } else {
      var _dateIni = DateTime.parse(_inputFechaInicio.toString());
      var _dateFin = DateTime.parse(_inputFechaFin.toString())
          .add(Duration(days: int.parse(_dias)));
      onInputFechaFinChange(
          '${_dateFin.year}-${(_dateFin.month) < 10 ? '0${_dateFin.month}' : '${_dateFin.month}'}-${(_dateFin.day) < 10 ? '0${_dateFin.day}' : '${_dateFin.day}'}');

      var nDias = _dateFin.difference(_dateIni);
    }
  }
//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//

  List _listaTodosLosClientes = [];
  List get getListaTodosLosClientes => _listaTodosLosClientes;

  void setListaTodosLosClientes(List data) {
    _listaTodosLosClientes = data;



// print('555555............. $_listaTodosLosClientes');

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
//=====================================================//

//============================================= LISTA DE FECHAS QUE SE AGREGAN AL CREAR EL TURNO====================//
  List<Map<String, dynamic>> _listFechasAusencia = [];
  List<Map<String, dynamic>> get getListFechasAusencia => _listFechasAusencia;

  void setListFechasAusencia(Map<String, dynamic> _data) {
    _listFechasAusencia.removeWhere((e) => e['desde'] == _data['desde']);
    _listFechasAusencia.addAll([_data]);
    // print('_listFechasAusencia   ${_listFechasAusencia.length}');
    notifyListeners();
  }

//============================================= LISTA DE FECHAS QUE SE AGREGAN AL CREAR EL TURNO====================//
  List<Map<String, dynamic>> _listFechasMilisegundosAusencia = [];
  List<Map<String, dynamic>> get getListFechasMilisegundosAusencia =>
      _listFechasMilisegundosAusencia;

  void setListFechasMilisegundosAusencia(Map<String, dynamic> _data) {
    _listFechasMilisegundosAusencia.removeWhere((e) => e == _data);
    _listFechasMilisegundosAusencia.addAll([_data]);
    // print('_listFechasMilisegundosAusencia   $_listFechasMilisegundosAusencia');
    notifyListeners();
  }

//======================ELIMINA FECHA TURNO EXTRA=========================//
  void deleteItemFecha(Map<String, dynamic> _val) {
    _listFechasAusencia.removeWhere((e) => e == _val);
    notifyListeners();
  }

//======================ELIMINA FECHA TURNO EXTRA=========================//
  void deleteItemFechaMilisegundo(Map<String, dynamic> _val) {
    _listFechasMilisegundosAusencia.removeWhere((e) => e == _val);
    notifyListeners();
  }

//=====================================================//

//==================== LISTO INFORMACION DEL GUARDIA  QR====================//
  List<Map<String, dynamic>> _listaGuardiasReemplazo = [];
  List get getListaGuardiasReemplazo => _listaGuardiasReemplazo;
  void setInfolistaGuardiasReemplazo(List<Map<String, dynamic>> data) {
    _listaGuardiasReemplazo = data;

    // print('informacion guardias:$_listaGuardiasReemplazo');
    notifyListeners();
  }

  bool? _errorListaGuardiasReemplazo; // sera nulo la primera vez
  bool? get getErrorListaGuardiasReemplazo => _errorListaGuardiasReemplazo;
  set setErrorListaGuardiasReemplazo(bool? value) {
    _errorListaGuardiasReemplazo = value;
    notifyListeners();
  }

  Future buscaListaGuardiasReemplazo(List<String>? _listaIds) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getGuardiasReemplazoAusencias(
      listaIds: _listaIds,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaGuardiasReemplazo = true;
      // print('la data RESPONSE:${response['data']}');
      // setInfolistaGuardiasReemplazo(response['idTurno']);
        _idsTurnosEmergente.clear();
      for (var item in response['data']) {
        //  print('ITEM:${item['turNomPersona']}');
        //  print('ITEM:${item['turFechasConsultaDB']}');
      

        _idsTurnosEmergente.addAll([
          {
            "turId": item['turId'],
            "turIdPersona": item['turIdPersona'],
            "turDocuPersona": item['turDocuPersona'],
            "turNomPersona": item['turNomPersona'],
            "fechas": item['turFechasConsultaDB'],
            "numDias": item['turDiasTurno']
          }
        ]);
      }
         print('ITEM REEMPLAZO:${_idsTurnosEmergente}'); 
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaGuardiasReemplazo = false;
      notifyListeners();
      return null;
    }
  }

  //=========================SUMA LOS DIAS DE PERMISOS============================//
  int _diasReemplazo = 0;
  int? get getDiasReemplazo => _diasReemplazo;
  //  void setDiasReemplazo(int _dia){
  void setDiasReemplazo() {
    _diasReemplazo = 0;
    for (var item in _idsTurnosEmergente) {
      _diasReemplazo = _diasReemplazo + int.parse(item['numDias'].toString());
    }

    notifyListeners();
  }

//=======================ELIMINA FECHAS DE LA LISTA==============================//
  void resetistaFechas() {
    _idsTurnosEmergente.clear();
    notifyListeners();
  }

//=====================================================//
//=======================ELIMINA FECHAS DE LA LISTA==============================//
  void resetListaFechas() {
    _listFechasAusencia.clear();
    notifyListeners();
  }
//=====================================================//

  List<Map<String, dynamic>> _listFechasAusenciaSeleccionadas = [];
  List<Map<String, dynamic>> get getListFechasAusenciaSeleccionadas =>
      _listFechasAusenciaSeleccionadas;

  void setListFechasAusenciaSeleccionadas(Map<String, dynamic> _data) {
    _listFechasAusenciaSeleccionadas
        .removeWhere((e) => e['desde'] == _data['desde']);
    _listFechasAusenciaSeleccionadas.add(_data);

    notifyListeners();
  }

  void eliminaListFechasAusenciaSeleccionadas(Map<String, dynamic> _data) {
    _listFechasAusenciaSeleccionadas
        .removeWhere((e) => e['desde'] == _data['desde']);

    notifyListeners();
  }

  void resetListaAusenciasTurno() {
    _listFechasAusenciaSeleccionadas = [];
  }
//=====================================================//

//========================= TOMAMOS LA INFO PARA VALIDAR SI EL GUARDIA TIENE TURNO ================================//

  Map<String, dynamic> _infoGuardiaVerificaTurno = {};
  Map<String, dynamic> get getInfoGuardiaVerificaTurno =>
      _infoGuardiaVerificaTurno;



Map<String,String> _fechas={};
  void setInfoGuardiaVerificaTurno(Map<String, dynamic> _guardia) {
    _infoGuardiaVerificaTurno = _guardia;

    
    print('ESTA ES LA DATA: $_fechas');

    notifyListeners();
  }
  // //========================== VERIFICA SI LA FECHA EXISTE =======================//
Map<String, dynamic> _contieneFecha={};
Map<String, dynamic>  get getContieneFecha => _contieneFecha;
String _idItem='';
void findDate(String targetDate) {

if ( _infoGuardiaVerificaTurno['perTurno']!=null) {
   if (_infoGuardiaVerificaTurno['perTurno'].isNotEmpty) {
   for (var item in _infoGuardiaVerificaTurno['perTurno']) {
        print('ESTA ES LA DATA: ${item['fechas']['desde']}');
        if (item['fechasConsultaDB'].isNotEmpty) {
          for (var fecha in item['fechasConsultaDB']) {
          //  print('ESTA ES LA DATA: desde: ${fecha['desde']} - hasta : ${fecha['hasta']}');
          final _fech=fecha['desde'].toString().substring(0,10);
            // print("La fecha $targetDate se encuentra $_fech");
                // print("La fecha ${_infoGuardiaVerificaTurno['perTurno']}");

          if (_fech==targetDate) {
             _idItem=item['id'];
             _contieneFecha.addAll(
              {
                "fecha":fecha,
               
                "idDelete": _idItem,
                 "id": _idItem,
                 "ruccliente":item['docClienteIngreso'],
                 "razonsocial": item['clienteIngreso'],
                 "ubicacion": item['clienteUbicacionIngreso'],
                 "puesto":item['puestoIngreso']
                                  
                }
              );
            //  _contieneFecha.addAll(fecha);
             break;
          } 
          else {
            // _contieneFecha={};
             print("La fecha $targetDate noooooooo encuentra en la lista.");
          }


        }
          
        } else {
       _contieneFecha={};
        }
  
    }
    print("La fecha $targetDate  encuentra $_contieneFecha.");
      //  return  _contieneFecha={};
      
 } else {
  _contieneFecha={};
 }
  
} else {

}


}


  // //========================== VALIDA CAMPO  FECHA  =======================//

  // String? _fechaValida = '';
  //  get getFechaValida => _fechaValida;

  // void setFechaValida(String? _date) {
  //   _fechaValida = _date;
  //   print('_fechaValida :$_fechaValida');

  //       notifyListeners();
  // }
  //========================== VALIDA CAMPO  FECHA  =======================//

  Map<String, dynamic> _fechaValida = {};
  get getFechaValida => _fechaValida;

  void setFechaValida(Map<String, dynamic> _date) {
    _fechaValida = _date;
    print('_fechaValida :$_fechaValida');

    notifyListeners();
  }

//========================================//

  List _listaInfoGuardia = [];

  List get getListaInfoGuardia => _listaInfoGuardia;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardia = [];
    _listaInfoGuardia = data;
    print('personal: $_listaInfoGuardia');

    notifyListeners();
  }

//   bool? _errorInfoGuardia; // sera nulo la primera vez
//   bool? get getErrorInfoGuardia => _errorInfoGuardia;
//   set setErrorInfoGuardia(bool? value) {
//     _errorInfoGuardia = value;
//     notifyListeners();
//   }

//   Future buscaInfoGuardias(String? _search )async {
//     final dataUser = await Auth.instance.getSession();

//  String _persona='';
//   if(dataUser!.rol!.contains('GUARDIA')){
//      _persona="GUARDIAS";

//   }else if(dataUser.rol!.contains('ADMINISTRACION')){
//      _persona="ADMINISTRACION";

//   }

//     final response = await _api.getAllGuardias(
//       search: _search,
//       // estado: 'GUARDIAS',
//       estado: '$_parsona',
//       // estado: 'ADMINISTRACION',
//       token: '${dataUser.token}',
//     );
//     if (response != null) {
//       _errorInfoGuardia = true;

//       setInfoBusquedaInfoGuardia(response['data']);
//       setInfoGuardiaVerificaTurno(response['data']);

//       notifyListeners();
//       return response;
//     }
//     if (response == null) {
//       _errorInfoGuardia = false;
//       notifyListeners();
//       return null;
//     }
//   }
  //========================== OBTENEMOS EL PERFIL DE LA PERSONA  ===============================//

  String? _parsona = '';
  String? get getPersona => _parsona;

  void setPersona(String? _person) {
    _parsona = _person;
    print('persona  : $_person');
    notifyListeners();
  }

  //========================== VALIDAMOS FECHA ASIGNADA A TURNO ===============================//

List<Map<String,dynamic>> _listaFechas=[];
List<Map<String,dynamic>> get getListaFechas=>_listaFechas;



 bool _dateExists = false;
 bool get getDateExists => _dateExists;
 void setDateExists(bool _state){
  _dateExists=_state;
  notifyListeners();
 }




   String? _getDate = '';
   String? get getTargetDate => _getDate;

 setListaFechaExistente( String _fecha) async{


_listaFechas=[];
 for (var item in _idsTurnosEmergente) {


      _listaFechas.addAll(item['fechas']);

    }

            // print('FECHAS: ${_idsTurnosEmergente.length}');
             for (var item in _listaFechas) {


            print('FECHAS: ${item['desde']}');

    }


//   for (var item in _listaFechas) {
//         if(_fecha==item["desde"].toString().substring(0,10)){
//             print('FECHAS:$_fecha == ${item["desde"].toString().substring(0,10)}');
//             //  _dateExists = true;
//              _getDate = _fecha;

// notifyListeners();
//         }else{
//             //  _dateExists = false;
//              _getDate = _fecha;
// notifyListeners();

//         }



    
//   }
// if(_getDate!=''){
//    _dateExists = true;

// }else{
//    _dateExists = false;
// }

// notifyListeners();



// for (var i = 0; i < _idsTurnosEmergente.length; i++) {

//   //  print('FECHAS:$i -- ${_idsTurnosEmergente[i]['fechas']}');
//      for (var item in _idsTurnosEmergente[i]['fechas']) {
//           print('FECHAS:$i -- ${item['desde']}');
//      }
// }





  }

}
