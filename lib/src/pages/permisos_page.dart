
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:permission_handler/permission_handler.dart';



class PermisosAppPage extends StatefulWidget {
  const PermisosAppPage({Key? key}) : super(key: key);

  @override
  _PermisosAppPageState createState() => _PermisosAppPageState();
}

class _PermisosAppPageState extends State<PermisosAppPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'home');
        // Navigator.pushReplacementNamed(context, 'login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return 
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
              child: Icon(Icons.info_outline_rounded,size: size.iScreen(10.0), color: Colors.green,)
            ),   SizedBox(height: size.iScreen(2.0),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
              child: Text('Para poder disfrutar de los beneficios de nuestra aplicación, es esencial conceder permisos de ubicación.',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.5),
                      color: Colors.black54,
                      fontWeight: FontWeight.w600)),
            ),
                    SizedBox(height: size.iScreen(2.0),),
            MaterialButton(
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: Text(
                'Solicitar Acceso',
                style: GoogleFonts.roboto(
                    fontSize: size.iScreen(1.7),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () async {
                // Extraemos el estatus del Permiso del GPS
// openAppSettings();

                final status = await Permission.location.request();
                accesoGPS(status);
              },
            ),
            SizedBox(height: size.iScreen(2.0),),
            MaterialButton(
              color: Colors.grey.shade500,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: Text(
                'Cancelar',
                style: GoogleFonts.roboto(
                    fontSize: size.iScreen(1.7),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: ()  {

Navigator.pop(context);

                // Extraemos el estatus del Permiso del GPS
// openAppSettings();

                // final status = await Permission.location.request();
                // accesoGPS(status);
              },
            ),
          ],
        ),
      ),
    );
  }


  void accesoGPS(PermissionStatus status) {
  
    switch (status) {
      // case PermissionStatus.granted:
      //   // Navigator.pushReplacementNamed(context, 'home');
      //   Navigator.pushReplacementNamed(context, 'login');
      //   break;
     
      // case PermissionStatus.denied:
      // case PermissionStatus.restricted:
      // case PermissionStatus.permanentlyDenied:
      // case PermissionStatus.limited:
      //   openAppSettings();
        
      // case PermissionStatus.provisional:
      //   // TODO: Handle this case.
      //   break;
       case PermissionStatus.granted:
      Navigator.pushReplacementNamed(context, 'splash');
      break;
    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.limited:
      openAppSettings();
      break; // Añade un break aquí para detener el flujo de ejecución
    case PermissionStatus.provisional:
      // TODO: Handle this case.
      break;
    }
  }
}
