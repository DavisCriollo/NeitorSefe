
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/pages/splash_screen.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:permission_handler/permission_handler.dart';



class ActivarGPSPage extends StatefulWidget {
  const ActivarGPSPage({Key? key}) : super(key: key);

  @override
  _ActivarGPSPageState createState() => _ActivarGPSPageState();
}

class _ActivarGPSPageState extends State<ActivarGPSPage>
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
        // Navigator.pushReplacementNamed(context, 'home');
        Navigator.pushReplacementNamed(context, 'splash');
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
              child: Icon(Icons.gps_fixed_rounded,size: size.iScreen(6.0), color: Colors.orange,)
            ),   SizedBox(height: size.iScreen(2.0),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
              child: Text('Para poder disfrutar de los beneficios de nuestra aplicación, es esencial activar el GPS.',
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
                'Activar GPS',
                style: GoogleFonts.roboto(
                    fontSize: size.iScreen(1.7),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () async {
                // Extraemos el estatus del Permiso del GPS
// openAppSettings();

              await Geolocator.openLocationSettings().then((value) {
               
              });
          
            SizedBox(height: size.iScreen(2.0),);
//             MaterialButton(
//               color: Colors.grey.shade500,
//               shape: const StadiumBorder(),
//               elevation: 0,
//               splashColor: Colors.transparent,
//               child: Text(
//                 'Cancelar',
//                 style: GoogleFonts.roboto(
//                     fontSize: size.iScreen(1.7),
//                     color: Colors.white,
//                     fontWeight: FontWeight.normal),
//               ),
//               onPressed: ()  {

// Navigator.pop(context);

//                 // Extraemos el estatus del Permiso del GPS
// // openAppSettings();

                // final status = await Permission.location.request();
                // accesoGPS(status);
              },
            ),
          ],
        ),
      ),
    );
  }


  
}
