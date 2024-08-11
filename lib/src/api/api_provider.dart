// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
// import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/evaluaciones_controller.dart';
import 'package:nseguridad/src/models/auth_response.dart';
import 'package:nseguridad/src/models/foto_url.dart';
import 'package:nseguridad/src/models/get_info_guardia_multa.dart';
import 'package:nseguridad/src/models/list_allClientePedido.dart';
import 'package:nseguridad/src/models/list_allGuardiasPedido.dart';
import 'package:nseguridad/src/models/lista_allClientes.dart';
import 'package:nseguridad/src/models/lista_allComunicados_clientes.dart';
import 'package:nseguridad/src/models/lista_allEstados_cuenta_cliente.dart';
import 'package:nseguridad/src/models/lista_allTipos_multas.dart';
import 'package:nseguridad/src/models/lista_personas_designadas_aCliente.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
// import 'package:nseguridad/src/services/notifications_service.dart' as  snaks;
import 'package:nseguridad/src/utils/dialogs.dart';

import 'package:nseguridad/src/service/notifications_service.dart' as snaks;


class ApiProvider {
//================================= URLS ==============================//
  // final String _dirURL = "https://backsigeop.neitor.com/api";
//=================================  ==============================//
//================================= URLS ==============================//
  final String _dirURL = "https://backsafe.neitor.com/api";
//=================================  ==============================//


