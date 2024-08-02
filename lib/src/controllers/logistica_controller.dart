import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/models/crea_nuevo_pedido.dart';
import 'package:nseguridad/src/models/list_allClientePedido.dart';
import 'package:nseguridad/src/models/list_allGuardiasPedido.dart';
import 'package:nseguridad/src/models/list_allImplemento_pedido.dart';
import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:sincop_app/src/api/api_provider.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/models/crea_nuevo_pedido.dart';
// import 'package:sincop_app/src/models/list_allGuardiasPedido.dart';
// import 'package:sincop_app/src/models/list_allClientePedido.dart';
// import 'package:sincop_app/src/models/list_allImplemento_pedido.dart';

// import 'package:sincop_app/src/service/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LogisticaController extends ChangeNotifier {
  GlobalKey<FormState> pedidoGuardiaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> validaNuevoPedidoGuardiaFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();

  void resetValuesPedidos() {
    _docCliente = '';
    _nomCliente = '';
    _docCliente = '';
    _nomCliente = '';

    _docGuardia = '';
    _nomGuardia = '';

    _itemCantidad;
    _labelPedido;
    _nuevoPedido.clear();
    _listaGuardiaVarios.clear();
    _listaItemsProductos.clear();
    _pedidoDevolucion = '';
    _itemDevolucionDisponible = false;
    _nuevoItemDevolucionPedido.clear();
    _labelNombreEstadoDevolucionPedido;
    _estadoDevolucion = false;
    _labelNombreEstado;
    labelEntrega;
    _listEstadosItem.clear();
    _listaGuardias.clear();
    _listaDeImplementos.clear();
    _listaDeMunisiones.clear();
    _ubicacionCliente = "";
    _puestoCliente = "";
    _total = 0;

    notifyListeners();
  }

  void resetListaPersonas() {
    _listaPersonas = [];
  }

  void resetListaInventario() {
    _listaItemPedido = [];
  }

  //===================OBTENEMOS EL IDE DEL TAB PARA LA BUSQUEDA==========================//
  int? _indexTapLogistica = 0;
  int? get getIndexTapLogistica => _indexTapLogistica;

  set setIndexTapLogistica(int value) {
    _indexTapLogistica = value;
    if (_indexTapLogistica == 0) {
      getTodosLosPedidosGuardias('', 'false');
      notifyListeners();
    } else if (_indexTapLogistica == 1) {
      getTodasLasDevoluciones('', 'false');
      notifyListeners();
    }
  }

  void resetBusquedaImplemento() {
    _implementoItem = '';
    _tipoPedido = '';
    _seriePedido = '';
    _idInvProductoPedido = '';
    _cantidadDevolucionPedido;
    _estadoPedido = '';
    notifyListeners();
  }

  bool validateForm() {
    if (pedidoGuardiaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormValidaCantidad() {
    if (validaNuevoPedidoGuardiaFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//======================================== RADIO BUTTON ENTREGA=======================//

  var _labelEntrega;
  var _labelValorEntrega;
  DateTime? _fechaActual;
  String? _fechaActualParse = "";

  String? get labelEntrega => _labelEntrega;
  get labelValorEntrega => _labelValorEntrega;

  void setLabelEntrega(value) {
    _labelValorEntrega = value;
    _labelEntrega = (value == 1) ? 'DOTACIÓN' : 'DESCUENTO';

    notifyListeners();
  }

//========================== TIPO DE IMPLEMETO =======================//s
  String? _tipoPedido = '';
  String? get getTipoPedido => _tipoPedido;

  void setTipoImplemento(String value) {
    _tipoPedido = value;

    notifyListeners();
  }

  String? _seriePedido = '';
  String? get getSeriePedido => _seriePedido;

  void setSeriePedido(String value) {
    _seriePedido = value;

    notifyListeners();
  }

  String? _estadosPedido = '';
  String? get getEstadosPedido => _estadosPedido;

  void setEstadosedido(String value) {
    _estadosPedido = value;

    notifyListeners();
  }

  int? _cantidadDevolucionPedido;
  int? get getCantidadDevolucionPedido => _cantidadDevolucionPedido;

  void setCantidadDevolucionPedido(int? value) {
    _cantidadDevolucionPedido = value;

    notifyListeners();
  }

  String? _idInvProductoPedido = '';
  String? get getidProductoPedido => _idInvProductoPedido;

  void setidProductoPedido(String value) {
    _idInvProductoPedido = value;

    notifyListeners();
  }

  String? _labelPedido;
  String? get labelPedidoGuardia => _labelPedido;

  void setLabelPedidoGuardia(String value) {
    _labelPedido = value;
    notifyListeners();
  }

//========================== DROPDOWN PERIODO  CLIENTE =======================//
  String? _labelNombreEstado;

  String? get labelNombreEstado => _labelNombreEstado;

  void setLabelNombreEstado(String value) async {
    _labelNombreEstado = value;
    if (_labelNombreEstado == 'RECIBIDO') {
      _fechaActualParse =
          '${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm').format(DateTime.now())}';
    }
    notifyListeners();
  }

//========================== CREA NUEVO ITEM PEDIDO =======================//

  int idItem = 0;
  final List<CreaNuevoItemPedido> _nuevoPedido = [];
  List<CreaNuevoItemPedido> get getNuevoPedido => _nuevoPedido;

  void setNuevoPedido(CreaNuevoItemPedido pedido) {
    _nuevoPedido.add(pedido);

    notifyListeners();
  }

  // void agregaNuevoPedido() {
  //   _nuevoPedido.add(
  //     CreaNuevoItemPedido(
  //       int.parse(_idInvProductoPedido!),
  //       '0',
  //       '$_implementoItem',
  //       '$_itemCantidad',
  //       '$_tipoPedido',
  //       '$_seriePedido',
  //       "PEDIDO",
  //     ),
  //   );
  //   notifyListeners();
  // }

//========================== CREA NUEVO ITEM PEDIDO IMPLEMENTOS=======================//

  // int idItem = 0;
  List<Map<String, dynamic>> _nuevoItemPedido = [];
  List<Map<String, dynamic>> get getNuevoItemPedido => _nuevoItemPedido;
  dynamic _getPedidoItem;
  void setNuevoItemPedido(Map<String, dynamic> _pedido) {
    _getPedidoItem;
    _getPedidoItem = _pedido;

    notifyListeners();
  }

  List<Map<String, dynamic>> _estadosItem = [];
  List<Map<String, dynamic>> _listaDeImplementos = [];
  List<Map<String, dynamic>> get getListaDeImplementos => _listaDeImplementos;
  void setListaDeImplementos(Map<String, dynamic> _item) {
    _listaDeImplementos.add(_item);
  }

  void agregaItemPedido(String _uuId) {
    _estadosItem = [];
    for (var item in getLlistEstadosItem) {
      _estadosItem.add({
        "estado": item['estado'],
        "cantidad": item['cantidad'],
        "max": item['disponible'], //stock del producto
      });
    }
    //  _nuevoItemPedido=[];
    final _itemImplemento = {
      "idMapeo": _uuId, // UUid()
      "tipo": _getPedidoItem['invTipo'],
      "idBodega": _getPedidoItem['invBodId'],
      "bodega": _getPedidoItem['invNomBodega'],
      "fotos": _getPedidoItem['invFotos'],
      "id": _getPedidoItem['invId'],
      "nombre": _getPedidoItem['invNombre'],
      "serie": _getPedidoItem['invSerie'],
      "valor": _getPedidoItem['invId'],
      "marca": _getPedidoItem['invMarca'],
      "modelo": _getPedidoItem['invModelo'],
      "talla": _getPedidoItem['invTalla'],
      "color": _getPedidoItem['invColor'],
      "stock": _getPedidoItem['invStock'],
      "cantidades": _estadosItem
    };
    _listaDeImplementos.removeWhere((e) =>
        int.parse(e['id'].toString()) ==
        int.parse(_itemImplemento['id'].toString()));
    _listaDeImplementos.add(_itemImplemento);
    // print('La DATA es: $_nuevoItemPedido');
    notifyListeners();
  }

//============ELIMINA ELEMENTO DE LA LISTA DE IMPLEMENTOS=====================//

  void eliminaPedidoAgregado(rowSelect) {
    _listaDeImplementos.removeWhere((e) => e['id'] == rowSelect['id']);
    sumaTotalPedido();
    notifyListeners();
  }
  //===============================================================================================================//
//========================== CREA NUEVO ITEM PEDIDO MUNICIONES=======================//

  // int idItem = 0;
  List<Map<String, dynamic>> _nuevoItemPedidoMunisiones = [];
  List<Map<String, dynamic>> get getNuevoItemPedidoMunisiones =>
      _nuevoItemPedidoMunisiones;
  dynamic _getPedidoItemMunisiones;
  void setNuevoItemPedidoMunisiones(Map<String, dynamic> _pedido) {
    _getPedidoItemMunisiones;
    _getPedidoItemMunisiones = _pedido;

    notifyListeners();
  }

  List<Map<String, dynamic>> _estadosItemMunisiones = [];
  List<Map<String, dynamic>> _listaDeMunisiones = [];
  List<Map<String, dynamic>> get getListaDeMunisiones => _listaDeMunisiones;
  void setListaDeMunisiones(Map<String, dynamic> _item) {
    _listaDeMunisiones.add(_item);
  }

  void agregaItemPedidoMunisiones(String _uuId) {
    _estadosItemMunisiones = [];
    for (var item in getLlistEstadosItemMunisiones) {
      _estadosItemMunisiones.add({
        "estado": item['estado'],
        "cantidad": item['cantidad'],
        "max": item['disponible'], //stock del producto
      });
    }
    //  _nuevoItemPedido=[];

    final _itemMunicion = {
      "idMapeo": _uuId, // UUid()
      "tipo": _getPedidoItemMunisiones['invTipo'],
      "idBodega": _getPedidoItemMunisiones['invBodId'],
      "bodega": _getPedidoItemMunisiones['invNomBodega'],
      "fotos": _getPedidoItemMunisiones['invFotos'],
      "id": _getPedidoItemMunisiones['invId'],
      "nombre": _getPedidoItemMunisiones['invNombre'],
      "serie": _getPedidoItemMunisiones['invSerie'],
      "valor": _getPedidoItemMunisiones['invId'],
      "marca": _getPedidoItemMunisiones['invMarca'],
      "modelo": _getPedidoItemMunisiones['invModelo'],
      "talla": _getPedidoItemMunisiones['invTalla'],
      "color": _getPedidoItemMunisiones['invColor'],
      "stock": _getPedidoItemMunisiones['invStock'],
      "cantidades": _estadosItemMunisiones
    };

    _listaDeMunisiones.removeWhere((e) =>
        int.parse(e['id'].toString()) ==
        int.parse(_itemMunicion['id'].toString()));
    _listaDeMunisiones.add(_itemMunicion);
    notifyListeners();
  }

//============ELIMINA ELEMENTO DE LA LISTA DE MUNICIONES=====================//

  void eliminaPedidoAgregadoMunisiones(rowSelect) {
    _listaDeMunisiones.removeWhere((e) => e['idMapeo'] == rowSelect['idMapeo']);
    sumaTotalPedido();
    notifyListeners();
  }

//===============================================================================================================//
//================================== OBTENEMOS TODOS LOS PEDIDOS DE LOS GUARDIAS  ==============================//
  List<dynamic> _listaTodosLosPedidosGuardias = [];
  List<dynamic> get getListaTodosLosPedidosGuardias =>
      _listaTodosLosPedidosGuardias;

  void setListaTodosLosPedidosGuardias(List<dynamic> data) {
    _listaTodosLosPedidosGuardias = [];
    _listaTodosLosPedidosGuardias = data;
    _listaTodosLosPedidosGuardias.sort((a, b) {
      if (a['disEstado'] == 'ANULADO' && b['disEstado'] != 'ANULADO') {
        return 1; // Mueve a 'a' al final
      } else if (a['disEstado'] != 'ANULADO' && b['disEstado'] == 'ANULADO') {
        return -1; // Mueve a 'a' al inicio
      } else {
        return 0; // Mantén el orden actual
      }
    });

    notifyListeners();
  }

  bool? _errorAllPedidos; // sera nulo la primera vez
  bool? get getErrorAllPedidos => _errorAllPedidos;

  Future getTodosLosPedidosGuardias(
      String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllPedidos(
      search: search,
      notificacion: notificacion,
      tipo: 'PEDIDO',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorAllPedidos = true;
      setListaTodosLosPedidosGuardias(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllPedidos = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== OBTENEMOS TODAS LAS DEVOLUCIONES  ==============================//
  List<dynamic> _listaTodaslasDevoluciones = [];
  List<dynamic> get getListaTodaLasDevoluciones => _listaTodaslasDevoluciones;

  void setListaTodasLasDevoluciones(List<dynamic> data) {
    _listaTodaslasDevoluciones = data;
    notifyListeners();
  }

  bool? _errorAllDevoluciones; // sera nulo la primera vez
  bool? get getErrorAllDevoluciones => _errorAllDevoluciones;

  Future getTodasLasDevoluciones(String? search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllDistribucion(
      search: search,
      notificacion: notificacion,
      tipo: 'DEVOLUCION',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorAllDevoluciones = true;

      setListaTodasLasDevoluciones(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllDevoluciones = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== OBTENEMOS TODAS LAS DEVOLUCIONES  ==============================//
  List<dynamic> _listaTodosLosPedidosActivos = [];
  List<dynamic> get getListaTodosLosPedidosActivos =>
      _listaTodosLosPedidosActivos;

  void setListaTodosLosPedidosActivos(List<dynamic> data) {
    _listaTodosLosPedidosActivos = data;
    notifyListeners();
  }

  bool? _errorAllPedidosActivos; // sera nulo la primera vez
  bool? get getErrorAllPedidosActivos => _errorAllPedidosActivos;

  Future getTodosLosPedidosActivos(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllPedidosActivos(
      search: search,
      tipo: 'DEVOLUCION',
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorAllPedidosActivos = true;

      List dataSort = [];
      dataSort = response['data'];
      dataSort.sort((a, b) => b['disFecReg']!.compareTo(a['disFecReg']!));

      setListaTodosLosPedidosActivos(response['data']);
      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorAllPedidosActivos = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaImplementoPedido;

  @override
  void dispose() {
    _deboucerSearchBuscaImplementoPedido?.cancel();
    _deboucerSearchBuscaClientePedidos?.cancel();
    _deboucerSearchBuscaGuardiasPedido?.cancel();
    _deboucerValidaStockItemPedido?.cancel();
    _deboucerValidaStockItemDevolucionPedido?.cancel();

    super.dispose();
  }

  String? _inputBuscaImplemento;
  get getInputBuscaGuardia => _inputBuscaImplemento;
  void onInputBuscaItemChange(String? text) {
    _inputBuscaImplemento = text;

//================================================================================//
    //   if (_inputBuscaImplemento!.length >= 3) {
    //     _deboucerSearchBuscaImplementoPedido?.cancel();
    //     _deboucerSearchBuscaImplementoPedido =
    //         Timer(const Duration(milliseconds: 500), () {
    //       buscaItemsPedido(_inputBuscaImplemento);
    //     });
    //   } else if (_inputBuscaImplemento!.isEmpty) {
    //     buscaImplementoPedido('');
    //   } else {
    //     buscaImplementoPedido('');
    //   }

    //   notifyListeners();
    // }
    if (_inputBuscaImplemento!.length >= 3) {
      _deboucerSearchBuscaImplementoPedido?.cancel();
      _deboucerSearchBuscaImplementoPedido =
          Timer(const Duration(milliseconds: 500), () {
        buscaItemPedido(_inputBuscaImplemento);
      });
    } else if (_inputBuscaImplemento!.isEmpty) {
      buscaItemPedido('');
    } else {
      buscaItemPedido('');
    }

    notifyListeners();
  }
//=======================================LISTAMOS IMPLEMENTOS=========================================//

  // List<Implemento> _listaImplementoPedido = [];
  // List<Implemento> get getListaImplementoPedido => _listaImplementoPedido;

  // void setInfoBusquedaImplementoPedido(List<Implemento> data) {
  //   _listaImplementoPedido = data;
  //   notifyListeners();
  // }

  // bool? _errorInfoImplementoPedido; // sera nulo la primera vez
  // bool? get getErrorImplementoPedido => _errorInfoImplementoPedido;
  // setErrorInfoImplementoPedido(bool? value) {
  //   _errorInfoImplementoPedido = value;
  //   notifyListeners();
  // }

  // Future<AllImplementoPedido?> buscaImplementoPedido(String? _search) async {
  //   final dataUser = await Auth.instance.getSession();
  //   final response = await _api.getAllImplementoPedido(
  //     search: _search,
  //     token: '${dataUser!.token}',
  //   );
  //   if (response != null) {
  //     _errorInfoImplementoPedido = true;
  //     setInfoBusquedaImplementoPedido(response.data);
  //   }
  //   if (response == null) {
  //     _errorInfoImplementoPedido = false;
  //     notifyListeners();
  //     return null;
  //   }
  // }

  List _listaImplementoPedido = [];
  List get getListaImplementoPedido => _listaImplementoPedido;

  void setInfoBusquedaImplementoPedido(List data) {
    _listaImplementoPedido = data;
    notifyListeners();
  }

  bool? _errorInfoImplementoPedido; // sera nulo la primera vez
  bool? get getErrorImplementoPedido => _errorInfoImplementoPedido;
  setErrorInfoImplementoPedido(bool? value) {
    _errorInfoImplementoPedido = value;
    notifyListeners();
  }

  Future buscaImplementoPedido(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllImplementoPedido(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoImplementoPedido = true;
      setInfoBusquedaImplementoPedido(response['data']);
    }
    if (response == null) {
      _errorInfoImplementoPedido = false;
      notifyListeners();
      return null;
    }
  }

  List _listaItemPedido = [];
  List get getListaItemPedido => _listaItemPedido;

  void setInfoBusquedaItemPedido(List data) {
    _listaItemPedido = [];
    _listaItemPedido = data;
    // print('LA DATA DE ITES :$_listaItemPedido');
    notifyListeners();
  }

  bool? _errorInfoItemPedido; // sera nulo la primera vez
  bool? get getErrorItemPedido => _errorInfoItemPedido;
  setErrorInfoItemPedido(bool? value) {
    _errorInfoItemPedido = value;
    notifyListeners();
  }

  Future buscaItemPedido(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInventario(
      search: _search,
      bodega: _nombreBodega,
      tipo: _tipoDePedido,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoItemPedido = true;
      setInfoBusquedaItemPedido(response['data']);
    }
    if (response == null) {
      _errorInfoItemPedido = false;
      notifyListeners();
      return null;
    }
  }

  Future buscaItemPedidoMuniciones(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllInventarioMunisiones(
      search: _search,
      bodega: _nombreBodega,
      tipo: _tipoDePedido,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoItemPedido = true;
      setInfoBusquedaItemPedido(response['data']);
    }
    if (response == null) {
      _errorInfoItemPedido = false;
      notifyListeners();
      return null;
    }
  }

  //========================== DROPDOWN  =======================//
  Implemento? implemento;

  String? _implementoItem = '';

  String? _itemCantidadDisponible = '';
  String? get getitemCantidadDisponible => _itemCantidadDisponible;

  String? get getImplementoItem => _implementoItem;
  String? _stockItem = '';

  String? get getStockItem => _stockItem;
  void setStockDelItem(String _stok) {
    _stockItem = _stok;
    print('El stock Item: $_stockItem');
    notifyListeners();
  }

  List _listEstadosItem = [];
  List get getLlistEstadosItem => _listEstadosItem;
  void setlistEstadosItem(List _estados) {
    _listEstadosItem = [];

    for (var i = 0; i < _estados.length; i++) {
      _listEstadosItem.add({
        "id": i,
        "estado": _estados[i]['estado'],
        "disponible": _estados[i]['cantidad'],
        "cantidad": int.parse(_estados[i]['cantidad'].toString()) > 0 ? 1 : 0,
      });
    }

    notifyListeners();
  }

  void actualizaItem(Map<String, dynamic> _item) {
    // print('ITEM A ELIMINAR $_item');

    _listEstadosItem.removeWhere((e) =>
        int.parse(e['id'].toString()) == int.parse(_item['id'].toString()));
    _listEstadosItem.add({
      "id": _item['id'],
      "estado": _item['estado'],
      "disponible": _item['disponible'],
      "cantidad": _itemCantidad,
    });

    _listEstadosItem.sort((a, b) =>
        int.parse(a['id'].toString()).compareTo(int.parse(b['id'].toString())));

    notifyListeners();
  }

  List _listEstadosItemMunisiones = [];
  List get getLlistEstadosItemMunisiones => _listEstadosItemMunisiones;
  void setlistEstadosItemMunisiones(List _estados) {
    _listEstadosItemMunisiones = [];
    for (var i = 0; i < _estados.length; i++) {
      _listEstadosItemMunisiones.add({
        "id": i,
        "estado": _estados[i]['estado'],
        "disponible": _estados[i]['cantidad'],
        "cantidad": int.parse(_estados[i]['cantidad'].toString()) > 0 ? 1 : 0,
      });
    }

    notifyListeners();
  }

  void actualizaItemMunisiones(Map<String, dynamic> _item) {
    _listEstadosItemMunisiones.removeWhere((e) =>
        int.parse(e['id'].toString()) == int.parse(_item['id'].toString()));
    _listEstadosItemMunisiones.add({
      "id": _item['id'],
      "estado": _item['estado'],
      "disponible": _item['disponible'],
      "cantidad": _itemCantidad,
    });

    _listEstadosItemMunisiones.sort((a, b) =>
        int.parse(a['id'].toString()).compareTo(int.parse(b['id'].toString())));
    notifyListeners();
  }

  //========================== OBTENEMOS LA INFORMACION DEL ITEM SELECCIONADO  =======================//

  void getImplemento(dynamic implemento) {
    _itemCantidadDisponible = implemento['invDisponible'].toString();
    setlistEstadosItem(implemento['invTotalesStock']);

    _implementoItem = implemento['invNombre'];
    _tipoPedido = implemento['invTipo'];
    _seriePedido = implemento['invSerie'];
    _idInvProductoPedido = implemento['invId'].toString();
    // _stockItem = implemento['invStock'].toString();

    notifyListeners();
  }

//  =================  CREO UN DEBOUNCE PARA VALIDAD ELEMNTO SELECCIONADO ==================//

  Timer? _deboucerValidaStockItemPedido;

  bool? _itemDisponible = false;
  bool? get getItemDisponible => _itemDisponible;

  void setItemDisponible(bool? value) {
    _itemDisponible = value;
    notifyListeners();
  }

  String? _itemCantidad = '';

  String? get getItemCantidad => _itemCantidad;

  void setItemCantidad(String? value) {
    _itemCantidad = value;
    // print('EL TEXTO: $_itemCantidad');
    //================================================================================//
    if (_itemCantidad!.isNotEmpty) {
      _deboucerValidaStockItemPedido?.cancel();
      _deboucerValidaStockItemPedido =
          Timer(const Duration(milliseconds: 500), () {
        final stock = int.parse(_stockItem!);
        final stockIngresado = int.parse(_itemCantidad!);

        if (stock >= stockIngresado && stockIngresado > 0) {
          setItemDisponible(true);
        } else {
          _itemCantidad = '';
          setItemDisponible(false);
        }
      });
    }

    notifyListeners();
  }

//  =================  CREO UN DEBOUNCE BUSCAR CLIENTES ==================//

  Timer? _deboucerSearchBuscaClientePedidos;

  String? _inputBuscaClientePedidos;
  get getInputBuscaClientesPedidos => _inputBuscaClientePedidos;
  void onInputBuscaClienteChangeChange(String? text, String? tipo) {
    _inputBuscaClientePedidos = text;

//================================================================================//

    if (_inputBuscaClientePedidos!.length >= 3) {
      _deboucerSearchBuscaClientePedidos?.cancel();
      _deboucerSearchBuscaClientePedidos =
          Timer(const Duration(milliseconds: 500), () {
        getTodosLosClientesPedido(_inputBuscaClientePedidos);
      });
    } else if (_inputBuscaClientePedidos!.isEmpty) {
      getTodosLosClientesPedido('');
    } else {
      getTodosLosClientesPedido('');
    }

    notifyListeners();
  }
//  =================  CREO UN DEBOUNCE BUSCAR CLIENTES ==================//

  Timer? _deboucerSearchBuscaGuardiasPedido;

  String? _inputBuscaGuardiasPedido;
  get getInputBuscaGuardiasPedido => _inputBuscaGuardiasPedido;
  void onInputBuscaGuardiasPedidoChange(String? text) {
    _inputBuscaGuardiasPedido = text;
    if (_inputBuscaGuardiasPedido!.length >= 3) {
      _deboucerSearchBuscaGuardiasPedido?.cancel();
      _deboucerSearchBuscaGuardiasPedido =
          Timer(const Duration(milliseconds: 500), () {
        getTodosLosGuardiasPedido(_inputBuscaGuardiasPedido);
      });
    } else if (_inputBuscaGuardiasPedido!.isEmpty) {
      getTodosLosGuardiasPedido('');
    } else {
      getTodosLosGuardiasPedido('');
    }

    notifyListeners();
  }

//================================== OBTENEMOS TODOS LOS CLIENTES PEDIDOS ==============================//
  List<Cliente> _listaTodosLosClientesPedidos = [];
  List<Cliente> get getListaTodosLosClientesPedidos =>
      _listaTodosLosClientesPedidos;

  void setListaTodosLosClientesPedidos(List<Cliente> data) {
    _listaTodosLosClientesPedidos = data;

    notifyListeners();
  }

  bool? _errorClientesPedidos; // sera nulo la primera vez
  bool? get getErrorClientesPedidos => _errorClientesPedidos;

  Future<AllClientePedido?> getTodosLosClientesPedido(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllClientesPedidos(
      search: search,
      tipo: 'CLIENTES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorClientesPedidos = true;
      setListaTodosLosClientesPedidos(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorClientesPedidos = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== OBTENEMOS TODOS LOS GUARDIAS ==============================//
  List<Guardia> _listaTodosLosGuardiasPedido = [];
  List<Guardia> get getListaTodosLosGuardiasPedido =>
      _listaTodosLosGuardiasPedido;

  void setListaTodosLosGuardiasPedido(List<Guardia> data) {
    _listaTodosLosGuardiasPedido = data;

    notifyListeners();
  }

  bool? _errorGuardiasPedido; // sera nulo la primera vez
  bool? get getErrorGuardiasPedido => _errorGuardiasPedido;

  Future<AllGuardiasPedido?> getTodosLosGuardiasPedido(String? search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllGuardiasPedido(
      search: search,
      docnumero: _docCliente,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorGuardiasPedido = true;
      setListaTodosLosGuardiasPedido(response.data);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorGuardiasPedido = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//===============OBTENGO AL CLIENTE SELECCIONADO =====================//
  dynamic _clientePedido;
  dynamic get getClienteInfoPedido => _clientePedido;
  String? _docCliente;
  String _nomCliente = '';
  String? get getDocCliente => _docCliente;
  String? get getNombreCliente => _nomCliente;

  void getClientePedido(Cliente? cliente) {
    _listaGuardiaVarios.clear();
    _clientePedido = cliente;
    _docCliente = cliente!.cliDocNumero;
    _nomCliente = cliente.cliNombreComercial!;

    notifyListeners();
  }

  Guardia? _guardia;
  String? _idGuardia = '';
  String? _docGuardia;
  String? _perfilGuardia = '';
  String _nomGuardia = '';
  String? get getDocGuardia => _docGuardia;
  String? get getNombreGuardia => _nomGuardia;

  void getGuardiaPedido(Guardia? guardia) {
    _guardia = guardia;
    _docGuardia = '${guardia!.perId}';
    _nomGuardia = '${guardia.perApellidos} ${guardia.perNombres} ';
    _docGuardia = '${guardia.perDocNumero}';
    _perfilGuardia = '${guardia.perPerfil}';
    notifyListeners();
  }

  String? _inputObservacion;
  String? _inputDetalle;
  String? _inputDocumento;
  String? _inputFechaEvio;
  String? get getInputObservacion => _inputObservacion;
  void onObservacionChange(String? text) {
    _inputObservacion = text;
    notifyListeners();
  }

  // //================================== CREA NUEVO PEDIDO ==============================//
  // Future crearPedido(
  //   BuildContext context,
  // ) async {
  //   final serviceSocket = SocketService();

  //   final infoUser = await Auth.instance.getSession();
  //   final _pyloadNuevoPedido = {
  //     "tabla": "pedido",
  //     "rucempresa": infoUser!.rucempresa,
  //     "rol": infoUser.rol, // LOGIN
  //     "disTipo": "PEDIDO", // defecto
  //     "disIdCliente": _infoClientePedido[
  //         'cliId'], // _clientePedido!.cliId, // Propiedad cliId
  //     "disDocuCliente": _infoClientePedido[
  //         'cliDocNumero'], //_clientePedido!.cliDocNumero, // propiedad cliDocNumero
  //     "disNombreCliente": _infoClientePedido[
  //         'cliRazonSocial'], //_clientePedido!.cliRazonSocial, // propiedad cliRazonSocial
  //     "disPersonas": _listaGuardiaVarios,
  //     "disEntrega": _labelEntrega, // select
  //     "disObservacion": _inputObservacion, // textarea
  //     "disEstado": "PENDIENTE", // defecto
  //     "disFechaEnvio": "", // interno
  //     "disDetalle": "", // interno
  //     "disDocumento": "", // vacio
  //     "disFechaRecibido": "", // vacio
  //     "disPedidos": _nuevoPedido, // listado
  //     "disUser": infoUser.usuario, // LOGIN
  //     "disEmpresa": infoUser.rucempresa // LOGIN
  //   };
  //   serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoPedido);

  //   getTodosLosPedidosGuardias('', 'false');

  // }
  //================================== CREA NUEVO PEDIDO ==============================//
  Future crearPedido(
    BuildContext context,
  ) async {
    final serviceSocket = SocketService();

    final infoUser = await Auth.instance.getSession();
    final _pyloadNuevoPedido = {
      "tabla": "pedido",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol, // LOGIN
      "disUser": infoUser.usuario, // LOGIN
      "disEmpresa": infoUser.rucempresa, // LOGIN

      // "disTipo": "PEDIDO", // defecto
      "disIdCliente": _infoClientePedido[
          'cliId'], // _clientePedido!.cliId, // Propiedad cliId
      "disDocuCliente": _infoClientePedido[
          'cliDocNumero'], //_clientePedido!.cliDocNumero, // propiedad cliDocNumero
      "disNombreCliente": _infoClientePedido[
          'cliRazonSocial'], //_clientePedido!.cliRazonSocial, // propiedad cliRazonSocial
      // "disPersonas": _listaGuardiaVarios,
      // "disEntrega": _labelEntrega, // select
      "disObservacion": _inputObservacion, // textarea
      // "disEstado": "PENDIENTE", // defecto
      // "disFechaEnvio": "", // interno
      // "disDetalle": "", // interno
      // "disDocumento": "", // vacio
      // "disFechaRecibido": "", // vacio
      // "disPedidos": _nuevoPedido, // listado

      // textarea
      "disUbicacionCliente": _ubicacionCliente, //endpoint
      "disPuestoCliente": _puestoCliente, //endpoint

      "disEntrega": _labelEntrega, // radiobutton

      "disPersonas": _listaGuardias,
      "disSupervisores": _listaSupervisores, //endopoint
      "disAdministracion": _listaAdministrador, //endopoint
      "disVestimenta": _listaDeImplementos,
      "disArmas": [], //endopoint
      "disMuniciones": _listaDeMunisiones,
      "disIdDescuento": [], //interno
    };

    serviceSocket.socket!.emit('client:guardarData', _pyloadNuevoPedido);
    getTodosLosPedidosGuardias('', 'false');
    // print('esta es la data para guardar:$_pyloadNuevoPedido');
  }

  //================================== ELIMINAR  MULTA  ==============================//
  Future eliminaPedido(BuildContext context, int? idPedido) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    final infoUser = await Auth.instance.getSession();

    final _pyloadEliminaPedido = {
      {
        "tabla": "pedido", // defecto
        "rucempresa": infoUser!.rucempresa, // login
        "disId": idPedido // id registro
      }
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaPedido);
    getTodosLosPedidosGuardias('', 'false');
  }

  //======================================== EDITAR PEDIDO==============================================//
  //LLENAMOS LOS DATOS A LAS VARIABLES //

  String? _idCliente = '';

  int? _idPedido;
  String? _rucempresa;
  String? _estadoPedido;
  String? get getEstadoPedido => _estadoPedido;
  void setEstadoDelPedido(String? estado) {
    _estadoPedido = estado;
    notifyListeners();
  }

  List<dynamic>? _disPedidosAntiguo = [];

  dynamic _infoPedido;
  dynamic get getinfoPedido => _infoPedido;

  void setInfoPedido(dynamic _pedido) {
    _total=0;
 _infoPedido = _pedido;
 // Sumar precios de la lista1
// Sumar precios de la lista2
    for (var item in _pedido['disVestimenta']) {
     _listaDeImplementos.add(item);
    }
    for (var item in _pedido['disMuniciones']) {
     _listaDeMunisiones.add(item);
    }

   sumaTotalPedido();


notifyListeners();


  }
  void infoPedidoEdicion(
      dynamic pedido, String estadoPedido, BuildContext context) {
    _infoPedido = pedido;
    // _nuevoPedido.clear();
    // _disPedidosAntiguo!.clear();
    // _listaGuardiaVarios.clear();
    // _idPedido = pedido['disId'];
    // _idCliente = '${pedido['disIdCliente']}';
    // _docCliente = '${pedido['disDocuCliente']}';
    // _nomCliente = '${pedido['disNombreCliente']}';
    // _rucempresa = '${pedido['disEmpresa']}';
    // _inputFechaEvio = '${pedido['disFechaEnvio']}';
    // _inputDetalle = '${pedido['disDetalle']}';
    // _inputDocumento = '${pedido['disDocumento']}';
    // _labelEntrega = '${pedido['disEntrega']}';
    // _listaGuardiaVarios = pedido['disPersonas'];

    // var estadoDelPedido = estadoPedido;
    // switch (estadoDelPedido) {
    //   case "RECIBIDO":
    //     {
    //       _fechaActualParse =
    //           '${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm').format(DateTime.now())}';
    //       _estadoPedido = 'RECIBIDO';
    //     }
    //     break;
    //   case "ANULADO":
    //     {
    //       _estadoPedido = 'ANULADO';
    //       _fechaActualParse = '';
    //     }
    //     break;

    //   case "PENDIENTE":
    //     {
    //       _estadoPedido = 'ANULADO';
    //       _fechaActualParse = '';
    //     }
    //     break;
    // }

    // if (_labelEntrega == 'DOTACION') {
    //   _labelEntrega = 'DOTACION';
    //   _labelValorEntrega = 1;
    //   notifyListeners();
    // } else if (_labelEntrega == 'DESCUENTO') {
    //   _labelEntrega = 'DESCUENTO';
    //   _labelValorEntrega = 2;
    //   notifyListeners();
    // }
    // _inputObservacion = '${pedido['disObservacion']}';
    // for (var item in pedido['disPedidos']) {
    //   _nuevoPedido.add(
    //     CreaNuevoItemPedido(
    //       item['id'],
    //       item['cantidadDevolucion'].toString(),
    //       item['nombre'],
    //       item['cantidad'],
    //       item['tipo'],
    //       item['serie'],
    //       item['estado'],
    //     ),
    //   );

    //   idItem = idItem + 1;
    // }

    // for (var item in pedido['disPedidos']) {
    //   _disPedidosAntiguo?.add(item);
    // }

    editarPedido(context, estadoPedido);

    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future editarPedido(BuildContext context, String _estado) async {
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    final infoUser = await Auth.instance.getSession();

    final _pyloadEditaPedido = {
      // "tabla": "pedido",
      // "disId": _idPedido,
      // "rucempresa": _rucempresa,
      // "rol": infoUser!.rol, // LOGIN
      // "disTipo": "PEDIDO", // defecto
      // "disIdCliente": _idCliente, // propiedad cliDocNumero
      // "disDocuCliente": _docCliente,
      // "disNombreCliente": _nomCliente, // propiedad cliRazonSocial
      // "disPersonas": _listaGuardiaVarios,
      // "disPedidosAntiguo": _disPedidosAntiguo, // PEDIDOS ANTIGUOS
      // "disEntrega": _labelEntrega, // select
      // "disObservacion": _inputObservacion, // textarea
      // "disEstado": _estadoPedido, // defecto
      // "disFechaEnvio": _inputFechaEvio, // interno
      // "disDetalle": _inputDetalle, // interno
      // "disDocumento": _inputDocumento, // vacio
      // "disFechaRecibido": _fechaActualParse, // vacio
      // "disPedidos": _nuevoPedido, // listado
      // "disUser": infoUser.usuario, // LOGIN
      // "disEmpresa": infoUser.rucempresa // LOGIN
      "tabla": "pedido",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol, // LOGIN

      'disEstado': _estado,
      "disId": _infoPedido['disId'],
      "disTipo": "PEDIDO", // defecto

      "disIdCliente": _infoPedido["disIdCliente"],
      "disDocuCliente": _infoPedido["disDocuCliente"],
      "disNombreCliente": _infoPedido["disNombreCliente"],

      "disObservacion": _infoPedido["disObservacion"],

      "disUbicacionCliente": _infoPedido["disUbicacionCliente"],
      "disPuestoCliente": _infoPedido["disPuestoCliente"],

      "disEntrega": _infoPedido["disEntrega"],
      "disDetalle": _infoPedido["disDetalle"],

      "disPersonas": _infoPedido["disPersonas"],
      "disSupervisores": _infoPedido["disSupervisores"],
      "disAdministracion": _infoPedido["disAdministracion"],
      "disVestimenta": _infoPedido["disVestimenta"],
      "disArmas": _infoPedido["disArmas"], //endopoint
      "disMuniciones": _infoPedido["disMuniciones"],
      "disIdDescuento": _infoPedido["disIdDescuento"], //interno

      "disUser": infoUser.usuario, // LOGIN
      "disEmpresa": infoUser.rucempresa // LOGIN
    };

    serviceSocket.socket!.emit('client:actualizarData', _pyloadEditaPedido);
    getTodosLosPedidosGuardias('', 'false');
    //  print('esta es la data para guardar:$_pyloadEditaPedido');
  }

//========================================//
  List _listaInfoGuardiaPedidos = [];

  List get getListaInfoGuardiaPedidos => _listaInfoGuardiaPedidos;

  void setInfoBusquedaInfoGuardia(List data) {
    _listaInfoGuardiaPedidos = data;

    notifyListeners();
  }

  bool? _errorInfoGuardiaPedidos; // sera nulo la primera vez
  bool? get getErrorInfoGuardiaPedido => _errorInfoGuardiaPedidos;
  set setErrorInfoGuardiaPedido(bool? value) {
    _errorInfoGuardiaPedidos = value;
    notifyListeners();
  }

  Future buscaInfoGuardiasPedidos(String? _search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllGuardiasPorCliente(
      search: _search,
      docnumero: _docCliente,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorInfoGuardiaPedidos = true;

      setInfoBusquedaInfoGuardia(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorInfoGuardiaPedidos = false;
      notifyListeners();
      return null;
    }
  }

// ================== ELIMINA GUARDIA AGREGADO =====================//
  void eliminaGuardiaPedido(int id) {
    _listaGuardiaVarios.removeWhere((e) => (e['id'] == id));

    _listaGuardiaVarios.forEach(((element) {}));

    notifyListeners();
  }
//========================================================= SELECCIONA  ==============================//

  List _listaGuardiaVarios = [];
  List get getListaGuardiasVarios => _listaGuardiaVarios;
  void setGuardiaVarios(dynamic guardia) {
    _listaGuardiaVarios.add({
      "docnumero": guardia['perDocNumero'],
      "nombres": '${guardia['perApellidos']} ${guardia['perNombres']} ',
      "asignado": true,
      "id": guardia['perId'],
      "foto": guardia['perFoto'],
      "correos": guardia['perEmail'],
    });
    notifyListeners();
  }

  //======================================== REALIZA DEVOLUCIONES ==================================================//
  dynamic _pedidoDevolucion = '';
  dynamic get getPedidoDevolucion => _pedidoDevolucion;
  List _listaItemsProductos = [];
  List get getListaItemsProductos => _listaItemsProductos;

  void setListaItemsProductos(List items) {
    _listaItemsProductos.addAll(items);
    notifyListeners();
  }

  List _listaItemsDevolucionProductos = [];
  List get getListaItemsDevolucionProductos => _listaItemsDevolucionProductos;

  void setListaItemsDevolucionProductos(List items) {
    _listaItemsDevolucionProductos.addAll(items);
    notifyListeners();
  }

  void getPedidoParaDevoluciones(dynamic pedido) {
    List<dynamic> _listatempPedidos = [];
    _pedidoDevolucion = pedido;

    setListaItemsProductos(pedido['disPedidos']);
  }

//====================== AGREGAMOS ITEM PARA LA DDEVOLUCION ======================//

  int? _idItem;
  String? _nombreItem = '';
  String? _cantidadItem = '';
  String? _tipoItem = '';
  String? _serieItem = '';
  String? _idProductoItem = '';
  int? _stock;
  int? _stockIngresado;
  String? _cantidadItemDevolucion = '';

  String? get getItemCantidadDevolucion => _cantidadItemDevolucion;
  Timer? _deboucerValidaStockItemDevolucionPedido;

  bool? _itemDevolucionDisponible = false;
  bool? get getItemDevolucionDisponible => _itemDevolucionDisponible;

  void setItemDevolucionDisponible(bool? value) {
    _itemDevolucionDisponible = value;
    notifyListeners();
  }

// ======= OBTENEMOS EL ITEM SELECCIONADO =============//

  int? _cantidadRestada;
  int? _itemTevolucion;
  int? get getCantidadRestada => _cantidadRestada;
  void setCantidadRestada(int? valor) {
    _cantidadRestada = valor;
  }

  void setItemscantidadDevolucion(String cantidad, String devolucion) {
    _cantidadItemDevolucion = devolucion;
    _itemTevolucion = int.parse(devolucion.trim());
    final inputText = int.parse(cantidad.trim());
    setCantidadRestada(inputText - _itemTevolucion!);
    if (inputText != 0) {
      _stockIngresado = inputText;
      _itemDevolucionDisponible = true;
    } else {
      _itemDevolucionDisponible = false;
    }
  }

  void resetItemDevolucion() {
    _itemDevolucionDisponible = false;
  }

  //========================== OBTENEMOS LA INFORMACION DEL ITEM SELECCIONADO  =======================//
  void agregarItemDevolucionPedido(dynamic _itemDevolucion) {
    _idItem = _itemDevolucion['id'];
    _nombreItem = _itemDevolucion['nombre'];
    _tipoItem = _itemDevolucion['tipo'];
    _cantidadItem = _itemDevolucion['cantidad'];
    _serieItem = _itemDevolucion['serie'];
    _idProductoItem = _itemDevolucion['idProduct'];
    _stock = int.parse(_itemDevolucion['cantidad']);

    notifyListeners();
  }

  final List<dynamic> _nuevoItemDevolucionPedido = [];
  List<dynamic> get getNuevoItemDevolucionPedido => _nuevoItemDevolucionPedido;

  void agregaNuevoItemDevolucionPedido() {
    _nuevoItemDevolucionPedido.removeWhere((e) => (e['id']) == _idItem!);

    _nuevoItemDevolucionPedido.add({
      "id": _idItem!,
      "nombre": '$_nombreItem',
      "cantidad": '$_cantidadItemDevolucion',
      "tipo": '$_tipoItem',
      "serie": '$_serieItem',
    });
    notifyListeners();
  }

//============ELIMINA ELEMENTO DE LA LISTA DE RTENCIONES=====================//

  void eliminaDevolucionPedidoAgregado(int rowSelect) {
    _nuevoItemDevolucionPedido.removeWhere((e) => e['id'] == rowSelect);

    notifyListeners();
  }

  void setItemCantidadDevolucion(String? value) {
    _cantidadItemDevolucion = value;
    if (value!.isNotEmpty) {
      _deboucerValidaStockItemDevolucionPedido?.cancel();
      _deboucerValidaStockItemDevolucionPedido =
          Timer(const Duration(milliseconds: 500), () {
        _stockIngresado = int.parse(_cantidadItemDevolucion!);
        if (_cantidadRestada! >= _stockIngresado! && _stockIngresado! > 0) {
          setItemDevolucionDisponible(true);
        } else {
          setItemDevolucionDisponible(false);
        }
      });
    } else if (_cantidadItemDevolucion == '') {
      setItemDevolucionDisponible(false);
    }

    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
  Future crearDevolucion(
    BuildContext context,
  ) async {
    final serviceSocket = SocketService();

    final infoUser = await Auth.instance.getSession();

    final _pyloadDevolucionPedido = {
      "tabla": "devolucion",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol, // LOGIN
      "disTipo": "DEVOLUCION",
      "disIdPedido": "${_pedidoDevolucion['disId']}", // defecto
      "disIdCliente": "${_pedidoDevolucion['disIdCliente']}", // Propiedad cliId
      "disDocuCliente":
          "${_pedidoDevolucion['disDocuCliente']}", // propiedad cliDocNumero
      "disNombreCliente":
          "${_pedidoDevolucion['disNombreCliente']}", // propiedad cliRazonSocial
      "disPersonas": _pedidoDevolucion['disPersonas'],
      "disEntrega": "${_pedidoDevolucion['disEntrega']}", // select
      "disObservacion": "${_pedidoDevolucion['disObservacion']}", // textarea
      "disEstado": "PENDIENTE", // defecto
      "disFechaEnvio": "", // interno
      "disDetalle": "", // interno
      "disDevolucion": _nuevoItemDevolucionPedido,
      "disFechaRecibido": "", // vacio
      "disPedidos": _pedidoDevolucion['disPedidos'], // listado
      "disUser": infoUser.usuario, // LOGIN
      "disEmpresa": infoUser.rucempresa // LOGIN
    };
    serviceSocket.socket!.emit('client:guardarData', _pyloadDevolucionPedido);
    getTodosLosPedidosActivos('');
  }

  //========================== DROPDOWN PERIODO  CLIENTE =======================//
  bool? _estadoDevolucion = false;
  bool? get getEstadoDevolucion => _estadoDevolucion;

  void setEstadoDevolucion(bool estado) {
    _estadoDevolucion = estado;
    notifyListeners();
  }

  String? _labelNombreEstadoDevolucionPedido;

  String? get labelNombreEstadoDevolucionPedido =>
      _labelNombreEstadoDevolucionPedido;

  void setLabelNombreEstadoDevolucionPedido(String value) {
    _labelNombreEstadoDevolucionPedido = value;
    setEstadoDevolucion(true);
    notifyListeners();
  }

//========================== OBTENEMOS LA INFORMACION DE LA DDEVOLUCION SELECCIONADA PARA EDITAR =======================//
// ESTADOS DE LA DEVOLUCION
  List<String> data = ['ANULADO'];

  List<String> get getDataEstadoDevolucion => data;

  dynamic _dataDevolucion;
  dynamic get getDataDevolucion => _dataDevolucion;

  List<dynamic> _listaPedidosDevolucion = [];
  List<dynamic> _listaDevolucionDePedido = [];

  void getInfoDevolucionPedido(dynamic infoDevolucion) {
    _listaPedidosDevolucion = [];
    _listaDevolucionDePedido = [];
    _dataDevolucion = infoDevolucion;

    for (var item in _dataDevolucion['disPedidos']) {
      _listaPedidosDevolucion.add({
        "id": item['id'],
        "nombre": item['nombre'],
        "cantidad": item['cantidad'],
        "tipo": item['tipo'],
        "serie": item['serie'],
      });
    }
  }

//========================== REALIZAMOS LA DEVOLUCION DEL PEDIDO =======================//
  Future editarDevolucionPedido(
    BuildContext context,
  ) async {
    final serviceSocket = SocketService();

    final infoUser = await Auth.instance.getSession();

    final _pyloadEditarDevolucionPedido = {
      "tabla": "devolucion",
      "rucempresa": infoUser!.rucempresa,
      "rol": infoUser.rol, // LOGIN
      "disTipo": "DEVOLUCION",
      "disId": _dataDevolucion['disId'],
      "disIdPedido": _dataDevolucion['disId'], // defecto
      "disIdCliente": _dataDevolucion['disIdCliente'], // Propiedad cliId
      "disDocuCliente":
          _dataDevolucion['disDocuCliente'], // propiedad cliDocNumero
      "disNombreCliente":
          _dataDevolucion['disNombreCliente'], // propiedad cliRazonSocial
      "disPersonas": _dataDevolucion['disPersonas'],
      "disEntrega": _dataDevolucion['disEntrega'], // select
      "disObservacion": _dataDevolucion['disObservacion'], // textarea
      "disEstado": _labelNombreEstadoDevolucionPedido, // defecto
      "disFechaEnvio": _dataDevolucion['disFechaEnvio'], // interno
      "disDetalle": _dataDevolucion['disDetalle'], // interno
      "disDevolucion": '',
      "disFechaRecibido": _dataDevolucion['disFechaRecibido'], // vacio
      "disPedidos": _listaPedidosDevolucion, // listado
      "disUser": infoUser.usuario, // LOGIN
      "disEmpresa": infoUser.rucempresa // LOGIN
    };
    serviceSocket.socket!
        .emit('client:actualizarData', _pyloadEditarDevolucionPedido);

    getTodasLasDevoluciones('', 'false');
  }

  //     '==========================OBTENEMOS DATO DEL PEDIDO ===============================');

  dynamic _infoClientePedido;
  dynamic get getInfoClientePedido => _infoClientePedido;
  List<Map<String, dynamic>> _datosOperativos = [];
  List<Map<String, dynamic>> get getDatosOperativos => _datosOperativos;

  void getInfoCliente(dynamic _cliente) {
    _infoClientePedido = _cliente;
    _clientePedido = _cliente;
    _docCliente = _cliente['cliDocNumero'];
    _nomCliente = _cliente['cliRazonSocial'];

    for (var item in _infoClientePedido['cliDatosOperativos']) {
      _datosOperativos.add({
        "ubicacion": item['ubicacion'],
        "puesto": item['puesto'],
      });
    }

    notifyListeners();

    // print('LOS  DATOS DE CLIENTE: ${_infoClientePedido['cliDatosOperativos']}');
    // print('LOS  DATOS : $_datosOperativos');
  }

  String _ubicacionCliente = "";
  String get getUbicacionCliente => _ubicacionCliente;
  String _puestoCliente = "";
  String get getPuestoCliente => _puestoCliente;
  void setUbicacionCliente(dynamic _item) {
    _ubicacionCliente = _item['ubicacion'];
    _puestoCliente = _item['puesto'];
    notifyListeners();
  }

//=================== BUSCA PERSONA=====================//

  //===================BOTON SEARCH CLIENTE==========================//
//  =================  CREO UN DEBOUNCE ==================//

  Timer? _deboucerSearchBuscaPersona;

  String? _inputBuscaPersona;
  get getInputBuscaClienteMulta => _inputBuscaPersona;
  void onInputBuscaPersonaChange(String? text) {
    _inputBuscaPersona = text;
    print(' GUARDIA MULTA :$_inputBuscaPersona');

//================================================================================//
    if (_inputBuscaPersona!.length >= 3) {
      _deboucerSearchBuscaPersona?.cancel();
      _deboucerSearchBuscaPersona =
          Timer(const Duration(milliseconds: 500), () {
            // setPersona('Guardias');
        buscaListaPersonas(_inputBuscaPersona);
      });
    } else if (_inputBuscaPersona!.isEmpty) {
      buscaListaPersonas('');
    } else {
      buscaListaPersonas('');
    }
//================================================================================//

    notifyListeners();
  }

  String? _parsona = '';
  String? get getPersona => _parsona;

  void setPersona(String? _person) {
    _parsona = _person;
    print('persona : $_person');
    notifyListeners();
  }

  List _listaPersonas = [];

  List get getListaPersonas => _listaPersonas;

  void setInfoBusquedaPersonas(List data) {
    _listaPersonas = [];
    _listaPersonas = data;

    print('los _listaPersonas : $_listaPersonas');

    notifyListeners();
  }

  bool? _errorListaPersona; // sera nulo la primera vez
  bool? get getErrorListaPersona => _errorListaPersona;
  set setErrorListaPersona(bool? value) {
    _errorListaPersona = value;
    notifyListeners();
  }

  Future buscaListaPersonas(String? _search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllPersonasCliente(
      search: _search,
      // estado: 'GUARDIAS',
      estado: '$_parsona',
      // estado: 'ADMINISTRACION',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaPersona = true;

      setInfoBusquedaPersonas(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaPersona = false;
      notifyListeners();
      return null;
    }
  }

  Future buscaListaGuardisDeCliente(String? _search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllGuardiasDeCliente(
      search: _search,
      documento: _docCliente,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaPersona = true;

      setInfoBusquedaPersonas(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaPersona = false;
      notifyListeners();
      return null;
    }
  }

//============== OBTENEMOS LA INFORMACION DEL GUARDIA GUSCADO ===============/

  List<Map<String, dynamic>> _listaGuardias = [];
  List get getListaGuardias => _listaGuardias;
  void getListaDeGuardias(dynamic _inf) {
    _listaGuardias.removeWhere((e) => (e['perId'] == _inf['perId']));

    _listaGuardias.add({
      "perId": _inf['perId'],
      "perDocNumero": _inf['perDocNumero'],
      "perApellidos": _inf['perApellidos'],
      "perNombres": _inf['perNombres'],
      "perEmail": _inf['perEmail'],
      "perFoto": _inf['perFoto'],
    });
    // print('el data del guardia: $_listaGuardias');
    notifyListeners();
  }

  // ================== ELIMINA GUARDIA AGREGADO =====================//
  void eliminaGuardiaListPedido(int id) {
    _listaGuardias.removeWhere((e) => (e['perId'] == id));

    _listaGuardias.forEach(((element) {}));

    notifyListeners();
  }
//============== OBTENEMOS LA INFORMACION DEL GUARDIA BUSCADO ===============/

  List<Map<String, dynamic>> _listaSupervisores = [];
  List get getListaSupervisores => _listaSupervisores;
  void getListaDeSupervisores(dynamic _inf) {
    _listaSupervisores.removeWhere((e) => (e['perId'] == _inf['perId']));

    _listaSupervisores.add({
      "perId": _inf['perId'],
      "perDocNumero": _inf['perDocNumero'],
      "perApellidos": _inf['perApellidos'],
      "perNombres": _inf['perNombres'],
      "perEmail": _inf['perEmail'],
      "perFoto": _inf['perFoto'],
    });
    // print('el data del guardia: $valueListaSupervisores');
    notifyListeners();
  }

  // ================== ELIMINA SUPERVISOR AGREGADO =====================//
  void eliminaSupervisorListPedido(int id) {
    _listaSupervisores.removeWhere((e) => (e['perId'] == id));

    _listaSupervisores.forEach(((element) {}));

    notifyListeners();
  }
//============== OBTENEMOS LA INFORMACION DEL ADMINISTRADOR BUSSCADO ===============/

  List<Map<String, dynamic>> _listaAdministrador = [];
  List get getListaAdministrador => _listaAdministrador;
  void getListaDeAdministrador(dynamic _inf) {
    _listaAdministrador.removeWhere((e) => (e['perId'] == _inf['perId']));

    _listaAdministrador.add({
      "perId": _inf['perId'],
      "perDocNumero": _inf['perDocNumero'],
      "perApellidos": _inf['perApellidos'],
      "perNombres": _inf['perNombres'],
      "perEmail": _inf['perEmail'],
      "perFoto": _inf['perFoto'],
    });
    // print('el data del guardia: $valueListaAdministrador');
    notifyListeners();
  }

  // ================== ELIMINA GUARDIA AGREGADO =====================//
  void eliminaAdministradorListPedido(int id) {
    _listaAdministrador.removeWhere((e) => (e['perId'] == id));

    _listaAdministrador.forEach(((element) {}));

    notifyListeners();
  }

//========================== SELECCIONAMOS BODEGA =======================//

  dynamic _mapBodega;
  String? get getmapBodega => _mapBodega;
  String? _nombreBodega = '';
  String? get getnombreBodega => _nombreBodega;

  void setNombreBodega(Map<String, dynamic> value) {
    _mapBodega;
    _mapBodega = value;
    _nombreBodega = '';
    _nombreBodega = value['bodNombre'];
    print("nombre de bodega: $_nombreBodega");
    notifyListeners();
  }

  List _listBodegas = [];
  List get getListBodegas => _listBodegas;

  void setListBodegas(_value) {
    _listBodegas.add(_value);
// print("LISTA DE BODEGAS: $_listBodegas");

    notifyListeners();
  }

  void resetModalAgregarItems() {
    _nombreBodega = '';
    _listBodegas = [];
    _tipoDePedido = '';
    _stockItem = '';
    notifyListeners();
  }

  String? _tipoDePedido = '';
  String? get getTipoDePedido => _tipoDePedido;

  void setTipoDePedido(String _value) {
    _tipoDePedido = _value;
    print("nombre de _tipoDePedido: $_tipoDePedido");
    notifyListeners();
  }

  List _listTipoDePedido = [];
  List get getListTipoDePedido => _listTipoDePedido;

  void setListTipoDePedido(String _value) {
    _listTipoDePedido.add(_value);
// print("LISTA DE _listTipoDePedido: $_listTipoDePedido");

    notifyListeners();
  }

//==================LISTA LAS BODEGAS======================//

  bool? _errorBodegasPedidos; // sera nulo la primera vez
  bool? get getErrorBodegasPedido => _errorBodegasPedidos;
  set setErrorBodegasPedido(bool? value) {
    _errorBodegasPedidos = value;
    notifyListeners();
  }

  Future buscaBodegasPedidos(String? _search) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllBodegas(
      search: _search,
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorBodegasPedidos = true;

      // print('object response ${response.runtimeType}');
      // print('object response ${response['data']}');
      setListBodegas(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorBodegasPedidos = false;
      notifyListeners();
      return null;
    }
  }

//==================  CREAR UUID V4 =======================//
  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

//=========================================//
//==================  CREAR UUID V4 =======================//
  double _total = 0.0;
  double get getTotalPedido => _total;

  void sumaTotalPedido() {
    _total = 0.0;
// Sumar precios de la lista1
    for (var valor in _listaDeMunisiones) {
      _total += int.parse(valor['valor'].toString());
    }

// Sumar precios de la lista2
if(_listaDeImplementos.isNotEmpty){
 for (var valor in _listaDeImplementos) {
      _total += double.parse(valor['valor'].toString());
    }
}
else{_total = 0;}
   

    notifyListeners();
  }
//===================RESET LAS LISTA DE GUARDIA, SUPERVISRORES Y ADMINISTRADORES======================//
void resetTipoDescuento(){
  _listaGuardias.clear();
  _listaSupervisores.clear();
  _listaAdministrador.clear();
 
}
//=========================================//

}
