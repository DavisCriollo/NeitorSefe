

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_fotos.dart';
// import 'package:sincop_app/src/models/foto_url.dart';
// import 'package:sincop_app/src/models/session_response.dart';
import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:sincop_app/src/service/socket_service.dart';
// import 'package:sincop_app/src/utils/fecha_local_convert.dart';

class NuevoPermisoController extends ChangeNotifier {
  GlobalKey<FormState> permisoFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

void resetVariablePermisos(){
_idFechas=[];
  _labelMotivoAusencia ='';
  _infoPersona={};
  _listaInfoGuardia = [];
  _errorInfoGuardia;
   _inputBuscaGuardia;
   _listaDiasPermiso= [];
   _isCheckedList=[] ;
   idDiasLaborablesValidados=[];
   _newPictureFile;
_listaFotosUrl = [];
_listaFotosCrearInforme = [];
_listaPersonasReemplazo.clear();


  notifyListeners();
}

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaTurno;

  @override
  void dispose() {
    _deboucerSearchBuscaTurno?.cancel();
      _deboucerSearchBuscaGuardias?.cancel();
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
        buscaNuevosPermisos(_nameSearch, 'false');
      });
    } else {
      buscaNuevosPermisos('', 'false');
    }
  }



//==================== LISTO TODOS  LOS CAMBIOS DE PUESTO====================//
  List _listaPermisos = [];
  List get getListaPermisos => _listaPermisos;

  void setInfoBusquedaPermisos(List data) {

_listaPermisos = [];
  _listaPermisos = data;
// print('NUEVO PERMISO: $_listaPermisos');

  
    notifyListeners();
  }

  bool? _errorPermisos; // sera nulo la primera vez
  bool? get getErrorPermisos => _errorPermisos;
  set setErrorPermisos(bool? value) {
    _errorPermisos = value;
    notifyListeners();
  }

  Future buscaNuevosPermisos(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllNuevosPermisos(
      search: _search,
      // notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorPermisos = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['permiFecReg']!.compareTo(a['permiFecReg']!));

      setInfoBusquedaPermisos(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPermisos = false;
      notifyListeners();
      return null;
    }
  }

  bool validateForm() {
    if (permisoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
//========================== DROPDOWN MOTIVO AUSENCIA =======================//
  String? _labelMotivoAusencia='';

  String? get labelMotivoAusencia => _labelMotivoAusencia;

  void setLabelMotivoAusencia(String value) {
    _labelMotivoAusencia = value;
    notifyListeners();
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


//**************  OBTIENE LA INFORMACION DEA PERSONA ******************//

Map<String,dynamic> _infoPersona={};

Map<String,dynamic> get getInfoPersona=>_infoPersona;


void setInfoPersona(Map<String,dynamic> _info){
_infoPersona={};
_infoPersona=_info;
//  print('persona: $_infoPersona');



  notifyListeners();
}

//**************  OBTIENE LA LISTA DE PERSONAS ******************//
 List _listaInfoGuardia = [];

  List get getListaInfoGuardia => _listaInfoGuardia;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardia = [];
    _listaInfoGuardia = data;
  

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

   final response = await _api.getAllPersonasNuevo(
      search: _search,
      // estado: 'GUARDIAS',
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

//**************  OBTIENE LA LISTA DE DIAS  ******************//
 List _listaDiasPermiso= [];

  List get getListaDiasPermiso=> _listaDiasPermiso;

  void setListaDiasPermiso(data) {
    _listaDiasPermiso= [];
    _listaDiasPermiso= data;

    print('LISTA LOS DIAS : $_listaDiasPermiso');
  

    notifyListeners();
  }

  bool? _errorDiasPermiso; // sera nulo la primera vez
  bool? get getErrorDiasPermiso=> _errorDiasPermiso;
  void setErrorDiasPermisobool (value) {
    _errorDiasPermiso= value;
    notifyListeners();
  }

  Future buscaDiasPermiso(int? _id )async {
    final dataUser = await Auth.instance.getSession();

   final response = await _api.getAllHorario(
      id: _id,
      // estado: 'GUARDIAS',
      // estado: 'ADMINISTRACION',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorDiasPermiso= true;

      setListaDiasPermiso(response['data']);
      // setDiasPermisoerificaTurno(response['data']);
    

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorDiasPermiso= false;
      notifyListeners();
      return null;
    }
  }

//**************SELECCIONA EL CHECK*****************//




//  List<bool> _isCheckedList = List.generate(100, (index) => false);

//   List<bool> get isCheckedList => _isCheckedList;

//   void toggleChecked(int index) {
//     _isCheckedList[index] = !_isCheckedList[index];
//     notifyListeners();
//   }



// final int _cantidadHorario=0;

// int get getCantidadHorarios=>_cantidadHorario;

// void setCantidadHorarios(int _info){

// _cantidadHorario=_info;

//   notifyListeners();
// }
List<bool> _isCheckedList=[] ;
void listaCountHoras(args) {
  _isCheckedList=[] ;
_isCheckedList=List.generate(int.parse(args), (index) => false);
  notifyListeners();
}



  List<Map<String,dynamic>> _selectedItemsFechas = [];
  void resetListFechas(){
_selectedItemsFechas.clear();
    notifyListeners();
  }

  List<bool> get isCheckedList => _isCheckedList;
   List<Map<String,dynamic>> get selectedItemsFechas => _selectedItemsFechas;

  void toggleChecked(int index,Map<String,dynamic> _data) {
    _isCheckedList[index] = !_isCheckedList[index];

    if (_isCheckedList[index]) {
      _selectedItemsFechas.addAll([_data]);
    } else {
      // _selectedItemsFechas.remove(index);
      _selectedItemsFechas.removeWhere((e) => e['id']==_data['id']);
    }


// print('los datos agregados; $_selectedItemsFechas');

    notifyListeners();
  }

 void deleteFechaDePermiso(Map<String,dynamic> _data)
  {
      _selectedItemsFechas.removeWhere((e) => e['id']==_data['id']);
    notifyListeners();
  }




//**************  OVERIFICA DIAS HABILES  ******************//
//  List _listaDiasPermiso= [];

//   List get getListaDiasPermiso=> _listaDiasPermiso;

//   void setListaDiasPermiso(data) {
//     _listaDiasPermiso= [];
//     _listaDiasPermiso= data;

//     print('LISTA LOS DIAS : $_listaDiasPermiso');
  

//     notifyListeners();
//   }

//   bool? _errorDiasPermiso; // sera nulo la primera vez
//   bool? get getErrorDiasPermiso=> _errorDiasPermiso;
//   void setErrorDiasPermisobool (value) {
//     _errorDiasPermiso= value;
//     notifyListeners();
//   }
     List idDiasLaborablesValidados=[];
     List get getIdDiasLaborablesValidados=>idDiasLaborablesValidados;
     List _idFechas=[];
  Future validaDiasHabiles(BuildContext context)async {
    final dataUser = await Auth.instance.getSession();

_idFechas=[];

    for (var item in _selectedItemsFechas) {

_idFechas.add(item['id']);
      
    }





   final response = await _api.getAllDiasHabiles(
    context: context,
      idFechas: _idFechas,
          token: '${dataUser!.token}',
    );
    if (response != null) {
          if (response.statusCode == 200) {
       idDiasLaborablesValidados=_selectedItemsFechas;
        return response;
      }
     
    if (response.statusCode == 404 ||response.statusCode == 500) {
        
      
        return response;
    
    }
    if (response.statusCode != 404 ||response.statusCode != 500) {
        
      
        return null;
    
    }
      
    

    }    
    if (response == null) {
      // _errorDiasPermiso= false;
      notifyListeners();
      return null;
    }
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
        .add(CreaNuevaFotoNewPermiso(id, _newPictureFile!.path));
    id = id + 1;
    notifyListeners();
  }

  void setEditarFoto(int id, String path) {
    _listaFotosCrearInforme.add(CreaNuevaFotoNewPermiso(id, path));

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
      imageQuality: 50,
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



  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }


//*************INFORMACION DEL PUESTO ESCOGIDO******************//

  Map<String,dynamic> _infoPuestoSeleccionado = {};
    Map<String,dynamic> get getInfoPuestoSeleccionado => _infoPuestoSeleccionado;
  void setInfoPuestoSeleccionado(Map<String,dynamic> _data){
    _infoPuestoSeleccionado = {};
_infoPuestoSeleccionado=_data;
// print('_infoPuestoSeleccionado :$_infoPuestoSeleccionado');
    notifyListeners();
  }

 
 

//***********   CREAR PERMIDO *******************//

Future crearPermiso(BuildContext context) async {
    final serviceSocket = SocketService();
  final infoUserLogin = await Auth.instance.getSession();

final List _idTurnos=[];


for (var item in getListaPersonasReemplazo) {
   
   _idTurnos.add(item['turnId']);
  //  print('idTurnos :$_idTurnos');
   
  
}
//  print('idTurnos :$getListaPersonasReemplazo');

final _pyloadNuevPermiso = {
      "tabla": "permiso", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin

 "permiIdPersona": _infoPuestoSeleccionado['id_persona'], // valor de la propiedad id_persona
  "permiIdDOperativo": _infoPuestoSeleccionado['id_dOperativo'], // valor de la propiedad id_dOperativo
  "permiIdMulta": 0, // default
  "permiMotivo": _labelMotivoAusencia, //verificar en anterior formulario
  "permiEstado": "", // vacio
  "permiDetalle":_inputDetalle , //textarea
  "permiStatusDescripcion": "", // vacio
  "permiDocumento": "", // vacio
  "permiUser": infoUserLogin.usuario, //login
  "permiEmpresa": infoUserLogin.rucempresa, // login
  "permiIdsTurnoExtra": _idTurnos, // vacio de momento, esto llenara del id de los turnos extras
  "permiIdsJornadaLaboral": _idFechas, // valor del id del array horarios
  "permitFotos":_listaFotosUrl

};

//  print('_pyloadNuevPermiso :$_pyloadNuevPermiso');

 serviceSocket.socket!.emit('client:guardarData', _pyloadNuevPermiso);

}

//*******************************//


// List<String> _selectedFechas = [];

//   List<String> get selectedFechas => _selectedFechas;


//    void resetListaSelectedFecha(){
//     _selectedFechas.clear();
//     notifyListeners();
//    }

//   void toggleSelectedFecha(String fecha) {
//     if (_selectedFechas.contains(fecha)) {
//       _selectedFechas.remove(fecha);
//     } else {
//       _selectedFechas.add(fecha);
//     }


//     print('FECHAS : $_selectedFechas');

//     notifyListeners();
//   }

//   void deleteFechaDeReemplazo(String fecha)
//   {
//       _selectedFechas.remove(fecha);
//     notifyListeners();
//   }

  List<Map<String, dynamic>> _selectedFechas = [];

  List<Map<String, dynamic>> get selectedFechas => _selectedFechas;

  void resetListaSelectedFecha() {
    _selectedFechas.clear();
    notifyListeners();
  }

  void toggleSelectedFecha(Map<String, dynamic> fecha) {
    if (_selectedFechas.contains(fecha)) {
       _selectedFechas.removeWhere((e) => e['id']==fecha['id']);
    } else {
      _selectedFechas.add(fecha);
    }

    // print('FECHAS : $_selectedFechas');

    notifyListeners();
  }

  void deleteFechaDeReemplazo(Map<String, dynamic> fecha) {
    _selectedFechas.removeWhere((e) => e['id']==fecha['id']);
    notifyListeners();
  }



//************** LISTA DE PERSONAS QUE REEEMPLAZAN AL PERMISO***************//

  List<Map<String, dynamic>> _listaPersonasReemplazo = [];
 List<Map<String, dynamic>> get getListaPersonasReemplazo =>_listaPersonasReemplazo;
void setListaPersonasReemplazo(Map<String, dynamic> _persona) {
    _listaPersonasReemplazo.add(_persona);

// print('LA DATA SELECCIONADA $_listaPersonasReemplazo');

    notifyListeners();
  }

bool verificarFechaEnLista(String fechaBuscada) {
  // Itera sobre la lista de turnos
  for (var turno in _listaPersonasReemplazo) {
    // Obtén la sublista de fechas (dias)
    List fechas = turno['dias'];

    // Itera sobre la sublista de fechas
    for (var fecha in fechas) {
      // Obtén la fecha de inicio de cada día

      //***********TRANFORMA FECHA************/
       // Parsea la cadena de fecha a un objeto DateTime
  DateTime fechaBase = DateTime.parse(fecha['fecha_inicio']);

  // Extrae la fecha sin la información de la hora y minutos
  String fechaLocal = "${fechaBase.year}-${_formatNumero(fechaBase.month)}-${_formatNumero(fechaBase.day)}";

   
      // print('fechaLocal: $fechaLocal ---- fechaBuscada: $fechaBuscada ');
      // Verifica si la fecha buscada coincide con la fecha de inicio
      if (fechaLocal == fechaBuscada) {
        return true; // La fecha está en la lista
      }
    }
    
  }

  return false; // La fecha no está en la lista
}

String _formatNumero(int numero) {
  // Formatea el número para agregar un cero adelante si es menor a 10
  return numero < 10 ? '0$numero' : '$numero';
}






//**********************************//

// void verificaFurnosCompletos(){


// for (var item in idDiasLaborablesValidados) {


  



bool verificaTurnosCompletos() {
List _fechaPermiso=[];
 for (var fecPer in idDiasLaborablesValidados) {
  // print('_fechaPermiso: $fecPer');
  //  for (var item in fecPer) {
     _fechaPermiso.add(fecPer['fecha_inicio']);
  //  }
    
 }
List _fechaReemplazo=[];
 for (var fecRec in _listaPersonasReemplazo) {
  // print('_fechaPermiso: $fecRec');
  // print('_fechaPermiso: $fecPer');
   for (var item in fecRec['dias']) {

 DateTime fechaBase = DateTime.parse(item['fecha_inicio']);

//   // Extrae la fecha sin la información de la hora y minutos
  String fechaReemp = "${fechaBase.year}-${_formatNumero(fechaBase.month)}-${_formatNumero(fechaBase.day)}";
   
     _fechaReemplazo.add(fechaReemp);
   }
    
 }

// print('_fechaPermiso: $_fechaPermiso');
// print('_fechaReemplazo: $_fechaReemplazo');


//************************************//
// Verifica si ambas listas tienen la misma longitud
  if (_fechaPermiso.length != _fechaReemplazo.length) {
    return false;
  }

  // Utiliza el método every para comparar cada elemento de ambas listas
  return _fechaPermiso.every((element) => _fechaReemplazo.contains(element)) &&
      _fechaReemplazo.every((element) => _fechaPermiso.contains(element));

}






//==================== LISTO INFORMACION DEL GUARDIA  QR====================//

List<Map<String, dynamic>> _idsTurnosEmergente = [];
  List<Map<String, dynamic>> get getIdsTurnosEmergente => _idsTurnosEmergente;

  void setIdsTurnoEmergente(Map<String, dynamic> _value) {
    _idsTurnosEmergente
        .removeWhere((element) => element['fechas'] == _value['fechas']);

    _idsTurnosEmergente.add(_value);
    print('ESTA ES LA DATA DE  LOS ID; $_idsTurnosEmergente');

    // sumaDias();
  

    notifyListeners();
  }

List  _guardiasReemplatoPermiso = [];
  List  get getGuardiasReemplatoPermiso => _guardiasReemplatoPermiso;


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
    final response = await _api.getGuardiasReemplazoPermiso(
      listaIds: _listaIds,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaGuardiasReemplazo = true;
      // print('la data RESPONSE:${response['data']}');
      // setInfolistaGuardiasReemplazo(response['idTurno']);
      // for (var item in response['data']) {
      //   //  print('ITEM:${item['turNomPersona']}');
      //   //  print('ITEM:${item['turFechasConsultaDB']}');
      //   _guardiasReemplatoPermiso.clear();

      //   // _idsTurnosEmergente.addAll([
      //   //   {
      //   //     "turId": item['turId'],
      //   //     "turIdPersona": item['turIdPersona'],
      //   //     "turDocuPersona": item['turDocuPersona'],
      //   //     "turNomPersona": item['turNomPersona'],
      //   //     "fechas": item['turFechasConsultaDB'],
      //   //     "numDias": item['turDiasTurno']
      //   //   }
      //   // ]);
      // }
      print('LOS REEMPLAZOS API :${response}');
      _guardiasReemplatoPermiso=response;
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaGuardiasReemplazo = false;
      notifyListeners();
      return null;
    }
  }


  String? _estadoAusencia = "EN PROCESO";
  String? get getEstadoAusencia => _estadoAusencia;
  void setEstadoAusencia(String? text) {
    _estadoAusencia = text;
    notifyListeners();
  }

  int? _idAusencia;

  dynamic _getInfoAusencia;
  dynamic get getInfoAusencia => _getInfoAusencia;
  // String? _ausenciaEstadoDescripcion = '';
  void getDataAusencia(dynamic ausencia) {
    _getInfoAusencia = ausencia;

//  print('iINFO PERMISO -----> :$_getInfoAusencia');
notifyListeners();
  }












}