  Future<AuthResponse?> login({
    BuildContext? context,
    String? usuario,
    String? password,
    String? empresa,
  }) async {
    try {
      final dataResp = await _http.post(
        
          Uri.parse('$_dirURL/auth/login'),
          body: {"usuario": usuario, "password": password, "empresa": empresa});
      final respo = jsonDecode(dataResp.body);
      print('EL LOGIN  API :${respo}');
        print('EL code  API :${dataResp.statusCode}');

      if (dataResp.statusCode == 404 || dataResp.statusCode == 500) {
       snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responsData = AuthResponse.fromMap(respo);
        return responsData;
      }
      if (dataResp.statusCode == 401) {
          snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }

//================================= RECUPERA CLAVE ==============================//
  Future recuperaClave({
    BuildContext? context,
    String? usuario,
    String? empresa,
  }) async {
    try {
      final dataResp = await _http.post(Uri.parse('$_dirURL/auth/password'),
          body: {"usuario": usuario, "empresa": empresa});
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }

  //=========================GET ALL COMUNICADOS CLIENTES =====================================//
  Future<AllCumunicadosClientes?> getAllComunicadosClientes({
    BuildContext? context,
    int? cantidad,
    int? page,
    String? search,
    String? input,
    bool? orden,
    String? datos,
    String? rucempresa,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/comunicados?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&datos=$datos&rucempresa=$rucempresa');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final responseData = AllCumunicadosClientes.fromJson(dataResp.body);

        return responseData;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
      return null;
    }
  }

  //=========================GET ALL COMUNICADOS CLIENTES =====================================//
  Future getAllComunicados({
    BuildContext? context,
    String? token,
    String? search,
  
    String? notificacion,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/avisos/filtro/0?&search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL MULTAS=====================================//
  Future getAllMultasGuardias({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(

          // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
          '$_dirURL/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

  Future getAllClientesMultas({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL PUESTOS GUALDIAS =====================================//

  Future getAllPuestosClientes({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL CLIENTE MULTAS  =====================================//
  Future<AllClientes?> getAllClientes({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final responseData = AllClientes.fromJson(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL CLIENTE PEDIDOS-DISTRIBUCION =====================================//
  Future<AllClientePedido?> getAllClientesPedidos({
    BuildContext? context,
    String? search,
    String? tipo,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$tipo');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final responseData = AllClientePedido.fromJson(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL GUARDIAS PEDIDOS =====================================//
  Future<AllGuardiasPedido?> getAllGuardiasPedido({
    BuildContext? context,
    String? search,
    String? docnumero,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final response = AllGuardiasPedido.fromJson(dataResp.body);

        return response;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL TIPOS DE MULTAS GUARDIAS =====================================//
  Future<AllTiposMultasGuardias?> getAllTiposMultasGuardias({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/novedades/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final responseData = AllTiposMultasGuardias.fromJson(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL INFO  GUARDIAS =====================================//
  Future<AllGuardias?> getAllInfoGuardias({
    BuildContext? context,
    String? search,
    String? docnumero,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = AllGuardias.fromJson(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL INFO GUARDIAS CONSIGNAS =====================================//
  Future getAllInfoGuardiasConsignas({
    BuildContext? context,
    String? search,
    String? docnumero,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL INPLEMENTOS PARA GUARDIAS =====================================//
  // Future<AllImplementoPedido?> getAllImplementoPedido({
  //   BuildContext? context,
  //   String? search,
  //   String? token,
  // }) async {
  //   try {
  //     final url = Uri.parse('$_dirURL/inventario/filtro/0?search=$search');

  //     final dataResp = await _http.get(
  //       url,
  //       headers: {"x-auth-token": '$token'},
  //     );

  //     if (dataResp.body.isEmpty) {
  //       return null;
  //     }
  //     if (dataResp.statusCode == 200) {
  //       // final responseData = AllImplementoPedido.fromJson(dataResp.body);
  //        final responseData = jsonDecode(dataResp.body);

  //       return responseData;
  //     }
  //     if (dataResp.statusCode == 404) {
  //       return null;
  //     }
  //     if (dataResp.statusCode == 401) {
  //       Auth.instance.deleteSesion(context!);

  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
  Future getAllImplementoPedido({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/inventario/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        // final responseData = AllImplementoPedido.fromJson(dataResp.body);
         final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL INFORMES DE GUARDIAS =====================================//
  Future getAllInformesGuardia({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/informes/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL GUARDIAS =====================================//
  Future getAllGuardias({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/personas/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL GUARDIAS POR CLIENTES =====================================//
  Future getAllGuardiasPorCliente({
    String? search,
    // String? estado,
    String? docnumero,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/personas/listado/0?docnumero=$docnumero');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET INFO GUARDIA QR =====================================//
  Future getGuardiaQR({
    BuildContext? context,
    String? codigoQR,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/personas/$codigoQR?tipo=QR');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET INFO CLIENTES QR =====================================//
  Future getClienteQR({
    BuildContext? context,
    String? codigoQR,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/clientes/$codigoQR?tipo=QR');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL AVISO DE SALIDA DE LOS  GUARDIAS =====================================//
  Future getAllAvisosSalida({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/avisosalidas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALLCAMBIO DE LOS  GUARDIAS =====================================//
  Future getAllCambioPuesto({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/cambiopuesto/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL AUSENCIAS DE LOS  GUARDIAS =====================================//
  Future getAllAusencias({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/ausencias/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL TURNOS EXTRAS =====================================//
  Future getAllTurnosExtras({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/turnoextra/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL CONSIGNAS CLIENTES  =====================================//
  Future getAllConsignasClientes({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/consignas/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL PEDIDOS GUARDIAS =====================================//
  Future getAllPedidos({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? tipo,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          // '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');
          '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final response = jsonDecode(dataResp.body);

        return response;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL PEDIDOS ACTIVOS =====================================//
  Future getAllPedidosActivos({
    BuildContext? context,
    String? search,
    String? tipo,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/pedidos/pedidos_activos/0?search=$search&tipo=$tipo');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final response = jsonDecode(dataResp.body);

        return response;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL DISTRIBUCION  =====================================//
  Future getAllDistribucion({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? tipo,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final response = jsonDecode(dataResp.body);

        return response;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL PERSONAL DESIGNADO =====================================//
  Future<AllPersonasDesignadas?> getAllPersonalDesignado({
    BuildContext? context,
    String? docnumero,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/personas/listado/0?docnumero=$docnumero');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.statusCode == 200) {
        final responseData = AllPersonasDesignadas.fromJson(dataResp.body);

        return responseData;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL ESTADO CUENTA CLIENTES CLIENTES =====================================//
  Future<AllEstadosCuentaCliente?> getAllEstadosdeCuentaClientes({
    BuildContext? context,
    int? cantidad,
    int? page,
    String? search,
    String? input,
    bool? orden,
    String? datos,
    String? rucempresa,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/estadocuentas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&datos=$datos&rucempresa=$rucempresa');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      if (dataResp.statusCode == 200) {
        final responseData = AllEstadosCuentaCliente.fromJson(dataResp.body);
        return responseData;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL ACTIVIDADES =====================================//
  Future getAllActividades({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/actividades/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        return 401;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL ACTIVIDADES =====================================//
  Future getAllActividadesAsignadas({
    BuildContext? context,
    String? search,
      String? notificacion,
         String? opcion,
    String? token,
  }) async {
    
    try {
    
   
  
      final url = Uri.parse('$_dirURL/actividades_asignadas/filtro/0?search=$search&notificacion=$notificacion&opcion=$opcion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

// print("ESTA ES LA DATA ${dataResp.body}");

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        return 401;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================GET ALL CLIENTES =====================================//
  Future getAllClientesVarios({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          'https://backsigeop.neitor.com/api/clientes/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        // print('RESPONSE CLIENTES MULTAS: ${dataResp.body}');

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//=====================================================================================//
//================================= TOKEN ID ==============================//
  Future sentIdToken({
    BuildContext? context,
    String? tokennotificacion,
    String? token,
  }) async {
    try {
      print('Se envia a la api Token FCM $tokennotificacion');
      final uri = Uri.parse('$_dirURL/notificaciones/token');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = {
        "tokennotificacion": tokennotificacion,
      };


        

      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

          print('Recibe de la api Token FCM ${dataResp.body}');

        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL NOTIFICACIONES1 PUSH =====================================//
  Future getAllNotificacionesPush({
    BuildContext? context,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/notificaciones/listado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      final responseData = jsonDecode(dataResp.body);

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        // Auth.instance.deleteSesion(context!);
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL NOTIFICACIONES2 PUSH =====================================//
  Future getAllNotificacionesPush2({
    BuildContext? context,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/notificaciones/listado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
        
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

//================================= DELETE TOKEN FIREBASE ==============================//
  Future deleteTokenFirebase({
    BuildContext? context,
    String? tokennotificacion,
    String? token,
  }) async {
    try {
      final uri = Uri.parse(
          '$_dirURL/notificaciones/token/eliminar');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = {
        "tokennotificacion": tokennotificacion,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
         print('RESPUESTA  de la api AL ELIMINAR Token FCM ${dataResp.body}');
        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
       return null;
    }
  }

//================================= RECOPERA TOKEN DEL SERVIDOR ==============================//
  Future revisaTokenTurno({
    BuildContext? context,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/session');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

            // print('LA DATA DE TURNO core *******> : ${dataResp.body} -*- ${dataResp.statusCode}');
     if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

          // print('LA DATA DE TURNO *******> : ${responseData}');

       return responseData;
       
      }
      if (dataResp.statusCode == 404) {
        
        return null;
      }
      if (dataResp.statusCode == 401) {
         snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");
       
        Auth.instance.deleteSesion(context!);
       return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL PERSONAS DIRIGIDO A =====================================//
  Future getAllPersonasDirigidoA({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/personas/filtroporareadepartamento/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

print('verificacion ***** > :${dataResp.body}');
      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

//================================= DELETE TOKEN FIREBASE ==============================//
  Future validaTokenUsuarios({
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/auth');

      final dataRespToken = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
 if (dataRespToken.body.isEmpty) {
        return null;
      }
      if (dataRespToken.statusCode == 200) {
        final responseData = jsonDecode(dataRespToken.body);
       return responseData;
      }
      if (dataRespToken.statusCode == 404) {
        return null;
      }
      if (dataRespToken.statusCode == 401) {
        
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL PREGUNTAS =====================================//
  Future getAllPreguntas({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/encuestas_evaluaciones/filtro/0');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
  final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
      return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL BUSCA PREGUNTAS=====================================//
  Future getSearchPreguntas({
    BuildContext? context,
    String? search,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/encuestas_evaluaciones/$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
 final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
       
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //========================= GUARDA ENCUESTA-ECALUACION GUARDIA =====================================//
  Future saveEvaluacion({
   
    EvaluacionesController? controller,
    dynamic data,
    List<TextEditingController>? controllersText,
    String? token,
  }) async {
    try {
      var _dio = Dio();
      final dataResp = await _dio.put(
          '$_dirURL/encuestas_evaluaciones/0',
          data: data,
          options: Options(headers: {'x-auth-token': '$token'}));

      if (dataResp.data.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.data);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL INFORMACION DE JEFE OPERATIVO =====================================//
  Future getDataJefeOperaciones({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? estado,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/personas/filtroporareadepartamento/0?search=$search&notificacion=$notificacion&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
 final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
       return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL CAPACITACIONES =====================================//
  Future getAllCapacitaciones({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/capacitaciones/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
 final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);
       return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL SUGERENCIAS=====================================//
  Future getAllSugerencias({
    BuildContext? context,
    String? search,
    String? tipo,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(

          '$_dirURL/mejoracontinua/filtro/0?tipo=$tipo&search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL SUGERENCIAS=====================================//
  Future getGuardiasReemplazoAusencias({
    BuildContext? context,
    List<String>? listaIds,
   
    String? token,
  }) async {


String  _listaTurnos='';
  
_listaTurnos =listaIds!
      .map((val) => val.trim())
      .join(',');
  // print(result);
  // _listaTurnos=result;


print('LOS IDS:${_listaTurnos}');




    try {
      final url = Uri.parse( '$_dirURL/turnoextra/byid?lista=$_listaTurnos');
          // '$_dirURL/turnoextra/byid?lista=$_listaTurnos');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

// print('LOS REEMPLAZOS API :${respo}');

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//  Future guardaInventarioInterno({
//     BuildContext? context,
//    dynamic infoInventarioInterno
//   }) async {
//     try {
//       // print(infoInventarioInterno);
//       final dataResp = await _http.post(
        
//           Uri.parse('$_dirURL/procesando_actividades/'),
//           body: {
//                   "act_asigId": infoInventarioInterno['act_asigId'], //id registro
//   "titulo": infoInventarioInterno['titulo'], 
//   "qr": "", // vacio
//   "fotos": [], //no obligatorio (3max)
//   "videos": [], // no obligatorio (1max)
//   "vestimentas": infoInventarioInterno['vestimentas'],
//   "armas":infoInventarioInterno['armas'], //formar de acuerdo al listado del endpoint (si existe true caso contrario false)
//   "municiones": infoInventarioInterno['municiones'],
//             });
//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       print('-ERROR -> $e');
//     }
//   }

 Future guardaInventarioInterno({
    BuildContext? context,
   dynamic infoInventarioInterno,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$_dirURL/procesando_actividades/');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = {
                  "act_asigId": infoInventarioInterno['act_asigId'], //id registro
  "titulo": infoInventarioInterno['titulo'], 
  "qr": "", // vacio
  "fotos": [], //no obligatorio (3max)
  "videos": [], // no obligatorio (1max)
  "vestimentas": infoInventarioInterno['vestimentas'],
  "armas":infoInventarioInterno['armas'], //formar de acuerdo al listado del endpoint (si existe true caso contrario false)
  "municiones": infoInventarioInterno['municiones'],
            };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }

}
//  Future guardaActividadDeRonda({
//     BuildContext? context,
//    dynamic infoInventarioInterno,
//     String? token,
//   }) async {
//     try {
//       // print(' longitud ${infoInventarioInterno['coordenasGps']['longitud'].runtimeType}');
//       // print(' latitud ${infoInventarioInterno['coordenasGps']['latitud'].runtimeType}');
//       // print(' ss ${infoInventarioInterno['coordenasGps']}');

// // final _coordenadas=
// // {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']};

// //       // print(' ok $_coordenadas}');
// //       // print(' ==== ${infoInventarioInterno['coordenasGps']['latitud']} == ${infoInventarioInterno['coordenasGps']['longitud']}');

//       final uri = Uri.parse('$_dirURL/procesando_actividades/');
//       final headers = {
//         'Content-Type': 'application/json',
//         "x-auth-token": "$token"
//       };
//       Map<String, dynamic> body = 
      
//       {
//     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],
//   "coordenasGps": infoInventarioInterno['coordenasGps']
//       };
//   // {infoInventarioInterno['coordenasGps'][0],infoInventarioInterno['coordenasGps'][1]}
//   // {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']} // obligatorio, coordenadas del punto del guardia.

//             // };
//       String jsonBody = json.encode(body);
//       final encoding = Encoding.getByName('utf-8');

//       final dataResp = await _http.post(
//         uri,
//         headers: headers,
//         body: jsonBody,
//         encoding: encoding,
//       );
//         print('LOS DATOS RESPONSE:${dataResp.body}');

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         print('LOS responseData:${responseData}');

//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }

// }

// Future guardaActividadDeRonda(  
//  { BuildContext? context,
//    dynamic infoInventarioInterno,
//     String? token,}
// ) async {
   
//   Map<String, String> headers = {
//    'Content-Type': 'application/json',
//         "x-auth-token": "$token"
//   };

//   Map<String, dynamic> body = {
//        "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],// no obligatorio pero (1max)
//   "coordenasGps": infoInventarioInterno['coordenasGps']
  
//   };

//   try {
//     final response = await _http.post(
//       Uri.parse('$_dirURL/procesando_actividades/'),
//       headers: headers,
//       body: jsonEncode(body),
//     );

//     if (response.statusCode == 200) {
//       // Petición exitosa, maneja la respuesta según tus necesidades
//       print('Respuesta: ${response.body}');
//     } else {
//       // Error en la petición, maneja el caso según tus necesidades
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Error al realizar la petición, maneja el caso según tus necesidades
//     print('Error: $e');
//   }
// }



Future guardaActividadDeRonda(

{
    BuildContext? context,
   dynamic infoInventarioInterno,
    String? token,
  }


) async {

  String url = '$_dirURL/procesando_actividades/';  // Reemplaza con tu URL de destino

  // Dio dio = Dio();
// Map<String, dynamic> data = {
  //   "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
  // "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
  // "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
  // "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
  // "videos": infoInventarioInterno['videos'],
  // "coordenasGps": _coordenadas
  // //infoInventarioInterno['coordenasGps']
  //     };
  Map<String, dynamic> data ={};
// if (infoInventarioInterno['lugar']=="RONDAS"){
  final _coordenadas=
{"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']};

  
data = {
    "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
  "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
  "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
  "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
  "videos": infoInventarioInterno['videos'],
   "coordenasGps":
   {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']} ,
    "id": infoInventarioInterno['id'],

      };
// }
// else if (infoInventarioInterno['lugar']=="INVENTARIO EXTERNO") {
//  data = {
//     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],
//   };

  try {
    // final response = await dio.post(
    //   url,
    //   data: data,
    //    options: Options(headers: {
    //      'Content-Type': 'application/json',
    //     'x-auth-token': '$token'
    //     }));

  final Map<String, String> cabeceras = {
    'Content-Type': 'application/json',
    'x-auth-token': '$token',
  };

 
          // print('LA DATA DE RONDAS *******> : ${data}');

  final response = await _http.post(
    Uri.parse(url),
    headers: cabeceras,
    body: json.encode(data), // Asegúrate de importar 'dart:convert'
  );





  // print('Respuesta  ${response.statusCode}');

  // print('la Respuesta de laa api : ${response.body}');


     if (response.statusCode == 404|| response.statusCode == 500) {
String errorMsg = json.decode(response.body)['msg'];
snaks.NotificatiosnService.showSnackBarDanger(errorMsg);

        return response;
      }
//       if (response.statusCode == 500) {
//     String errorMsg = json.decode(response.body)['msg'];
// snaks.NotificatiosnService.showSnackBarDanger(errorMsg);
//         return response.body;
//       }
      if (response.statusCode == 200) {
           print('Respuesta DE LA RONDA OK *****> : ${response.body}');
           
           
        return response;
      }
      if (response.statusCode == 401) {
          //  print('Respuesta 200: ${response.body}');
          snaks.NotificatiosnService.showSnackBarDanger('inicie seerion nuevamente');
        Auth.instance.deleteSesion(context!);


        return null;
      } 
    else {
      // Error en la petición, maneja el caso según tus necesidades
      // print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Error al realizar la petición, maneja el caso según tus necesidades
    print('Error: $e');
       snaks.NotificatiosnService.showSnackBarDanger("$e");
  }
}

Future guardaActividadDeInventario(

{
    BuildContext? context,
   dynamic infoInventarioInterno,
    String? token,
  }


) async {

  String url = '$_dirURL/procesando_actividades/';  // Reemplaza con tu URL de destino

  Dio dio = Dio();
// Map<String, dynamic> data = {
  //   "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
  // "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
  // "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
  // "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
  // "videos": infoInventarioInterno['videos'],
  // "coordenasGps": _coordenadas
  // //infoInventarioInterno['coordenasGps']
  //     };
  Map<String, dynamic> data ={};

data = {
    "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
  "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
  "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
  "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
  "videos": infoInventarioInterno['videos'],
   "id": infoInventarioInterno['id'],
 

      };
// }
// else if (infoInventarioInterno['lugar']=="INVENTARIO EXTERNO") {
//  data = {
//     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],
//   };


  try {
    final response = await dio.post(
      url,
      data: data,
       options: Options(headers: {
         'Content-Type': 'application/json',
        'x-auth-token': '$token'
        }));
  // print('la Respuesta de laa api : ${response.data}');
     if (response.statusCode == 404) {
          // print('Respuesta: ${response.data}');
        return null;
      }
      if (response.statusCode == 500) {
          // print('Respuesta: ${response.data}');
        return response.data;
      }
      if (response.statusCode == 200) {
          // print('Respuesta: ${response.data}');
        return response.data;
      }
      if (response.statusCode == 401) {
          //  print('Respuesta: ${response.data}');
        Auth.instance.deleteSesion(context!);

        return null;
      } 
    else {
      // Error en la petición, maneja el caso según tus necesidades
      // print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Error al realizar la petición, maneja el caso según tus necesidades
    print('Error: $e');
  }
}
// }


//=====================================================//
// Future  obtenerHoraDesdeInternet() async {
//   final response = await _http.get(Uri.parse('http://worldclockapi.com/api/json/utc/now'));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final hora = data['currentDateTime'];

//     return hora;
//   }
//      if (response.statusCode == 404 ||response.statusCode == 401 ||response.statusCode == 500) {
//           // print('Respuesta: ${response.data}');
//         return null;
      
       









//   } else {
//     throw Exception('Error al obtener la hora desde Internet');
//   }
// }





//=====================================================//



  //=========================GET ALL bitacotas CLIENTES =====================================//
  Future getAllBitacoras({
    BuildContext? context,
    String? token,
    String? search,
    String? tipo,
    String? idTurno,
      
    String? notificacion,
  }) async {

String _path='';
if(tipo=='CLIENTE'||tipo=='RESIDENTE'){
_path='$_dirURL/bitacora/cliente_residente';


}else{

_path='$_dirURL/bitacora/filtro/0?&search=$search&notificacion=$notificacion&regId=$idTurno';


}

    try {
      final url = Uri.parse(
          // '$_dirURL/bitacora/filtro/0?&search=$search&notificacion=$notificacion&regId=$idTurno');
          // '$_dirURL/bitacora/filtro/0?search&regId=1073');
        // '$_dirURL/bitacora/cliente_residente');
        //  '$_dirURL/$_path!');
         _path);

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

// print(' LA RESPUESTA DEL GET; ${dataResp.body}');


      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo['data'];
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

  Future getAllPersonasBitacora({
    BuildContext? context,
    String? search,
    String? regId,
    String? cliId,
    String? cliUbicacion,
    String? cliPuesto,
    String? token,
  }) async {
    try {
      final url =
          // Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');
          Uri.parse('$_dirURL/residentes/filtro/0?search=$search&regId=$regId&cliId=$cliId&cliUbicacion=$cliUbicacion&cliPuesto=$cliPuesto');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

        // print('Respuesta: ${respo.runtimeType}');


      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL RESIDENTES =====================================//
  Future getAllResidentes({
    BuildContext? context,
    String? token,
    String? search,
    String? idCli,
    String? notificacion,
  }) async {
    try {
      final url = Uri.parse(
          // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
          '$_dirURL/residentes/byCliId/0?&search=$search&notificacion=$notificacion&cliId=$idCli');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
       print('la data de residentes ********************* :${respo.body} ');
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL RESIDENTES GUARDIA=====================================//
  Future getAllResidentesGuardia({
    BuildContext? context,
    String? token,
    String? search,
    String? regId,
    String? cliId,
    String? cliUbicacion,
    String? cliPuesto,
  }) async {
    try {
      final url = Uri.parse(
          // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
          // '$_dirURL/residentes/byCliId/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
          // '$_dirURL/residentes/filtro/0?search=$search&regId=$regId&cliId=$cliId&cliUbicacion=$cliUbicacion&cliPuesto=$cliPuesto');
          '$_dirURL/residentes/listarDelTurnoIniciado/0?regId=$regId');
          

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
        // print('la data de residentes--------------------> :${dataResp.body} ');
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        
        
        // print('la data de residentessss :${respo} ');
        return respo;



      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL RESIDENTES =====================================//
  Future getClientePorId({
    BuildContext? context,
    String? token,
    String? idCli,
   
  }) async {
    try {
      final url = Uri.parse(
          // '$_dirURL/clientes/$idCli?tipo=QR');
          // '$_dirURL/clientes/1470?tipo=QR');
          'https://backsigeop.neitor.com/api/clientes/1470?tipo=QR');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

// print('EL RESPONSE : ${dataResp.body}');


      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL RESIDENTES =====================================//
  Future getAllClienteResidentes({
    BuildContext? context,
    String? token,
    String? search,
    String? idCli,
    String? notificacion,
  }) async {
    try {
      final url = Uri.parse(
          // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
          '$_dirURL/residentes/midata/0?&search=$search&notificacion=$notificacion&cliId=$idCli');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        print('LA DATA DE BITACORA --------- > $respo');
        if (respo=={}) {
           return null;
        } else {
 return respo;
        }
       
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL GUARDIAS =====================================//
  Future getAllPersonasCliente({
    BuildContext? context,
    String? search,
    String? estado,
    String? token,
  }) async {

    try {
      final url =
          Uri.parse('$_dirURL/personas/filtro/0?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL BODEGAS PEDIDO =====================================//
  Future getAllBodegas({
    BuildContext? context,
    String? search,

    String? token,
  }) async {

    try {
      final url =
          Uri.parse('$_dirURL/bodegas/filtro/0?search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================GET ALL INVENTARIO=====================================//
  Future getAllInventario({
    BuildContext? context,
    String? search,
    String? bodega,
    String? tipo,

    String? token,
  }) async {

    try {
      final url =
          Uri.parse('$_dirURL/inventario/filtroserie/0?tipo=$tipo&bodega=$bodega&nombre=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================GET ALL INVENTARIO MUNISIONES=====================================//
  Future getAllInventarioMunisiones({
    BuildContext? context,
    String? search,
    String? bodega,
    String? tipo,

    String? token,
  }) async {

    try {
      final url =
          Uri.parse('$_dirURL/inventario/filtroanidado/0?tipo=$tipo&bodega=$bodega&nombre=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================GET ALL GUARDIAS =====================================//
  Future getAllGuardiasDeCliente({
    BuildContext? context,
    String? search,
    String? documento,
    String? token,
  }) async {

    try {
      final url =
          Uri.parse('$_dirURL/personas/listado/0?docnumero=$documento&search=$search');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

 //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

  Future getAllFaltasInjustificadas({
    BuildContext? context,
    String? token,
    String? tipo,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/nominanovedades/byFaltasInjustificadas?tipo=$tipo');
        
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

 //=========================GET ALL MULTAS=====================================//
  Future getIdTurnoMultas({
    BuildContext? context,
    String? idTurno,
    String? token,
  }) async {
    try {
      final url = Uri.parse(

          // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
          '$_dirURL/nominanovedades/getMultaById?lista=$idTurno');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

  //  print('Respuesta: ${respo}');

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }
 //=========================GET PERSONA POR ID=====================================//
  Future getIdPersona({
    BuildContext? context,
    String? idTurno,
    String? token,
  }) async {
    try {
      final url = Uri.parse(

          // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
          '$_dirURL/personas/perfil/$idTurno');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

  //  print('Respuesta: ${respo}');

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }




 //=========================GET ALL ROLES =====================================//
  Future getAllRolesPago({
    BuildContext? context,
      String? token,
  }) async {
    
    try {
    
   
  
      final url = Uri.parse('$_dirURL/rolpagos/byUser');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
        

// print('ROLES : ${dataResp.body}');


      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
     
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;

      }
    } catch (e) {
      return null;
    }
  }

 //=========================GET ALL GESTIODOCUMENTAL =====================================//
  Future getAllGestionDocumental({
    BuildContext? context,
    String? search,
    String? estado,
      String? token,
  }) async {
    
    try {
    
   
  
      final url = Uri.parse('$_dirURL/acta_entrega_recepcion/byUser?search=$search&estado=$estado');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
        

// print('ROLES : ${dataResp.body}');


      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
     
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;

      }
    } catch (e) {
      return null;
    }
  }

 //=========================ENVIA LOS URLTEMPORALES =====================================//

Future saveUrlAlServidor({ BuildContext? context,File? urlFile, String? token}) async {
  try {
     var request = _http.MultipartRequest(
        'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

    //for token
    request.headers.addAll({"x-auth-token": '$token'});

    request.files
        .add(await _http.MultipartFile.fromPath('foto', urlFile!.path));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);
// print('LISTA SERVER: ${responsed.body}');
      if (responsed.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "No se puede agregar Contenido");

        return null;
      
      }
      if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      // print('LISTA foto: ${responseFoto.urls[0].url}');
     return  responseFoto.urls[0].url;
      }
      if (responsed.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;

      }



  } catch (e) {
 return null;
  }

   

}
 //=========================ELIMINA FOTO DEL SERVIDOS=====================================//

  Future deleteUrlDelServidor({List<Map<String, String>>? datos, String? token}) async {
    try {

var request = _http.MultipartRequest('POST', Uri.parse('$_dirURL/multimedias'));
 request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        "x-auth-token": '$token'
      });

// Convierte el array de objetos a una cadena JSON
String arrayDeObjetosJson = jsonEncode(datos);

// Añade el array de objetos al request
request.fields['eliminar'] = arrayDeObjetosJson;

var response = await request.send();
      // print('=== 200 ===> ${response.reasonPhrase}');
 if (response.statusCode == 200) {
      // print('=== 200 ===> ${response.reasonPhrase}');
      return true;
    }  
    if (response.statusCode == 404) {
        // snaks.NotificatiosnService.showSnackBarDanger(
        //     "=== 404 ===>  No se puede agregar foto");
        return false;
       }
      if (response.statusCode == 401) {
        // snaks.NotificatiosnService.showSnackBarDanger(
        //     "=== 401 ===>  Debe inciar sesión nuevamente");

        return false;

      }

    } catch (err) {

      return false;
    }
  }



//************************************************** NUEVOS ******************************************************/


  //=========================GET ALL AUSENCIAS DE LOS  GUARDIAS =====================================//
  Future getAllNuevosPermisos({
    BuildContext? context,
    String? search,
    String? notificacion,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/permisos/filtro/0?search=$search&notificacion=$notificacion');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }



  //=========================GET ALL HORAS =====================================//
  Future getAllPersonasNuevo({
    BuildContext? context,
    String? search,

    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/personas/filtro/0?search=$search');
      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL HORAS =====================================//
  Future getAllHorario({
    BuildContext? context,
    int? id,

    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/horarios_jornada_laboral/byIdPersona/$id');
      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

      if (dataResp.body.isEmpty) {
        return null;
      }

      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //=========================GET ALL HORAS =====================================//
  Future getAllDiasHabiles({

    BuildContext? context,
    List? idFechas,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$_dirURL/horarios_jornada_laboral/dias-habiles-permiso');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = {
        "dias": idFechas
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
       print('la informacion dias habiles API: ${dataResp.body}');
      if (dataResp.statusCode == 404) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
       Dialogs.alert(context!, title: 'Atención', description: '${message['msg']}');
        return dataResp;
    
      }
      if (dataResp.statusCode == 500) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
         Dialogs.alert(context!, title: 'Atención', description: '${message['msg']}');
       
        return dataResp;
    
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return dataResp;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }




  //=========================GET ALL HORAS =====================================//
  Future getAllTurnosDiasLibres({

    BuildContext? context,
    Map<String,dynamic>? data,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$_dirURL/horarios_jornada_laboral/dias-libres');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = data!;
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
          // print('la informacion dias LIBRES API: ${dataResp.body}');
      //  print('la ataResp.statusCode API: ${dataResp.statusCode}');
      if (dataResp.statusCode == 404||dataResp.statusCode == 200||dataResp.statusCode == 500 ||dataResp.statusCode == 403) {
      //    Map<String, dynamic> message = jsonDecode(dataResp.body);
      //  Dialogs.alert(context!, title: 'Atención', description: '${message['msg']}');
        return dataResp;
    
      }
      
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
//=========================GET ALL SUGERENCIAS=====================================//
  Future getGuardiasReemplazoPermiso({
    BuildContext? context,
    List<String>? listaIds,
   
    String? token,
  }) async {


String  _listaTurnos='';
  
_listaTurnos =listaIds!
      .map((val) => val.trim())
      .join(',');
  // print(result);
  // _listaTurnos=result;


// print('LOS IDS:${_listaTurnos}');




    try {
      final url = Uri.parse( '$_dirURL/turnos_extras/byIds/$_listaTurnos');
          // '$_dirURL/turnoextra/byid?lista=$_listaTurnos');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

// print('LOS REEMPLAZOS API :${respo}');

      if (dataResp.body.isEmpty) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        // print('LOS REEMPLAZOS API :${respo['data']}');
        return respo['data'];
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }



//=========================GET ALL MANTENIMIENTO =====================================//
  Future getAllMantenimiento({

    // BuildContext? context,
    // List? idFechas,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/actualizaciones/mostrarMensaje/app');
        
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      //  print('RESPUESTA DE MANTENIMIENTO: ${dataResp.body} ---- ${dataResp.statusCode}');
      // final respo = jsonDecode(dataResp.body);
      //  print('RESPUESTA DE MANTENIMIENTO: ${dataResp.body} ---- ${dataResp.statusCode}');
      if (dataResp.statusCode == 404) {
      //    Map<String, dynamic> message = jsonDecode(dataResp.body);
      //  Dialogs.alert(context!, title: 'Atención', description: '${message['msg']}');
        return null;
    
      }
      if (dataResp.statusCode == 500) {
        //  Map<String, dynamic> message = jsonDecode(dataResp.body);
        //  Dialogs.alert(context!, title: 'Atención', description: '${message['msg']}');
       
        return null;
    
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);
        return responseData;
      }
      if (dataResp.statusCode == 401) {
        // Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


//**********//

//=========================GET ALL HORAS =====================================//
  Future cambiarClaveUsuario({

    BuildContext? context,
    Map<String,dynamic>? data,
    int? id,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$_dirURL/personas/update/$id');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = data!;
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.put(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
          print('la informacion para la API: ${jsonBody} -- ${token}');
      //  print('la ataResp.statusCode API: ${dataResp.statusCode}');
      if (dataResp.statusCode == 200) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
          print('lRESPUESTA API: ${message} ');
      
        return message;
    
      }
        if (dataResp.statusCode == 404||dataResp.statusCode == 500 ||dataResp.statusCode == 403) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
          print('lRESPUESTA API: ${message} ');
       Dialogs.alert(context!, title: 'Información', description: '${message['msg']}');
        return null;
    
      }
      
      // if (dataResp.statusCode == 401) {
      //   Auth.instance.deleteSesion(context!);

      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }


//=========================GET ALL meses de horario =====================================//
  Future getAllMesesHorario({

    BuildContext? context,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/horarios/meses_de_horario/0');
        
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
          // print('la informacion para la API: ${dataResp.body}');
          //  print('lsdfsdRESPUESTA API: ${dataResp.body.runtimeType} ');
          //   List<Map<String, dynamic>> jsonList = jsonDecode(dataResp.body);
          //       print('message API: ${jsonList.runtimeType} ');
      //  print('la ataResp.statusCode API: ${dataResp.statusCode}');
      if (dataResp.statusCode == 200) {
        //  print('la informacion para la API: ${dataResp.body}');
        //    print('lsdfsdRESPUESTA API: ${dataResp.body.runtimeType} ');
            // List<Map<String, dynamic>> jsonList = jsonDecode(dataResp.body);
        //         print('message API: ${jsonList.runtimeType} ');
          // print('lRESPUESTA API: ${message.runtimeType} ');
      
        return dataResp.body;
    
      }
        if (dataResp.statusCode == 404||dataResp.statusCode == 500 ||dataResp.statusCode == 403) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
          // print('lRESPUESTA API: ${message} ');
       Dialogs.alert(context!, title: 'Información', description: '${message['msg']}');
        return null;
    
      }
      
      // if (dataResp.statusCode == 401) {
      //   Auth.instance.deleteSesion(context!);

      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }


//=========================GET ALL meses de horario =====================================//
  Future getAllNotificacionesMenu({

    BuildContext? context,
    String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/notificaciones/grupos_notificaciones');
        
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      //     print('la informacion para la API: ${dataResp.body}');
      //      print('lsdfsdRESPUESTA API: ${dataResp.body.runtimeType} ');
      //     //   List<Map<String, dynamic>> jsonList = jsonDecode(dataResp.body);
      //     //       print('message API: ${jsonList.runtimeType} ');
      //  print('la ataResp.statusCode API: ${dataResp.statusCode}');
      if (dataResp.statusCode == 200) {
        //  print('la informacion para la API: ${dataResp.body}');
        //    print('lsdfsdRESPUESTA API: ${dataResp.body.runtimeType} ');
            // List<Map<String, dynamic>> jsonList = jsonDecode(dataResp.body);
        //         print('message API: ${jsonList.runtimeType} ');
          // print('lRESPUESTA API: ${message.runtimeType} ');
      
        return dataResp.body;
    
      }
        if (dataResp.statusCode == 404||dataResp.statusCode == 500 ||dataResp.statusCode == 403) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
          // print('lRESPUESTA API: ${message} ');
       Dialogs.alert(context!, title: 'Información', description: '${message['msg']}');
        return null;
    
      }
      
      // if (dataResp.statusCode == 401) {
      //   Auth.instance.deleteSesion(context!);

      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }

  //=========================GET CEDULA VISITANTE=====================================//
  Future getCedulaVisita({
    
    String? token,
    String? search,
    String? tipo,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/personas/searchByCedulaOfRuc/0?search=$search&perfil=$tipo');
          

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
        // print('la data de LA CEDULA :${dataResp.body} ');
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        
        
        print('LA CEDULA :${respo} ');
        print('LA respo-perDocNumero : ${respo['perDocNumero']} ');
        if (respo['perDocNumero'].isEmpty) {
          return null;
        } 
          return respo;
       
        



      }
 if (dataResp.statusCode == 500) {
        Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 404) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 401) {
       

        return null;
      }
    } catch (e) {
      return null;
    }
  }



  //=========================GET CEDULA VISITANTE=====================================//
  Future getPlacaVehiculoVisita({
    
    String? token,
    String? placa,
    
  }) async {

   print('PLACA PARA API:${placa} ');


    try {
      final url = Uri.parse('$_dirURL/personas/searchByPlaca/0?placa=$placa');
          

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
        print('la data de LA paca api:${dataResp.body} ');
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        
        
        // print('LA CEDULA :${respo} ');
        return respo;



      }
 if (dataResp.statusCode == 500) {
        Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 404) {
         Map<String, dynamic> message = jsonDecode(dataResp.body);
        NotificatiosnService.showSnackBarError(message['msg']);
        return null;
      }
      if (dataResp.statusCode == 401) {
       

        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL VITACORAS VISITAS =====================================//
  Future getAllBitacorasVisitas({
    BuildContext? context,
    String? token,
    String? search,
    String? tipo,
    String? idTurno,
      
    String? notificacion,
  }) async {

String _path='';
if(tipo=='CLIENTE'||tipo=='RESIDENTE'){
_path='$_dirURL/bitacora/cliente_residente';


}else{

_path='$_dirURL/bitacora/cliente_residente?search=$search&notificacion=$notificacion';


}

    try {
      final url = Uri.parse(
          // '$_dirURL/bitacora/filtro/0?&search=$search&notificacion=$notificacion&regId=$idTurno');
          // '$_dirURL/bitacora/filtro/0?search&regId=1073');
        // '$_dirURL/bitacora/cliente_residente');
        //  '$_dirURL/$_path!');
         _path);

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );

// print(' LA RESPUESTA DEL GET; ${dataResp.body}');


      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo['data'];
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


  //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

  Future getAllVisitasResidente({
    BuildContext? context,
    String? propietario,
      String? residente,
        String? token,
  }) async {
    try {
      final url =
          Uri.parse('$_dirURL/bitacora/misvisitantes/0?id_residente=$residente&id_propietario=$propietario');
          final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);

      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }


//*******************************//

  //=====================================GET ALL ESTUDIANTES VOLTA=====================================//
  Future getAllEstudiantesPruebaVolta(
    // {
    
    // String? token,
    // String? search,
    // String? tipo,
  ) async{   
   try {
      final dataResp = await _http.post(
        
          Uri.parse('https://api.ueavolta.edu.ec/api/grades/search'));
          // body: {"usuario": usuario, "password": password, "empresa": empresa});
      final respo = jsonDecode(dataResp.body);
      print('LA  API :${respo}');
       print('LA  API :${respo.runtimeType}');
      //   print('EL code  API :${dataResp.statusCode}');

      if (dataResp.statusCode == 404 || dataResp.statusCode == 500) {
      //  snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        return null;
      }
      if (dataResp.statusCode == 200) {
       
        return respo;
      }
      
    } catch (e) {
      print('-ERROR -> $e');
    }
  
  }





}