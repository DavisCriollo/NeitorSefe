// import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart' as Geolocator;
// import 'package:nseguridad/src/api/api_provider.dart';
// import 'package:nseguridad/src/api/authentication_client.dart';
// import 'package:nseguridad/src/models/auth_response.dart';
// import 'package:nseguridad/src/models/session_response.dart';
// import 'package:nseguridad/src/service/notifications_service.dart';
// import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:sincop_app/src/api/api_provider.dart';
// // import 'package:sincop_app/src/api/authentication_client.dart';
// // import 'package:sincop_app/src/models/auth_response.dart';
// // import 'package:sincop_app/src/models/session_response.dart';

// // import 'package:sincop_app/src/service/notifications_service.dart';
// // import 'package:sincop_app/src/service/socket_service.dart';
// import 'package:provider/provider.dart';

// class HomeController extends ChangeNotifier {
//   final _api = ApiProvider();
//   GlobalKey<FormState> homeFormKey = GlobalKey<FormState>();
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   Session? _infoUser;
//   Session? get infoUser => _infoUser;
//   AuthResponse? usuarios;
//   bool validateForm() {
//     if (homeFormKey.currentState!.validate()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool _inciarTurnoCodigo = false;
//   bool get getIniciarTurnoCodigo => _inciarTurnoCodigo;
//   void setIniciarTurno(bool value) {
//     _inciarTurnoCodigo = value;
//     notifyListeners();
//   }
//   //===================BOTON SEARCH CLIENTE==========================//

//   bool _btnSearch = false;
//   bool get btnSearch => _btnSearch;

//   void setBtnSearch(bool action) {
//     _btnSearch = action;
//     notifyListeners();
//   }
//   //===================BOTON SEARCH MORE CLIENTE==========================//

//   bool _btnSearchMore = false;
//   bool get btnSearchMore => _btnSearchMore;

//   void setBtnSearchMore(bool action) {
//     _btnSearchMore = action;
//     notifyListeners();
//   }

//   //  =================  CREO UN DEBOUNCE ==================//

//   Timer? _deboucerSearchCompras;

//   @override
//   void dispose() {
//     _deboucerSearchCompras?.cancel();
//     super.dispose();
//   }

//   String _nameSearch = "";
//   String get nameSearch => _nameSearch;

//   void onSearchText(String data) {
//     _nameSearch = data;
//     if (_nameSearch.length >= 3) {
//       _deboucerSearchCompras?.cancel();
//       _deboucerSearchCompras = Timer(const Duration(milliseconds: 700), () {});
//     } else {}
//   }

//   //===================LEE CODIGO QR==========================//

//   Map<int, String>? _elementoQR = {};
//   String? _infoQRTurno = '';
//   String? get getInfoQRTurno => _infoQRTurno;

//   void setInfoQRTurno(String? value) {
//     _infoQRTurno = '';
//     _infoQRTurno = value;
//     final split = _infoQRTurno!.split('-');
//     _elementoQR = {for (int i = 0; i < split.length; i++) i: split[i]};
//     notifyListeners();
//   }

//   //===================SELECCIONAMOS EL LA OBCION DE INICIAR ACTIVIDADES==========================//
//   int? opcionActividad;

//   int? get getOpcionActividad => opcionActividad;
//   void setOpcionActividad(int? value) {
//     opcionActividad = value;

//     notifyListeners();
//   }

//   String _textoActividad = '';

//   var _itemActividad;
//   get getItemActividad => _itemActividad;
//   get getTextoActividad => _textoActividad;
//   void setItenActividad(value, text) {
//     _itemActividad = value;
//     _textoActividad = text;

//     notifyListeners();
//   }

//   //===================CODIGO DE ACCESO A NOVEDADES==========================//
//   String _textoCodigAccesoTurno = '';
//   String? get getCodigoAccesoNovedades => _textoCodigAccesoTurno;
//   void onChangeCodigoAccesoTurno(String text) {
//     _textoCodigAccesoTurno = text;
//     notifyListeners();
//   }

//   //===================CHECK TERMINOS Y CONDICIONES ==========================//
//   bool _terminosCondiciones = false;
//   bool get getTerminosCondiciones => _terminosCondiciones;

//   void setTerminosCondiciones(bool value) {
//     _terminosCondiciones = value;

//     notifyListeners();
//   }

//   //===================VALIDA BOTON TURNO ==========================//
//   bool? _finalizaTurno;
//   bool? get getFinalizaTurno => _finalizaTurno;

//   void setFinalizaTurno(bool? value) {
//     _finalizaTurno = value;
//     notifyListeners();
//   }

//   bool? _validaBtnTurno;
//   bool? get getValidaBtnTurno => _validaBtnTurno;

//   void setValidaBtnTurno(bool? value) {
//     _validaBtnTurno = value;
//     notifyListeners();
//   }

