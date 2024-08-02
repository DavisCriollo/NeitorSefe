import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';

class PasswordController extends ChangeNotifier {
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();
  final _api = ApiProvider();
  String _usuario = "";
  String _empresa = "";

  void onChangeUser(String text) {
    _usuario = text;
  }

  void onChangeEmpresa(String text) {
    _empresa = text;
  }

  bool validateForm() {
    if (formKeyPassword.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//========================== RECUPERA CLAVE =======================//
  Future passwordRecovery() async {
    final response =
        await _api.recuperaClave(empresa: _empresa, usuario: _usuario);
    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }
}
