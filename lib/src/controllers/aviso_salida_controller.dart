import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/lista_allInforme_guardias.dart';
import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/lista_allInforme_guardias.dart';
// import 'package:sincop_app/src/service/socket_service.dart';


class AvisoSalidaController extends ChangeNotifier {
  GlobalKey<FormState> avisoSalidaFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesAvisoSalida() {
    _idGuardia;
    _cedulaGuardia;
    _nombreGuardia = '';
    _inputDetalle;
    _inputFechaAvisoSalida;
    _inputHoraAvisoSalida;
    _listaFotosAvisoSalida.clear();
    _listaFotosUrl!.clear();
    _listaVideosUrl.clear();
    _listaGuardiaInformacion.clear();
    _labelAvisoSalida = '';
    _listFechas.clear();
    _fechaAvisoSalida ='';
    notifyListeners();
  }

  bool validateForm() {
    if (avisoSalidaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  int? _idGuardia;
  String? _cedulaGuardia;
  String? _nombreGuardia;
  String? get nombreGuardia => _nombreGuardia;

  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    // print(_inputDetalle);
    notifyListeners();
  }

//========================== DROPDOWN PERIODO CONSIGNA CLIENTE =======================//
  String? _labelAvisoSalida = '';

  String? get labelAvisoSalida => _labelAvisoSalida;

  void setLabelAvisoSalida(String value) {
    if(value=='RENUNCIA ART 190 CT' ){
       _listFechas.clear();
    }
    _labelAvisoSalida = value;

    notifyListeners();
  }

  //================================== FECHA DEL AVISO  ==============================//
 
  String? _inputFechaAvisoSalida =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
  get getInputfechaAvisoSalida => _inputFechaAvisoSalida;
  void onInputFechaAvisoSalidaChange(String? date) {
    _inputFechaAvisoSalida = date;
    setListFechas(_inputFechaAvisoSalida!);

    notifyListeners();
  }

  String? _inputHoraAvisoSalida =
      '${(DateTime.now().hour) < 10 ? '0${DateTime.now().hour}' : '${DateTime.now().hour}'}:${(DateTime.now().minute) < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'}';
  get getInputHoraAvisoSalida => _inputHoraAvisoSalida;
  void onInputHoraAvisoSalidaChange(String? date) {
    _inputHoraAvisoSalida = date;

    notifyListeners();
  }

//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  int id = 0;
  File? _newPictureFile;
  File? get getNewPictureFile => _newPictureFile;
  List? _listaFotosUrl = [];
  List? get getListaFotosUrl => _listaFotosUrl;