//   //===================VALIDA BOTON TURNO OK ==========================//
//   bool? _btnTurno;
//   bool? get getBtnTurno => _btnTurno;

//   void setBtnTurno(bool? value) {
//     _btnTurno = value;
//     notifyListeners();
//   }

//   //===================CHECK TERMINOS Y CONDICIONES ==========================//
//   String? _codigoQRTurno;
//   String? get getCodigoQRTurno => _codigoQRTurno;

//   void setCodigoQRTurno(String? value) {
//     _codigoQRTurno = value;

//     notifyListeners();
//   }

//   //=================== IDENTIFICA EL DISPOSITIVO ==========================//
//   String? _tipoDispositivo = '';
//   String? get getTipoDispositivo => _tipoDispositivo;

//   void setTipoDispositivo(String? value) {
//     _tipoDispositivo = value;
//   }

// //========================== GEOLOCATOR =======================//
//   String? _coordenadas = "";
//   Geolocator.Position? _position;
//   Geolocator.Position? get position => _position;
//   String? _selectCoords = "";
//   String? get getCoords => _selectCoords;
//   set setCoords(String? value) {
//     _selectCoords = value;
//     notifyListeners();
//   }

//   Future<bool?> checkGPSStatus() async {
//     final isEnable = await Geolocator.Geolocator.isLocationServiceEnabled();
//     Geolocator.Geolocator.getServiceStatusStream().listen((event) {
//       final isEnable = (event.index == 1) ? true : false;
//     });
//     return isEnable;
//   }

//   Future<void> getCurrentPosition() async {
//     late Geolocator.LocationSettings locationSettings;

//     locationSettings = const Geolocator.LocationSettings(
//       accuracy: Geolocator.LocationAccuracy.high,
//       distanceFilter: 100,
//     );
//     _position =
//         await Geolocator.GeolocatorPlatform.instance.getCurrentPosition();
//     _position = position;
//     _selectCoords = ('${position!.latitude},${position!.longitude}');
//     _coordenadas = _selectCoords;
//     notifyListeners();
//   }

// //================== VALIDA CODIGO QR INICIA TURNO ===========================//
//   Future<void> validaCodigoQRTurno(BuildContext context) async {
//     final serviceSocket = SocketService();

//     _infoUser = await Auth.instance.getSession();
//     final _pyloadDataIniciaTurno = {
//       "tabla": "registro", // info Quemada
//       "rucempresa": _infoUser!.rucempresa, // dato del login
//       "rol": _infoUser!.rol, // dato del login
//       "regId": "", // va vacio
//       "regCodigo": _elementoQR![0], // leer del qr
//       "regRegistro": "QR",
//       "regDocumento": "", // va vacio
//       "regNombres": "", // va vacio
//       "regPuesto": "", // va vacio
//       'regTerminosCondiciones': _terminosCondiciones,
//       "regCoordenadas": {
//         // tomar coordenadas
//         "latitud": position!.latitude,
//         "longitud": position!.longitude,
//       },
//       "regDispositivo": _tipoDispositivo, // DISPOSITIVO
//       "regEstadoIngreso": "INICIADA", // INICIADA O FINALIZADA
//       "regEmpresa": _infoUser!.rucempresa, // dato del login
//       "regUser": _infoUser!.usuario, // dato del login
//       "regFecReg": "", // va vacio
//       "Todos": "" // va vacio
//     };
//   }

// //============================================================ VALIDA INICIA TURNO QR ===========================//

//   Future<void> validaTurnoQR(BuildContext context) async {
//     final serviceSocket = context.read<SocketService>();
//     final infoUser = await Auth.instance.getSession();

//     final _pyloadDataIniciaTurno = {
//       "tabla": "registro", // info Quemada
//       "rucempresa": infoUser!.rucempresa, // dato del login
//       "rol": infoUser.rol, // dato del login
//       "regId": "", // va vacio
//       "regCodigo": infoUser.id, // _textoCodigAccesoTurno, // leer del qr
//       "regDocumento": "", // va vacio
//       "regNombres": "", // va vacio
//       "regPuesto": "", // va vacio
//       'regTerminosCondiciones': _terminosCondiciones,
//       "qrcliente":
//           _infoQRTurno, //SE AGREGA LA INFORMACION QUE SE ESCANE A QR EN LA NUEVA FORMA DEINICIAAR TURNO
//       "regCoordenadas": {
//         // tomar coordenadas
//         "latitud": position!.latitude,
//         "longitud": position!.longitude,
//       },
//       "regRegistro": "CÓDIGO",
//       "regDispositivo": _tipoDispositivo, // tomar coordenadas
//       "regEstadoIngreso": "INICIADA", // INICIADA O FINALIZADA
//       "regEmpresa": infoUser.rucempresa, // dato del login
//       "regUser": infoUser.usuario, // dato del login
//       "regFecReg": "", // va vacio
//       "Todos": "" // va vacio
//     };
//     serviceSocket.socket?.emit('client:guardarData', _pyloadDataIniciaTurno);
//     serviceSocket.socket?.on('server:guardadoExitoso', (data) async {
//       if (data['tabla'] == 'registro') {
//         if (data['regCodigo'] == infoUser.id.toString()) {
//           //====================================//
//           await Auth.instance.saveIdRegistro('${data['regId']}');

