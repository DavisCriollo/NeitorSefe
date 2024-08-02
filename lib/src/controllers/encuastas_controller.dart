import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';


class EncuestasController extends ChangeNotifier {
  GlobalKey<FormState> encuestasFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  void resetValuesEncuestas() {
    _listaPreguntasEncuesta = [];
  }

  bool validateForm() {
    if (encuestasFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//===================BOTON SEARCH ENCUASTAS==========================//

  bool _btnSearchEnc = false;
  bool get btnSearch => _btnSearchEnc;

  void setBtnSearch(bool action) {
    _btnSearchEnc = action;
    notifyListeners();
  }

  bool _btnSearchEncuastas = false;
  bool get btnSearchEncuastas => _btnSearchEncuastas;

  void setBtnSearchEncuastas(bool action) {
    _btnSearchEncuastas = action;
    notifyListeners();
  }

  String _nameSearchEncuastas = "";
  String get nameSearchEnc => _nameSearchEncuastas;

  void onSearchTextEncuesta(String data) {
    _nameSearchEncuastas = data;
    if (_nameSearchEncuastas.length >= 3) {
      _deboucerSearchBuscaEncuasta?.cancel();
      _deboucerSearchBuscaEncuasta =
          Timer(const Duration(milliseconds: 700), () {
        // print('=====> $data');
        buscaEncuestas(_nameSearchEncuastas, 'false');
      });
    } else {
      // buscaAusencias('', 'false');
    }
    // notifyListeners();
  }

//  =================  CREO UN DEBOUNCE ==================//

  // Timer? _deboucerSearchBuscaEvaluacion;
  Timer? _deboucerSearchBuscaEncuasta;

  @override
  void dispose() {
    _deboucerSearchBuscaEncuasta?.cancel();
    // _deboucerSearchBuscaEvaluacion?.cancel();

    // _videoController.dispose();
    super.dispose();
  }

//==============================ENCUASTAS==================================//
  List<Map<String, dynamic>> _listaEncuastas = [];
  List<Map<String, dynamic>> get getListaEncuastas => _listaEncuastas;

  bool? _errorEncuestas; // sera nulo la primera vez
  bool? get getErrorEncuestas => _errorEncuestas;
  set setErrorEncuestas(bool? value) {
    _errorEncuestas = value;
    notifyListeners();
  }

  Future buscaEncuestas(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPreguntas(
      search: _search,
      notificacion: notificacion,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorEncuestas = true;
      _listaEncuastas = [];

      for (var i = 0; i < response['data'].length; i++) {
        if (response['data'][i]['encOption'] == 'ENCUESTAS' &&
            response['data'][i]['docPreguntas'].isNotEmpty) {
          _listaEncuastas.add(response['data'][i]);
        }
      }

      _listaEncuastas
          .sort((a, b) => b['encFecReg']!.compareTo(a['encFecReg']!));

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorEncuestas = false;
      notifyListeners();
      return null;
    }
  }

//====================OBTENEMOS LA INFORMACION DEL LA EVALUACION====================//
  dynamic _getInfoEncuesta;
  get getInfoEncuesta => _getInfoEncuesta;

  List<Map<String, dynamic>> _listaPreguntasEncuesta = [];
  get getListaPreguntasEncuesta => _listaPreguntasEncuesta;

  void getDataEncuesta(dynamic _data) {
    _getInfoEncuesta = _data;
    for (var item in _data['docPreguntas']) {
      _listaPreguntasEncuesta.add(item);
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
  Future guardaEncuesta(EncuestasController controller, dynamic _data) async {
    final infoUserLogin = await Auth.instance.getSession();
    final response =
        await _api.saveEvaluacion(data: _data, token: infoUserLogin!.token);

    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }

//==================================================================//

}
