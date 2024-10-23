import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_foto_multas.dart';
// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/get_info_guardia_multa.dart';
// import 'package:sincop_app/src/models/lista_allClientes.dart';
// import 'package:sincop_app/src/models/lista_allNovedades_guardia.dart';
// import 'package:sincop_app/src/models/lista_allTipos_multas.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_foto_multas.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/get_info_guardia_multa.dart';
import 'package:nseguridad/src/models/lista_allClientes.dart';
import 'package:nseguridad/src/models/lista_allNovedades_guardia.dart';
import 'package:nseguridad/src/models/lista_allTipos_multas.dart';
import 'package:nseguridad/src/models/session_response.dart';
// import 'package:sincop_app/src/models/session_response.dart';
// import 'package:sincop_app/src/service/notifications_service.dart' as snaks;
// import 'package:sincop_app/src/service/socket_service.dart';
import 'package:nseguridad/src/service/notifications_service.dart' as snaks;
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:provider/provider.dart';

class MultasGuardiasContrtoller extends ChangeNotifier {
  GlobalKey<FormState> multasGuardiaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> validaMultasGuardiaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> validaMultasApelacionFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  Session? infoUser;

  MultasGuardiasContrtoller() {
    formatofecha();
  }
  bool validateForm() {
    if (multasGuardiaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormValidaMulta() {
    if (validaMultasGuardiaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormApelacionMulta() {
    if (validaMultasApelacionFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//================================== OBTENEMOS TODAS LAS NOVEDADES MODIFICADAS ==============================//
  List? _listaTodasLasMultas = [];
  List? get getListaTodasLasMultasGuardias => _listaTodasLasMultas;

  void setListaTodasLasMultas(List? data) {
    _listaTodasLasMultas = [];
    _listaTodasLasMultas = data;
    // print('SI HACE EL LLAMADO : $_listaTodasLasMultas');

    notifyListeners();
  }

  bool? _errorMultas; // sera nulo la primera vez
  bool? get getErrorMultas => _errorMultas;

  Future getTodasLasMultasGuardia(String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllMultasGuardias(
      search: search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorMultas = true;
      List? daraSort = [];
      daraSort = response['data'];
      daraSort!.sort((a, b) => b['nomFecReg']!.compareTo(a['nomFecReg']!));
      setListaTodasLasMultas(daraSort);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorMultas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  //===================SELECCIONAMOS EL LA OBCION DE LA MULTA==========================//
  var _idMulta;
  String _origen = '';
  String _textoTipoMulta = '';
  String _tipoMulta = '';

  var _itemTipoMulta;
  var _porcentajeTipoMulta;
  get getIdMulta => _idMulta;
  get getOrigenMulta => _origen;
  get getTipoMulta => _tipoMulta;
  get getItemTipoMulta => _itemTipoMulta;
  String get getTextoTipoMulta => _textoTipoMulta;
  get getPorcentajeTipoMulta => _porcentajeTipoMulta;
  final Map<String, dynamic> _datosMulta = {};
  Map<String, dynamic> get getdatosMulta => _datosMulta;

  void setItenTipoMulta(value, idMulta, origen, tipo, porcentaje, text) {
    _idMulta = idMulta;
    _origen = origen;
    _tipoMulta = tipo;
    _itemTipoMulta = value;
    _porcentajeTipoMulta = porcentaje;
    _textoTipoMulta = text;
    notifyListeners();
  }

//========================== GEOLOCATOR =======================//
  String? _coordenadas = "";
  Geolocator.Position? _position;
  Geolocator.Position? get position => _position;
  String? _selectCoords = "";
  String? get getCoords => _selectCoords;
  set setCoords(String? value) {
    _selectCoords = value;
  }

  Future<bool?> checkGPSStatus() async {
    final isEnable = await Geolocator.Geolocator.isLocationServiceEnabled();
    Geolocator.Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1) ? true : false;
    });
    return isEnable;
  }

  Future<void> getCurrentPosition() async {
    late LocationSettings locationSettings;

    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _position =
        await Geolocator.GeolocatorPlatform.instance.getCurrentPosition();
    _position = position;
    _selectCoords = ('${position!.latitude},${position!.longitude}');
    _coordenadas = _selectCoords;
    notifyListeners();
  }

//========================== DROPDOWN PERIODO CONSIGNA CLIENTE =======================//
  String? _labelPuestosCliente;

  String? get labelPuestosCliente => _labelPuestosCliente;

  void setLabelPuestosCliente(String value) {
    _labelPuestosCliente = value;
    notifyListeners();
  }

//================================== OBTENEMOS TODOS LOS TIPOS DE MULTAS  ==============================//
  List<TipoMulta> _listaTodosLosTiposDeMultas = [];
  List<TipoMulta> get getListaTodosLosTiposDeMultas =>
      _listaTodosLosTiposDeMultas;

  void setListaTodosLosTiposDeMultas(List<TipoMulta> data) {
    _listaTodosLosTiposDeMultas = data;
    notifyListeners();
  }

  bool? _errorTiposMultas; // sera nulo la primera vez
  bool? get getErrorTiposMultas => _errorTiposMultas;

  Future<AllTiposMultasGuardias?> getTodoosLosTiposDeMultasGuardia() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllTiposMultasGuardias(
      search: 'MULTAS',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorTiposMultas = true;
      setListaTodosLosTiposDeMultas(response.data);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTiposMultas = false;
      notifyListeners();
      return null;
    }
  }

  //========================== OBTENEMOS LA INFORMACION DE LA LA MULTA =======================//
  dynamic _getInformacionMulta;

  dynamic get geInformacionMulta => _getInformacionMulta;

  void setInfoMultaObtenida(dynamic _info) {
    _getInformacionMulta = _info;

    // print('EL ITEM DE MULTA: $_getInformacionMulta');


    notifyListeners();
  }

  //========================== VALIDA CAMPO  FECHA FIN CONSIGNA =======================//
  String? _inputFechaMulta;
  get getInputFechamulta => _inputFechaMulta;
  void onInputFechaMultaChange(String? date) {
    _inputFechaMulta;
    _inputFechaMulta = date;
    notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;

  List _listaFotosUrlMultas = [];
  List? get getListaFotosUrl => _listaFotosUrlMultas;

  List<CreaNuevaFotoMultas?> _listaFotoMulta = [];
  List<CreaNuevaFotoMultas?> get getListaFotosMultas => _listaFotoMulta;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotoMulta.add(CreaNuevaFotoMultas(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotoMulta.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  void eliminaFotoA(int id) {
    _listaFotoMulta.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  int idFotoApelacion = 0;
  File? _newPictureFileApelacion;
  File? get getNewPictureFileApelacion => _newPictureFileApelacion;

  List _listaFotosUrlMultasApelacion = [];
  List? get getListaFotosUrlApelacion => _listaFotosUrlMultasApelacion;
  List _listaFotosUrlMultasApelaciones = [];
  List? get getListaFotosUrlApelaciones => _listaFotosUrlMultasApelaciones;

  List<CreaNuevaFotoApelarMulta?> _listaFotoMultaApelacion = [];
  List<CreaNuevaFotoApelarMulta?> get getListaFotosMultasApelacion =>
      _listaFotoMultaApelacion;
  void setNewPictureFileApelacion(String? path) {
    _newPictureFileApelacion = File?.fromUri(Uri(path: path));
    upLoadImagenApelacion(_newPictureFileApelacion);
    _listaFotoMultaApelacion
        .add(CreaNuevaFotoApelarMulta(id, _newPictureFileApelacion!.path));
    id = id + 1;
    notifyListeners();
  }

  void eliminaFotoApelacion(int id) {
    _listaFotoMultaApelacion.removeWhere((element) => element!.id == id);

    notifyListeners();
  }

  void opcionesDecamara(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      // print('NO SELECCIONO IMAGEN');
      return;
    }
    setNewPictureFile(pickedFile.path);
  }

  String? _inputDetalleNovedad = '';
  get getInputDetalleNovedad => _inputDetalleNovedad;
  void onInputDetalleNovedadChange(String? text) {
    _inputDetalleNovedad = text;

    notifyListeners();
  }

  String? _inputAnulacionDeMulta;
  get getInputAnulacionDeMulta => _inputAnulacionDeMulta;
  void onInputAnulacionDeMultaChange(String? text) {
    _inputAnulacionDeMulta = text;
    notifyListeners();
  }

  String? _inputCiudad;
  get getInputCiudad => _inputCiudad;
  void onInputCiudadChange(String? text) {
    _inputCiudad = text;
    notifyListeners();
  }

  String? _inputBuscaPersona;
  get getInputBuscaPersona => _inputBuscaPersona;
  void onInputBuscaPersonaChange(String? text) {
    _inputBuscaPersona = text;
    notifyListeners();
  }

  Future<String?> upLoadImagen(File? newPictureFiles) async {
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

      _listaFotosUrlMultas.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
    }
    for (var item in _listaFotosUrlMultas) {}
    notifyListeners();
  }

  Future<String?> upLoadImagenApelacion(File? newPictureFiles) async {
    final dataUser = await Auth.instance.getSession();

    //for multipartrequest
    var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    //for token
    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

    request.files
        .add(await _http.MultipartFile.fromPath('foto', newPictureFiles!.path));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);

    if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      final fotoUrl = responseFoto.urls[0];
      _listaFotosUrlMultasApelacion.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
    }
    notifyListeners();
  }

  Future<String?> upLoadImagenesApelacion(File? newPictureFiles) async {
    final dataUser = await Auth.instance.getSession();

    //for multipartrequest
    var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    //for token
    request.headers.addAll({"x-auth-token": '${dataUser!.token}'});

    request.files
        .add(await _http.MultipartFile.fromPath('foto', newPictureFiles!.path));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);

    if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      final fotoUrl = responseFoto.urls[0];
      _listaFotosUrlMultasApelaciones.addAll([
        {
          "nombre": responseFoto
              .urls[0].nombre, // al consumir el endpoint => perDocNumero
          "url": responseFoto.urls[0].url
        }
      ]);
    }
    notifyListeners();
  }

  void resetValuesMulta() {
    _listaInfoGuardia.clear();
    _listaFotosUrlMultas.clear();
    // _listaFotosUrlMultasApelacion.clear();
    _listaFotoMulta.clear();
    _listaComparteClienteMultas.clear();
    // _listaFotosUrlMultasApelacion.clear();
    _errorInfoGuardia = false;
    _nomApelacionTexto;
    // _listaFotosUrlMultasApelacion.clear();
    _listaTodosLosPuestosDelCliente.clear();
    setTurnoEmergenteGuardado(false);
    setGuardiaReemplazo(false);
    setDataTurnoEmergente(null);
    _nombreClienteMulta;
    _labelPuestosCliente;
    setLabelPuestosCliente('');
    _listaFotosUrlMultasApelacion = [];
    _idTurnoEmergente = '';
    _pathVideo = '';
    _urlVideo = '';
_guardiaReemplazo = false;
_cedulaGuardia='';
_nombreGuardia='';

// controllerMulta.setDataTurnoEmergente(data);
                // controllerMulta.setIdTurnoEmergente(data['turId'].toString());

_idTurnoEmergente = '';

          


 _idGuardia;
   




    _inputFechaInicio =//'2022-12-21';
       '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraInicio =
        '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
    _inputFechaFin = '';
    // '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    _inputHoraFin = '';
    // '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
_fechaTurnoExtra = {};



 _listaTodasLasMultas = [];




    notifyListeners();
  }

  void resetValuesTurnoEmergente() {
    _labelNuevoPuesto;
    _listaTodosLosPuestosDelCliente.clear();
    notifyListeners();
  }

//================================== BUSCA GUARDIA PARA ASIGNAR MULTA  ==============================//
  List<Guardia> _listaInfoGuardia = [];
  List<Guardia> get getInfoGuardia => _listaInfoGuardia;

  void setInfoGuardia(List<Guardia> data) {
    _listaInfoGuardia = data;
    notifyListeners();
  }

  bool? _errorInfoGuardia; // sera nulo la primera vez
  bool? get getErrorInfoGuardia => _errorInfoGuardia;
  set setErrorInfoGuardia(bool? value) {
    _errorInfoGuardia = value;
  }

  int? _idPersona;
  String? _cedPersona;
  String? _nombrePersona;
  String? get getIdPersona => _cedPersona;
  String? get getCedPersona => _cedPersona;
  String? get getNomPersona => _cedPersona;

  Future<AllGuardias?> s() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInfoGuardias(
      search: _inputBuscaGuardia,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardia = true;
      setInfoGuardia(response.data);
      _idPersona = response.data[0].perId;
      _cedPersona = response.data[0].perDocNumero;
      _nombrePersona =
          '${response.data[0].perNombres}' ' ${response.data[0].perApellidos}';

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardia = false;
      notifyListeners();
      return null;
    }
  }

  bool? _errorInfoCompartirGuardia; // sera nulo la primera vez
  bool? get getErrorInfoCompartirGuardia => _errorInfoCompartirGuardia;
  set setErrorInfoCompartirGuardia(bool? value) {
    _errorInfoCompartirGuardia = value;
  }

  List<Guardia> _listaInfoCompartir = [];
  List<Guardia> get getInfoCompartir => _listaInfoGuardia;

  void setInfoBusquedaCompartirGuardia(List<Guardia> data) {
    _listaInfoCompartir = data;
    notifyListeners();
  }

  int? _idPersonaCompartir;
  String? _cedPersonaCompartir;
  String? _nombrePersonaCompartir;
  String? get getIdPersonaCompartir => _cedPersonaCompartir;
  String? get getCedPersonaCompartir => _cedPersonaCompartir;
  String? get getNombrePersonaCompartir => _cedPersonaCompartir;

  Future<AllGuardias?> buscaCompartirMulta() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInfoGuardias(
      search: _inputBuscaGuardia,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoCompartirGuardia = true;
      setInfoBusquedaCompartirGuardia(response.data);
      _idPersonaCompartir = response.data[0].perId;
      _cedPersonaCompartir = response.data[0].perDocNumero;
      _nombrePersonaCompartir = response.data[0].perNombres;

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoCompartirGuardia = false;
      notifyListeners();
      return null;
    }
  }

