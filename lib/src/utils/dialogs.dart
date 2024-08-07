
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/theme.dart';

// import 'package:sincop_app/src/utils/theme.dart';



abstract class Dialogs {
  static alert(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
        title: Text(title),
        content: Text(description,
            style: GoogleFonts.lexendDeca(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              // color: Colors.white,
            )),
        actions: [
          // MaterialButton(
          //   color: primaryColor,
          //   onPressed: () {
          //     Navigator.pop(_);
          //   },
          //   child: Text("OK"),
          // ),
          CupertinoDialogAction(
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
              child: Text("OK",
                  style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )),
            ),
            onPressed: () {
              Navigator.pop(context);
             
            },
          ),
        ],
      ),
    );
  }

  static alertConfirm(
    BuildContext context, {
    required double size,
    required String title,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(description,
            style: GoogleFonts.lexendDeca(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              // color: Colors.white,
            )),
        actions: [
          MaterialButton(
            color: secondaryColor,
            onPressed: () {
              Navigator.pop(_);
            },
            child: Text("Confirmar",
                style: GoogleFonts.lexendDeca(
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          MaterialButton(
            color: cuaternaryColor,
            onPressed: () {
              Navigator.pop(_);
            },
            child: Text("Cancelar",
                style: GoogleFonts.lexendDeca(
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          // CupertinoDialogAction(
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: primaryColor,
          //         borderRadius: BorderRadius.circular(5.0)),
          //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
          //     child: Text("OK",
          //         style: GoogleFonts.lexendDeca(
          //           // fontSize: size.iScreen(2.0),
          //           fontWeight: FontWeight.normal,
          //           color: Colors.white,
          //         )),
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}

abstract class ProgressDialog {
  static show(BuildContext context, {String? messaje}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.9),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          onWillPop: () async => false,
        );
      },
    );
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}

abstract class ProgressDialogMini {
  static show(BuildContext context, {String? messaje}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Container(
            // width: double.infinity,
            // height: double.infinity,
            color: Colors.white.withOpacity(0.9),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          onWillPop: () async => false,
        );
      },
    );
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}

// abstract class ProgressDialogUpLoads {
//   static show(BuildContext context, {String? mensaje}) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (_) {
//         return WillPopScope(
//           child: Container(
//             color: Colors.white.withOpacity(0.9),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16.0), // Espacio entre el indicador y el texto
//                   Text(
//                     mensaje ?? 'Espere por favor...',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           onWillPop: () async => false,
//         );
//       },
//     );
//   }

//   static dissmiss(BuildContext context) {
//     Navigator.pop(context);
//   }
// }
abstract class ProgressDialogUpLoads {
  static show(BuildContext context, {String mensaje = 'Procesando, espere por favor...'}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),// Asegúrate de que el fondo sea transparente
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0), // Espacio entre el indicador y el texto
                  Text(
                    mensaje,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onWillPop: () async => false,
        );
      },
    );
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}
