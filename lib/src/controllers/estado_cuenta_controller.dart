import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/lista_allEstados_cuenta_cliente.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/lista_allEstados_cuenta_cliente.dart';

class EstadoCuentaController extends ChangeNotifier{

  final _api = ApiProvider();
  
EstadoCuentaController(){
getEstadosDeCuentaClientes('');
}

//================================= OBTENEMOS TODAS LAS CONSIGNAS  ==============================//
  List<Result> _listaTodoslosEstadosdeCuentaCliente = [];
  List<Result> get getTodoslosEstadosdeCuentaCliente =>
      _listaTodoslosEstadosdeCuentaCliente;
  List<EstCuota> _listaTodasLasCuotasCliente = [];
  List<EstCuota> get getListaTodasLasCuotasCliente =>
      _listaTodasLasCuotasCliente;

  void setTodoslosEstadosdeCuentaCliente(List<Result> data) {
    _listaTodoslosEstadosdeCuentaCliente = data;
   notifyListeners();
  }

  bool? _errorAllEstadosCuenta; // sera nulo la primera vez
  bool? get getErrorAllEstadosCuenta => _errorAllEstadosCuenta;

  Future getEstadosDeCuentaClientes(String? search) async {
    final dataUser = await Auth.instance.getSession();
 final response = await _api.getAllEstadosdeCuentaClientes(
      cantidad: 100,
      page: 0,
      search: search,
      input: 'estId',
      orden: false,
      datos: '',
      rucempresa: '${dataUser!.rucempresa}',
      token: '${dataUser.token}',
    );

    if (response != null) {
      _errorAllEstadosCuenta = true;
      setTodoslosEstadosdeCuentaCliente(response.data.results);

for (var e in response.data.results) {
   _listaTodasLasCuotasCliente=e.estCuotas!;
 }
 notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllEstadosCuenta = false;
      notifyListeners();
      return null;
    }
    return null;
  }







}