  String? _fechaActual;
  get getFechaActul => _fechaActual;

  formatofecha() {
    DateTime? data = DateTime.now().toLocal();
    String? anio, mes, dia;
    anio = '${data.year}';
    mes = (data.month < 10) ? '0${data.month}' : '${data.month}';
    dia = (data.day < 10) ? '0${data.day}' : '${data.day}';

    _fechaActual = '${anio.toString()}-${mes.toString()}-${dia.toString()}';

    _inputFechaMulta = _fechaActual;

    return _fechaActual;
  }

  void getInfomacionGuardia(dynamic guardia) {
    _idPersonaMulta = guardia['perId'];
    _cedPersonaMulta = guardia['perDocNumero'];
    setNomGuardiaMulta(' ${guardia['perApellidos']} ${guardia['perNombres']}');
    _lugarTrabajoPersonaMulta = guardia['perLugarTrabajo'];
    _puestoServicio = guardia['perPuestoServicio'];
    _idClienteMulta = guardia['perIdCliente'];
    _cedClienteMulta = guardia['perDocuCliente'];
    _nombreClienteMulta = guardia['perNombreCliente'];
  }

//================================== OBTENEMOS TODOS LOS PUESTOS DEL CLIENTES ==============================//

  String? _labelNuevoPuesto;

