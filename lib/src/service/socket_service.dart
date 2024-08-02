import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Ofline,
  Connecting,
}

class SocketService extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  

// EXPONER DE MANERA PRIVADA PARA CONTROLAR LA MANERA DE EXPOSICION AL MUBDO , PANTALLA, CLASE
  late IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  // String? _serverResponses;
  // String? get serverResponses => _serverResponses;

  IO.Socket? get socket => _socket;

  SocketService() {
   
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    // _socket = IO.io('https://contabackend.neitor.com', {
    // _socket = IO.io('http://192.168.1.4:3000', {
    //       'transports': ['websocket'],
    //   'autoConnect': true,
    // });
    _socket = IO.io(
      //  'https://backsigeop.neitor.com',
         'https://backsafe.neitor.com',
       
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .setExtraHeaders({'':''}) // optional
            .build());


 

    _socket?.onConnect((_) {
      print('USUARIO conectado desde Flutter !!! ');
      _serverStatus = ServerStatus.Online;
      
      // NotificatiosnService.showSnackBarDanger("Bienvenido");


      notifyListeners();
    });

    _socket?.onDisconnect((_) {
      print('disconnect de Flutter');
      _serverStatus = ServerStatus.Ofline;

      

      // NotificatiosnService.showSnackBarError("Sin conexión a internet");
      // _socket = null;
      notifyListeners();
    });

    //======================================== FUNCION PARA RESPONDER AL SOCKET==============================================//
    // final controllerHome = Provider.of<HomeController>();
//     final controllerInformes = InformeController();
// print('========================PAILOAD=================================');
    // print('$_pyloadDataIniciaTurno');
   
    // _socket!.on('server:guardadoExitoso', (data) async {
    //   if (data['tabla'] == 'registro') {

    //     // await Auth.instance.saveTurnoSession(true);
    //     // controllerHome.setValidaBtnTurno(true);
    //     // _validaBtnTurno = true;
    //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //     // _socket?.clearListeners();
    //     notifyListeners();
    //     // Navigator.of(context).pop();
    //   }
    // });
    // _socket?.on('server:error', (data) {
    //   NotificatiosnService.showSnackBarError(data['msg']);
    //   // _socket?.clearListeners();
    //   notifyListeners();
    // });

//      _socket!.on('server:guardadoExitoso', (data) {

//       if (data['tabla'] == 'pedido') {
//         print('payload GUARDA ok======> $data');
//         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//         // print('data##############> $data');
// //         // controllerInformes.buscaInformeGuardias('');

// //  data.remove('rucempresa');
// //        data.remove('rol');
// //        data.remove('tabla');
// //        data.remove('msg');

// // final listaData=Informe.fromMap(data);

// // // map.entries.map((e) => list.add({e.key: e.value})).toList();

// // // controllerInformes.setinformeGuardia(listaData );

// //         controllerInformes.setInfoBusquedaInformesGuardia([listaData]);

// //         // _socket?.clearListeners();

//       }
//     });
//        _socket!.on('server:eliminadoExitoso', (data) async {
//         if (data['tabla'] == 'pedido') {
// print('payload ELIMIN ok======> $data');
//           // buscaInformeGuardias('');
//           // NotificatiosnService.showSnackBarSuccsses(data['msg']);
//           // serviceSocket.socket?.clearListeners();
//           // notifyListeners();
//         }
//       });
    //   _socket?.on('server:error', (data) {
    //     // _serverResponses = data;
    //     NotificatiosnService.showSnackBarError(data['msg']);
    //     notifyListeners();
    //   });
    // }

   
  }







  
}
