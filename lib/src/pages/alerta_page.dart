
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/urls/urls.dart' as urls;
import 'package:url_launcher/url_launcher.dart';

class AlertaPage extends StatefulWidget {
  final Map<String, dynamic>? notificacion;
  const AlertaPage({Key? key, this.notificacion}) : super(key: key);

  @override
  State<AlertaPage> createState() => _AlertaPageState();
}

class _AlertaPageState extends State<AlertaPage> {
  @override
  void initState() {
    initil();
    super.initState();
  }

  void initil() async {
    AudioCache player = AudioCache();

    player = AudioCache();

    await player.play('Alarm.mp3');
  }
@override
  void dispose() {
   
AudioCache player = AudioCache();

    player = AudioCache();


   player.clearAll();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final homeControl=context.read<HomeController>();
 
    final List _telefonos = [];
    final List _correos = [];


// print('la notificacion : ${widget.notificacion}');
    // final  _locationPuroString =  jsonEncode(widget.notificacion!['coordenadas'].toString().replaceAll('"',''));
    // final  _locationPuroJson =  jsonDecode(_locationPuroString);
    // List _location = [];
    // String _locationData = '';
    // _location = widget.notificacion!['coordenadas'];
    // _locationData = _location.toString().replaceAll('{longitud: ','').replaceAll('{longitud: ','').replaceAll('}','');

    // final _coordenadas = '${_location[1]},${_location[0]}';
    // final List _coordenadas = 
    // [
    //   0:
// "longitud" -> "-0.2355998819854843"
// 1:
// "latitud" -> "-79.18314344484017"

    // ];
//   final _long=  _location[0].toString().replaceAll('{longitud: ','');
//     _location[1].toString().replaceAll('latitud:  ','');
//   final _lat=  _location[1].toString().replaceAll('}','');

//  final coordenadasItem = {
//           "Longitud": homeControl.getLatitud,
//           "latitud": homeControl.getLatitud,
//         };

// final Map<String, dynamic> _latLong=widget.notificacion!['coordenadas'];
// final Map<String, dynamic> _latLong=coordenadasItem;


print('UDUCACION DE ALERTA : ${widget.notificacion!['coordenadas']['Longitud']} - ${widget.notificacion!['coordenadas']['latitud']}');

// final lat=double.parse(_latLong['latitud'].toString());
// final long=double.parse(_latLong['longitud'].toString());


// final lat=_latLong['latitud'];
// final long=_latLong['longitud'];


// print('Longitud: ${_latLong['Longitud']}');
// print('Longitud: ${_latLong['latitud']}');
// print('Longitud: ${_latLong['Longitud'].runtimeType}');
// print('latitud: ${_latLong['latitud'].runtimeType}');
// homeControl.setLatLong(lat,long);
// homeControl.setLatLong(double.parse(_latLong['latitud'].toString()),double.parse(_latLong['longitud'].toString()));
// homeControl.setLatLong(double.parse(widget.notificacion!['coordenadas']['latitud'].toString()),double.parse(widget.notificacion!['coordenadas']['longitud'].toString()));
// {
//   "Longitud":_long,
//   "latitud":_lat,
// };


//     print('COORDENADAS Longitud : ${_latLong['Longitud']}');
//     print('COORDENADAS latitud : ${_latLong['latitud']}');
//     print('_latLong : ${_latLong}');
    // print('COORDENADAS latitud : ${ _location[0].toString().replaceAll('{longitud: ','')}');
    // print('COORDENADAS Longitud: ${_location[1]}');
    // print('_locationData : ${_locationData}');
    // print('puro : ${widget.notificacion!['coordenadas'][0]}');
    // print('_locationPuroString : ${_locationPuroString}');
    // print('_locationPuroJson : ${_locationPuroJson.runtimeType}');
    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        // backgroundColor: const Color(0XFF343A40), // primaryColor,
           flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  ctrlTheme.primaryColor,
                  ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
        title: Text(
          'ALERTA',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        //  color: Colors.blue.shade100,
        width: size.wScreen(100),
        height: size.hScreen(100),
        margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                endRadius: 80,
                glowColor: Colors.red,
                duration: const Duration(milliseconds: 1000),
                child: Image.asset(
                  'assets/imgs/alarma.png',
                  color: Colors.red.shade900,
                  width: size.iScreen(18.0),
                  height: size.iScreen(20.0),
                ),
              ),
              Column(
                children: [
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text('SOS',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(3.5),
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text(
                        'Se ha generado una alerta por parte del siguiente usuario:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.5),
                  ),
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Nombre:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),

                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('${widget.notificacion!['notNombrePersona']}',
                        // Text('notNombrePersona',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey
                        )),
                  ),

                  _telefonos.isNotEmpty
                      ? Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.5),
                            ),
                            //*****************************************/
                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Teléfono:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Wrap(
                                children: _telefonos
                                    .map(
                                      (e) => InkWell(
                                        // focusColor: Colors.red,
                                        onLongPress: () {
                                          _callNumber('$e');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.2),
                                              horizontal: size.iScreen(0.2)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.iScreen(0.2),
                                              horizontal: size.iScreen(1.0)),
                                          // color: Colors.red,
                                          // width: size.wScreen(100),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('$e',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    fontWeight: FontWeight.bold,
                                                    // color: Colors.grey
                                                  )),
                                              //***********************************************/
                                              SizedBox(
                                                width: size.iScreen(3.0),
                                              ),
                                              //*****************************************/
                                              Icon(
                                                Icons.phone_forwarded_outlined,
                                                size: size.iScreen(3.0),
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ],
                        )
                      : Container(),

                  //***********************************************/

                  _correos.isNotEmpty
                      ? Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.5),
                            ),
                            //*****************************************/
                            SizedBox(
                              width: size.wScreen(100.0),

                              // color: Colors.blue,
                              child: Text('Correo:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Wrap(
                                children: _correos
                                    .map(
                                      (e) => Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.2),
                                            horizontal: size.iScreen(0.2)),
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.2),
                                            horizontal: size.iScreen(1.0)),
                                        // color: Colors.red,
                                        width: size.wScreen(100),
                                        child: Text('$e',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.bold,
                                              // color: Colors.grey
                                            )),
                                      ),
                                    )
                                    .toList()),
                          ],
                        )
                      : Container(),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.5),
                  ),
                  //*****************************************/

                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Ciudad:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),

                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    // child: Text('Santo Domingo de los Tsáchilas',
                    child: Text('${widget.notificacion!['perCiudad']}',
                        // 'sdsd',
                        // 'notNombrePersona',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey
                        )),
                  ),
                  //***********************************************/
                  SizedBox(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    // child: Text('SANI GROUP S.C.',
                    child: Column(
                      children: [
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        //*****************************************/

                        SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Cliente:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        SizedBox(
                          width: size.wScreen(100.0),
                          child: Text('${widget.notificacion!['notEmpresa']}',
                              // Text('sdfsdf',
                              // Text('notNombrePersona}',
                              style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                // color: Colors.grey
                              )),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        //*****************************************/

                        SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Ubicación:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),

                        SizedBox(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          // child: Text('Santo Domingo de los Tsáchilas',
                          child:
                              //  Text('${widget.notificacion['notInformacion']['datos']['perLugarTrabajo']}',
                              Text('${widget.notificacion!['perLugarTrabajo']}',
                                  style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.grey
                                  )),
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        //*****************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                      ],
                    ),
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //*****************************************/

                  GestureDetector(
                                   onTap: () {

//************************//
final _ctrlHome= context.read<HomeController>();
 _ctrlHome.fetchCurrentPosition();
    
         

          
           
 if (_ctrlHome.currentPosition != null)

 {
              print('Latitud: ${_ctrlHome.currentPosition!.latitude}, Longitud: ${_ctrlHome.currentPosition!.longitude}');


               bottomSheetMaps(context,size,'Seleccionar',_ctrlHome,'Seleccione Mapa',_ctrlHome.currentPosition!.latitude,_ctrlHome.currentPosition!.longitude);

 }else if (_ctrlHome.errorMessage != null)
              // print('Error: ${_ctrlHome.errorMessage}');
               NotificatiosnService.showSnackBarDanger('${_ctrlHome.errorMessage}');
            else
              print('Presiona el botón para obtener la ubicación');
            
    
//********************************************/

//************************//




                        // bottomSheetMaps(
                        //   context,
                        //   size,
                        //   'Navegar',
                        //   homeControl,
                        //   'Seleccione Aplicación',
                          
                        // );
                      },
                    child: Container(
                      decoration: BoxDecoration(
                          color: tercearyColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(5.0),
                          vertical: size.iScreen(3.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(3.0),
                          vertical: size.iScreen(0.5)),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.iScreen(3.5),
                        width: size.iScreen(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Acudir',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                )),
                            Icon(
                              Icons.room_outlined,
                              size: size.iScreen(2.8),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
              onPressed: () {
                final _ctrlHome= context.read<HomeController>();
                _ctrlHome.fetchCurrentPosition();
                 if (_ctrlHome.currentPosition != null) {
                  print('LatitudS: ${_ctrlHome.currentPosition!.latitude}, Longitud: ${_ctrlHome.currentPosition!.longitude}');
               
              //  openGoogleMaps(_ctrlHome.currentPosition!.latitude, _ctrlHome.currentPosition!.longitude, widget.notificacion!['coordenadas']['latitud'], widget.notificacion!['coordenadas']['Longitud']);
              final coordenadaslatLong = {
          "Longitud": _ctrlHome.currentPosition!.longitude,
          "latitud": _ctrlHome.currentPosition!.latitude,
        };
          print('LAS COORDENADAS ANTES DE ENVIAR A LOS MAPAS> Latitud: ${_ctrlHome.currentPosition!.latitude}, Longitud: ${_ctrlHome.currentPosition!.longitude}');
              // openGoogleMaps('${}')
               bottomSheetMaps(context,size,'Seleccionar',_ctrlHome,'Seleccione Mapa',_ctrlHome.currentPosition!.latitude,_ctrlHome.currentPosition!.longitude);
               
                } else if (_ctrlHome.errorMessage != null) {
                  // print('Error: ${_ctrlHome.errorMessage}');

                    NotificatiosnService.showSnackBarSuccsses('${_ctrlHome.errorMessage}');

                }
              },
              child: Text('Obtener ubicación'),
            )
                  //==========================================//
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomSheetMaps(
    BuildContext context,
    Responsive size,
    String title,
    HomeController homeController,
    // Map<String, dynamic> coordenadas,
  // int _idNotificacion,
    String message,
     double _lat ,
     double _long ,
  ) {

         print('INFO Q SE ENVIA AL MAPA : latitud $_lat -- longitud $_long} ');
   

    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              message: Text(message,
                  style: GoogleFonts.roboto(
                    fontSize: size.iScreen(1.8),
                    fontWeight: FontWeight.w500,
                    // color: Colors.white,
                  )),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    openWaze(double.parse(homeController.currentPosition!.latitude.toString()), double.parse(homeController.currentPosition!.longitude.toString()), double.parse(widget.notificacion!['coordenadas']['latitud'].toString()), double.parse(widget.notificacion!['coordenadas']['Longitud'].toString()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: size.wScreen(10.0),
                          child: Image.asset('assets/imgs/waze-icon.jpeg'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.iScreen(1.0)),
                        child: Text('Mapa Waze',
                            style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.w500,
                              // color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                     openGoogleMaps(homeController.currentPosition!.latitude, homeController.currentPosition!.longitude, widget.notificacion!['coordenadas']['latitud'], widget.notificacion!['coordenadas']['Longitud']);
                
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: size.wScreen(10.0),
                          child: Image.asset('assets/imgs/google-icon.png'),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: size.iScreen(1.0)),
                          child: Text('Mapa Google',
                              style: GoogleFonts.roboto(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.w500,
                                // color: Colors.white,
                              ))),
                    ],
                  ),
                ),
              ],
            ));
  }

  void openWaze(double originLat, double originLng, double destLat, double destLng) async {
  final wazeUrl = 'https://waze.com/ul?ll=$destLat,$destLng&from=$originLat,$originLng&navigate=yes';
  if (await canLaunch(wazeUrl)) {
    await launch(wazeUrl);
  } else {
    throw 'Could not open Waze.';
  }
}
void openGoogleMaps(double originLat, double originLng, double destLat, double destLng) async {
  final googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destLat,$destLng';
  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not open Google Maps.';
  }
}

  
}

_callNumber(String numero) async {
  await FlutterPhoneDirectCaller.callNumber(numero);
}

