// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:nseguridad/src/controllers/home_ctrl.dart';
// import 'package:nseguridad/src/theme/themes_app.dart';
// import 'package:provider/provider.dart';
// import 'package:nseguridad/src/controllers/bitacora_controller.dart';
// import 'package:nseguridad/src/controllers/home_controller.dart';
// import 'package:nseguridad/src/models/session_response.dart';
// import 'package:nseguridad/src/pages/crear_bitacora.dart';
// import 'package:nseguridad/src/pages/detalle_bitacora.dart';
// import 'package:nseguridad/src/pages/registro_bitacora_page.dart';
// import 'package:nseguridad/src/service/notifications_service.dart';
// import 'package:nseguridad/src/service/socket_service.dart';
// import 'package:nseguridad/src/utils/dialogs.dart';
// import 'package:nseguridad/src/utils/fecha_local_convert.dart';
// import 'package:nseguridad/src/utils/responsive.dart';
// import 'package:nseguridad/src/utils/theme.dart';
// import 'package:nseguridad/src/widgets/no_data.dart';

// class ListaBitacora extends StatefulWidget {
//   final Session? user;
//   const ListaBitacora({Key? key, this.user}) : super(key: key);

//   @override
//   State<ListaBitacora> createState() => _ListaBitacoraState();
// }

// class _ListaBitacoraState extends State<ListaBitacora> {
//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   void initData() async {
//     final loadInfo = Provider.of<BitacoraController>(context, listen: false);
//     loadInfo.getBitacoras('', 'false');

//     final serviceSocket = Provider.of<SocketService>(context, listen: false);
//     serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
//       if (data['tabla'] == 'bitacora') {
//         loadInfo.getBitacoras('', 'false');
//         NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
//       if (data['tabla'] == 'bitacora') {
//         loadInfo.getBitacoras('', 'false');
//         NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//     serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
//       if (data['tabla'] == 'bitacora') {
//         loadInfo.getBitacoras('', 'false');
//         NotificatiosnService.showSnackBarSuccsses(data['msg']);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive size = Responsive.of(context);
//     final _user = context.read<HomeController>();
//     final _controller = context.read<BitacoraController>();
//       final ctrlTheme = context.read<ThemeApp>();
//     return Scaffold(
//       appBar: AppBar(

//          flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//         title: Text(
//           'Bitácora',
//           // style: Theme.of(context).textTheme.headline2,
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//               margin: EdgeInsets.only(
//                 top: size.iScreen(1.5),
//                 left: size.iScreen(0.5),
//                 right: size.iScreen(0.5),
//               ),
//               width: size.wScreen(100.0),
//               height: size.hScreen(100.0),
//               child: Consumer<BitacoraController>(
//                 builder: (_, providers, __) {
//                   if (providers.getErrorBitacoras == null) {
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Cargando Datos...',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           //***********************************************/
//                           SizedBox(
//                             height: size.iScreen(1.0),
//                           ),
//                           //*****************************************/
//                           const CircularProgressIndicator(),
//                         ],
//                       ),
//                     );
//                   } else if (providers.getErrorBitacoras == false) {
//                     return const NoData(
//                       label: 'No existen datos para mostar',
//                     );
//                   } else if (providers.getListaBitacoras.isEmpty) {
//                     return const NoData(
//                       label: 'No existen datos para mostar',
//                     );
//                     // Text("sin datos");
//                   }

//                   return Consumer<SocketService>(
//                     builder: (_, valueEstadoInter, __) {
//                       return ListView.builder(
//                         itemCount: providers.getListaBitacoras.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final bitacora = providers.getListaBitacoras[index];

//                           //                          String dateString = '${bitacora['bitFecReg'].toString()}';
//                           String fechaLocal = bitacora['bitFecReg'] != ""
//                               ? DateUtility.fechaLocalConvert(
//                                   bitacora['bitFecReg'].toString())
//                               : "--- ---";

//                           // // Convertir la cadena a un objeto DateTime en formato UTC
//                           // DateTime utcDateTime = DateTime.parse(dateString);

//                           // // Obtener la zona horaria local
//                           // DateTime localDateTime = utcDateTime.toLocal();

//                           // // Formatear la fecha y hora en el formato deseado
//                           // String fechaLocal = DateFormat('yyyy-MM-dd HH:mm').format(localDateTime);

//                           // print(fechaLocal); // Resultado: 2023-06-20 15:58:07 (ejemplo de zona horaria -04:00)

//                           return Slidable(
//                             startActionPane: ActionPane(
//                               motion: const ScrollMotion(),
//                               children: [
//                                 //       widget.user!.rol!.contains('CLIENTE')
//                                 //  ?Container():

