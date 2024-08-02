
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:permission_handler/permission_handler.dart';


void showPermissionModal(BuildContext context, Responsive size,String _title) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromARGB(117, 0, 0, 0), // Color oscuro de fondo
          child: CupertinoAlertDialog(
            // title: Text('Permisos Necesarios', style: GoogleFonts.poppins(
            //             fontSize: size.iScreen(2.0),
            //             color: Colors.black,
            //             fontWeight: FontWeight.w600)),
            content: Column(
              children: [
              
                SizedBox(height: size.iScreen(1.0)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CupertinoButton(
                    //   child: Text('Permitir GPS'),
                    //   onPressed: () async {
                    //     Navigator.pop(context); // Cierra el modal
                    //     // await _requestPermission(Permission.location);
                    //   },
                    // ),
                    // SizedBox(width: 20),
                    // CupertinoButton(
                    //   child: Text('Permitir Cámara'),
                    //   onPressed: () async {
                    //     Navigator.pop(context); // Cierra el modal
                    //     // await _requestPermission(Permission.camera);
                    //   },
                    // ),
                    Icon(Icons.info_outline,size: size.iScreen(5.0),color: Colors.green,),
              SizedBox(height: size.iScreen(1.0),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
                child: Text(_title,
                    style: GoogleFonts.poppins(
                        fontSize: size.iScreen(2.0),
                        color: Colors.black,
                        fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
              ),
                      SizedBox(height: size.iScreen(3.0),),
                  ],
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Cancelar', style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.7),
                        color: Colors.red,
                        fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                onPressed: () {
                  Navigator.pop(context); // Cierra el modal
                },
              ),
               CupertinoDialogAction(
               child: Text('Aceptar',style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.7),
                        color: Colors.black,
                        fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                onPressed: () {
                  openAppSettings(); 
                  Navigator.pop(context);
                  // Cierra el modal
                },
              ),
            ],
          ),
        );
      },
    );
  }
