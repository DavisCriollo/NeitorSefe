import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';

class CierreBitacoraController extends ChangeNotifier {
  GlobalKey<FormState> cierreBitacoraFormKey = GlobalKey<FormState>();

  final _api = ApiProvider();

  bool validateForm() {
    if (cierreBitacoraFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


//===================BOTON SEARCH CLIENTE==========================//

  bool _btnSearch = false;
  bool get btnSearch => _btnSearch;

  void setBtnSearch(bool action) {
    _btnSearch = action;
    notifyListeners();
  }


//=================BUSCADOR LOCAL==================//
List _bitacoras = [];
List _bitacotasCierradas = [];

  List get getBitacotasCierradasFiltradas => _bitacotasCierradas;

  void setBtacotasCierradas(List bitsC) {
    _bitacoras = bitsC;
     print(' LA RESPUESTA DEL getAllCierreBitacoras; ${_bitacoras}');
    notifyListeners();
  }
 List<dynamic> _allItemsFilters=[];
   List<dynamic> get allItemsFilters => _allItemsFilters;
   void setListFilter( List<dynamic> _list){
  _allItemsFilters = [];

_allItemsFilters.addAll(_list);


  notifyListeners();
 }

//===================================================//

    void search(String query) {
      List<Map<String, dynamic>> originalList = List.from(_bitacotasCierradas); // Copia de la lista original
    if (query.isEmpty) {
      _allItemsFilters = originalList;
    } else {
      _allItemsFilters = originalList.where((item) {
        return 
        item['cliDocNumero'].toLowerCase().contains(query.toLowerCase()) ||
        item['cliRazonSocial'].toLowerCase().contains(query.toLowerCase()) ;
      }).toList();
    }
    notifyListeners();
  }


//====================================//
  Future buscaBitacorasCierre(String? _search, String? notificacion) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getAllCierreBitacoras(
   
      token: '${dataUser!.token}',
    );
    if (response != null) {
     

      List dataSort = [];
      dataSort = response;
      dataSort.sort((a, b) => b['bitcFecha']!.compareTo(a['bitcFecha']!));

      setListFilter(response);
      notifyListeners();
      return response;
    }
    if (response == null) {
    
      notifyListeners();
      return null;
    }
  }



}