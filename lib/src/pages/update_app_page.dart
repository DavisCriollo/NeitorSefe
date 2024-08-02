
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateApp extends StatefulWidget {
  final AppCheckerResult? info;
  const UpdateApp({Key? key, this.info}) : super(key: key);

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  @override
  void initState() {
//  inicial();
    super.initState();
  }

void inicial() async{

    //  await Auth.instance.deleteCache(context);
}



  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);


    // print(
    //     ' Necesita actualizacion: ${info!.canUpdate}'); //return true if update is available
    // print(info!.currentVersion); //return current app version
    // print(info!.newVersion); //return the new app version
    // print(info!.appURL); //return the app url
    // print(info!.errorMessage);

    return UpgradeAlert(
      upgrader: Upgrader(
        onUpdate:() {
          print('SE REALIZA LA ACCION DE ACTUALIZAR');
          return true;
        },
              canDismissDialog: true,
              durationUntilAlertAgain: Duration(minutes: 1),
              showIgnore: false,
              showLater: false,
              languageCode: 'es',
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
            ),
      child: Scaffold(
        // backgroundColor: Colors.grey.shade600,
        body: UpgradeAlert(
          upgrader: Upgrader(),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: size.iScreen(0.0), horizontal: size.iScreen(2.0)),
            child: const Center(
              child: CircularProgressIndicator()
              // Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //       //set border radius more than 50% of height and width to make circle
              //     ),
              //     child: Container(
              //       margin: EdgeInsets.symmetric(
              //           vertical: size.iScreen(0.0), horizontal: size.iScreen(2.0)),
              //       padding: EdgeInsets.symmetric(
              //           vertical: size.iScreen(3.0), horizontal: size.iScreen(2.0)),
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.symmetric(
              //                 vertical: size.iScreen(1.0),
              //                 horizontal: size.iScreen(0.0)),
              //             child: Icon(
              //               Icons.new_releases_outlined,
              //               size: size.iScreen(6.0),
              //               color: Colors.green,
              //             ),
              //           ),
              //           Text(
              //             'Versión: ${info!.newVersion}',
              //             style: GoogleFonts.lexendDeca(
              //                 fontSize: size.iScreen(1.8),
              //                 // color: Colors.white,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //           //***********************************************/
              //           SizedBox(
              //             height: size.iScreen(1.0),
              //           ),
              //           //*****************************************/
              //           Text(
              //             'Tenemos una nueva actualización del sistema con mejoras importantes.  \n \n Es necesario actualizar.',
              //             style: GoogleFonts.lexendDeca(
              //                 fontSize: size.iScreen(1.8),
              //                 // color: Colors.white,
              //                 fontWeight: FontWeight.normal),
              //           ),
              //           //========================================//
              //           Consumer<AppTheme>(builder: (_, value, __) {
              //             return Container(
              //               decoration: BoxDecoration(
              //                   color: Colors.blue, //value.getPrimaryTextColor,
              //                   borderRadius: BorderRadius.circular(8.0)),
              //               margin: EdgeInsets.symmetric(
              //                   horizontal: size.iScreen(5.0),
              //                   vertical: size.iScreen(3.0)),
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: size.iScreen(3.0),
              //                   vertical: size.iScreen(0.5)),
              //               child: GestureDetector(
              //                 child: Container(
              //                   alignment: Alignment.center,
              //                   height: size.iScreen(3.5),
              //                   width: size.iScreen(14.0),
              //                   child: Row(
              //                     children: [
              //                       Text('Actualizar',
              //                           style: GoogleFonts.lexendDeca(
              //                             fontSize: size.iScreen(1.8),
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.white,
              //                           )),
              //                       Container(
              //                         margin: EdgeInsets.symmetric(
              //                             vertical: size.iScreen(0.0),
              //                             horizontal: size.iScreen(1.0)),
              //                         child: const Icon(
              //                           Icons.update_rounded,
              //                           // size: size.iScreen(2.0),
              //                           color: Colors.white,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 onTap: () {
              //                   _onSubmit(context, info);
              //                 },
              //               ),
              //             );
              //             //    Icon(
              //             //  Icons.access_time_outlined,
              //             //   color:value.getPrimaryTextColor,
              //             //   size: 30,
              //             // );
              //           }),
              //           //===========================================//
              //         ],
              //       ),
              //     )),
          
          
          
          
          
          
          
          
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, AppCheckerResult? info) async{


    // print(
    //     ' Necesita actualizacion: ${info!.canUpdate}'); //return true if update is available
    // print(info.currentVersion); //return current app version
    // print(info.newVersion); //return the new app version
    // print(info.appURL); //return the app url
    // print(info.errorMessage);
  await Auth.instance.deleteSesion(context);
  await Auth.instance.deleteTurnoSesion();
final Uri _url = Uri.parse('${info!.appURL}');
// final Uri _url = Uri.parse('https://acortar.link/kTJt3V');
// final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=app_neitor.sincop_app');
_launchUrl(_url);

  }

  //========================================//
Future<void> _launchUrl(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch ${Uri.parse('$_url')}');
  }
}
}