  String? get labelNuevoPuesto => _labelNuevoPuesto;

  void setNuevoPuestos(String? _puestoValor) {
    _labelNuevoPuesto = _puestoValor;
    notifyListeners();
  }

  List _listaTodosLosPuestosDelCliente = [];
  List _listaDatosDelCliente = [];
  List get getDatosDelCliente => _listaDatosDelCliente;

  void setListaInfoDelCliente(List data) {
    _listaDatosDelCliente.add(data);
    notifyListeners();
  }

  List get getListaTodosLosPuestosDelCliente => _listaTodosLosPuestosDelCliente;

  void setListaTodosLosPuestosDelCliente(List data) {
    List _listaDatosDelCliente = data;

    for (var e in data) {
      _listaTodosLosPuestosDelCliente.add(e['puesto']);
    }
    notifyListeners();
  }

  bool? _errorPuestoClientes; // sera nulo la primera vez
  bool? get getErrorPuestoClientes => _errorPuestoClientes;
  Future getTodosLosPuestosDelCliente(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPuestosClientes(
      search: search,
      estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPuestoClientes = true;
      setListaInfoDelCliente(response['data']);
      for (var e in response['data']) {
        setListaTodosLosPuestosDelCliente(e['cliDatosOperativos']);
      }

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPuestoClientes = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  List _listaPuestosCliente = [];
  List get getListaPuestosCliente => _listaPuestosCliente;
  void setListaPuestoCliente(List data) {
    _listaPuestosCliente = data;
    notifyListeners();
  }

  Map<String, dynamic>? _nuevoPuesto;
  dynamic _itemSelect;
  void setLabelINuevoPuesto(String? value) {
    _labelNuevoPuesto = value;

    for (var e in _listaPuestosCliente) {
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

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future creaMultaGuardia(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    infoUser = await Auth.instance.getSession();

    final _pyloadNuevaMulta = {
      "tabla": "nominanovedad", // defecto
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser!.rol, // LOGIN
      "nomCodigo": _idMulta, // datos de la multa, propiedad => novId
      "nomOrigen": _origen, // datos de la multa, propiedad => novOrigen
      "nomTipo": _tipoMulta, // datos de la multa, propiedad => novTipo
      "nomPorcentaje":
          _porcentajeTipoMulta, // datos de la multa, propiedad => novPorcentaje
      "nomSueldo": "",
      "nomDescuento": "",
      "nomDetalle": _textoTipoMulta, //input
      "nomObservacion": _inputDetalleNovedad, //input
      "nomFotos": _listaFotosUrlMultas, //input
      "nomVideo": _listaVideosUrl,
      "nomCompartido": _listaComparteClienteMultas, //input
      "nomEstado": "EN PROCESO", // POR DEFECTO
      "nomCiudad": _lugarTrabajoPersonaMulta, // input
      "nomAnulacion": "", // esto input aparecera si actualiza el estado
      "nomFecha": _inputFechaMulta, // input
      "nomIdPer":
          _idPersonaMulta, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomDocuPer":
          _cedPersonaMulta, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomNombrePer":
          _nombrePersonaMulta, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomPuesto": _puestoServicio,
      "nomUser": infoUser!.usuario, // LOGIN
      "nomEmpresa": infoUser!.rucempresa, // LOGIN
      "nomApelacionTexto": "",
      "nomApelacionFotos": [],
      "nomApelacionFecha": "",
      "nomApelacionTextoAceptada": "",
      "nomApelacionFechaAceptada": "",
      "nomApelacionUserAceptada": "",

      "idAnticipo": [],
      "nomMostrarEnInforme": "NO",


      "nomCorreo": [],
      "nomFecReg": _nomFecReg,
      "Todos": _todos,
      "idTurno": _idTurnoEmergente
    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevaMulta);

    // print('LA DATA DEL JSON DE MULTA ES: $_pyloadNuevaMulta ');


  }

//================================== ACTUALIZA MULTAS  ==============================//
  Future actualizaEstadoMulta(BuildContext context, Result multas) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();
    final _pyloadActualizaEstadoMulta = {
      "tabla": "nominanovedad", // defecto
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser.rol, // LOGIN
      "nomId": multas.nomId, // ID de registro
      "nomCodigo": multas.nomCodigo, // datos de la multa, propiedad => novId
      "nomOrigen":
          multas.nomOrigen, // datos de la multa, propiedad => novOrigen
      "nomTipo": multas.nomTipo, // datos de la multa, propiedad => novTipo
      "nomPorcentaje":
          multas.nomPorcentaje, // datos de la multa, propiedad => novPorcentaje
      "nomDetalle": multas.nomDetalle, //input
      "nomObservacion": multas.nomObservacion, //input
      "nomFotos": multas.nomFotos, //input
      "nomVideo": "", //input
      "nomEstado": "INACTIVA", // POR DEFECTO
      "nomAnulacion":
          _inputAnulacionDeMulta, // esto input aparecera si actualiza el estado
      "nomCiudad": "SANTO DOMINGO", // input
      "nomFecha": multas.nomFecha, // input
      "nomIdPer": multas
          .nomIdPer, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomDocuPer": multas
          .nomDocuPer, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomNombrePer": multas
          .nomNombrePer, // Esto datos tomar de un endpoint(luego que paso el endpoint)
      "nomEmpresa": infoUser.rucempresa, // LOGIN
      "nomUser": infoUser.usuario, // LOGIN
      "nomCorreo": [],
    };
  }

  //================================== ELIMINAR  MULTA  ==============================//
  Future eliminaMultaGuardia(BuildContext context, Result? multaGuardia) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaMultaGuardia = {
      "tabla": "nominanovedad", // defecto
      "nomId": multaGuardia!.nomId,
      "rucempresa": infoUser!.rucempresa, //login
    };
    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaMultaGuardia);
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'nominanovedad') {
        getTodasLasMultasGuardia('', 'false');
        snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
        serviceSocket.socket?.clearListeners();
        notifyListeners();
      }
    });
  }