  List<dynamic> _listaFotosAvisoSalida = [];
  List<dynamic> get getListaFotosInforme => _listaFotosAvisoSalida;
  void setNewPictureFile(String? path) {
    _newPictureFile = File?.fromUri(Uri(path: path));
    upLoadImagen(_newPictureFile);
    _listaFotosAvisoSalida
        .add(CreaNuevaFotoAvisoSalida(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotosAvisoSalida.add(CreaNuevaFotoAvisoSalida(id, path));

    notifyListeners();
  }

  void eliminaFoto(int id) {
    _listaFotosAvisoSalida.removeWhere((element) => element!.id == id);

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

  //========================== OBTENEMOS EL PERFIL DE LA PERSONA  ===============================//

  String? _parsona = '';
  String? get getPersona => _parsona;

  void setPersona(String? _person) {
    _parsona = _person;
    print('persona : $_person');
    notifyListeners();
  }
  //==========================TRABAJAMOS CON VIDEO  ===============================//

  String? _pathVideo = '';
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
    for (var item in _listaVideosUrl) {}
  }

  void eliminaVideo() {
    _listaVideosUrl.clear();
    _urlVideo = '';
    _pathVideo = '';
    notifyListeners();
  }

//==================== LISTO TODOS  LOS AVISOS====================//
  List _listaAvisosSalida = [];
  List get getListaAvisosSalida => _listaAvisosSalida;

  void setInfoBusquedaAvisosSalida(List data) {
    _listaAvisosSalida = data;
    notifyListeners();
  }

  bool? _errorAvisosSalida; // sera nulo la primera vez
  bool? get getErrorInformesGuardia => _errorAvisosSalida;
  set setErrorInformesGuardia(bool? value) {
    _errorAvisosSalida = value;
    notifyListeners();
  }

  Future buscaAvisosSalida(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllAvisosSalida(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorAvisosSalida = true;
         List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['nomFecReg']!.compareTo(a['nomFecReg']!));
      setInfoBusquedaAvisosSalida(dataSort);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAvisosSalida = false;
      notifyListeners();
      return null;
    }
  }

//========================================//

  List _listaInfoGuardia = [];

  List get getListaInfoGuardia => _listaInfoGuardia;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardia = [];
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

  Future buscaInfoGuardias(String? _search )async {
    final dataUser = await Auth.instance.getSession();

//  String _persona='';
//   if(dataUser!.rol!.contains('GUARDIA')){
//      _persona="GUARDIAS";

//   }else if(dataUser.rol!.contains('ADMINISTRACION')){
//      _persona="ADMINISTRACION";

//   }



    final response = await _api.getAllGuardias(
      search: _search,
      // estado: 'GUARDIAS',
      estado: '$_parsona',
      // estado: 'ADMINISTRACION',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardia = true;

      setInfoBusquedaInfoGuardia(response['data']);
      // setInfoGuardiaVerificaTurno(response['data']);
    

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

  Timer? _deboucerSearchBuscaGuardias;

  @override
  void dispose() {
    _deboucerSearchBuscaGuardias?.cancel();

    super.dispose();
  }

  String? _inputBuscaGuardia;
  get getInputBuscaGuardia => _inputBuscaGuardia;
  void onInputBuscaGuardiaChange(String? text) {
    _inputBuscaGuardia = text;

    if (_inputBuscaGuardia!.length >= 3) {
      _deboucerSearchBuscaGuardias?.cancel();
      _deboucerSearchBuscaGuardias =
          Timer(const Duration(milliseconds: 700), () {
        buscaInfoGuardias(_inputBuscaGuardia,);
      });
    } else {
      buscaInfoGuardias('');
    }
  }

//================================== CREA NUEVO AVISO  ==============================//

  void getInfomacionGuardia(
      int id, String cedula, String nombre, String apellido) {
    _idGuardia = id;
    _cedulaGuardia = cedula;
    _nombreGuardia = '$apellido $nombre' ;
  }

   String? _fechaAvisoSalida ='';
  Future crearAvisoSalida(BuildContext context) async {
    _fechaAvisoSalida =
      '${DateTime.now().year}-${(DateTime.now().month) < 10 ? '0${DateTime.now().month}' : '${DateTime.now().month}'}-${(DateTime.now().day) < 10 ? '0${DateTime.now().day}' : '${DateTime.now().day}'}';
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    // final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

    // // final turno = jsonDecode(infoUserTurno);

    // // print('usuario TurnoinfoUserTurno :$infoUserTurno');
    // // print('usuario Turno :$turno');
   

    final _pyloadNuevoAvisoSalida = {
      "tabla": "avisosalida", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //login
      "nomTipo": "AVISO SALIDA", // defecto

       "nomId": "",
      "nomIdPersona": _idGuardia,
      "nomDocuPersona": _cedulaGuardia,
      "nomNomPersona": _nombreGuardia,
      "nomMotivo": _labelAvisoSalida,
      "nomDetalle": _inputDetalle,
      "nomStatusDescripcion": "",
      "nomEstado": "EN PROCESO",
      "nomFecReg": "",
			"nomFecUpd": "",
      "nomFecha":_fechaAvisoSalida, //'${_inputFechaAvisoSalida}T$_inputHoraAvisoSalida',
      "nomFotos": _listaFotosUrl,
      "nomVideos": _listaVideosUrl,
      "nomFechas": _listFechas,
			"nomFechasConsultaDB": [],

      "nomUser": infoUserLogin.usuario, // iniciado turno
      "nomEmpresa": infoUserLogin.rucempresa,//login

    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoAvisoSalida);
    // print('INFO DE AVISO DE SALID: $_pyloadNuevoAvisoSalida');
  }

  //================================== ELIMINAR  MULTA  ==============================//
  Future eliminaAvisoSalida(int? idAviso) async {
    final serviceSocket = SocketService();
    final infoUser = await Auth.instance.getSession();
    final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();
    // final turno = jsonDecode(infoUserTurno);
    final _pyloadEliminaAvisoSalida = {
      {
        "tabla": 'avisosalida',
        "rucempresa": infoUser!.rucempresa,
        "nomId": idAviso,
      }
    };

    serviceSocket.socket!
        .emit('client:eliminarData', _pyloadEliminaAvisoSalida);
    buscaAvisosSalida('');
  }

  int? _idAviso;

  dynamic _infoAvisoSalida = '';
  dynamic get getInfoAvisoSalida => _infoAvisoSalida;

  void getDataAvisoSalida(dynamic aviso) {
    _infoAvisoSalida = aviso;
    _idAviso = aviso['nomId'];
    _idGuardia = int.parse(aviso['nomIdPersona'].toString());
    _cedulaGuardia = aviso['nomDocuPersona'];
    _nombreGuardia = aviso['nomNomPersona'];
    _labelAvisoSalida = aviso['nomMotivo'];
    _inputDetalle = aviso['nomDetalle'];
    // _inputFechaAvisoSalida = aviso['nomFecha'];
    _listaVideosUrl = aviso['nomVideos'];
    _listaFotosUrl = aviso['nomFotos'];
    _fechaAvisoSalida = aviso['nomFecha'];
    _listFechas = aviso['nomFechas'];

  //   "nomFecReg": "2023-06-29T22:22:13.000Z",
	// 		"nomFecUpd": "2023-06-29T22:22:13.000Z",

	// "nomFechasConsultaDB": []
    


    notifyListeners();
  }

//========================================================================//
  Future editarAvisoSalida() async {
    final serviceSocket = SocketService();

    final infoUserLogin = await Auth.instance.getSession();
    // final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();
    // final turno = jsonDecode(infoUserTurno);
    final _pyloadEditaAvisoSalida = {
      // "tabla": "avisosalida", // defecto
      // "rucempresa": infoUserLogin!.rucempresa, //login
      // 'nomId': _idAviso,
      // "rol": infoUserLogin.rol, //login
      // "nomTipo": "AVISO SALIDA", // defecto
      // "nomIdPersona": _idGuardia,
      // "nomDocuPersona": _cedulaGuardia,
      // "nomNomPersona": _nombreGuardia,
      // "nomMotivo": _labelAvisoSalida,
      // "nomDetalle": _inputDetalle,
      // "nomEstado": "PENDIENTE",
      // "nomFecha": '${_inputFechaAvisoSalida}T$_inputHoraAvisoSalida',
      // "nomFotos": _listaFotosUrl,
      // "nomVideos": _listaVideosUrl,
      // "nomUser": turno['user'], // iniciado turno
      // "nomEmpresa": infoUserLogin.rucempresa //login



      "tabla": "avisosalida", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //login
      "nomTipo": "AVISO SALIDA", // defecto

       "nomId": _idAviso,
      "nomIdPersona": _idGuardia,
      "nomDocuPersona": _cedulaGuardia,
      "nomNomPersona": _nombreGuardia,
      "nomMotivo": _labelAvisoSalida,
      "nomDetalle": _inputDetalle,
      "nomStatusDescripcion":getInfoAvisoSalida['nomStatusDescripcion'],
      "nomEstado": getInfoAvisoSalida['nomEstado'],
      "nomFecReg": getInfoAvisoSalida['nomFecReg'],
			"nomFecUpd": getInfoAvisoSalida['nomFecUpd'],
      "nomFecha":_fechaAvisoSalida, //'${_inputFechaAvisoSalida}T$_inputHoraAvisoSalida',
      "nomFotos": _listaFotosUrl,
      "nomVideos": _listaVideosUrl,
      "nomFechas": _listFechas,
			"nomFechasConsultaDB": getInfoAvisoSalida['nomFechasConsultaDB'],

      "nomUser": infoUserLogin.usuario, // iniciado turno
      "nomEmpresa": infoUserLogin.rucempresa,//login



    };
 
    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEditaAvisoSalida);
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

//========================================================= SELECCIONA VARIOS GUARDIAS ==============================//

  List _listaGuardiaInformacion = [];
  List get getListaGuardiaInformeacion => _listaGuardiaInformacion;
  void setGuardiaInformacion(dynamic guardia) {
    _listaGuardiaInformacion.removeWhere((e) => (e['id'] == guardia['perId']));

    _listaGuardiaInformacion.add({
      "perPuestoServicio": guardia['perPuestoServicio'],
      "docnumero": guardia['perDocNumero'],
      "nombres": '${guardia['perApellidos']} ${guardia['perNombres']} ',
      "asignado": true,
      "id": guardia['perId'],
      "foto": guardia['perFoto'],
      "correo": guardia['perEmail']
    });
    
    
    print('INFORMACION GUARDIA: $_listaGuardiaInformacion');
    
    notifyListeners();







  }

  void eliminaGuardiaInformacion(int id) {
    _listaGuardiaInformacion.removeWhere((e) => (e['id'] == id));
    _listaGuardiaInformacion.forEach(((element) {}));

    notifyListeners();
  }







//=========================LISTA DE FECHAS================================//
List _listFechas=[];
List get getListFechas=>_listFechas;
 void setListFechas(String _fecha){
  _listFechas.removeWhere((e) => e==_fecha);
_listFechas.add(_fecha);
// print('FECHA AGREGADA; $_listFechas');
notifyListeners();

 }

  void deleteFecha(String _fecha){
_listFechas.removeWhere((e) => e==_fecha);

notifyListeners();

 }

//=========================LISTA DE FECHAS================================//


Map <String,dynamic> _infoGuardiaVerificaTurno={};
Map <String,dynamic> get getInfoGuardiaVerificaTurno=>_infoGuardiaVerificaTurno;

 void setInfoGuardiaVerificaTurno(Map <String,dynamic> _guardia){
  _infoGuardiaVerificaTurno=_guardia;
print('Obtenemos : $_infoGuardiaVerificaTurno ');

notifyListeners();

 }




}