//           final datosLogin = {
//             "turno": true,
//             "user": data['regDocumento'],
//           };

//           await Auth.instance.saveTurnoSessionUser(datosLogin);
//           //========INICIO TURNO DE NUEVA NAMERA======//
//           setBotonTurno(true);
//           //====================================//
//         }
//       }
//     });
//   }

// //========================== GUARDA TOKEN DDE LA NOTIFICACION =======================//
//   String? _tokennotificacion;

//   String? get getTokennotificacion => _tokennotificacion;
//   Future? setTokennotificacion(String? id) async {
//     _tokennotificacion = id;
//     sentToken();
//     notifyListeners();
//   }

//   bool? _errorGuardatoken; // sera nulo la primera vez
//   bool? get getErrorGuardatoken => _errorGuardatoken;
//   set setErrorGuardatoken(bool? value) {
//     _errorGuardatoken = value;
//     notifyListeners();
//   }

//   Future sentToken() async {
//     _infoUser = await Auth.instance.getSession();

// if (_infoUser!=null) {
//    final response = await _api.sentIdToken(
//       tokennotificacion: _tokennotificacion,
//       token: infoUser!.token,
//     );

//     if (response != null) {
//       _errorGuardatoken = true;
//       return response;
//     }
//     if (response == null) {
//       _errorGuardatoken = false;
//       notifyListeners();
//       return null;
//     }
// } else {
//     print('NO HAY TOKEN  : ${_infoUser}');
// }

   
//   }

// //==================== Notifiaciones 1====================//

//   int numNotificaciones = 0;
//   int get getNumNotificaciones => numNotificaciones;
//   void setNumNotificaciones(int data) {
//     numNotificaciones = data;
//     notifyListeners();
//   }

//   List _listaNotificacionesPushNoLeidas = [];
//   List get getListaNotificacionesPushNoLeidas =>
//       _listaNotificacionesPushNoLeidas;
//   void setInfoBusquedaNotificacionesPushNoLeidas(List data) {
//     // _listaNotificacionesPushNoLeidas = data;
//     print(
//         '_listaNotificacionesPushNoLeidas : ${_listaNotificacionesPushNoLeidas}');
//     _listaNotificacionesPushNoLeidas = [];
//     _listaNotificacionesPushNoLeidas = data;

//     notifyListeners();
//   }

//   List _listaNotificacionesPush = [];
//   List get getListaNotificacionesPush => _listaNotificacionesPush;
//   void setInfoBusquedaNotificacionesPush(List data) {
//     _listaNotificacionesPush = [];
//     _listaNotificacionesPush = data;
//     //  print('object : ${_idsNotificacionActividades}');
//     notifyListeners();
//   }

//   void cuentaNotificacionesNOLeidas() {
//     numNotificaciones = 0;
//     if (_listaNotificacionesPush.isNotEmpty) {
//       _listaNotificacionesPush.forEach(((e) {
//         if (e['notVisto'] == 'NO') {
//           numNotificaciones = numNotificaciones + 1;
//         } else {
//           numNotificaciones = 0;
//         }
//         notifyListeners();
//       }));
//     }
//   }


// void resetNotificaciones()
// {
//     _listaNotificacionesPush = [];
//      _cuentaNotificacionesPush2 = [];
//      numNotificaciones = 0;
//      numNotificaciones2 = 0;
//      _idsNotificacionActividades = [];
// notifyListeners();

// }
// //==============================ID NOTIFICACIONES ACTIVIDADES=============================//
//   List _idsNotificacionActividades = [];

//   List get getListaIdNotificacionActividades => _idsNotificacionActividades;

//   void setIdsNotificacionesActividades(int _listIds) {
//     _idsNotificacionActividades.removeWhere((e) => e == _listIds);
//     _idsNotificacionActividades.add(_listIds);
//     //  print('object : ${_idsNotificacionActividades}');
//     notifyListeners();
//   }

// //==============================ID NOTIFICACIONES ACTIVIDADES=============================//
//   List _idsNotificacionComunicados = [];

//   List get getListaIdNotificacionComunicados => _idsNotificacionComunicados;

//   void setIdsNotificacionesComunicados(int _listIds) {
//     _idsNotificacionComunicados.removeWhere((e) => e == _listIds);
//     _idsNotificacionComunicados.add(_listIds);
//     //  print('object : ${_idsNotificacionActividades}');
//     notifyListeners();
//   }

