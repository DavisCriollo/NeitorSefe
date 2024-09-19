import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crear_foto_comunicado_guardia.dart';
import 'package:nseguridad/src/models/lista_allComunicados_clientes.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/service/notifications_service.dart' as snaks;

import 'package:provider/provider.dart';
// import 'package:sincop_app/src/api/api_provider.dart';

// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crear_foto_comunicado_guardia.dart';
// import 'package:sincop_app/src/models/lista_allComunicados_clientes.dart';
// import 'package:sincop_app/src/service/notifications_service.dart' as snaks;
// import 'package:sincop_app/src/service/socket_service.dart';


class AvisosController extends ChangeNotifier {
  GlobalKey<FormState> comunicadosClienteFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> comunicadosRespondeFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  AvisosController() {
    getTodosLosComunicadosClientes('');
  }

  bool validateForm() {
    if (comunicadosClienteFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
  bool validateFormResponde() {
    if (comunicadosRespondeFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool _estadoComunicado = false;
  int? _itemComunicado = 0;
  get getItemComunicado => _itemComunicado;

  bool get getEstadoComunicado => _estadoComunicado;
  void setEstadoComunicado(bool value, int item) {
    _estadoComunicado = value;
    _itemComunicado = item;

    notifyListeners();
  }

  String? _asunto;
  void onChangeAsunto(String? text) {
    _asunto = text;
  }

  String? _detalle;
  void onChangeDetalle(String? text) {
    _detalle = text;
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

  //  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchCompras;

  @override
  void dispose() {
    _deboucerSearchCompras?.cancel();
    super.dispose();
  }

  String _nameSearch = "";
  String get nameSearch => _nameSearch;

  void onSearchText(String data) {
    _nameSearch = data;
    if (_nameSearch.length >= 3) {
      _deboucerSearchCompras?.cancel();
      _deboucerSearchCompras = Timer(const Duration(milliseconds: 700), () {
        getTodosLosComunicadosClientes(_nameSearch);
      });
    } else {
      getTodosLosComunicadosClientes('');
    }
  }

  //================================== CAMBIAMOS EL ESTADO DEL SWITCH BOTTON ==============================//

  bool _estadoSwith = false;
  bool get getEstadoSwith => _estadoSwith;
  void setEstadoSwith(bool value) {
    _estadoSwith = _estadoSwith;

    notifyListeners();
  }

  //================================== OBTENEMOS TODOS LOS COMUNICADOS  ==============================//
  List<Result> _listaTodosLosComunicadosCliente = [];
  List<Result> get getListaTodosLosComunicadosCliente =>
      _listaTodosLosComunicadosCliente;

  void setListaTodosLosComunicadosCliente(List<Result> data) {
    _listaTodosLosComunicadosCliente = data;

    notifyListeners();
  }

  bool? _error; // sera nulo la primera vez
  bool? get getError => _error;

  Future getTodosLosComunicadosClientes(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllComunicadosClientes(
      cantidad: 100,
      page: 0,
      search: search,
      input: 'comId',
      orden: false,
      datos: '',
      rucempresa: '${dataUser!.rucempresa}',
      token: '${dataUser.token}',
    );

    if (response != null) {
      _error = true;
      setListaTodosLosComunicadosCliente(response.data.results);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _error = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  //==================================+++++++++++++++++++++++++++++++ OBTENEMOS TODOS LOS AVISOS  =====++++++++++++++++++++++++++++++++++++++++++++=========================//
  List<dynamic> _listaTodosLosAvisos = [];
  List<dynamic> get getListaTodosLosAvisos => _listaTodosLosAvisos;

  void setListaTodosLosAvisos(List<dynamic> data) {
    data.sort((a, b) => b['aviFecReg'].compareTo(a['aviFecReg']));
    _listaTodosLosAvisos = data;


        // print('TENEMOS DATA:$_listaTodosLosAvisos');


    notifyListeners();
  }

  bool? _errorTodosLosAvisos; // sera nulo la primera vez
  bool? get getErrorTodosLosAvisos => _error;

  Future<dynamic> getTodosLosAvisos(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllComunicados(
      search: search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorTodosLosAvisos = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['aviFecReg']!.compareTo(a['aviFecReg']!));

      setListaTodosLosAvisos(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorTodosLosAvisos = false;
      notifyListeners();
      return null;
    }
    return null;
  }

  //================================== FECHA Y HORA DEL COMUNICADO  ==============================//
  String? _inputFechaFinComunicado;
  get getInputfechaFinComunicado => _inputFechaFinComunicado;
  void onInputFechaFinComunicadoChange(String? date) {
    _inputFechaFinComunicado = date;
    notifyListeners();
  }

  String? _inputHoraFinComunicado;
  get getInputHoraFinComunicado => _inputHoraFinComunicado;
  void onInputHoraFinComunicadoChange(String? date) {
    _inputHoraFinComunicado = date;
    notifyListeners();
  }

  String? _inputFechaInicioComunicado;
  get getInputfechaInicioComunicado => _inputFechaInicioComunicado;
  void onInputFechaInicioComunicadoChange(String? date) {
    _inputFechaInicioComunicado = date;

    notifyListeners();
  }

  String? _inputHoraInicioComunicado;
  get getInputHoraInicioComunicado => _inputHoraInicioComunicado;
  void onInputHoraInicioComunicadoChange(String? date) {
    _inputHoraInicioComunicado = date;

    notifyListeners();
  }

  //================================== CREA NUEVO COMUNICADO  ==============================//
  Future creaComunicadoCliente(
    BuildContext context,
  ) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadNuevoComunicado = {
      "tabla": "comunicado", // defecto
      "comId": "",
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login
      "comClienteId": infoUser.id, // id login
      "comClienteNombre": infoUser.nombre, //login nombre
      "comAsunto": _asunto,
      "comDetalle": _detalle,
      "comEstado": 'ACTIVA', // defecto
      "comFotos": [],
      "comLeidos": [], //vacio
      "comEmpresa": infoUser.rucempresa, //login
      "comUser": infoUser.usuario, //login
    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoComunicado);
    serviceSocket.socket!.on(
      'server:guardadoExitoso',
      (data) async {
        if (data['tabla'] == 'comunicado') {
          getTodosLosComunicadosClientes('');
          snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
          // serviceSocket.socket?.clearListeners();
          notifyListeners();
        }
      },
    );
  }

  //================================== EDITAR  COMUNICADO  ==============================//
  Future editaComunicadoCliente(
      BuildContext context, Result? comunicado) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadEditaComunicado = {
      "tabla": "comunicado", // defecto
      "comId": comunicado!.comId,
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login
      "comClienteId": infoUser.id, // id login
      "comClienteNombre": infoUser.nombre, //login nombre
      "comAsunto": _asunto,
      "comDetalle": _detalle,
      "comEstado": comunicado.comEstado, // defecto
      "comLeidos": comunicado.comLeidos,
      "comFotos": comunicado.comFotos, //vacio
      "comEmpresa": infoUser.rucempresa, //login
      "comUser": infoUser.usuario, //login
    };

    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaComunicado);
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado') {
        getTodosLosComunicadosClientes('');
        snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
        notifyListeners();
      }
    });
  }

  //================================== EDITAR  COMUNICADO  ==============================//
  Future cambiaEstadoComunicadoCliente(
      BuildContext context, Result? comunicado) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadCambiaEstadoComunicadoCliente = {
      "tabla": "comunicado", // defecto
      "comId": comunicado!.comId,
      "rucempresa": infoUser!.rucempresa, //login
      "rol": infoUser.rol, // login
      "comClienteId": infoUser.id, // id login
      "comClienteNombre": infoUser.nombre, //login nombre
      "comAsunto": comunicado.comAsunto,
      "comDetalle": comunicado.comDetalle,
      "comEstado":
          (comunicado.comEstado == 'ACTIVA') ? 'INACTIVA' : 'ACTIVA', // defecto
      "comLeidos": [], //vacio
      "comEmpresa": infoUser.rucempresa, //login
      "comUser": infoUser.usuario, //login
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadCambiaEstadoComunicadoCliente);
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado') {
        getTodosLosComunicadosClientes('');
        notifyListeners();
      }
    });
  }

  //================================== ELIMINAR  COMUNICADO  ==============================//
  Future eliminaComunicadoCliente(
      BuildContext context, Result? comunicado) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaComunicado = {
      "tabla": "comunicado", // defecto
      "comId": comunicado!.comId,
      "rucempresa": infoUser!.rucempresa, //login
    };
    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaComunicado);
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado') {
        getTodosLosComunicadosClientes('');
        snaks.NotificatiosnService.showSnackBarSuccsses(data['msg']);
        notifyListeners();
      }
    });
  }

  //================================== LEE  COMUNICADO  ==============================//
  Future comunicadoLeidoGuardia(
      int? _idComunicado, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadComunicadoLeidoGuardia = {
      "tabla": "avisoleido",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "aviId": _idComunicado,
      "aviIdPersona": infoUser.id,
      "aviNombrePersona": infoUser.nombre,
      "aviUser": infoUser.rucempresa,
    };

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadComunicadoLeidoGuardia);
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;

  List<CreaNuevaFotoComunicadoGuardia?> _listaFotos = [];
  List<CreaNuevaFotoComunicadoGuardia?> get getListaFotos => _listaFotos;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    _listaFotos.add(CreaNuevaFotoComunicadoGuardia(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotos.removeWhere((element) => element!.id == id);

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
    setNewPictureFile(pickedFile.path);
  }

  String? _itemFechaRegistro = '';
  String? get getItemFechaRegistro => _itemFechaRegistro;
  String? _itemAsunto = '';
  String? get getItemAsunto => _itemAsunto;
  String? _itemEmpresa = '';
  String? get getItemEmpresa => _itemEmpresa;
  String? _itemDetalle = '';
  String? get getItemDetalle => _itemDetalle;


dynamic _comunicado;
dynamic get getComunicado=>_comunicado;
  void getInfoComunicado(dynamic _com) {

    // print('comunicado : ${comunicado['aviId']}');
_comunicado=_com;
notifyListeners();
  }
  //================================== RESPONDER COMUNICADO  ==============================//
  String? _inputRespondeComunicado;
  get getInputRespondeComunicado => _inputRespondeComunicado;
  void onInputRespondeComunicadoChange(String? date) {
    _inputRespondeComunicado = date;
    notifyListeners();
  }
//=======================================================================================================//

  //================================== LEE  COMUNICADO  ==============================//
  Future respondeComunicado(
      int? _idComunicado, BuildContext context) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadRespondeComunicado = {


      "tabla": "respuestacomunicado",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol,
      "aviId": _idComunicado,
      "aviIdPersona": infoUser.id,
      "respuestaTexto": _inputRespondeComunicado,
     


   


    };
    // print('LA DATA QUE ENVIO $_pyloadRespondeComunicado');

    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadRespondeComunicado);
  }







}
