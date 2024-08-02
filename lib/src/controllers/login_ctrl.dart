// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:nseguridad/src/api/api_provider.dart';
// import 'package:nseguridad/src/api/authentication_client.dart';

// import 'package:nseguridad/src/models/auth_response.dart';
// import 'package:nseguridad/src/models/session_response.dart';


// class LoginController extends ChangeNotifier {
//   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//   final _api = ApiProvider();
//   AuthResponse? _dataLogin;

//   Session? infoUser;

//   bool? _recuerdaCredenciales = true;

//   String? _usuario = "", _clave = "";
//   void onChangeUser(String text) {
//     _usuario = text;
//   }

//   void onChangeClave(String text) {
//     _clave = text;
//   }

//   bool? get getRecuerdaCredenciales => _recuerdaCredenciales;
//   String? get getUsuario => _usuario;
//   String? get getClave => _clave;

//   bool validateForm() {
//     if (loginFormKey.currentState!.validate()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

// //========================== DROPDOWN MOTIVO AUSENCIA =======================//

//   String? _textNombreEmpresa;
//   String? get getlNombreEmpresa => _textNombreEmpresa;

//   void setLabelNombreEmpresa(String value) {
//     _textNombreEmpresa = value;
//     notifyListeners();
//   }

//   //========================== MENU =======================//
//   bool _isOpen = false;
//   int _indexMenu = 0;

//   void onChangeOpen(bool value) {
//     _isOpen = value;

//     notifyListeners();
//   }

//   void onChangeIndex(int index) {
//     _indexMenu = index;

//     notifyListeners();
//   }

//   bool get getIsOpen => _isOpen;
//   int get getIndexMenu => _indexMenu;

//   //========================== CREA TABLA ACTIVIDADES =======================//

//   List<dynamic> tablaActividades = [];
//   String _rondaSave = '';

//   //========================== LOGIN =======================//
//   Future<AuthResponse?> loginApp(BuildContext context) async {
//     List _creddenciales = [];
//     final response = await _api.login(
//         empresa: _textNombreEmpresa!.trim(),
//         usuario: _usuario!.trim(),
//         password: _clave!.trim());

//     if (response != null) {
//       _creddenciales.addAll([
//         '$_recuerdaCredenciales',
//         '$_textNombreEmpresa',
//         '$_usuario',
//         '$_clave'
//       ]);
//       await Auth.instance.deleteDataRecordarme();

//       await Auth.instance.saveSession(response);
//       infoUser = await Auth.instance.getSession();
//       if (_recuerdaCredenciales == true) {
//         await Auth.instance.saveDataRecordarme(_creddenciales);
//       }
//       _dataLogin = response;

//       _rondaSave = jsonEncode(tablaActividades);
//       await Auth.instance.saveRondasActividad(_rondaSave);

//       return response;
//     }
//     if (response == null) {
//       return null;
//     }
//   }

//   //====================================== RECORDAR CLAVE ======================================//
//   void onRecuerdaCredenciales(bool value) {
//     _recuerdaCredenciales = value;
//     notifyListeners();
//   }












// }