//   bool? _errorNotificacionesPush; // sera nulo la primera vez
//   bool? get getErrorNotificacionesPush => _errorNotificacionesPush;
//   set setErrorNotificacionesPush(bool? value) {
//     _errorNotificacionesPush = value;
//     notifyListeners();
//   }

//   Future buscaNotificacionesPush(String? _search) async {
//     final dataUser = await Auth.instance.getSession();
//     final response = await _api.getAllNotificacionesPush(
//       token: '${dataUser!.token}',
//     );
//     if (response != null) {
// // print('response notificacion 1 si: ${response['data']}');
//       if (response['data'].length > 0) {
//         _errorNotificacionesPush = true;

//         for (var item in response['data']['notificacion1']) {
//           if (item['notTipo'] == 'ACTIVIDAD') {
//             setIdsNotificacionesActividades(item['notId']);
//           }
//         }

//         for (var item in response['data']['notificacion1']) {
//           if (item['notEmpresa'] == dataUser.rucempresa) {
//             setInfoBusquedaNotificacionesPush(
//                 response['data']['notificacion1']);
//             cuentaNotificacionesNOLeidas();
//             notifyListeners();
//           }
//         }

//         return response;
//       }
//     }
//     if (response == null) {
//       _errorNotificacionesPush = false;
//       notifyListeners();
//       return null;
//     }
//   }

// // //=========================NOTIFICACION 2==================================//
//   int numNotificaciones2 = 0;
//   int get getNumNotificaciones2 => numNotificaciones2;
//   void setNumNotificaciones2(int data) {
//     numNotificaciones2 = data;
//     notifyListeners();
//   }

//   List _listaNotificacionesPush2NoLeidas = [];
//   List get getListaNotificaciones2PushNoLeidas =>
//       _listaNotificacionesPush2NoLeidas;
//   void setlistaNotificacionesPush2NoLeidas(List data) {
//     _listaNotificacionesPush2NoLeidas = [];
//     _listaNotificacionesPush2NoLeidas = data;
//     notifyListeners();
//   }

// // //============ CONTADOR DE NOTIFICACIONES_2 NO LEIDAS =======//
//   List<dynamic> _cuentaNotificacionesPush2 = [];
//   List<dynamic> get getCuentaNotificacionesPush2 => _cuentaNotificacionesPush2;

//   void cuentaNotificacionesNOLeidas2() {
//     numNotificaciones2 = 0;
//     if (_listaNotificacionesPush2.isNotEmpty) {
//       _listaNotificacionesPush2.forEach(((e) {
//         if (e['notVisto'] == 'NO') {
//           numNotificaciones2 = numNotificaciones2 + 1;
//         } else {
//           numNotificaciones2 = 0;
//         }
//         notifyListeners();
//       }));
//     }
//   }

// // //===========================================================//

//   List _listaNotificacionesPush2 = [];
//   List get getListaNotificacionesPush2 => _listaNotificacionesPush2;
//   void setListaNotificacionesPush2(List data) {
//     _listaNotificacionesPush2 = [];
//     _listaNotificacionesPush2 = data;
//     notifyListeners();
//   }

//   bool? _errorNotificacionesPush2; // sera nulo la primera vez
//   bool? get getErrorNotificacionesPush2 => _errorNotificacionesPush2;
//   set setErrorNotificacionesPush2(bool? value) {
//     _errorNotificacionesPush2 = value;

//     notifyListeners();
//   }

//   Future buscaNotificacionesPush2(String? _search) async {
//     final dataUser = await Auth.instance.getSession();
//     final response = await _api.getAllNotificacionesPush2(
//       token: '${dataUser!.token}',
//     );
//     if (response != null) {
//       _errorNotificacionesPush2 = true;

//       //  print('response notificacion 2: ${response['data']}');

//       if (response['data'].length > 0) {
//         for (var item in response['data']['notificacion2']) {
//           if (item['notTipo'] == 'COMUNICADO') {
//             setIdsNotificacionesComunicados(item['notId']);
//           }
//         }

//         for (var item in response['data']['notificacion2']) {
//           if (item['notEmpresa'] == dataUser.rucempresa) {
//             setListaNotificacionesPush2(response['data']['notificacion2']);
//             cuentaNotificacionesNOLeidas2();
//             setInfoNotificacionAlerta(response['data']['notificacion2']);
//           }
//         }

//         return response;
//       } else {
//         _listaNotificacionesPush2 = [];
//         numNotificaciones2 = 0;
//       }
//     }
//     if (response == null) {
//       _errorNotificacionesPush2 = false;
//       return null;
//     }
//     notifyListeners();
//   }

//   //====================== LEER LA NOTIFICACION_1
//   Future leerNotificacionPush(dynamic notificacion) async {
//     final serviceSocket = SocketService();
//     final infoUserLogin = await Auth.instance.getSession();
//     final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

