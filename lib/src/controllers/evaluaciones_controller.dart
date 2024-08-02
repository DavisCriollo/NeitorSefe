import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';


class EvaluacionesController extends ChangeNotifier {
//==============inicio el controller ====================//

  GlobalKey<FormState> evaluacionesFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesEvaluaciones() {
    _listaPreguntasEvaluacion = [];
  }

  bool validateForm() {
    if (evaluacionesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//===================BOTON SEARCH EVALUACION==========================//

  bool _btnSearchEva = false;
  bool get btnSearchEva => _btnSearchEva;

  void setBtnSearchEva(bool action) {
    _btnSearchEva = action;
    notifyListeners();
  }

  bool _btnSearchEvaluacion = false;
  bool get btnSearchEvaluacion => _btnSearchEvaluacion;

  void setBtnSearchEvaluacion(bool action) {
    _btnSearchEvaluacion = action;
    notifyListeners();
  }

  String _nameSearchEval = "";
  String get nameSearchEval => _nameSearchEval;

  void onSearchTextEval(String data) {
    _nameSearchEval = data;
    if (_nameSearchEval.length >= 3) {
      _deboucerSearchBuscaEvaluacion?.cancel();
      _deboucerSearchBuscaEvaluacion =
          Timer(const Duration(milliseconds: 700), () {
        buscaEvaluaciones(_nameSearchEval, 'false');
      });
    } else {}
  }

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaEvaluacion;

  @override
  void dispose() {
    _deboucerSearchBuscaEvaluacion?.cancel();
    super.dispose();
  }
//==================== LISTO TODAS LAS EVALUACIONES====================//

  List<Map<String, dynamic>> _listaEvaluaciones = [];
  List<Map<String, dynamic>> get getListaEvaluaciones => _listaEvaluaciones;

  bool? _errorEvaluaciones; // sera nulo la primera vez
  bool? get getErrorEvaluaciones => _errorEvaluaciones;
  set setErrorEvaluaciones(bool? value) {
    _errorEvaluaciones = value;
    notifyListeners();
  }

  Future buscaEvaluaciones(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPreguntas(
      search: _search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorEvaluaciones = true;
      _listaEvaluaciones = [];

      for (var i = 0; i < response['data'].length; i++) {
        if (response['data'][i]['encOption'] == 'EVALUACIONES' &&
            response['data'][i]['docPreguntas'].isNotEmpty) {
          _listaEvaluaciones.add(response['data'][i]);
        }
      }
      _listaEvaluaciones
          .sort((a, b) => b['encFecReg']!.compareTo(a['encFecReg']!));
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorEvaluaciones = false;
      notifyListeners();
      return null;
    }
  }

//====================OBTENEMOS LA INFORMACION DEL LA EVALUACION====================//
  dynamic _getInfoEvaluacion;
  get getInfoEvaluacion => _getInfoEvaluacion;

  List<Map<String, dynamic>> _listaPreguntasEvaluacion = [];
  get getListaPreguntasEvaluacion => _listaPreguntasEvaluacion;

  void getDataEvaluacion(dynamic _data) {
    _getInfoEvaluacion = _data;
    for (var item in _data['docPreguntas']) {
      _listaPreguntasEvaluacion.add(item);
    }
    notifyListeners();
  }

//======================SELECT MULTIPLA TEMPORAL1=========================//
  List _listaSelectMultipleTemp1 = [];
  List get getListaSelectMultipleTemp1 => _listaSelectMultipleTemp1;

  void setListaSelectMultipleTemp1(String _data) {
    _listaSelectMultipleTemp1.removeWhere((e) => e == _data);
    _listaSelectMultipleTemp1.add(_data);
    notifyListeners();
  }

//======================SELECT LISTA TEMPORAL1=========================//
  List _listaSelectTemp1 = [];
  List get getListaSelectTemp1 => _listaSelectTemp1;

  void setListaSelectTemp1(String _data) {
    _listaSelectTemp1.clear();
    _listaSelectTemp1.add(_data);
    notifyListeners();
  }

//======================SELECT LISTA TEMPORAL1=========================//
  List _listaSelectPuntajeTemp1 = [];
  List get getListaSelectPuntajeTemp1 => _listaSelectPuntajeTemp1;

  void setListaSelectPuntajeTemp1(String _value) {
    _listaSelectPuntajeTemp1.clear();
    _listaSelectPuntajeTemp1.add(_value);
    notifyListeners();
  }

//======================ELIMINA SELECT MULTIPLE TEMPORAL1=========================//
  void deleteItemSelectMultipleTemp1(String _val) {
    _listaSelectMultipleTemp1.removeWhere((e) => e == _val);

    notifyListeners();
  }

//=====================  GUARDA ENCUESTA ==========================//
  Future guardaEvaluacion(
      EvaluacionesController controller, dynamic _data) async {
    final infoUserLogin = await Auth.instance.getSession();

    final response = await _api.saveEvaluacion(
        controller: controller, data: _data, token: infoUserLogin!.token);

    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }
//==================================================================//

}
