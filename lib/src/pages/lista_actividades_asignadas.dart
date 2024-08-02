// // import 'package:flutter/material.dart';
// // import 'package:flutter_slidable/flutter_slidable.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sincop_app/src/controllers/actividades_asignadas_controller.dart';
// // import 'package:sincop_app/src/controllers/home_controller.dart';
// // import 'package:sincop_app/src/pages/detalle_actividad_asignada.dart';
// // import 'package:sincop_app/src/theme/themes_app.dart';
// // // import 'package:sincop_app/src/service/notifications_service.dart';
// // // import 'package:sincop_app/src/service/socket_service.dart';
// // import 'package:sincop_app/src/utils/responsive.dart';
// // import 'package:sincop_app/src/utils/theme.dart';
// // import 'package:sincop_app/src/widgets/no_data.dart';

// // class ListActividadesAsignadas extends StatefulWidget {
// //   const ListActividadesAsignadas({Key? key}) : super(key: key);

// //   @override
// //   State<ListActividadesAsignadas> createState() =>
// //       _ListActividadesAsignadasState();
// // }

// // class _ListActividadesAsignadasState extends State<ListActividadesAsignadas> {
// //   @override
// //   void initState() {
// //     initData();
// //     super.initState();
// //   }

// //   void initData() async {
// //     // final loadInfo = Provider.of<ActividadesAsignadasController>(context, listen: false);
// //     // loadInfo.getActividadesAsignadas('','false');

// //     // final serviceSocket = Provider.of<SocketService>(context, listen: false);
// //     // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
// //     //   if (data['tabla'] == 'ausencia') {
// //     //     loadInfo.getActividadesAsignadas('');
// //     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //     //   }
// //     // });
// //     // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
// //     //   if (data['tabla'] == 'ausencia') {
// //     //     loadInfo.getActividadesAsignadas('');
// //     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //     //   }
// //     // });
// //     // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
// //     //   if (data['tabla'] == 'ausencia') {
// //     //     loadInfo.getActividadesAsignadas('');
// //     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //     //   }
// //     // });
// //   }

// //   @override
// //   Widget build(BuildContext context) {




// //     //==========================/

// //     Responsive size = Responsive.of(context);
// //     final _user = context.read<HomeController>();

// //     return SafeArea(
// //       child: GestureDetector(
// //         onTap: () => FocusScope.of(context).unfocus(),
// //         child: Scaffold(
// //        backgroundColor: const Color(0xFFEEEEEE),
// //           appBar: AppBar(
// //             title: Text(
// //               'Actividades',
// //               style: Theme.of(context).textTheme.headline2,
// //             ),
// //           ),
// //           body: 
// //         Stack(
// //             children: [
// //               Container(
// //                 padding: EdgeInsets.only(
// //                   top: size.iScreen(2.0),
// //                   left: size.iScreen(0.0),
// //                   right: size.iScreen(0.0),
// //                 ),
// //                 width: size.wScreen(100.0),
// //                 height: size.hScreen(100.0),
// //                 child: 
                