//                                 bitacora['bitEstado'] == 'ANULADA'
//                                     ? Container()
//                                     : SlidableAction(
//                                         backgroundColor: Colors.purple,
//                                         foregroundColor: Colors.white,
//                                         icon: Icons.edit,
//                                         // label: 'Editar',
//                                         onPressed: (context) {
//                                           providers.resetEstadobitacora();
//                                           providers.setInfoBitacora(bitacora);
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: ((context) =>
//                                                       const DetalleDeBitacora(
//                                                         action: 'EDIT',
//                                                       ))));
//                                         },
//                                       ),
//                               ],
//                             ),
//                             child: GestureDetector(
//                               onTap: () {
//                                 providers.setInfoBitacora(bitacora);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: ((context) =>
//                                             const DetalleDeBitacora(
//                                               action: 'CREATE',
//                                             ))));
//                               },
//                               child: ClipRRect(
//                                 child: Card(
//                                   child: Container(
//                                     margin:
//                                         EdgeInsets.only(top: size.iScreen(0.5)),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: size.iScreen(1.0),
//                                         vertical: size.iScreen(0.5)),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(8),
//                                       boxShadow: const <BoxShadow>[
//                                         BoxShadow(
//                                             color: Colors.black54,
//                                             blurRadius: 1.0,
//                                             offset: Offset(0.0, 1.0))
//                                       ],
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     // width: size.wScreen(100.0),
//                                                     child: Text(
//                                                       'Tipo Persona: ',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     // color: Colors.red,
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     width: size.wScreen(60.0),
//                                                     child: Text(
//                                                       '${bitacora['bitTipoPersona']} ',
//                                                       // '${providers.getListaBitacoras[index]['bitId']}',
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     // width: size.wScreen(100.0),
//                                                     child: Text(
//                                                       'Cédula: ',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     // color: Colors.red,
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     width: size.wScreen(60.0),
//                                                     child: Text(
//                                                       '${bitacora['bitDocumento']}',
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     // width: size.wScreen(100.0),
//                                                     child: Text(
//                                                       'Nombres: ',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     child: Container(
//                                                       // color: Colors.red,
//                                                       margin: EdgeInsets.only(
//                                                           top:
//                                                               size.iScreen(0.5),
//                                                           bottom: size
//                                                               .iScreen(0.0)),
//                                                       // width: size.wScreen(60.0),
//                                                       child: Text(
//                                                         '${bitacora['bitNombres']}',
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: GoogleFonts
//                                                             .lexendDeca(
//                                                                 fontSize: size
//                                                                     .iScreen(
//                                                                         1.5),
//                                                                 color: Colors
//                                                                     .black87,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     // width: size.wScreen(100.0),
//                                                     child: Text(
//                                                       'Se dirige: ',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     // color: Colors.red,
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     width: size.wScreen(60.0),
//                                                     child: Text(
//                                                       '${bitacora['bitResNombres']}',
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     // width: size.wScreen(100.0),
//                                                     child: Text(
//                                                       'Estado: ',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.5),
//                                                               color: Colors
//                                                                   .black87,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     // color: Colors.red,
//                                                     margin: EdgeInsets.only(
//                                                         top: size.iScreen(0.5),
//                                                         bottom:
//                                                             size.iScreen(0.0)),
//                                                     width: size.wScreen(60.0),
//                                                     child: Text(
//                                                       '${bitacora['bitEstado']}',
//                                                       style: GoogleFonts
//                                                           .lexendDeca(
//                                                               fontSize: size
//                                                                   .iScreen(1.6),
//                                                               // color: _colorEstado,
//                                                               color: bitacora[
//                                                                           'bitEstado'] ==
//                                                                       'INGRESO'
//                                                                   ? primaryColor
//                                                                   : bitacora['bitEstado'] ==
//                                                                           'SALIDA'
//                                                                       ? secondaryColor
//                                                                       : bitacora['bitEstado'] ==
//                                                                               'ANULADA'
//                                                                           ? Colors
//                                                                               .red
//                                                                           : tercearyColor,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: size
//                                                                 .iScreen(0.5),
//                                                             bottom: size
//                                                                 .iScreen(0.0)),
//                                                         // width: size.wScreen(100.0),
//                                                         child: Text(
//                                                           'F. Ingreso: ',
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(
//                                                                           1.5),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: size
//                                                                 .iScreen(0.5),
//                                                             bottom: size
//                                                                 .iScreen(0.0)),
//                                                         // width: size.wScreen(100.0),
//                                                         child: Text(
//                                                           fechaLocal,
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(
//                                                                           1.5),
//                                                                   // color: Colors.red,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: size
//                                                                 .iScreen(0.5),
//                                                             bottom: size
//                                                                 .iScreen(0.0)),
//                                                         // width: size.wScreen(100.0),
//                                                         child: Text(
//                                                           'F. Salida: ',
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(
//                                                                           1.5),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: size
//                                                                 .iScreen(0.5),
//                                                             bottom: size
//                                                                 .iScreen(0.0)),
//                                                         // width: size.wScreen(100.0),
//                                                         child: Text(
//                                                           fechaLocal,
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(
//                                                                           1.5),
//                                                                   // color: Colors.red,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: size.iScreen(1.0),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );

//                   // ListView(
//                   //   children: [
//                   //     Slidable(
//                   //       startActionPane: ActionPane(
//                   //         motion: const ScrollMotion(),
//                   //         children: [
//                   //           // SlidableAction(
//                   //           //   onPressed: (context) async {},
//                   //           //   backgroundColor: Colors.red.shade700,
//                   //           //   foregroundColor: Colors.white,
//                   //           //   icon: Icons.delete_forever_outlined,
//                   //           //   // label: 'Eliminar',
//                   //           // ),
//                   //         ],
//                   //       ),
//                   //       child: GestureDetector(
//                   //         onTap: () {
//                   //           Navigator.push(
//                   //               context,
//                   //               MaterialPageRoute(
//                   //                   builder: ((context) =>
//                   //                       const DetalleDeBitacora())));
//                   //         },
//                   //         child: ClipRRect(
//                   //           child: Card(
//                   //             child: Container(
//                   //               margin: EdgeInsets.only(top: size.iScreen(0.5)),
//                   //               padding: EdgeInsets.symmetric(
//                   //                   horizontal: size.iScreen(1.0),
//                   //                   vertical: size.iScreen(0.5)),
//                   //               decoration: BoxDecoration(
//                   //                 color: Colors.white,
//                   //                 borderRadius: BorderRadius.circular(8),
//                   //                 boxShadow: const <BoxShadow>[
//                   //                   BoxShadow(
//                   //                       color: Colors.black54,
//                   //                       blurRadius: 1.0,
//                   //                       offset: Offset(0.0, 1.0))
//                   //                 ],
//                   //               ),
//                   //               child: Row(
//                   //                 children: [
//                   //                   Expanded(
//                   //                     child: Column(
//                   //                       mainAxisAlignment:
//                   //                           MainAxisAlignment.start,
//                   //                       children: [
//                   //                         Row(
//                   //                           children: [
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'Cédula: ',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.normal),
//                   //                               ),
//                   //                             ),
//                   //                             Container(
//                   //                               // color: Colors.red,
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               width: size.wScreen(60.0),
//                   //                               child: Text(
//                   //                                 '1234637289',
//                   //                                 overflow: TextOverflow.ellipsis,
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.bold),
//                   //                               ),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                         Row(
//                   //                           children: [
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'Nombres: ',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.normal),
//                   //                               ),
//                   //                             ),
//                   //                             Expanded(
//                   //                               child: Container(
//                   //                                 // color: Colors.red,
//                   //                                 margin: EdgeInsets.only(
//                   //                                     top: size.iScreen(0.5),
//                   //                                     bottom: size.iScreen(0.0)),
//                   //                                 // width: size.wScreen(60.0),
//                   //                                 child: Text(
//                   //                                   'ESTRELLA NOVEDAD MARQUINES RAMIREZ ',
//                   //                                   overflow:
//                   //                                       TextOverflow.ellipsis,
//                   //                                   style: GoogleFonts.lexendDeca(
//                   //                                       fontSize:
//                   //                                           size.iScreen(1.5),
//                   //                                       color: Colors.black87,
//                   //                                       fontWeight:
//                   //                                           FontWeight.bold),
//                   //                                 ),
//                   //                               ),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                         Row(
//                   //                           children: [
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'Se dirige a: ',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.normal),
//                   //                               ),
//                   //                             ),
//                   //                             Container(
//                   //                               // color: Colors.red,
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               width: size.wScreen(60.0),
//                   //                               child: Text(
//                   //                                 'Oficina de abogado',
//                   //                                 overflow: TextOverflow.ellipsis,
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.bold),
//                   //                               ),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                         Row(
//                   //                           children: [
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'Fecha de ingreso: ',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.normal),
//                   //                               ),
//                   //                             ),
//                   //                             Container(
//                   //                               // color: Colors.red,
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               width: size.wScreen(60.0),
//                   //                               child: Text(
//                   //                                 '2022-08-26 12:00:54',
//                   //                                 overflow: TextOverflow.ellipsis,
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.bold),
//                   //                               ),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                         Row(
//                   //                           children: [
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'Fecha de Salida: ',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.black87,
//                   //                                     fontWeight:
//                   //                                         FontWeight.normal),
//                   //                               ),
//                   //                             ),
//                   //                             Container(
//                   //                               margin: EdgeInsets.only(
//                   //                                   top: size.iScreen(0.5),
//                   //                                   bottom: size.iScreen(0.0)),
//                   //                               // width: size.wScreen(100.0),
//                   //                               child: Text(
//                   //                                 'No resgistrada',
//                   //                                 style: GoogleFonts.lexendDeca(
//                   //                                     fontSize: size.iScreen(1.5),
//                   //                                     color: Colors.red,
//                   //                                     fontWeight:
//                   //                                         FontWeight.bold),
//                   //                               ),
//                   //                             ),
//                   //                           ],
//                   //                         ),
//                   //                         SizedBox(
//                   //                           height: size.iScreen(1.0),
//                   //                         )
//                   //                       ],
//                   //                     ),
//                   //                   ),
//                   //                 ],
//                   //               ),
//                   //             ),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     )