//======================================================OBTIENE DATOS DEL CLIENTE============================================//

  String? _idClienteMulta;
  String? _cedClienteMulta;
  String? _nombreClienteMulta;

  String? get getIdClienteMulta => _idClienteMulta;
  String? get getCedClienteMulta => _cedClienteMulta;
  String? get getNomClienteMulta => _nombreClienteMulta;

  set setIdCliente(int? id) {
    _idPersonaMulta = id;

    notifyListeners();
  }

  void setCedCliente(String? _ced) {
    _cedClienteMulta = _ced;
    notifyListeners();
  }

  void setNomCliente(String? _name) {
    _nombreClienteMulta = _name;

    notifyListeners();
  }

//======================================================OBTIENE DATOS DEL GUARDIAMULTA============================================//
  int? _idPersonaMulta;
  String? _cedPersonaMulta;
  String? _nombrePersonaMulta;
  String? _lugarTrabajoPersonaMulta;
  List? _puestoServicio = [];

  int? get getIdPersonaMulta => _idPersonaMulta;
  String? get getCedPersonaMulta => _cedPersonaMulta;
  String? get getNomPersonaMulta => _nombrePersonaMulta;
  String? get getlugarTrabajoPersonaMulta => _lugarTrabajoPersonaMulta;
  List? get getPuestoServicio => _puestoServicio;

  set setIdPersonaMulta(int? id) {
    _idPersonaMulta = id;

    notifyListeners();
  }

  set setCedPersonaMulta(String? cedula) {
    _cedPersonaMulta = cedula;

    notifyListeners();
  }

  void setCedTurnoMulta(String? cedula) {
    _cedPersonaMulta = cedula;
    notifyListeners();
  }

  void setNomGuardiaMulta(String? nombre) {
    _nombrePersonaMulta = nombre;

    notifyListeners();
  }

  set setNomPersonaMulta(String? nombre) {
    _nombrePersonaMulta = nombre;

    notifyListeners();
  }

  set setlugarTrabajoPersonaMulta(String? lugarTrabajo) {
    _lugarTrabajoPersonaMulta = lugarTrabajo;

    notifyListeners();
  }

  set setPuestoServicio(List? puestoTrabajo) {
    _puestoServicio = puestoTrabajo;

    notifyListeners();
  }

  //===================LEE CODIGO QR==========================//
  String? _infoQRTurnoMulta;
  String? get getInfoQRMultaGuardia => _infoQRTurnoMulta;

  Future setInfoQRMultaGuardia(String? value) async {
    _infoQRTurnoMulta = value;
    if (_infoQRTurnoMulta != null) {
      _errorInfoMultaGuardia = true;
      final split = _infoQRTurnoMulta!.split('-');
      setIdPersonaMulta = int.parse(split[0]);
      setCedPersonaMulta = split[1];
      setNomPersonaMulta = split[2];
      setlugarTrabajoPersonaMulta = split[2];

      notifyListeners();
    } else {
      _errorInfoMultaGuardia = false;
    }
  }
  //===================INGRESA CODIGO O NOMBRE GUARDIA MULTA==========================//

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaGuardiasMultas;

  @override
  void dispose() {
    _deboucerSearchBuscaGuardiasMultas?.cancel();
    _deboucerSearchBuscaClienteMultas?.cancel();
    super.dispose();
  }

  String? _inputBuscaGuardia;
  get getInputBuscaGuardia => _inputBuscaGuardia;
  void onInputBuscaGuardiaChange(String? text) {
    _inputBuscaGuardia = text;

//================================================================================//
    if (_inputBuscaGuardia!.length >= 3) {
      _deboucerSearchBuscaGuardiasMultas?.cancel();
      _deboucerSearchBuscaGuardiasMultas =
          Timer(const Duration(milliseconds: 500), () {
        buscaGuardiaMultas(_inputBuscaGuardia);
      });
    } else if (_inputBuscaGuardia!.isEmpty) {
      buscaGuardiaMultas('');
    } else {
      buscaGuardiaMultas('');
    }
//================================================================================//

    notifyListeners();
  }

  List<Guardia> _listaInfoMultaGuardia = [];
  List<Guardia> get getListaInfoMultaGuardia => _listaInfoMultaGuardia;

  void setInfoBusquedaMultaGuardia(List<Guardia> data) {
    _listaInfoMultaGuardia = data;
    notifyListeners();
  }

  bool? _errorInfoMultaGuardia; // sera nulo la primera vez
  bool? get getErrorInfoMultaGuardia => _errorInfoMultaGuardia;
  set setErrorInfoMultaGuardia(bool? value) {
    _errorInfoMultaGuardia = value;
    notifyListeners();
  }

  String? _textDocNumDirigidoA = '';
  Future<AllGuardias?> buscaGuardiaMultas(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInfoGuardias(
      search: _search,
      docnumero: _textDocNumDirigidoA,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoMultaGuardia = true;
      setInfoBusquedaMultaGuardia(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoMultaGuardia = false;
      notifyListeners();
      return null;
    }
  }

//================================== OBTENEMOS TODOS LOS CLIENTES ==============================//
  List<InfoCliente> _listaTodosLosClientesMultas = [];
  List<InfoCliente> get getListaTodosLosClientes =>
      _listaTodosLosClientesMultas;

  void setListaTodosLosClientesMultas(List<InfoCliente> data) {
    _listaTodosLosClientesMultas = data;
    // print('data clientes : ${_listaTodosLosClientesMultas}');
    notifyListeners();
  }

  bool? _errorClientesMultas; // sera nulo la primera vez
  bool? get getErrorClientesMultas => _errorClientesMultas;

  Future<AllClientes?> getTodosLosClientesMultas(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllClientesMultas(
      search: search,
      estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorClientesMultas = true;
      setListaTodosLosClientesMultas(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClientesMultas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//  =================  AGREGA CORREOS CLIENTE MULTAS ==================//

  List<dynamic> _listaComparteClienteMultas = [];
  List<dynamic> get getListaCorreosClienteMultas => _listaComparteClienteMultas;

  void setListaCorreosClienteMultas(
      int? id, String? documento, String? nombres, List<dynamic>? correo) {
    _listaComparteClienteMultas.removeWhere((e) => (e['id'] == id));

    _listaComparteClienteMultas.addAll([
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

  void eliminaClienteMulta(int id) {
    _listaComparteClienteMultas.removeWhere((e) => e['id'] == id);
    _listaComparteClienteMultas.forEach(((element) {}));

    notifyListeners();
  }
//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaClienteMultas;

  String? _inputBuscaClienteMultas;
  get getInputBuscaClienteMulta => _inputBuscaClienteMultas;
  void onInputBuscaClienteMultaChange(String? text) {
    _inputBuscaClienteMultas = text;
    // print(' GUARDIA MULTA :$_inputBuscaClienteMultas');

//================================================================================//
    if (_inputBuscaClienteMultas!.length >= 3) {
      _deboucerSearchBuscaClienteMultas?.cancel();
      _deboucerSearchBuscaClienteMultas =
          Timer(const Duration(milliseconds: 500), () {
        getTodosLosClientesMultas(_inputBuscaClienteMultas);
      });
    } else if (_inputBuscaClienteMultas!.isEmpty) {
      getTodosLosClientesMultas('');
    } else {
      getTodosLosClientesMultas('');
    }
//================================================================================//

    notifyListeners();
  }

  //==========================TRABAJAMOS CON VIDEO  ===============================//

  String? _pathVideo = '';
  String? get getPathVideo => _pathVideo;

  void setPathVideoMultas(String? path) {
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
      print("SUCCESS");
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
  }

  void eliminaVideo() {
    _listaVideosUrl.clear();
    _urlVideo = '';
    _pathVideo = '';
    notifyListeners();
  }

//========================================//
  List _listaInfoCliente = [];
  List get getListaInfoCliente => _listaInfoCliente;

  void setInfoBusquedaInfoCliente(List data) {
    _listaInfoCliente = data;
    notifyListeners();
  }

  bool? _errorInfoCliente; // sera nulo la primera vez
  bool? get getErrorInfoCliente => _errorInfoCliente;
  set setErrorInfoCliente(bool? value) {
    _errorInfoCliente = value;
    notifyListeners();
  }

  Future buscaInfoClientes(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllClientesVarios(
      search: _search,
      estado: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoCliente = true;

      setInfoBusquedaInfoCliente(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoCliente = false;
      notifyListeners();
      return null;
    }
  }

  String? _nomApelacionTexto;
  get getInputDetalleApelacion => _nomApelacionTexto;
  void onInputDetalleApelacionChange(String? text) {
    _nomApelacionTexto = text;
    notifyListeners();
  }

//================================== CREA APELACION  ==============================//
  int? _nomId;
  String? _nomCodigo = "";
  String? _nomOrigen = "";
  String? _nomTipo = "";
  String? _nomPorcentaje = "";
  String? _nomSueldo = "";
  String? _nomDescuento = "";
  String? _nomDetalle = "";
  String? _nomObservacion = "";
  List? _nomFotosMultas = [];
  List? _nomVideoMultas = [];
  List? _nomCorreos = [];
  List? _nomCompartido = [];
  // List? _nomPuesto = [];
  List<dynamic>? _nomPuesto = [];
  List<dynamic>? _anticipo = [];

  String? _nomMostrarEnInforme = "NO";
  String? _nomEstado = "";
  String? _nomAnulacion = "";
  String? _nomCiudad = "";
  String? _nomFecha = "";
  String? _nomIdPer = "";
  String? _nomDocuPer = "";
  String? _nomNombrePer = "";
  List? _nomApelacionFotos = [];
  String? _nomApelacionFecha = "";

  String? _nomApelacionTextoAceptada = "";
  String? _nomApelacionFechaAceptada = "";
  String? _nomApelacionUserAceptada = "";
  String? _nomUser = "";
  String? _nomFecReg = "";
  String? _nomEmpresa = "";
  String? _todos = "";

  dynamic _dataMulta;
  get getDataMulta => _dataMulta;
  void getInfomacionMulta(multa) {
    _dataMulta = multa;
    _nomId = multa['nomId'];
    _nomCodigo = multa['nomCodigo'].toString();
    _nomOrigen = multa['nomOrigen'];
    _nomTipo = multa['nomTipo'];
    _porcentajeTipoMulta = multa['nomPorcentaje'];
    _nomSueldo = multa['nomSueldo'];
    _nomDescuento = multa['nomDescuento'];
    _textoTipoMulta = multa['nomDetalle'];
    _inputDetalleNovedad = multa['nomObservacion'];

    for (var e in multa['nomFotos']) {
      _listaFotosUrlMultas.add({"nombre": e['nombre'], "url": e['url']});
    }
    for (var e in multa['nomVideo']) {
      _nomVideoMultas!.add({"nombre": e['nombre'], "url": e['url']});
    }
    for (var e in multa['nomApelacionFotos']) {
      _listaFotosUrlMultasApelacion
          .add({"nombre": e['nombre'], "url": e['url']});
    }

    _nomCorreos = multa['nomCorreo'];
    _nomCompartido = multa['nomCompartido'];
    _nomPuesto = multa['nomPuesto'];
    // print(' pruestooooo: ${multa['nomPuesto'].runtimeType}');
    _nomEstado = multa['nomEstado'];
    _nomAnulacion = multa['nomAnulacion'];
    _nomCiudad = multa['nomCiudad'];
    final fechaTemp = multa['nomFecha']!.toString().substring(0, 10);
    onInputFechaMultaChange(fechaTemp);

    _nomIdPer = multa['nomIdPer'].toString();
    _cedPersonaMulta = multa['nomDocuPer'];
    _nombrePersonaMulta = multa['nomNombrePer'];
    _nomApelacionTexto = multa['nomApelacionTexto'];
    _nomApelacionFotos = multa['nomApelacionFotos'];
    _nomApelacionFecha = multa['nomApelacionFecha'];

    _nomApelacionTextoAceptada = multa['nomApelacionTextoAceptada'];
    _nomApelacionFechaAceptada = multa['nomApelacionFechaAceptada'];
    _nomApelacionUserAceptada = multa['nomApelacionUserAceptada'];


    _anticipo=multa['idAnticipo'];
    _nomMostrarEnInforme=multa['nomMostrarEnInforme'];



    _nomUser = multa['nomUser'];
    _idTurnoEmergente = multa['idTurno'].toString(); // ERROR PARECE QUE SE MODIFICO
    _nomEmpresa = multa['nomEmpresa'];
    _nomFecReg = multa['nomFecReg'].toString();
    _todos = multa['todos'];
  }

  //================================== EDITAR MULTA ==============================//
  Future creaApelacionMulta(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    infoUser = await Auth.instance.getSession();

    final _pyloadCreaApelacionMulta = {
      "tabla": "nominanovedad", // defecto
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser!.rol, // LOGIN

      // ==== DATOS DE APELACION ==== //
      "nomId": _nomId,
      "nomCodigo": _nomCodigo,
      "nomOrigen": _nomOrigen,
      "nomTipo": _nomTipo,
      "nomPorcentaje": _porcentajeTipoMulta,
      "nomSueldo": _nomSueldo,
      "nomDescuento": _nomDescuento,
      "nomDetalle": _textoTipoMulta,
      "nomObservacion": _inputDetalleNovedad,
      "nomFotos": _listaFotosUrlMultas,
      "nomVideo": _nomVideoMultas,
      "nomCompartido": _nomCompartido,
      "nomPuesto": _nomPuesto,
      "nomEstado": 'APELACION',
      "nomAnulacion": _nomAnulacion,
      "nomCiudad": _nomCiudad,
      "nomFecha": _inputFechaMulta,
      "nomIdPer": _nomIdPer,
      "nomDocuPer": _cedPersonaMulta,
      "nomNombrePer": _nombrePersonaMulta,
      "nomApelacionTexto": _nomApelacionTexto,
      "nomApelacionFotos": _listaFotosUrlMultasApelacion,
      "nomApelacionFecha": _nomApelacionFecha,
      "nomApelacionTextoAceptada": _nomApelacionTextoAceptada,
      "nomApelacionFechaAceptada": _nomApelacionFechaAceptada,
      "nomApelacionUserAceptada": _nomApelacionUserAceptada,
      "nomCorreo": _nomCorreos,

      "nomUser": _nomUser,
      "nomEmpresa": _nomEmpresa,
      "nomFecReg": _nomFecReg,
      "Todos": _todos,
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadCreaApelacionMulta);
  }

  //==========================OBTENEMOS LOS DATOS DE LA MULTA ===============================//

  String? get getNomPorcentaje => _nomPorcentaje;
  void setNomPorcentaje(String? _valor) {
    _nomPorcentaje = _nomPorcentaje;
    notifyListeners();
  }

  void getInfoMulta(dynamic multas) {
    _listaFotosUrlMultas = [];
    _nomId = multas.nomId;
    final fechaTemp = multas.nomFecha!.toString().substring(0, 10);
    onInputFechaMultaChange(fechaTemp);
    _nomCodigo = multas.nomCodigo;
    _nomOrigen = multas.nomOrigen;
    _nomTipo = multas.nomTipo;
    _porcentajeTipoMulta = multas.nomPorcentaje;
    _nomSueldo = multas.nomSueldo;
    _nomDescuento = multas.nomDescuento;
    _textoTipoMulta = multas.nomDetalle;
    _inputDetalleNovedad = multas.nomObservacion;
    for (var e in multas.nomFotos!) {
      _listaFotosUrlMultas.addAll([
        {
          "nombre": e.nombre,
          // al consumir el endpoint => perDocNumero
          "url": e.url
        }
      ]);
    }
    for (var e in multas.nomVideo) {
      _nomVideoMultas!.add({"nombre": e['nombre'], "url": e['url']});
    }
    for (var e in multas.nomApelacionFotos) {
      _listaFotosUrlMultasApelacion
          .add({"nombre": e['nombre'], "url": e['url']});
    }
    _nomCompartido = multas.nomCompartido;
    _nomPuesto = multas.nomPuesto;
    _nomEstado = multas.nomEstado;
    _nomAnulacion = multas.nomAnulacion;
    _nomCiudad = multas.nomCiudad;
    _nomIdPer = multas.nomIdPer;
    _cedPersonaMulta = multas.nomDocuPer;
    _nombrePersonaMulta = multas.nomNombrePer;
    _nomApelacionTexto = multas.nomApelacionTexto;
    _nomApelacionFotos = multas.nomApelacionFotos;
    _nomApelacionFecha = multas.nomApelacionFecha;

    _nomApelacionTextoAceptada = multas.nomApelacionTextoAceptada;
    _nomApelacionFechaAceptada = multas.nomApelacionFechaAceptada;
    _nomApelacionUserAceptada = multas.nomApelacionUserAceptada;
    _nomFecReg = multas.nomFecReg.toString();
    _todos = multas.todos;

    notifyListeners();
//********************************/
  }

  void eliminaFotoUrl(String url) {
    _listaFotosUrlMultas.removeWhere((e) => e['url'] == url);
  }

  //============================OBTENEMOS LOS DATOS DEL GUARDIA SELECCIONADO==================================//

  void getInfoGuardiaEdit(dynamic _guardia) {
    _idPersonaMulta = _guardia['perId'];
    _cedPersonaMulta = _guardia['perDocNumero'];
    _nombrePersonaMulta =
        '${_guardia['perNombres']} ${_guardia['perApellidos']}';
    _puestoServicio = _guardia['perPuestoServicio'];
    notifyListeners();
  }

  //================================== EDITAR MULTA ==============================//
  Future editarMultaGuardia(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    infoUser = await Auth.instance.getSession();

    final _pyloadEditaMulta = {
      "tabla": "nominanovedad", // defecto
      "rucempresa": infoUser!.rucempresa, // LOGIN
      "rol": infoUser!.rol, // LOGIN
      "nomId": _nomId,
      "nomCodigo": _nomCodigo,
      "nomOrigen": _nomOrigen,
      "nomTipo": _nomTipo,
      "nomPorcentaje": _porcentajeTipoMulta,
      "nomSueldo": _nomSueldo,
      "nomDescuento": _nomDescuento,
      "nomDetalle": _textoTipoMulta,
      "nomObservacion": _inputDetalleNovedad,
      "nomFotos": _listaFotosUrlMultas,
      "nomVideo": _nomVideoMultas,
      "nomCompartido": _nomCompartido,
      "nomPuesto": _nomPuesto,
      "nomEstado": _nomEstado,
      "nomAnulacion": _nomAnulacion,
      "nomCiudad": _nomCiudad,
      "nomFecha": _inputFechaMulta,
      "nomIdPer": _nomIdPer,
      "nomDocuPer": _cedPersonaMulta,
      "nomNombrePer": _nombrePersonaMulta,
      "nomApelacionTexto": _nomApelacionTexto,
      "nomApelacionFotos": _listaFotosUrlMultasApelacion,
      "nomApelacionFecha": _nomApelacionFecha,
      "nomApelacionTextoAceptada": _nomApelacionTextoAceptada,
      "nomApelacionFechaAceptada": _nomApelacionFechaAceptada,
      "nomApelacionUserAceptada": _nomApelacionUserAceptada,
      "nomUser": _nomUser,
      "nomEmpresa": _nomEmpresa,
      "nomCorreo": _nomCorreos,

       "idAnticipo": _anticipo,
       "nomMostrarEnInforme":_nomMostrarEnInforme,



      "nomFecReg": _nomFecReg,
      "Todos": _todos,
      "idTurno": _idTurnoEmergente
    };
// print('ESTA ES LA DATA====>: ${_pyloadEditaMulta['nomMostrarEnInforme']}');
//   print('ESTA ES LA DATA: ${_pyloadEditaMulta}');

    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaMulta);

    getTodasLasMultasGuardia('', 'false');

    notifyListeners();
  }

  //     '========================== VALIDA BOTONES DE CREAR Y DETALLE DE APELACION ===============================');

  bool _usuarioLogin = false;
  bool _btnDetalleApelacion = false;
  bool _btnCrearApelacioApelacion = false;
  bool get getUsuarioLogin => _usuarioLogin;
  bool get getBotonDetalleApelacion => _btnDetalleApelacion;
  bool get getBotonCrearApelacioApelacion => _btnCrearApelacioApelacion;

  void setUsuarioLogin(bool _estado) {
    _usuarioLogin = _estado;
  }

  void setBotonDetalleApelacion(bool _estado) {
    _btnDetalleApelacion = _estado;
  }

  void setBotonCrearApelacion(bool _estado) {
    _btnCrearApelacioApelacion = _estado;
  }

//===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }
  //===================BOTON SEARCH MORE CLIENTE==========================//

  bool _btnSearchMulta = false;
  bool get btnSearchMulta => _btnSearchMulta;

  void setBtnSearchMulta(bool action) {
    _btnSearchMulta = action;
    notifyListeners();
  }
//====== CAMPO BUSQUEDAS COMPRAS =========//

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    if (_nameSearch.length >= 3) {
      _deboucerSearchBuscaGuardiasMultas?.cancel();
      _deboucerSearchBuscaGuardiasMultas =
          Timer(const Duration(milliseconds: 700), () {
        getTodasLasMultasGuardia(_nameSearch, 'false');
      });
    } else {
      getTodasLasMultasGuardia('', 'false');
    }
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

//==================================//
  //==========================inputs================//
  int? _idGuardia;
  String? _cedulaGuardia='';
  String? _nombreGuardia='';

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
//==================================//

  String _idTurnoEmergente = '';
  String get getIdTurnoEmergente => _idTurnoEmergente;
  void setIdTurnoEmergente(String _value) {
    _idTurnoEmergente = _value;
    notifyListeners();
  }

//=================================ESTADO DE LA MULTA EDITAR===============================================//

  bool? _estadoMulta = false;
  bool? get getEstadoMulta => _estadoMulta;

  void setEstadoMulta(bool estado) {
    _estadoMulta = estado;
    notifyListeners();
  }

  String? _labelNombreEstadoMulta;

  String? get labelNombreEstadoMulta => _labelNombreEstadoMulta;

  void setLabelNombreEstadoMulta(String value) {
    _labelNombreEstadoMulta = value;
    setEstadoMulta(true);
    _nomEstado = value;
    notifyListeners();
  }

//=================================FECHAS TEMPORARES PARA TRABAJAR CON MULTAS Y TURNO===============================================//

  //========================== VALIDA CAMPO  FECHA INICIO TURNO =======================//
  String? _inputFechaInicio =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaInicio => _inputFechaInicio;
  void onInputFechaInicioChange(String? date) {
    _inputFechaInicio = date;

    // var _date = DateTime.parse(_inputFechaInicio.toString());
    // onInputFechaFinChange(
    //     '${_date.year}-${(_date.month) < 10 ? '0${_date.month}' : '${_date.month}'}-${(_date.day) < 10 ? '0${_date.day}' : '${_date.day}'}');

    notifyListeners();
  }

  String? _inputHoraInicio =
      '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
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
    notifyListeners();
  }

// ================================================//

  Map<String, dynamic> _fechaTurnoExtra = {};
  Map<String, dynamic> get getFechaTurnoExtra => _fechaTurnoExtra;
  void setFechaTurnoExtra(Map<String, dynamic> _fecha) {
    _fechaTurnoExtra=_fecha;

print('FECHA SELECCIONADA:$_fechaTurnoExtra');


    notifyListeners();
  }

// ================================================//
Map <String,dynamic> _infoGuardiaVerificaTurno={};
Map <String,dynamic> get getInfoGuardiaVerificaTurno=>_infoGuardiaVerificaTurno;

 void setInfoGuardiaVerificaTurno(Map <String,dynamic> _guardia){
  _infoGuardiaVerificaTurno=_guardia;
print('ESTA ES LA DATA: $_infoGuardiaVerificaTurno');

notifyListeners();

 }




//================================== OBTENEMOS TODOS LAS FALTAS ==============================//

void resetListFaltas()
{   
  _labelFaltas='Diurno';
  _listaTodasLasFaltasInjustificadas = [];
  notifyListeners();
}

  List _listaTodasLasFaltasInjustificadas = [];
  List get getListaFaltasInjustificadas =>
      _listaTodasLasFaltasInjustificadas;

  void setListaTodasLasFaltasInjustificadas(List data) {
    _listaTodasLasFaltasInjustificadas = [];
    _listaTodasLasFaltasInjustificadas = data;
    print('data _listaTodasLasFaltasInjustificadas : ${_listaTodasLasFaltasInjustificadas}');
    notifyListeners();
  }

  bool? _errorFaltasInjustificadas; // sera nulo la primera vez
  bool? get getErrorFaltasInjustificadas => _errorFaltasInjustificadas;

  Future getTodasLasFaltasInjustificadas(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllFaltasInjustificadas(
          token: '${dataUser!.token}',
          tipo: _labelFaltas
    );
    if (response != null) {
      _errorFaltasInjustificadas = true;
      setListaTodasLasFaltasInjustificadas(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorFaltasInjustificadas = false;
      notifyListeners();
      return null;
    }
    return null;
  }

// ================================================//


  //========================== OBTENEMOS LA INFORMACION DE LA LA MULTA =======================//
  dynamic _getInfoFalta;

  dynamic get getInfoFalta => _getInfoFalta;

  void setInfoFalta(dynamic _info) {
    _getInfoFalta = _info;

    notifyListeners();
  }

 //============================================= AGREGAMOS LA UBICACUON Y PUESTO DEL TURNO TURNO====================//
  List<Map<String, dynamic>> _listMultaTurPuesto = [];
  List<Map<String, dynamic>> get getListMultaTurPuesto => _listMultaTurPuesto;

  void setListMultaTurPuesto(Map<String, dynamic> _data) {
    _listMultaTurPuesto.removeWhere((e) => e['id'] == _data['id']);
    _listMultaTurPuesto.addAll([_data]);
    // print('_listMultaTurPuesto  MULTA xxxxxxxxxx  ${_listMultaTurPuesto}');
    notifyListeners();
  }
  void deleteItemTurPuesto(Map<String, dynamic>_item) {
  
    _listMultaTurPuesto.removeWhere((e) => e['id'] == _item['id']);
    //  print('_listTurPuesto CURRENT  ${_listTurPuesto}');

   
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
//========================== DROPDOWN FALTAS DIURNO NOCTURNO =======================//
  String? _labelFaltas='Diurno';

  String? get labelFaltas => _labelFaltas;

  void setLabelFaltas(String value) {
    _labelFaltas = value;
    print('setLabelFaltas *****************> : $_labelFaltas');
    notifyListeners();
  }


//========================== DROPDOWN FALTAS DIURNO NOCTURNO =======================//
  String? _labelMes='';

  String? get labelabelMes => _labelMes;



int? _numeroMes;

  int? get numeroMes => _numeroMes;


  void setLabelMes(String value) {
    _labelMes = value;
    print('_labelMes *****************> : $_labelMes');

   _numeroMes = verificarMes(_labelMes);

  //  print('numero *****************> : $_numeroMes');


    notifyListeners();
  }



//========================== VERIFICA EL MES SELECCIONADO PARA GENERAR EL PDF =======================//
int verificarMes(String? mes) {
  switch (mes) {
    case "Enero":
      return 1;
    case "Febrero":
      return 2;
    case "Marzo":
      return 3;
    case "Abril":
      return 4;
    case "Mayo":
      return 5;
    case "Junio":
      return 6;
    case "Julio":
      return 7;
    case "Agosto":
      return 8;
    case "Septiembre":
      return 9;
    case "Octubre":
      return 10;
    case "Noviembre":
      return 11;
    case "Diciembre":
      return 12;
    default:
      return 0;
  }
}

}