// //                 Consumer<ActividadesAsignadasController>(
// //                     builder: (_, provider, __) {
// //                   if (provider.getErrorActividadesAsignadas == null) {
// //                     return Center(
// //                       // child: CircularProgressIndicator(),
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Text(
// //                             'Cargando Datos...',
// //                             style: GoogleFonts.lexendDeca(
// //                                 fontSize: size.iScreen(1.5),
// //                                 color: Colors.black87,
// //                                 fontWeight: FontWeight.bold),
// //                           ),
// //                           //***********************************************/
// //                           SizedBox(
// //                             height: size.iScreen(1.0),
// //                           ),
// //                           //*****************************************/
// //                           const CircularProgressIndicator(),
// //                         ],
// //                       ),
// //                     );
// //                   } else if (provider.getErrorActividadesAsignadas == false) {
// //                     return const NoData(
// //                       label: 'No existen datos para mostar',
// //                     );
// //                   } else if (provider.getListaActividadesAsignadas.isEmpty) {
// //                     return const NoData(
// //                       label: 'No existen datos para mostar',
// //                     );
// //                   }
// //                     provider.setItemsLista(provider.getListaActividadesAsignadas);
// //                   return RefreshIndicator(
// //                     onRefresh: onRefresh,
// //                     child:
                       
// //                         //=======================================//
// //           Consumer<ActividadesAsignadasController>(builder: (_, values,__) {  

// // return     
// // ListView(
// //                       children: values.getWordMap.entries.map((entry) {
                        
// //                         String type = entry.key;
      

// //                         List<Map<String, dynamic>>  wordList = entry.value;

// //                         List<Widget> cardChildren = wordList.map((word) {
                          
// // //=============================================================//
// //                           return GestureDetector
// //                           (

// //                              onTap: () {
                              

// //                               context
// //                                   .read<ActividadesAsignadasController>()
// //                                   .setInfoActividad(word);

// //                               Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: ((context) =>
// //                                           const DetalleActividadAsignada())));
// //                             },
// //                             child: Container(
// //                               margin: EdgeInsets.only(
// //                                   top: size.iScreen(0.5),
// //                                   left: size.iScreen(0.75),
// //                                   right: size.iScreen(0.75)),
// //                               padding: EdgeInsets.symmetric(
// //                                   horizontal: size.iScreen(1.0),
// //                                   vertical: size.iScreen(0.5)),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.white,
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               child: Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Column(
// //                                       mainAxisAlignment: MainAxisAlignment.start,
// //                                       children: [
                                       
// //                                         Row(
// //                                           children: [
// //                                             Container(
// //                                               margin: EdgeInsets.only(
// //                                                   top: size.iScreen(0.5),
// //                                                   bottom: size.iScreen(0.0)),
// //                                               // width: size.wScreen(100.0),
// //                                               child: Text(
// //                                                 'Actividad: ',
// //                                                 style: GoogleFonts.lexendDeca(
// //                                                     fontSize: size.iScreen(1.5),
// //                                                     color: Colors.black87,
// //                                                     fontWeight:
// //                                                         FontWeight.normal),
// //                                               ),
// //                                             ),
// //                                             Expanded(
// //                                               child: Container(
// //                                                 width: size.iScreen(31.0),
// //                                                 // color: Colors.red,
// //                                                 margin: EdgeInsets.only(
// //                                                     top: size.iScreen(0.5),
// //                                                     bottom: size.iScreen(0.0)),
                          
// //                                                 child: Text(
// //                                                   ' ${word['act_asigEveNombre'].toUpperCase()}',
// //                                                   overflow: TextOverflow.ellipsis,
// //                                                   style: GoogleFonts.lexendDeca(
// //                                                       fontSize: size.iScreen(1.5),
// //                                                       color: Colors.black87,
// //                                                       fontWeight:
// //                                                           FontWeight.bold),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
                                       
// //                                         Row(
// //                                           children: [
// //                                             Container(
// //                                               // width: size.iScreen(10.0),
// //                                               margin: EdgeInsets.only(
// //                                                   top: size.iScreen(0.5),
// //                                                   bottom: size.iScreen(0.0)),
// //                                               // width: size.wScreen(100.0),
// //                                               child: Text(
// //                                                 '# Actividades: ',
// //                                                 style: GoogleFonts.lexendDeca(
// //                                                     fontSize: size.iScreen(1.5),
// //                                                     color: Colors.black87,
// //                                                     fontWeight:
// //                                                         FontWeight.normal),
// //                                               ),
// //                                             ),
// //                                             Container(
// //                                               width: size.iScreen(10.0),
// //                                               // color: Colors.red,
// //                                               margin: EdgeInsets.only(
// //                                                   top: size.iScreen(0.5),
// //                                                   bottom: size.iScreen(0.0)),
                          
// //                                               child: Text(
// //                                                 ' ${word['act_asigEveActividades'].length} - ${word['act_asigId']}',
// //                                                 overflow: TextOverflow.ellipsis,
// //                                                 style: GoogleFonts.lexendDeca(
// //                                                     fontSize: size.iScreen(1.6),
// //                                                     color: Colors.black87,
// //                                                     fontWeight: FontWeight.bold),
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         Row(
// //                                           children: [
// //                                             Container(
// //                                               // width: size.iScreen(10.0),
// //                                               margin: EdgeInsets.only(
// //                                                   top: size.iScreen(0.5),
// //                                                   bottom: size.iScreen(0.0)),
// //                                               // width: size.wScreen(100.0),
// //                                               child: Text(
// //                                                 'Fecha Registro: ',
// //                                                 style: GoogleFonts.lexendDeca(
// //                                                     fontSize: size.iScreen(1.5),
// //                                                     color: Colors.black87,
// //                                                     fontWeight:
// //                                                         FontWeight.normal),
// //                                               ),
// //                                             ),
                                           
// //                                             Container(
// //                                               margin: EdgeInsets.only(
// //                                                   top: size.iScreen(0.5),
// //                                                   bottom: size.iScreen(0.0)),
// //                                               // width: size.wScreen(100.0),
// //                                               child: Text(
// //                                                 word['act_asigFecReg']!
// //                                                     // .toLocal()
// //                                                     .toString()
// //                                                     .replaceAll(".000Z", "")
// //                                                     .replaceAll(".000", "")
// //                                                     .replaceAll("T", " "),
// //                                                 // child: Text(
// //                                                 //   _fechaUTC,
// //                                                 style: GoogleFonts.lexendDeca(
// //                                                     fontSize: size.iScreen(1.5),
// //                                                     color: Colors.black87,
// //                                                     fontWeight: FontWeight.bold),
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   Column(
// //                                     children: [
// //                                       Text(
// //                                         'Estado',
// //                                         style: GoogleFonts.lexendDeca(
// //                                             fontSize: size.iScreen(1.6),
// //                                             color: Colors.black87,
// //                                             fontWeight: FontWeight.normal),
// //                                       ),
                                      
// //                                       Text(
// //                                         '${word['act_asigEstado']}',
// //                                         style: GoogleFonts.lexendDeca(
// //                                             fontSize: size.iScreen(1.4),
// //                                             // color: Colors.orange,
// //                                             color: '${word['act_asigEstado']}' ==
// //                                                     'FINALIZADA'
// //                                                 ? secondaryColor
// //                                                 : '${word['act_asigEstado']}' ==
// //                                                         'EN PROCESO'
// //                                                     ? tercearyColor
// //                                                     : '${word['act_asigEstado']}' ==
// //                                                             'PROCESANDO'
// //                                                         ? primaryColor
// //                                                         : '${word['act_asigEstado']}' ==
// //                                                                 'INCUMPLIDA'
// //                                                             ? Colors.red
// //                                                             : '${word['act_asigEstado']}' ==
// //                                                                     'ASIGNADA'
// //                                                                 ? primaryColor
// //                                                                 : Colors.grey,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           );
// // //=============================================================/
// //                         }).toList();

// //                         return 
// //                         Consumer<ActividadesAsignadasController>(builder: (_, value, __) { 
// //                               return Column(mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             ExpansionTile(
// //                               title: Text(type),
// //                               children: cardChildren,
// //                             ),
// //                               Divider(
// //         color: Colors.grey.shade300,
// //         thickness: 1,
// //         height: 0,
// //       )
// //                           ],
// //                         );
// //                          });
                        
                       
                        
// //                       }).toList(),
// //                     );

            
// //           },)
                    

// //                   );
// //                 }),
// //               ),
// //               Positioned(
// //                 top: 0,
// //                 child: Container(
// //                     width: size.wScreen(100.0),
// //                     margin: const EdgeInsets.all(0.0),
// //                     padding: const EdgeInsets.all(0.0),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         Text('${_user.getUsuarioInfo!.rucempresa!}  ',
// //                             style: GoogleFonts.lexendDeca(
// //                                 fontSize: size.iScreen(1.5),
// //                                 color: Colors.grey.shade600,
// //                                 fontWeight: FontWeight.bold)),
// //                         Text('-',
// //                             style: GoogleFonts.lexendDeca(
// //                                 fontSize: size.iScreen(1.5),
// //                                 color: Colors.grey,
// //                                 fontWeight: FontWeight.bold)),
// //                         Text('  ${_user.getUsuarioInfo!.usuario!} ',
// //                             style: GoogleFonts.lexendDeca(
// //                                 fontSize: size.iScreen(1.5),
// //                                 color: Colors.grey.shade600,
// //                                 fontWeight: FontWeight.bold)),
// //                       ],
// //                     )),
// //               )
// //             ],
// //           )
          
          
          
          
        
          
          
          
// //           //  floatingActionButton: _usuario!.rol!.contains('SUPERVISOR') ||
// //           //         _usuario.rol!.contains('GUARDIA')
// //           //     ? FloatingActionButton(
// //           //         // backgroundColor: primaryColor,
// //           //         child: const Icon(Icons.add),
// //           //         onPressed: () {
// //           //           final ausenciaController =
// //           //               Provider.of<ActividadesAsignadasController>(context,
// //           //                   listen: false);
// //           //           final turnoExtraController =
// //           //               Provider.of<TurnoExtraController>(context,
// //           //                       listen: false)
// //           //                   .resetValuesTurnoExtra();
// //           //           ausenciaController.resetValuesAusencias();

// //           //           ausenciaController.setUsuarioLogin(_usuario);

// //           //           Navigator.push(
// //           //               context,
// //           //               MaterialPageRoute(
// //           //                   builder: ((context) => CreaAusencia(
// //           //                         usuario: _usuario,
// //           //                         action: 'CREATE',
// //           //                       ))));

// //           //           // Navigator.pushNamed(context, 'creaAusencia',
// //           //           //     arguments: 'CREATE');
// //           //         },
// //           //       )
// //           //     : Container()),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> onRefresh() async {
// //     final informeController =
// //         Provider.of<ActividadesAsignadasController>(context, listen: false);
// //     // informeController.resetValuesActividades() ;
// //     // informeController.setItemsLista([]) ;
// //     informeController.getActividadesAsignadas('', 'false');
// //     setState(() {
      
// //     });
// //   }
// // }




// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:sincop_app/src/controllers/actividades_asignadas_controller.dart';
// import 'package:sincop_app/src/controllers/home_controller.dart';
// import 'package:sincop_app/src/pages/detalle_actividad_asignada.dart';
// import 'package:sincop_app/src/theme/themes_app.dart';
// // import 'package:sincop_app/src/service/notifications_service.dart';
// // import 'package:sincop_app/src/service/socket_service.dart';
// import 'package:sincop_app/src/utils/responsive.dart';
// import 'package:sincop_app/src/utils/theme.dart';
// import 'package:sincop_app/src/widgets/no_data.dart';

// class ListActividadesAsignadas extends StatefulWidget {
//   const ListActividadesAsignadas({Key? key}) : super(key: key);

//   @override
//   State<ListActividadesAsignadas> createState() =>
//       _ListActividadesAsignadasState();
// }

// class _ListActividadesAsignadasState extends State<ListActividadesAsignadas> {
//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   void initData() async {
//     // final loadInfo = Provider.of<ActividadesAsignadasController>(context, listen: false);
//     // loadInfo.getActividadesAsignadas('','false');

//     // final serviceSocket = Provider.of<SocketService>(context, listen: false);
//     // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
//     //   if (data['tabla'] == 'ausencia') {
//     //     loadInfo.getActividadesAsignadas('');
//     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
//     //   }
//     // });
//     // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
//     //   if (data['tabla'] == 'ausencia') {
//     //     loadInfo.getActividadesAsignadas('');
//     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
//     //   }
//     // });
//     // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
//     //   if (data['tabla'] == 'ausencia') {
//     //     loadInfo.getActividadesAsignadas('');
//     //     NotificatiosnService.showSnackBarSuccsses(data['msg']);
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {




//     //==========================/

//     Responsive size = Responsive.of(context);
//     final _user = context.read<HomeController>();

//     return SafeArea(
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//        backgroundColor: const Color(0xFFEEEEEE),
//           appBar: AppBar(
//             title: Text(
//               'Actividades',
//               style: Theme.of(context).textTheme.headline2,
//             ),
//           ),
//           body: 
//         Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                   top: size.iScreen(2.0),
//                   left: size.iScreen(0.0),
//                   right: size.iScreen(0.0),
//                 ),
//                 width: size.wScreen(100.0),
//                 height: size.hScreen(100.0),
//                 child: 
                
//                 Consumer<ActividadesAsignadasController>(
//                     builder: (_, provider, __) {
//                   if (provider.getErrorActividadesAsignadas == null) {
//                     return Center(
//                       // child: CircularProgressIndicator(),
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
//                   } else if (provider.getErrorActividadesAsignadas == false) {
//                     return const NoData(
//                       label: 'No existen datos para mostar',
//                     );
//                   } else if (provider.getListaActividadesAsignadas.isEmpty) {
//                     return const NoData(
//                       label: 'No existen datos para mostar',
//                     );
//                   }
//                     provider.setItemsLista(provider.getListaActividadesAsignadas);
//                   return RefreshIndicator(
//                     onRefresh: onRefresh,
//                     child:
                       
//                         //=======================================//
//           Consumer<ActividadesAsignadasController>(builder: (_, values,__) {  

// // return   Text('data') ;
// return   

// ListView(
//                       children: values.getWordMap.entries.map((entry) {
                        
//                         String type = entry.key;
      

//                         List<Map<String, dynamic>>  wordList = entry.value;

//                         List<Widget> cardChildren = wordList.map((word) {
                          
// //=============================================================//
//                           return GestureDetector
//                           (

//                              onTap: () {
                              

//                               context
//                                   .read<ActividadesAsignadasController>()
//                                   .setInfoActividad(word);

//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: ((context) =>
//                                           const DetalleActividadAsignada())));
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   left: size.iScreen(0.75),
//                                   right: size.iScreen(0.75)),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.iScreen(1.0),
//                                   vertical: size.iScreen(0.5)),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
                                       
//                                         Row(
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(
//                                                   top: size.iScreen(0.5),
//                                                   bottom: size.iScreen(0.0)),
//                                               // width: size.wScreen(100.0),
//                                               child: Text(
//                                                 'Actividad: ',
//                                                 style: GoogleFonts.lexendDeca(
//                                                     fontSize: size.iScreen(1.5),
//                                                     color: Colors.black87,
//                                                     fontWeight:
//                                                         FontWeight.normal),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 width: size.iScreen(31.0),
//                                                 // color: Colors.red,
//                                                 margin: EdgeInsets.only(
//                                                     top: size.iScreen(0.5),
//                                                     bottom: size.iScreen(0.0)),
                          
//                                                 child: Text(
//                                                   ' ${word['act_asigEveNombre'].toUpperCase()}',
//                                                   overflow: TextOverflow.ellipsis,
//                                                   style: GoogleFonts.lexendDeca(
//                                                       fontSize: size.iScreen(1.5),
//                                                       color: Colors.black87,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
                                       
//                                         Row(
//                                           children: [
//                                             Container(
//                                               // width: size.iScreen(10.0),
//                                               margin: EdgeInsets.only(
//                                                   top: size.iScreen(0.5),
//                                                   bottom: size.iScreen(0.0)),
//                                               // width: size.wScreen(100.0),
//                                               child: Text(
//                                                 '# Actividades: ',
//                                                 style: GoogleFonts.lexendDeca(
//                                                     fontSize: size.iScreen(1.5),
//                                                     color: Colors.black87,
//                                                     fontWeight:
//                                                         FontWeight.normal),
//                                               ),
//                                             ),
//                                             Container(
//                                               width: size.iScreen(10.0),
//                                               // color: Colors.red,
//                                               margin: EdgeInsets.only(
//                                                   top: size.iScreen(0.5),
//                                                   bottom: size.iScreen(0.0)),
                          
//                                               child: Text(
//                                                 ' ${word['act_asigEveActividades'].length} - ${word['act_asigId']}',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: GoogleFonts.lexendDeca(
//                                                     fontSize: size.iScreen(1.6),
//                                                     color: Colors.black87,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Container(
//                                               // width: size.iScreen(10.0),
//                                               margin: EdgeInsets.only(
//                                                   top: size.iScreen(0.5),
//                                                   bottom: size.iScreen(0.0)),
//                                               // width: size.wScreen(100.0),
//                                               child: Text(
//                                                 'Fecha Registro: ',
//                                                 style: GoogleFonts.lexendDeca(
//                                                     fontSize: size.iScreen(1.5),
//                                                     color: Colors.black87,
//                                                     fontWeight:
//                                                         FontWeight.normal),
//                                               ),
//                                             ),
                                           
//                                             Container(
//                                               margin: EdgeInsets.only(
//                                                   top: size.iScreen(0.5),
//                                                   bottom: size.iScreen(0.0)),
//                                               // width: size.wScreen(100.0),
//                                               child: Text(
//                                                 word['act_asigFecReg']!
//                                                     // .toLocal()
//                                                     .toString()
//                                                     .replaceAll(".000Z", "")
//                                                     .replaceAll(".000", "")
//                                                     .replaceAll("T", " "),
//                                                 // child: Text(
//                                                 //   _fechaUTC,
//                                                 style: GoogleFonts.lexendDeca(
//                                                     fontSize: size.iScreen(1.5),
//                                                     color: Colors.black87,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         'Estado',
//                                         style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.6),
//                                             color: Colors.black87,
//                                             fontWeight: FontWeight.normal),
//                                       ),
                                      
//                                       Text(
//                                         '${word['act_asigEstado']}',
//                                         style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.4),
//                                             // color: Colors.orange,
//                                             color: '${word['act_asigEstado']}' ==
//                                                     'FINALIZADA'
//                                                 ? secondaryColor
//                                                 : '${word['act_asigEstado']}' ==
//                                                         'EN PROCESO'
//                                                     ? tercearyColor
//                                                     : '${word['act_asigEstado']}' ==
//                                                             'PROCESANDO'
//                                                         ? primaryColor
//                                                         : '${word['act_asigEstado']}' ==
//                                                                 'INCUMPLIDA'
//                                                             ? Colors.red
//                                                             : '${word['act_asigEstado']}' ==
//                                                                     'ASIGNADA'
//                                                                 ? primaryColor
//                                                                 : Colors.grey,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
// //=============================================================/
//                         }).toList();

//                         return 
//                         Consumer<ActividadesAsignadasController>(builder: (_, value, __) { 
//                               return Column(mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ExpansionTile(
//                               title: Text(type),
//                               children: cardChildren,
//                             ),
//                               Divider(
//         color: Colors.grey.shade300,
//         thickness: 1,
//         height: 0,
//       )
//                           ],
//                         );
//                          });
                        
                       
                        
//                       }).toList(),
//                     );

            
//           },)
                    

//                   );
//                 }),
//               ),
//               Positioned(
//                 top: 0,
//                 child: Container(
//                     width: size.wScreen(100.0),
//                     margin: const EdgeInsets.all(0.0),
//                     padding: const EdgeInsets.all(0.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text('${_user.getUsuarioInfo!.rucempresa!}  ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.bold)),
//                         Text('-',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold)),
//                         Text('  ${_user.getUsuarioInfo!.usuario!} ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.bold)),
//                       ],
//                     )),
//               )
//             ],
//           )
          
          
          
          
        
          
          
          
//           //  floatingActionButton: _usuario!.rol!.contains('SUPERVISOR') ||
//           //         _usuario.rol!.contains('GUARDIA')
//           //     ? FloatingActionButton(
//           //         // backgroundColor: primaryColor,
//           //         child: const Icon(Icons.add),
//           //         onPressed: () {
//           //           final ausenciaController =
//           //               Provider.of<ActividadesAsignadasController>(context,
//           //                   listen: false);
//           //           final turnoExtraController =
//           //               Provider.of<TurnoExtraController>(context,
//           //                       listen: false)
//           //                   .resetValuesTurnoExtra();
//           //           ausenciaController.resetValuesAusencias();

//           //           ausenciaController.setUsuarioLogin(_usuario);

//           //           Navigator.push(
//           //               context,
//           //               MaterialPageRoute(
//           //                   builder: ((context) => CreaAusencia(
//           //                         usuario: _usuario,
//           //                         action: 'CREATE',
//           //                       ))));

//           //           // Navigator.pushNamed(context, 'creaAusencia',
//           //           //     arguments: 'CREATE');
//           //         },
//           //       )
//           //     : Container()),
//         ),
//       ),
//     );
//   }

//   Future<void> onRefresh() async {
//     final informeController =
//         Provider.of<ActividadesAsignadasController>(context, listen: false);
//     // informeController.resetValuesActividades() ;
//     // informeController.setItemsLista([]) ;
//     informeController.getActividadesAsignadas('', 'false');
//     setState(() {
      
//     });
//   }
// }
