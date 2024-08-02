import 'package:flutter/material.dart';
import 'package:nseguridad/src/utils/theme.dart';

// import 'package:sincop_app/src/utils/theme.dart';




class NotificatiosnService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
       GlobalKey<ScaffoldMessengerState>();
  
  static showSnackBarError(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.red.withOpacity(0.9),
 backgroundColor: cuaternaryColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarSuccsses(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      backgroundColor: secondaryColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarDanger(String message) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      backgroundColor: tercearyColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  static showSnackBarInfo(String message,String result) {
    final snackBar =  SnackBar(
      // backgroundColor: Colors.green.withOpacity(0.9),
      backgroundColor: (result=='success')?secondaryColor:tercearyColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
  // static alertaInfo(String message,String result) {
    
    
    
    
    
  //   // final snackBar = 
  //    const AlertDialog(
  //     title: Text('Notificaciones'),
  //     content:
  //         Text("¿Desea recibir notificaciones? Serán muy pocas de verdad :)"),
  //     // actions: <Widget>[
  //     //   FlatButton(
  //     //       child: Text("Aceptar"),
  //     //       textColor: Colors.blue,
  //     //       onPressed: () {
  //     //         Navigator.of(context).pop();
  //     //       }),

  //     //   FlatButton(
  //     //       child: Text("Cancelar"),
  //     //       textColor: Colors.red,
  //     //       onPressed: () {
  //     //         Navigator.of(context).pop();
  //     //       }),
  //     // ],
  //   );
  //   // messengerKey.currentState!;
  // }
}