//                   //   ],
//                   // );
//                 },
//               )),
//           Positioned(
//             top: 0,
//             child: Container(
//                 width: size.wScreen(100.0),
//                 margin: const EdgeInsets.all(0.0),
//                 padding: const EdgeInsets.all(0.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('${_user.getUsuarioInfo!.rucempresa!}  ',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey.shade600,
//                             fontWeight: FontWeight.bold)),
//                     Text('-',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold)),
//                     Text('  ${_user.getUsuarioInfo!.usuario!} ',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey.shade600,
//                             fontWeight: FontWeight.bold)),
//                   ],
//                 )),
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   // backgroundColor: primaryColor,
//       //   child: const Icon(Icons.add),
//       //   onPressed: () {
//       //     Navigator.pushNamed(context, 'registroDeBitacora');
//       //   },
//       // )
//       floatingActionButton:
//           //  //***********************************************/
//           widget.user!.rol!.contains('CLIENTE')
//               ? Container()
//               : Consumer<SocketService>(
//                   builder: (_, valueEstadoInter, __) {
//                     return valueEstadoInter.serverStatus == ServerStatus.Online
//                         ? FloatingActionButton(
//                             backgroundColor:  ctrlTheme.primaryColor,
//                             child: const Icon(Icons.add),
//                             onPressed: () {
//                               _controller.resetValuesBitacora();
//                               widget.user!.rol!.contains('GUARDIA')
//                                   ? Container()
//                                   : _controller.getInfoClienteResidente('');

//                               // Navigator.pushNamed(context, 'registroDeBitacora');

//                               // _controller.removeFrontBackImage();

//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       // builder: ((context) => const RegitroBiracora(
//                                       builder: ((context) => CrearBitaora(
//                                             user: widget.user,
//                                             action: 'CREATE',
//                                           ))));
//                             },
//                           )
//                         : Container();
//                   },
//                 ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/pages/info_detalle_visita.dart';
import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crear_bitacora.dart';
import 'package:nseguridad/src/pages/detalle_bitacora.dart';
import 'package:nseguridad/src/pages/registro_bitacora_page.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaBitacora extends StatefulWidget {
  final Session? user;
  const ListaBitacora({Key? key, this.user}) : super(key: key);

  @override
  State<ListaBitacora> createState() => _ListaBitacoraState();
}

class _ListaBitacoraState extends State<ListaBitacora> {
  final TextEditingController _textSearchController = TextEditingController();

  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _horaInicioController = TextEditingController();
  TextEditingController _horaFinController = TextEditingController();

  late TimeOfDay timerInicio;
  late TimeOfDay timerFin;

// Session? usuario;

  void initload() async {
    timerInicio = TimeOfDay.now();
    timerFin = TimeOfDay.now();
  }

  @override
  void dispose() {
    _fechaInicioController.clear();
    _fechaFinController.clear();
    _horaFinController.clear();
    _horaFinController.clear();
    super.dispose();
  }