//     final _pyloadNotificacionPushLeida = {
//       "tabla": "notificacionleido", // defecto
//       "rucempresa": infoUserLogin!.rucempresa, //login
//       "rol": infoUserLogin.rol, //login
//       "notId": notificacion['notId'],
//       "notTipo": notificacion['notTipo'],
//       "notVisto": notificacion['notVisto'],
//       "notIdPersona": notificacion['notIdPersona'],
//       "notDocuPersona": notificacion['notDocuPersona'],
//       "notNombrePersona": notificacion['notNombrePersona'],
//       "notFoto": notificacion['notFoto'],
//       "notRol": notificacion['notRol'],
//       "notTitulo": notificacion['notTitulo'],
//       "notContenido": notificacion['notContenido'],
//       "notUser": notificacion['notUser'],
//       "notNotificacionPertenece": notificacion['notNotificacionPertenece'],
//       "notEmpresa": notificacion['notEmpresa'],

//       "notInformacion": notificacion['notTipo'] == 'ACTIVIDAD'
//           ? {
//               "conAsunto": notificacion['notInformacion']['conAsunto'],
//               "actDesde": notificacion['notInformacion']['actDesde'],
//               "actHasta": notificacion['notInformacion']['actHasta'],
//               "actFrecuencia": notificacion['notInformacion']['actFrecuencia'],
//               "actPrioridad": notificacion['notInformacion']['actPrioridad'],
//               "actDiasRepetir": notificacion['notInformacion']['actDiasRepetir']
//             }
//           : {
//               "conAsunto": notificacion['notInformacion']['conAsunto'],
//               "conDesde": notificacion['notInformacion']['conDesde'],
//               "conHasta": notificacion['notInformacion']['conHasta'],
//               "conFrecuencia": notificacion['notInformacion']['conFrecuencia'],
//               "conPrioridad": notificacion['notInformacion']['conPrioridad'],
//               "conDiasRepetir": notificacion['notInformacion']['conDiasRepetir']
//             },
//       "notFecReg": notificacion['notFecReg']
//     };
//     serviceSocket.socket!
//         .emit('client:actualizarData', _pyloadNotificacionPushLeida);
//   }

//   //====================== LEER LA NOTIFICACION_2
//   Future leerNotificacion2Push(dynamic notificacion) async {
//     List documentosexpirados = [];
//     final serviceSocket = SocketService();
//     final infoUserLogin = await Auth.instance.getSession();
//     final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

//     final _pyloadNotificacion2PushLeida = {
//       "tabla": "notificacionleido", // defecto
//       "rucempresa": infoUserLogin!.rucempresa, //login
//       "rol": infoUserLogin.rol, //login
//       "notId": notificacion['notId'],
//       "notTipo": notificacion['notTipo'],
//       "notVisto": notificacion['notVisto'],
//       "notIdPersona": notificacion['notIdPersona'],
//       "notDocuPersona": notificacion['notDocuPersona'],
//       "notNombrePersona": notificacion['notNombrePersona'],
//       "notFoto": notificacion['notFoto'],
//       "notRol": notificacion['notRol'],
//       "notTitulo": notificacion['notTitulo'],
//       "notContenido": notificacion['notContenido'],
//       "notUser": notificacion['notUser'],
//       "notNotificacionPertenece": notificacion['notNotificacionPertenece'],
//       "notEmpresa": notificacion['notEmpresa'],
//       "notInformacion": {
//         "documentosexpirados": [
//           {
//             "namearchivo": "certificadoafisexpira",
//             "fecha": "2022-03-23",
//             "url":
//                 "https://backsigeop.neitor.com/PAZVISEG/documentos/17d72c93-586d-4986-b317-0140560dc3df.pdf"
//           },
//           {
//             "namearchivo": "antecedentepenalesexpira",
//             "fecha": "2022-03-23",
//             "url":
//                 "https://backsigeop.neitor.com/PAZVISEG/documentos/2a80ac7e-00fc-48d4-ad92-14b5c12b1180.pdf"
//           },
//           {
//             "namearchivo": "certificadomedicoexpira",
//             "fecha": "2022-03-23",
//             "url":
//                 "https://backsigeop.neitor.com/PAZVISEG/documentos/c9adeb69-41db-4023-bebf-bb8f83f9b56e.pdf"
//           }
//         ]
//       },

//       "notFecReg": notificacion['notFecReg']
//     };
//     serviceSocket.socket!
//         .emit('client:actualizarData', _pyloadNotificacion2PushLeida);
//   }

//   // '========================== LEER LA NOTIFICACION GENERICA ===============================');