  @override
  void initState() {
    initData();
    initload();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<BitacoraController>(context, listen: false);
    loadInfo.getBitacoras('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'bitacora') {
        loadInfo.getBitacoras('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'bitacora') {
        loadInfo.getBitacoras('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'bitacora') {
        loadInfo.getBitacoras('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
    final _controller = context.read<BitacoraController>();
    final ctrlTheme = context.read<ThemeApp>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
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
        // title: Text(
        //   'Bitácora',
        //   // style: Theme.of(context).textTheme.headline2,
        // ),
        title: Consumer<BitacoraController>(
          builder: (_, provider, __) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                    child: (provider.btnSearch)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(1.5)),
                                    color: Colors.white,
                                    height: size.iScreen(4.0),
                                    child: TextField(
                                      controller: _textSearchController,
                                      autofocus: true,
                                      onChanged: (text) {
                                        // _controller.onSearchText(text);
                                        // _controller.search(text);
                                        _controller.searchParametro(text);

                                        //  provider.search(text);
                                        // setState(() {});
                                      },
                                      decoration: const InputDecoration(
                                        // icon: Icon(Icons.search),
                                        border: InputBorder.none,
                                        hintText: 'Buscar persona',
                                      ),
                                    ),
                                  ),
                                ),
                                // GestureDetector(
                                //   child: Container(
                                //     decoration: const BoxDecoration(
                                //       color: Colors.white,
                                //       border:
                                //           // Border.all(
                                //           //     color: Colors.white)
                                //           Border(
                                //         left: BorderSide(
                                //             width: 0.0, color: Colors.grey),
                                //       ),
                                //     ),
                                //     height: size.iScreen(4.0),
                                //     width: size.iScreen(3.0),
                                //     child: const Icon(Icons.search,
                                //         color: primaryColor),
                                //   ),
                                //   onTap: () {},
                                // )
                              ],
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            width: size.wScreen(90.0),
                            child: Text(
                              'Bitácora',
                              // style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                  ),
                ),
                IconButton(
                    splashRadius: 2.0,
                    icon: (!provider.btnSearch)
                        ? Icon(
                            Icons.search,
                            size: size.iScreen(3.5),
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.clear,
                            size: size.iScreen(3.5),
                            color: Colors.white,
                          ),
                    onPressed: () {
                      provider.setBtnSearch(!provider.btnSearch);
                      _textSearchController.text = "";

                      if (provider.getingresoSalida == 0) {
                        // provider.setListaVisitasBitacoras([]);

                        provider.getAllVisitasBitacoras('', 'false', 'INGRESO');
                      } else {
                        // provider.setListaVisitasBitacoras([]);

                        provider.getAllVisitasBitacoras('', 'false', 'SALIDA');
                      }

                      // provider.setingresoSalida(0);
                    }),
                IconButton(
                    splashRadius: 2.0,
                    icon: Icon(
                      Icons.manage_search_outlined,
                      size: size.iScreen(3.5),
                      color: Colors.white,
                    ),
                    onPressed: () {
                      busquedaAvanzadaModal(context, size);
                      // provider.getTodosLosComunicadosClientes('');
                    }),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(
                top: size.iScreen(0.0),
                left: size.iScreen(0.5),
                right: size.iScreen(0.5),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child:

//               Consumer<BitacoraController>(
//                 builder: (_, providers, __) {

//                   return (providers.filteredList.isEmpty)
//                       ? Center(child: Column(
//                         children: [
//                           CircularProgressIndicator(),
//                           Text('No hay resyltados ....')
//                         ],
//                       ))
//                       : (providers.filteredList.length > 0)
//                           ?
//                           ListView.builder(
//                              itemCount: providers.filteredList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 // print('SE RECARGO.....!!!!');
//                                 final visitante = providers.filteredList[index];

//                                 return
//                                 // Text(cliente['residenteNombre']);
//                              //==================================//

//         //                       ExpansionTile(
//         //   title: Text(visitante["visitaNombre"] ?? "Nombre no disponible", style: GoogleFonts
//         //                                                     .lexendDeca(
//         //                                                         fontSize: size
//         //                                                             .iScreen(1.8),
//         //                                                         color: Colors
//         //                                                             .black87,
//         //                                                         fontWeight:
//         //                                                             FontWeight
//         //                                                                 .bold),),
//         //   children: [

//         //   ],
//         // );

// Card(
//               child: Container(
//                 decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8)
//                 ),

//                 padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5),vertical: size.iScreen(0.5)),
//                 width: size.wScreen(100),
//                 child: Column(

//                   children: [
//                     Row(

//                       children: [
//                         // Aquí puedes añadir una imagen de la foto si la tienes
//                         // por ejemplo usando un Image.network si la foto es una URL
//                         visitante["foto"]!.isNotEmpty
//                             ? Container(
//                                decoration: BoxDecoration(
//                                  color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(8.0)
//                               ),
//                               child: Image.network(
//                                   visitante["foto"]!,
//                                   width: size.iScreen(3.0),
//                                   height: size.iScreen(3.0),
//                                   fit: BoxFit.cover,
//                                 ),
//                             )
//                             : Container(
//                               decoration: BoxDecoration(
//                                  color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(8.0)
//                               ),
//                                 width: size.iScreen(6.0),
//                                 height: size.iScreen(6.0),

//                                 child: Icon(Icons.person),
//                               ),
//                         SizedBox(width: 10),
//                         Container(

//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                                Container(
//                                 // color: Colors.green,
//                                 width: size.wScreen(75.0),
//                                 child: Row(
//                                   children: [
//                                     Text("Documento: ", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),),
//                                                                           Text("${visitante["visitaCedula"]}", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),),
//                                   ],
//                                 )),
//                                  SizedBox(height:size.iScreen(0.5)),
//                               Container(
//                                 // color: Colors.red,
//                                  width: size.wScreen(75.0),
//                                 child: Text("${visitante["visitaNombre"]}", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),),)
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height:size.iScreen(0.5)),
//                     Container(
//                       width: size.wScreen(100),
//                       // color:Colors.red,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                                   children: [
//                                     Text("Departamento: ", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),),
//                                                                           Container(

//                                                                               width: size.wScreen(60),
//                                                                             child: Text("${visitante["departamento"]}", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                             .bold),),
//                                                                           ),
//                                   ],
//                                 ),
//                                   SizedBox(height:size.iScreen(0.5)),
//                            Row(
//                                   children: [
//                                     Text("Número: ", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),),
//                                                                           Container(
//                                                                               width: size.wScreen(70),
//                                                                             child: Text("${visitante["numero"]}", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                             .bold),),
//                                                                           ),
//                                   ],
//                                 ),
//                                 SizedBox(height:size.iScreen(0.5)),
//                               Row(
//                                   children: [
//                                     Text("Ubicación: ", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal),),
//                                                                           Container(
//                                                                             width: size.wScreen(70),
//                                                                             child: Text("${visitante["ubicacion"]}", style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(1.8),
//                                                                   color: Colors
//                                                                       .black87,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                             .bold),),
//                                                                           ),
//                                   ],
//                                 ),
//                                 SizedBox(height:size.iScreen(1.0)),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
//                                       decoration:BoxDecoration(
//                                           color: Colors.green.shade200,
//                                           borderRadius: BorderRadius.circular(8.0)
//                                       ),

//                                       child: Column(
//                                         children: [
//                                           Text("Ingreso ", style: GoogleFonts
//                                                                     .lexendDeca(
//                                                                         fontSize: size
//                                                                             .iScreen(1.8),
//                                                                         color: Colors
//                                                                             .black87,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .normal),),
//                                                                                  SizedBox(height:size.iScreen(0.5)),
//                                                                                  Text("${visitante["fechaIngreso"]}", style: GoogleFonts
//                                                                 .lexendDeca(
//                                                                     fontSize: size
//                                                                         .iScreen(1.8),
//                                                                     color: Colors
//                                                                         .black87,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold),),
//                                         ],
//                                       ),
//                                     ),

//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
//                                       decoration:BoxDecoration(
//                                           color: Colors.orange.shade200,
//                                           borderRadius: BorderRadius.circular(8.0)
//                                       ),

//                                       child: Column(
//                                         children: [
//                                           Text("Salida ", style: GoogleFonts
//                                                                     .lexendDeca(
//                                                                         fontSize: size
//                                                                             .iScreen(1.8),
//                                                                         color: Colors
//                                                                             .black87,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .normal),),
//                                                                                  SizedBox(height:size.iScreen(0.5)),
//                                                                                  Text("--- --- --- --- ---", style: GoogleFonts
//                                                                 .lexendDeca(
//                                                                     fontSize: size
//                                                                         .iScreen(1.8),
//                                                                     color: Colors
//                                                                         .black87,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold),),
//                                         ],
//                                       ),
//                                     ),

//                                   ],
//                                 ),
//                                  SizedBox(height:size.iScreen(1.0)),

//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );

//                               //********************************//

//                               },

//                             )
//                           : NoData(
//                               label: 'No existe el Cliente',
//                             );

//     // ListView.builder(
//     //   itemCount: _listaVisitantes.length,
//     //   itemBuilder: (context, index) {
//     //     var visitante = _listaVisitantes[index];
//     //     return
//     // ExpansionTile(
//     //       title: Text(visitante["visitaNombre"] ?? "Nombre no disponible", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .bold),),
//     //       children: [
//     //         Container(
//     //           color: Colors.white,
//     //           padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5),vertical: size.iScreen(0.5)),
//     //           width: size.wScreen(100),
//     //           child: Column(

//     //             children: [
//     //               Row(

//     //                 children: [
//     //                   // Aquí puedes añadir una imagen de la foto si la tienes
//     //                   // por ejemplo usando un Image.network si la foto es una URL
//     //                   visitante["foto"]!.isNotEmpty
//     //                       ? Container(
//     //                          decoration: BoxDecoration(
//     //                            color: Colors.grey,
//     //                           borderRadius: BorderRadius.circular(8.0)
//     //                         ),
//     //                         child: Image.network(
//     //                             visitante["foto"]!,
//     //                             width: size.iScreen(3.0),
//     //                             height: size.iScreen(3.0),
//     //                             fit: BoxFit.cover,
//     //                           ),
//     //                       )
//     //                       : Container(
//     //                         decoration: BoxDecoration(
//     //                            color: Colors.grey,
//     //                           borderRadius: BorderRadius.circular(8.0)
//     //                         ),
//     //                           width: size.iScreen(6.0),
//     //                           height: size.iScreen(6.0),

//     //                           child: Icon(Icons.person),
//     //                         ),
//     //                   SizedBox(width: 10),
//     //                   Container(

//     //                     child: Column(
//     //                       mainAxisAlignment: MainAxisAlignment.start,
//     //                       children: [
//     //                          Container(
//     //                           // color: Colors.green,
//     //                           width: size.wScreen(75.0),
//     //                           child: Row(
//     //                             children: [
//     //                               Text("Documento: ", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .grey,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .normal),),
//     //                                                                     Text("${visitante["visitaCedula"]}", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .bold),),
//     //                             ],
//     //                           )),
//     //                            SizedBox(height:size.iScreen(0.5)),
//     //                         Container(
//     //                           // color: Colors.red,
//     //                            width: size.wScreen(75.0),
//     //                           child: Text("${visitante["visitaNombre"]}", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .bold),),)
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //               SizedBox(height:size.iScreen(0.5)),
//     //               Container(
//     //                 width: size.wScreen(100),
//     //                 // color:Colors.red,
//     //                 child: Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: [
//     //                     Row(
//     //                             children: [
//     //                               Text("Departamento: ", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .grey,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .normal),),
//     //                                                                     Container(

//     //                                                                         width: size.wScreen(60),
//     //                                                                       child: Text("${visitante["departamento"]}", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                       .bold),),
//     //                                                                     ),
//     //                             ],
//     //                           ),
//     //                             SizedBox(height:size.iScreen(0.5)),
//     //                      Row(
//     //                             children: [
//     //                               Text("Número: ", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .grey,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .normal),),
//     //                                                                     Container(
//     //                                                                         width: size.wScreen(70),
//     //                                                                       child: Text("${visitante["numero"]}", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                       .bold),),
//     //                                                                     ),
//     //                             ],
//     //                           ),
//     //                           SizedBox(height:size.iScreen(0.5)),
//     //                         Row(
//     //                             children: [
//     //                               Text("Ubicación: ", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .grey,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                     .normal),),
//     //                                                                     Container(
//     //                                                                       width: size.wScreen(70),
//     //                                                                       child: Text("${visitante["ubicacion"]}", style: GoogleFonts
//     //                                                         .lexendDeca(
//     //                                                             fontSize: size
//     //                                                                 .iScreen(1.8),
//     //                                                             color: Colors
//     //                                                                 .black87,
//     //                                                             fontWeight:
//     //                                                                 FontWeight
//     //                                                                       .bold),),
//     //                                                                     ),
//     //                             ],
//     //                           ),
//     //                           SizedBox(height:size.iScreen(1.0)),
//     //                             Row(
//     //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //                             children: [
//     //                               Container(
//     //                                 padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
//     //                                 decoration:BoxDecoration(
//     //                                     color: Colors.green.shade200,
//     //                                     borderRadius: BorderRadius.circular(8.0)
//     //                                 ),

//     //                                 child: Column(
//     //                                   children: [
//     //                                     Text("Ingreso ", style: GoogleFonts
//     //                                                               .lexendDeca(
//     //                                                                   fontSize: size
//     //                                                                       .iScreen(1.8),
//     //                                                                   color: Colors
//     //                                                                       .black87,
//     //                                                                   fontWeight:
//     //                                                                       FontWeight
//     //                                                                           .normal),),
//     //                                                                            SizedBox(height:size.iScreen(0.5)),
//     //                                                                            Text("${visitante["fechaIngreso"]}", style: GoogleFonts
//     //                                                           .lexendDeca(
//     //                                                               fontSize: size
//     //                                                                   .iScreen(1.8),
//     //                                                               color: Colors
//     //                                                                   .black87,
//     //                                                               fontWeight:
//     //                                                                   FontWeight
//     //                                                                       .bold),),
//     //                                   ],
//     //                                 ),
//     //                               ),

//     //                               Container(
//     //                                 padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
//     //                                 decoration:BoxDecoration(
//     //                                     color: Colors.orange.shade200,
//     //                                     borderRadius: BorderRadius.circular(8.0)
//     //                                 ),

//     //                                 child: Column(
//     //                                   children: [
//     //                                     Text("Salida ", style: GoogleFonts
//     //                                                               .lexendDeca(
//     //                                                                   fontSize: size
//     //                                                                       .iScreen(1.8),
//     //                                                                   color: Colors
//     //                                                                       .black87,
//     //                                                                   fontWeight:
//     //                                                                       FontWeight
//     //                                                                           .normal),),
//     //                                                                            SizedBox(height:size.iScreen(0.5)),
//     //                                                                            Text("--- --- --- --- ---", style: GoogleFonts
//     //                                                           .lexendDeca(
//     //                                                               fontSize: size
//     //                                                                   .iScreen(1.8),
//     //                                                               color: Colors
//     //                                                                   .black87,
//     //                                                               fontWeight:
//     //                                                                   FontWeight
//     //                                                                       .bold),),
//     //                                   ],
//     //                                 ),
//     //                               ),

//     //                             ],
//     //                           ),
//     //                            SizedBox(height:size.iScreen(0.5)),

//     //                   ],
//     //                 ),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       ],
//     //     );
//     //   },
//     // );

//                 },
//               )),
//           Positioned(
//             top: 0,
//             child: Container(
//                 width: size.wScreen(100.0),
//                 margin: const EdgeInsets.all(0.0),
//                 padding: const EdgeInsets.all(0.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('${_user.getUsuarioInfo!.rucempresa!}  ',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey.shade600,
//                             fontWeight: FontWeight.bold)),
//                     Text('-',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold)),
//                     Text('  ${_user.getUsuarioInfo!.usuario!} ',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.5),
//                             color: Colors.grey.shade600,
//                             fontWeight: FontWeight.bold)),
//                   ],
//                 )),
//           ),

                  DefaultTabController(
                      length: 2, // Número de pestañas
                      child: Column(
                        children: [
                          // Pestañas

                          SizedBox(
                            height: size.iScreen(0.0),
                          ),

                          //==========================================//
                          Container(
                              width: size.wScreen(100.0),
                              margin: const EdgeInsets.all(0.0),
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold)),
                                  Text('-',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                  Text('  ${_user.getUsuarioInfo!.usuario!} ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                          //*****************************************/

                          // SizedBox(
                          //   height: size.iScreen(0.5),
                          // ),

                          //==========================================//
                          Consumer<BitacoraController>(
                            builder: (_, value, __) {
                              return TabBar(
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(
                                      text: value.getingresoSalida == 0
                                          ? 'INGRESOS (${value.filteredList.length})'
                                          : 'INGRESOS'),
                                  Tab(
                                      text: value.getingresoSalida == 1
                                          ? 'SALIDAS (${value.filteredList.length})'
                                          : 'SALIDAS'),
                                ],
                                onTap: (int index) {
                                  _controller.resetValuesBitacora();
                                  _controller.onInputFechaInicioChange('');
                                  _controller.onInputFechaFinChange('');
                                  if (index == 0) {
                                    // _controller.getBitacoras('', 'false'); ///*********este es el principal  */
                                    _controller.setingresoSalida(0);
                                    _controller.setListaVisitasBitacoras([]);
                                    _controller.getAllVisitasBitacoras(
                                        '', 'false', 'INGRESO');
                                  } else {
                                    _controller.setingresoSalida(1);
                                    _controller.setListaVisitasBitacoras([]);
                                    _controller.getAllVisitasBitacoras(
                                        '', 'false', 'SALIDA');
                                  }
                                },
                              );
                            },
                          ),

                          Expanded(
                              child: TabBarView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                //=================================INGRESO VISITANTES===================================//

                                Consumer<BitacoraController>(
                                  builder: (_, providers, __) {
                                    return (providers.filteredList.isEmpty)
                                        ?
                                        // Center(
                                        //     child: Column(
                                        //       mainAxisAlignment: MainAxisAlignment.center,
                                        //     children: [
                                        //       CircularProgressIndicator(),
                                        //       Text('No hay resultados ....')
                                        //     ],
                                        //   ))
                                        NoData(label: 'No hay registro')
                                        : (providers.filteredList.length > 0)
                                            ? RefreshIndicator(
                                                onRefresh: _onRefreshIngreso,
                                                child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: providers
                                                      .filteredList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    // print('SE RECARGO.....!!!!');
                                                    final visitante = providers
                                                        .filteredList[index];

                                                    //****************FECHA LOCAL INGRESO****************//
                                                    String fechaLocalIngreso =
                                                        '';
                                                    if (visitante[
                                                            'bitFechaIngreso'] !=
                                                        null) {
                                                      fechaLocalIngreso = DateUtility
                                                          .fechaLocalConvert(
                                                              visitante[
                                                                      'bitFechaIngreso']!
                                                                  .toString());
                                                    } else {
                                                      fechaLocalIngreso =
                                                          '--- --- --- --- --- ';
                                                    }
                                                    //****************FECHA LOCAL SALIDA****************//
                                                    String fechaLocalSalida =
                                                        '';
                                                    if (visitante[
                                                            'bitFechaSalida'] !=
                                                        null) {
                                                      fechaLocalSalida = DateUtility
                                                          .fechaLocalConvert(
                                                              visitante[
                                                                      'bitFechaSalida']!
                                                                  .toString());
                                                    } else {
                                                      fechaLocalSalida =
                                                          '--- --- --- --- --- ';
                                                    }

                                                    return
                                                        // Text(cliente['residenteNombre']);
                                                        //==================================//

                                                        GestureDetector(
                                                      onDoubleTap: () {
                                                        providers.setInfoVisita(
                                                            visitante);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const InfoVisita()));
                                                      },
                                                      child: Card(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          0.5),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          width:
                                                              size.wScreen(100),
                                                          child: Column(
                                                            children: [
                                                                                 //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                            //*****************************************/
                                             Container(
                                              width: size.wScreen(100.0),
                                              child: Row(
                                                children: [
                                                  Text('Tipo de Ingreso: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                            Container(
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                  '${visitante['bitTipoIngreso']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.bold,
                                                      // color: Colors.grey
                                                      )),
                                            ),
                                                ],
                                              ),
                                            ),
              
                                          
                                          
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),

                                                              Row(
                                                                children: [
                                                                  // Aquí puedes añadir una imagen de la foto si la tienes
                                                                  // por ejemplo usando un Image.network si la foto es una URL
                                                                  visitante["bitFotoPersona"] !=
                                                                          null
                                                                      ? Container(
                                                                          width: size.iScreen(
                                                                              5.5),
                                                                          height: size.iScreen(
                                                                              5.5),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey.shade300,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          child:
                                                                              //  Image
                                                                              //     .network(
                                                                              //   visitante[
                                                                              //       "foto"]!,
                                                                              //   width: size
                                                                              //       .iScreen(3.0),
                                                                              //   height:
                                                                              //       size.iScreen(3.0),
                                                                              //   fit: BoxFit
                                                                              //       .cover,
                                                                              // ),
                                                                              //            FadeInImage(
                                                                              //   placeholder:
                                                                              //       const AssetImage(
                                                                              //             'assets/imgs/loader.gif'),
                                                                              //   image: NetworkImage(
                                                                              //     '${visitante['bitFotoPersona']}',
                                                                              //   ),
                                                                              // )
                                                                              FadeInImage(
                                                                            placeholder:
                                                                                const AssetImage('assets/imgs/loader.gif'),
                                                                            image:
                                                                                NetworkImage(visitante['bitFotoPersona']),
                                                                            imageErrorBuilder: (BuildContext context,
                                                                                Object error,
                                                                                StackTrace? stackTrace) {
                                                                              return Image.asset('assets/imgs/no-image.png'); // Imagen de respaldo
                                                                            },
                                                                          ))
                                                                      : Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey.shade300,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          width:
                                                                              size.iScreen(6.0),
                                                                          height:
                                                                              size.iScreen(6.0),
                                                                          child:
                                                                              Icon(Icons.person),
                                                                        ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            // color: Colors.green,
                                                                            width:
                                                                                size.wScreen(75.0),
                                                                            child: Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Documento: ",
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.grey, fontWeight: FontWeight.normal),
                                                                                ),
                                                                                Text(
                                                                                  visitante["bitVisitanteCedula"] != null ? "${visitante["bitVisitanteCedula"]}" : '--- --- --- --- ---',
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Spacer(),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    //  Navigator.pop(context);
                            //====================//

  // print('${visitante["bitId"]}&rucempresa=${_user.getUsuarioInfo!.rucempresa}');




                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewsPDFs(
                                      infoPdf:'https://backsafe.neitor.com/api/reportes/bitacora_individual?bitId=${visitante["bitId"]}&rucempresa=${_user.getUsuarioInfo!.rucempresa}',
                                       labelPdf: 'Visita.pdf')));
                                     
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white, // Fondo blanco
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                      border: Border.all(color: Colors.red, width: 2), // Borde rojo
                                                                                    ),
                                                                                    width: size.iScreen(5.0),
                                                                                    height: size.iScreen(4.0),
                                                                                    child: Center(
                                                                                      child: FaIcon(
                                                                                        FontAwesomeIcons.filePdf,
                                                                                        color: Colors.red, // Ícono rojo
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )),
                                                                        SizedBox(
                                                                            height:
                                                                                size.iScreen(0.5)),
                                                                        Container(
                                                                          // color: Colors.red,
                                                                          width:
                                                                              size.wScreen(75.0),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitVisitanteNombres"] != null
                                                                                ? "${visitante["bitVisitanteNombres"]}"
                                                                                : '--- --- --- --- --- ',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          0.5)),
                                                              Container(
                                                                width: size
                                                                    .wScreen(
                                                                        100),
                                                                // color:Colors.red,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Departamento: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(60),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitNombre_dpt"] != null
                                                                                ? "${visitante["bitNombre_dpt"]}"
                                                                                : '--- --- --- --- ---',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Número: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(70),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitNumero_dpt"] != null
                                                                                ? "${visitante["bitNumero_dpt"]}"
                                                                                : '--- --- --- --- ---',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Ubicación: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(70),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitCliUbicacion"] != null
                                                                                ? "${visitante["bitCliUbicacion"]}"
                                                                                : '',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(1.0)),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.iScreen(1.0),
                                                                              vertical: size.iScreen(0.5)),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.green.shade200,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Ingreso ",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.normal),
                                                                              ),
                                                                              SizedBox(height: size.iScreen(0.5)),
                                                                              Text(
                                                                                "${fechaLocalIngreso}",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            _controller.setInfoVisitante(visitante);

                                                                            showExitConfirmationDialog(context,
                                                                                size);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: size.iScreen(1.0), vertical: size.iScreen(0.5)),
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8.0)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  "Salida ",
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.normal),
                                                                                ),
                                                                                SizedBox(height: size.iScreen(0.5)),
                                                                                Text(
                                                                                  "--- --- --- --- ---",
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(1.0)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    //********************************//
                                                  },
                                                ),
                                              )
                                            : NoData(
                                                label: 'No existen Datos',
                                              );
                                  },
                                ),

                                //=============================SALIDA DE VISITANTES=======================================//

                                Consumer<BitacoraController>(
                                  builder: (_, providers, __) {
                                    return (providers.filteredList.isEmpty)
                                        ?
                                        // Center(
                                        //     child: Column(
                                        //     children: [
                                        //       CircularProgressIndicator(),
                                        //       Text('No hay resultados ....')
                                        //     ],
                                        //   ))
                                        NoData(label: 'No hay registro')
                                        : (providers.filteredList.length > 0)
                                            ? RefreshIndicator(
                                                onRefresh: _onRefreshSalida,
                                                child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: providers
                                                      .filteredList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    //****************FECHA LOCAL INGRESO****************//
                                                    final visitante = providers
                                                        .filteredList[index];
                                                    String fechaLocalIngreso =
                                                        '';
                                                    if (visitante[
                                                            'bitFechaIngreso'] !=
                                                        null) {
                                                      fechaLocalIngreso = DateUtility
                                                          .fechaLocalConvert(
                                                              visitante[
                                                                      'bitFechaIngreso']!
                                                                  .toString());
                                                    } else {
                                                      fechaLocalIngreso =
                                                          '--- --- --- --- --- ';
                                                    }
                                                    //****************FECHA LOCAL SALIDA****************//
                                                    String fechaLocalSalida =
                                                        '';
                                                    if (visitante[
                                                            'bitFechaSalida'] !=
                                                        null) {
                                                      fechaLocalSalida = DateUtility
                                                          .fechaLocalConvert(
                                                              visitante[
                                                                      'bitFechaSalida']!
                                                                  .toString());
                                                    } else {
                                                      fechaLocalSalida =
                                                          '--- --- --- --- --- ';
                                                    }
                                                    return
                                                        // Text(cliente['residenteNombre']);
                                                        //==================================//

                                                        GestureDetector(
                                                      onDoubleTap: () {
                                                        providers.setInfoVisita(
                                                            visitante);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const InfoVisita()));
                                                      },
                                                      child: Card(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          0.5),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          width:
                                                              size.wScreen(100),
                                                          child: Column(
                                                            children: [
                                                                                 //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                            //*****************************************/
                                             Container(
                                              width: size.wScreen(100.0),
                                              child: Row(
                                                children: [
                                                  Text('Tipo de Ingreso: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                            Container(
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                  '${visitante['bitTipoIngreso']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.bold,
                                                      // color: Colors.grey
                                                      )),
                                            ),
                                                ],
                                              ),
                                            ),
              
                                          
                                          
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),

                                                              Row(
                                                                children: [
                                                                  // Aquí puedes añadir una imagen de la foto si la tienes
                                                                  // por ejemplo usando un Image.network si la foto es una URL
                                                                  visitante["bitFotoPersona"]!
                                                                          .isNotEmpty
                                                                      ? Container(
                                                                          width: size.iScreen(
                                                                              5.5),
                                                                          height: size.iScreen(
                                                                              5.5),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey.shade300,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          child:
                                                                              //  Image
                                                                              //     .network(
                                                                              //   visitante[
                                                                              //       "foto"]!,
                                                                              //   width: size
                                                                              //       .iScreen(3.0),
                                                                              //   height:
                                                                              //       size.iScreen(3.0),
                                                                              //   fit: BoxFit
                                                                              //       .cover,
                                                                              // ),
                                                                              //            FadeInImage(
                                                                              //   placeholder:
                                                                              //       const AssetImage(
                                                                              //             'assets/imgs/loader.gif'),
                                                                              //   image: NetworkImage(
                                                                              //     '${visitante['bitFotoPersona']}',
                                                                              //   ),
                                                                              // )
                                                                              FadeInImage(
                                                                            placeholder:
                                                                                const AssetImage('assets/imgs/loader.gif'),
                                                                            image:
                                                                                NetworkImage(visitante['bitFotoPersona']),
                                                                            imageErrorBuilder: (BuildContext context,
                                                                                Object error,
                                                                                StackTrace? stackTrace) {
                                                                              return Image.asset('assets/imgs/no-image.png'); // Imagen de respaldo
                                                                            },
                                                                          ))
                                                                      : Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey.shade300,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          width:
                                                                              size.iScreen(6.0),
                                                                          height:
                                                                              size.iScreen(6.0),
                                                                          child:
                                                                              Icon(Icons.person),
                                                                        ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            // color: Colors.green,
                                                                            width:
                                                                                size.wScreen(75.0),
                                                                            child: Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Documento: ",
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.grey, fontWeight: FontWeight.normal),
                                                                                ),
                                                                                Text(
                                                                                  visitante["bitVisitanteCedula"].isEmpty || visitante["bitVisitanteCedula"] != null ? "${visitante["bitVisitanteCedula"]}" : '--- --- --- --- ---',
                                                                                  style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Spacer(),
                                                                                GestureDetector(
                                                                                  onTap: () {


                                                                                    

                                                                                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewsPDFs(
                                      infoPdf:'https://backsafe.neitor.com/api/reportes/bitacora_individual?bitId=${visitante["bitId"]}&rucempresa=${_user.getUsuarioInfo!.rucempresa}',
                                       labelPdf: 'Visita.pdf')));
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white, // Fondo blanco
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                      border: Border.all(color: Colors.red, width: 2), // Borde rojo
                                                                                    ),
                                                                                    width: size.iScreen(5.0),
                                                                                    height: size.iScreen(4.0),
                                                                                    child: Center(
                                                                                      child: FaIcon(
                                                                                        FontAwesomeIcons.filePdf,
                                                                                        color: Colors.red, // Ícono rojo
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )),
                                                                        SizedBox(
                                                                            height:
                                                                                size.iScreen(0.5)),
                                                                        Container(
                                                                          // color: Colors.red,
                                                                          width:
                                                                              size.wScreen(75.0),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitVisitanteNombres"].isEmpty || visitante["bitVisitanteNombres"] != null
                                                                                ? "${visitante["bitVisitanteNombres"]}"
                                                                                : '--- --- --- --- --- ',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          0.5)),
                                                              Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: size
                                                                        .iScreen(
                                                                            0.5),
                                                                    horizontal:
                                                                        size.iScreen(
                                                                            0.5)),
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                                width: size
                                                                    .wScreen(
                                                                        100),
                                                                child: Text(
                                                                  "Se dirige a: ",
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.7),
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: size
                                                                    .wScreen(
                                                                        100),
                                                                // color:Colors.red,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Persona: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(75),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitResApellidos"].isEmpty || visitante["bitResApellidos"] != null
                                                                                ? "${visitante["bitResApellidos"]} ${visitante["bitResNombres"]}"
                                                                                : '--- --- --- --- ---',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Departamento: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(60),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitNombre_dpt"].isEmpty || visitante["bitNombre_dpt"] != null
                                                                                ? "${visitante["bitNombre_dpt"]}"
                                                                                : '--- --- --- --- ---',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Número: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(70),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitNumero_dpt"].isEmpty || visitante["bitNumero_dpt"] != null
                                                                                ? "${visitante["bitNumero_dpt"]}"
                                                                                : '--- --- --- --- ---',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(0.5)),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Ubicación: ",
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              size.wScreen(70),
                                                                          child:
                                                                              Text(
                                                                            visitante["bitCliUbicacion"].isEmpty || visitante["bitCliUbicacion"] != null
                                                                                ? "${visitante["bitCliUbicacion"]}"
                                                                                : '',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.8),
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(1.0)),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.iScreen(1.0),
                                                                              vertical: size.iScreen(0.5)),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey.shade300,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Ingreso ",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.normal),
                                                                              ),
                                                                              SizedBox(height: size.iScreen(0.5)),
                                                                              Text(
                                                                                "${fechaLocalIngreso}",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.iScreen(1.0),
                                                                              vertical: size.iScreen(0.5)),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.orange.shade200,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Salida ",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.normal),
                                                                              ),
                                                                              SizedBox(height: size.iScreen(0.5)),
                                                                              Text(
                                                                                "$fechaLocalSalida",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            size.iScreen(1.0)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    //********************************//
                                                  },
                                                ),
                                              )
                                            : NoData(
                                                label: 'No existen Datos',
                                              );
                                  },
                                ),

                                //====================================================================//
                              ]))
                        ],
                      )))