//   //====================== LEER LA NOTIFICACION_2 ==================//
//   Future leerNotificacionPushGeneric(dynamic notificacion) async {
//     final serviceSocket = SocketService();
//     final infoUserLogin = await Auth.instance.getSession();
//     final infoUserTurno = await Auth.instance.getTurnoSessionUsuario();

//     if (notificacion['notTipo'] == 'MULTA') {}

//     final _payloadNotificacionGeneric = {
//       {
//         "tabla": "notificacionleido",
//         "notId": notificacion['notId'],
//         "notTipo": notificacion['notTipo'],
//         "rucempresa": infoUserLogin!.rucempresa,
//         "rol": infoUserLogin.rol,
//         "notVisto": notificacion['notVisto'],
//         "notIdPersona": notificacion['notIdPersona'],
//         "notDocuPersona": notificacion['notDocuPersona'],
//         "notNombrePersona": notificacion['notNombrePersona'],
//         "notFoto": notificacion['notFoto'],
//         "notRol": notificacion['notRol'],
//         "notTitulo": notificacion['notTitulo'],
//         "notContenido": notificacion['notContenido'],
//         "notUser": notificacion['notUser'],
//         "notNotificacionPertenece": notificacion['notNotificacionPertenece'],
//         "notEmpresa": notificacion['notEmpresa'],
//         "notInformacion": notificacion['notInformacion'],
//         "notFecReg": notificacion['notFecReg']
//       }
//     };

//     serviceSocket.socket!
//         .emit('client:actualizarData', _payloadNotificacionGeneric);
//   }

//   //====================== SE ENVIA ALERTA ==================//
//   Future enviaAlerta() async {
//     final serviceSocket = SocketService();
//     Session? infoUserLogin;
//     infoUserLogin = await Auth.instance.getSession();

//     final status = await Permission.location.request();
//     if (status == PermissionStatus.granted) {
//       await getCurrentPosition();
//     }
//     if (status == PermissionStatus.denied ||
//         status == PermissionStatus.restricted ||
//         status == PermissionStatus.permanentlyDenied ||
//         status == PermissionStatus.limited) {
//       openAppSettings();
//     }
//     final List<String> latlong = _coordenadas!.split(",");
//     final _pyloadEnviaAlerta = {
//       "usuario": '${infoUserLogin!.usuario}',
//       "rol": infoUserLogin.rol,
//       "rucempresa": '${infoUserLogin.rucempresa}',
//       "coordenadas": {"longitud": latlong[0], "latitud": latlong[1]}
//     };
//     serviceSocket.socket!.emit('client:alerta', _pyloadEnviaAlerta);
//   }

//   RemoteMessage? payloadAlerta;

//   RemoteMessage? get getPayloadAlerta => payloadAlerta;
//   void setPayloadAlerta(RemoteMessage? paylad) {
//     payloadAlerta = paylad;
//     notifyListeners();
//   }

// //========================== ELIMINA TOKEN DE LA NOTIFICACION =======================//
//   String? _tokennotificacionDelete;

//   String? get getTokennotificacionDelete => _tokennotificacionDelete;
//   Future? setTokennotificacionDelete(String? id) {
//     _tokennotificacionDelete = id;
//     sentToken();
//     notifyListeners();
//     return null;
//   }

//   bool? _errorGuardatokenDelete; // sera nulo la primera vez
//   bool? get getErrorGuardatokenDelete => _errorGuardatokenDelete;
//   set setErrorGuardatokenDelete(bool? value) {
//     _errorGuardatokenDelete = value;
//     notifyListeners();
//   }

//   Future sentTokenDelete() async {
//     final dataUser = await Auth.instance.getSession();
//     final String? firebase = await Auth.instance.getTokenFireBase();
//     final response = await _api.deleteTokenFirebase(
//       tokennotificacion: firebase,
//       token: dataUser!.token,
//     );

//     if (response != null) {
//       _errorGuardatokenDelete = true;

//       return response;
//     }
//     if (response == null) {
//       _errorGuardatokenDelete = false;
//       notifyListeners();
//       return null;
//     }
//   }

// // ============== ACTIVAMOS EL BOTON DE INICIAR TURNO ================//

//   bool? _btnIniciaTurno = false;
//   bool? get getBtnIniciaTurno => _btnIniciaTurno;

//   void setBtnIniciaTurno(bool? value) async {
//     if (value == false) {
//       await Auth.instance.deleteTurnoSesion();
//       _btnIniciaTurno = false;
//       notifyListeners();
//     } else {
//       _btnIniciaTurno = true;
//       notifyListeners();
//     }
//     notifyListeners();
//   }

// //==================FINALIZA TURNO ===========================//
//   Future<void> finalizarTurno(BuildContext context) async {
//     final serviceSocket = context.read<SocketService>();
//     final infoUser = await Auth.instance.getSession();
//     final idRegistro = await Auth.instance.getIdRegistro();