//=========================================================================//
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   // backgroundColor: primaryColor,
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, 'registroDeBitacora');
      //   },
      // )
      // floatingActionButton:
      //     //  //***********************************************/
      //     widget.user!.rol!.contains('CLIENTE')
      //         ? Container()
      //         : Consumer<SocketService>(
      //             builder: (_, valueEstadoInter, __) {
      //               return valueEstadoInter.serverStatus == ServerStatus.Online
      //                   ? FloatingActionButton(
      //                       backgroundColor:  ctrlTheme.primaryColor,
      //                       child: const Icon(Icons.add),
      //                       onPressed: () {
      //                         _controller.resetValuesBitacora();
      //                         widget.user!.rol!.contains('GUARDIA')
      //                             ? Container()
      //                             : _controller.getInfoClienteResidente('');

      //                         // Navigator.pushNamed(context, 'registroDeBitacora');

      //                         // _controller.removeFrontBackImage();

      //                         Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                                 // builder: ((context) => const RegitroBiracora(
      //                                 builder: ((context) => CrearBitaora(
      //                                       user: widget.user,
      //                                       action: 'CREATE',
      //                                     ))));
      //                       },
      //                     )
      //                   : Container();
      //             },
      //           ),
    );
  }

  void showExitConfirmationDialog(BuildContext context, Responsive size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Confirmar Salida',
              style: GoogleFonts.lexendDeca(
                  fontSize: size.iScreen(2.5),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          content: Text('Seguro de Salir?',
              style: GoogleFonts.lexendDeca(
                  fontSize: size.iScreen(2.0),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: () {
                final _crtl = context.read<BitacoraController>();

                _crtl.creaSalidaBitacoraVisitante(context);
                _crtl.getAllVisitasBitacoras('', 'false', 'INGRESO');

                Navigator.of(context).pop(); // Close the dialog
                // Add your exit logic here
              },
            ),
          ],
        );
      },
    );
  }

  // void busquedaAvanzadaModal(context, Responsive size) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.symmetric(
  //             horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         title: Text('Búsqueda Avanzada',
  //             style: GoogleFonts.lexendDeca(
  //                 fontSize: size.iScreen(2.5),
  //                 color: Colors.black87,
  //                 fontWeight: FontWeight.bold)),
  //         content: Container(
  //           width: size.wScreen(100.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: size.wScreen(100.0),
  //                 padding:EdgeInsets.symmetric(
  //             horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
  //                 child: Text('Por Fecha:',
  //                     style: GoogleFonts.lexendDeca(
  //                         fontSize: size.iScreen(1.8),
  //                         color: Colors.grey,
  //                         fontWeight: FontWeight.normal)),
  //               ),
  //                SizedBox(
  //                                                                   height: size
  //                                                                       .iScreen(
  //                                                                           0.0)),
  //               Container(
  //                 width: size.wScreen(100.0),
  //                 child:
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Column(
  //                       children: [
  //                         Text('desde',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.normal)),
  //                         Text('2024-07-30',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.bold)),
  //                       ],
  //                     ),
  //                      Text(' - ',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.bold)),
  //                     Column(
  //                       children: [
  //                         Text('Hasta',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.normal)),
  //                         Text('2024-07-30',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.bold)),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Si'),
  //             onPressed: () {
  //               final _crtl = context.read<BitacoraController>();

  //               Navigator.of(context).pop(); // Close the dialog
  //               // Add your exit logic here
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void busquedaAvanzadaModal(BuildContext context, Responsive size) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Búsqueda Avanzada',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  Container(
                    width: size.wScreen(100),
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.iScreen(0.5),
                        vertical: size.iScreen(0.5)),
                    child: Text('Por Fecha',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.grey,
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(height: size.iScreen(1.0)),
                  SizedBox(
                    width: size.wScreen(100),
                    // height: size.hScreen(26),
                    child: Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text('desde',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Consumer<BitacoraController>(
                                builder: (_, valueFecha, __) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // if (_action !=
                                            //     'MULTA') {
                                            //   FocusScope.of(context)
                                            //       .requestFocus(
                                            //           FocusNode());
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _selectFechaInicio(
                                              context,
                                              valueFecha,
                                            );
                                            // }
                                            // _fecha(context, valueFecha);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                valueFecha.getInputfechaInicio ==
                                                        ''
                                                    ? '-- -- -- -- --'
                                                    : valueFecha
                                                        .getInputfechaInicio
                                                        .toString()
                                                        .substring(0, 10),
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.iScreen(1.0),
                                              ),
                                              Consumer<ThemeApp>(
                                                builder: (_, value, __) {
                                                  return Icon(
                                                    Icons.date_range_outlined,
                                                    color: value.secondaryColor,
                                                    size: 30,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]);
                                },
                              ),
                            ],
                          ),
                          Column(children: [
                            Text(' / ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                          ]),
                          Column(
                            children: [
                              Text('hasta',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              Consumer<BitacoraController>(
                                builder: (_, valueFecha, __) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // if (_action !=
                                            //     'MULTA') {
                                            //   FocusScope.of(context)
                                            //       .requestFocus(
                                            //           FocusNode());
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _selectFechaFin(
                                              context,
                                              valueFecha,
                                            );
                                            // }
                                            // _fecha(context, valueFecha);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                valueFecha.getInputfechaFin ==
                                                        ''
                                                    ? '-- -- -- -- --'
                                                    : valueFecha
                                                        .getInputfechaFin
                                                        .toString()
                                                        .substring(0, 10),
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.iScreen(1.0),
                                              ),
                                              Consumer<ThemeApp>(
                                                builder: (_, value, __) {
                                                  return Icon(
                                                    Icons.date_range_outlined,
                                                    color: value.secondaryColor,
                                                    size: 30,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.iScreen(1.0)),
                  Consumer<BitacoraController>(builder: (_, valueBtn, __) {
                    return GestureDetector(
                      onTap: valueBtn.getInputfechaFin != ''
                          ? () {
                              if (valueBtn.getingresoSalida == 0) {
                                // valueBtn.setListaVisitasBitacoras([]);

                                //       valueBtn.getAllVisitasBitacoras(
                                //           '', 'false', 'INGRESO');
                                // valueBtn.setListFilter([]);
                                // valueBtn.searchParametro('');
                                valueBtn.filterByDates();
                              } else {
                                // valueBtn.setListaVisitasBitacoras([]);

                                //         valueBtn.getAllVisitasBitacoras(
                                //             '', 'false', 'SALIDA');
                                valueBtn.setListFilter([]);
                                valueBtn.searchParametro('');
                              }

                              // print('MOSTRAMOS LA LISTA ACTUAL ${valueBtn.getListaVisitasBitacoras.length}');
                              //  print('MOSTRAMOS LA LISTA ACTUAL 1 ${valueBtn.getListaVisitasBitacoras[0]}');
                              //  print('MOSTRAMOS LA LISTA ACTUAL 2 ${valueBtn.getListaVisitasBitacoras[1]}');
                              //  print('MOSTRAMOS LA LISTA ACTUAL 3${valueBtn.getListaVisitasBitacoras[2]}');
                              // print('MOSTRAMOS FECHAS : ${valueBtn.getInputfechaInicio}- ${valueBtn.getInputfechaFin}');

                              Navigator.of(context).pop();
                            }
                          : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Consumer<ThemeApp>(
                          builder: (_, valueTheme, __) {
                            return Container(
                                alignment: Alignment.center,
                                // color:value.getInputfechaInicio!='' && value.getInputHoraInicio!=''
                                // && value.getInputfechaFin!='' && value.getInputHoraFin!=''
                                //  ?valueTheme.getPrimaryTextColor : Colors.grey.shade500  ,
                                // width: size.iScreen(9.0),
                                color: valueBtn.getInputfechaFin != ''
                                    ? valueTheme.primaryColor
                                    : Colors.grey,
                                width: size.iScreen(9.0),
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.5),
                                  left: size.iScreen(0.5),
                                  right: size.iScreen(0.5),
                                ),
                                child: Text('Agregar',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white))
                                // Icon(
                                //   Icons.add,
                                //   color: valueTheme.getSecondryTextColor,
                                //   size: size.iScreen(2.0),
                                // ),
                                );
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _onRefreshIngreso() async {
    final _controller = context.read<BitacoraController>();
    _controller.resetValuesBitacora();

    _controller.setListaVisitasBitacoras([]);
    _controller.getAllVisitasBitacoras('', 'false', 'INGRESO');
    //  _controller.setListFilter(_controller.getListaVisitantes);
    // _controller.setListFilter(_controller.getListaVisitasBitacoras);
  }

  Future<void> _onRefreshSalida() async {
    final _controller = context.read<BitacoraController>();
    _controller.resetValuesBitacora();

    _controller.setListaVisitasBitacoras([]);
    _controller.getAllVisitasBitacoras('', 'false', 'SALIDA');
    //  _controller.setListFilter(_controller.getListaVisitantes);
    // _controller.setListFilter(_controller.getListaVisitasBitacoras);
  }

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaInicio(BuildContext context, BitacoraController _ctr) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaInicioController.text = _fechaInicio;
      _ctr.onInputFechaInicioChange(_fechaInicio);
    }
  }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  _selectFechaFin(BuildContext context, BitacoraController _ctr) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_ctr.getInputfechaInicio),
      firstDate: DateTime.parse(_ctr.getInputfechaInicio),
      lastDate: DateTime(2050),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

      setState(() {
        final _fechaFin =
            '${anio.toString()}-${mes.toString()}-${dia.toString()}';
        _fechaFinController.text = _fechaFin;

        _ctr.onInputFechaFinChange(_fechaFin);
      });
    }
  }

  void _seleccionaHoraInicio(
      BuildContext context, BitacoraController _ctr) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timerInicio);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timerInicio = _hora;
        String horaInicio = '${dateHora}:${dateMinutos}';
        _horaInicioController.text = horaInicio;
        _ctr.onInputHoraFinChange(horaInicio);
        //  print('si: $horaInicio');
      });
    }
  }

  void _seleccionaHoraFin(BuildContext context, BitacoraController _ctr) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timerFin);
    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timerFin = _hora;
        print(timerFin.format(context));
        String horaFin = '${dateHora}:${dateMinutos}';
        _horaFinController.text = horaFin;
        _ctr.onInputHoraFinChange(horaFin);
        //  print('si: $horaFin');
      });
    }
  }
}