//     final _pyloadDataFinaizaTurno = {
//       "tabla": "registro", // info Quemada
//       "rucempresa": infoUser!.rucempresa, // dato del login
//       "regId": idRegistro, // va vacio
//       "qrcliente": _infoQRTurno,
//       "coordenadasFinalizar": {
//         "latitud": position!.latitude,
//         "longitud": position!.longitude,
//       }
//     };
//     serviceSocket.socket
//         ?.emit('client:actualizarData', _pyloadDataFinaizaTurno);
//     serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
//       if (data['tabla'] == 'registro') {
//         //================= FINALIZO TURNO DE NUEVA FORMA ===================//
//         setBotonTurno(false);
//       }
//     });
//     serviceSocket.socket?.on('server:error', (data) async {
//       NotificatiosnService.showSnackBarError(data['msg']);
//     });
//   }

// //========ESTE BOTON INICIA Y FINALIZA TURNO ======//
//   bool _botonTurno =
//       false; //POR DEFECTO ES FALSE  SE CAMBIO A TRUE PARA SEGUIR AVANZANDO
//   bool get getBotonTurno => _botonTurno;
//   void setBotonTurno(bool estado) {
//     _botonTurno = estado;
//     // print( 'es turno es: $_botonTurno');
//     notifyListeners();
//   }

// //========VERIFICAMOS SI HAY TURNO EN EL SERVIDOR  ======//

//   bool? _getTestTurno; // sera nulo la primera vez
//   bool? get getgetTestTurno => _getTestTurno;
//   void setGetTestTurno(bool? value) {
//     _getTestTurno = value;
//     // print( '_getTestTurno ++++ > : $_botonTurno');
//     notifyListeners();
//   }

//   bool? _errorRefreshToken; // sera nulo la primera vez
//   bool? get getErrorRefreshToken => _errorRefreshToken;
//   set setErrorRefreshToken(bool? value) {
//     _errorRefreshToken = value;

//     notifyListeners();
//   }

//   Future getValidaTurnoServer() async {
//     final dataUser = await Auth.instance.getSession();
//     print('token Usuario${dataUser!.token}');

//     final response = await _api.revisaTokenTurno(
//       token: dataUser.token,
//     );

//     if (response != null) {
//       _errorRefreshToken = true;
//       setGetTestTurno(true);
//       if (response['data'].length > 0) {
//         await Auth.instance.deleteIdRegistro();
//         await Auth.instance.saveIdRegistro('${response['data']['regId']}');
//         setBotonTurno(true);
//       } else {
//         setBotonTurno(false);
//       }

//       return response;
//     }
//     if (response == null) {
//       _errorRefreshToken = false;
//       notifyListeners();
//       return null;
//     }
//   }

//   bool? _tieneInternet;
//   bool? get getTieneInternet => _tieneInternet;

//   void setTieneInternet(bool? estado) {
//     _tieneInternet = estado;
//     if (_tieneInternet == true) {
//       setBotonTurno(true);
//     } else if (_tieneInternet == false) {
//       setBotonTurno(false);
//     }
//     notifyListeners();
//   }

// //====== VALIDA LA SESION DEL USUARIO ==========//

//   Future validaInicioDeSesion(BuildContext context) async {
//     final dataUser = await Auth.instance.getSession();
//     final response = await _api.validaTokenUsuarios(
//       token: dataUser!.token,
//     );

//     if (response != null) {
//       return response;
//     }
//     if (response == null) {
//       await Auth.instance.deleteSesion(context);

//       return null;
//     }
//   }

// //=======================LEE LA NTIFICACION DEL ALERTA========================//
//   dynamic _leeNotificacionAlerta;
//   dynamic get getInfoNotificacionAlerta => _leeNotificacionAlerta;

//   void setInfoNotificacionAlerta(dynamic _notificacion) {
//     _leeNotificacionAlerta = _notificacion;
//   }
// //============================================================================//

//   Session? _usuarioInfo;
//   Session? get getUsuarioInfo => _usuarioInfo;

//   void setUsuarioInfo(Session? _user) {
//     _usuarioInfo = _user;
//     // notifyListeners();
//   }

// //================LATITUD LONGITUD========================//
//   double _latitud = 0;
//   double _longitud = 0;

//   double get getLatitud => _latitud;
//   double get getLongitud => _longitud;

//   void setLatLong(double _lat, double _long) {
//     _latitud = _lat;
//     _longitud = _long;
//     print('LA DTA  $_latitud - $_longitud');
//   }

// //============================================================================//

//   List _listaRolesPago = [];
//   List get getListaRolesPago => _listaRolesPago;

//   void setListaRolesPago(List data) {
//     _listaRolesPago = [];
//     _listaRolesPago.addAll(data);
//     // print('LA DATA DE LOS ROLES: ******> $_listaRolesPago');
//     notifyListeners();
//   }

//   bool? _errorRolesPago; // sera nulo la primera vez
//   bool? get getErrorRolesPago => _errorRolesPago;
//   set setErrorRolesPago(bool? value) {
//     _errorRolesPago = value;
//     notifyListeners();
//   }

//   Future buscaRolesPago() async {
//     final dataUser = await Auth.instance.getSession();
//     final response = await _api.getAllRolesPago(
//       token: '${dataUser!.token}',
//     );
//     if (response != null) {
//       // print('ROLES : ${response['data']}');
//       setListaRolesPago(response['data']);
//       _errorRolesPago = true;

//       notifyListeners();
//       return response;
//     }
//     if (response == null) {
//       _errorRolesPago = false;
//       notifyListeners();
//       return null;
//     }
//   }

// //=================================GESTION DOCUMENTAL===========================================//

//   List _listaGestionDocumentaEnviados = [];
//   List get getListaGestionDocumentalEnviados => _listaGestionDocumentaEnviados;

//   void setListaGestionDocumentaEnviados(List data) {
//     _listaGestionDocumentaEnviados = [];
//     _listaGestionDocumentaEnviados.addAll(data);
//     print(
//         'LA DATA DE LOS _listaGestionDocumentaEnviados: ******> ${_listaGestionDocumentaEnviados.length}');
//     notifyListeners();
//   }

//   List _listaGestionDocumentalRecibidos = [];
//   List get getListaGestionDocumentalRecibidos =>
//       _listaGestionDocumentalRecibidos;

//   void setListaGestionDocumentaRecibidos(List data) {
//     _listaGestionDocumentalRecibidos = [];
//     _listaGestionDocumentalRecibidos.addAll(data);
//     print(
//         'LA DATA DE LOS _listaGestionDocumentaRecibidos: ******> ${_listaGestionDocumentalRecibidos.length}');
//     notifyListeners();
//   }

//   bool? _errorGestionDocumentalEnviados; // sera nulo la primera vez
//   bool? get getErrorGestionDocumentalEnviados =>
//       _errorGestionDocumentalEnviados;
//   void setErrorGestionDocumentalEnviados(bool? value) {
//     _errorGestionDocumentalEnviados = value;
//     notifyListeners();
//   }

//   bool? _errorGestionDocumentalRecibidos; // sera nulo la primera vez
//   bool? get getErrorGestionDocumentalRecibidos =>
//       _errorGestionDocumentalRecibidos;
//   void setErrorGestionDocumentalRecibidos(bool? value) {
//     _errorGestionDocumentalRecibidos = value;
//     notifyListeners();
//   }

//   Future buscaGestionDocumental(String? _search, String? _estado) async {
//     final dataUser = await Auth.instance.getSession();
//     final response = await _api.getAllGestionDocumental(
//       search: _search,
//       estado: _estado,
//       token: '${dataUser!.token}',
//     );

//     if (response != null && _estado == 'ENVIADO') {
//       // print('ROLES : ${response['data']}');
//           List dataSort = [];
//       dataSort = response['data'];
//       dataSort.sort((a, b) => b['actaFecReg']!.compareTo(a['actaFecReg']!));
//       setListaGestionDocumentaEnviados(dataSort);
//       setErrorGestionDocumentalEnviados(true);

//       notifyListeners();
//       return response;
//     }
//     if (response != null && _estado == 'RECIBIDO') {
//       // print('ROLES : ${response['data']}');

//       setListaGestionDocumentaRecibidos(response['data']);
//       setErrorGestionDocumentalRecibidos(true);

//       notifyListeners();
//       return response;
//     }

//     if (response == null && _estado == 'ENVIADO') {
//       _errorGestionDocumentalEnviados = false;
//       notifyListeners();
//       return null;
//     }
//     if (response == null && _estado == 'RECIBIDO') {
//       _errorGestionDocumentalEnviados = false;
//       notifyListeners();
//       return null;
//     }
//   }

// //============================================================================//
//   int _selectedTabIndex = 0;

//   int get selectedTabIndex => _selectedTabIndex;

//   set selectedTabIndex(int index) {
//     _selectedTabIndex = index;
//     if (index == 0) {
//       resetListasGestion();
//       buscaGestionDocumental('', 'ENVIADO');
//     }
//     if (index == 1) {
//          resetListasGestion();
//       buscaGestionDocumental('', 'RECIBIDO');
//     }
//     notifyListeners();
//   }
// //============================================================================//
// void resetListasGestion(){
//     _listaGestionDocumentaEnviados = [];
//     _listaGestionDocumentalRecibidos = [];
//     notifyListeners();
// }

// //============================CARGAR CUALQUIER TIPO DE ARCHIVO================================================//
// String? _filePath;

//   String? get filePath => _filePath;

//   void setFilePath(String path) {
//     _filePath = path;
//     notifyListeners();
//   }










// }
