// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sincop_app/src/pages/detalle_consigna_realizada_guardia.dart';
// import 'package:sincop_app/src/utils/responsive.dart';
// import 'package:sincop_app/src/utils/theme.dart';

// import '../models/lista_allConsignas_clientes.dart';

// class VistaConsignasRealizadasGuardias extends StatefulWidget {
//   final dynamic infoConsignasRealizada;
//   const VistaConsignasRealizadasGuardias(
//       {Key? key, this.infoConsignasRealizada})
//       : super(key: key);

//   @override
//   State<VistaConsignasRealizadasGuardias> createState() =>
//       _VistaConsignasRealizadasGuardiasState();
// }

// class _VistaConsignasRealizadasGuardiasState
//     extends State<VistaConsignasRealizadasGuardias> {
//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: primaryColor,
//         title: const Text('Consignas Realizadas'),
//          flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomCenter,
//                   colors: <Color>[
//                     Color(0XFF153E76),
//                     Color(0XFF0076A7),
                   
                   
                   
//                     // Color(0XFF005B97),
//                     // Color(0XFF0075BE),
//                     // Color(0XFF1E9CD7),
//                     // Color(0XFF3DA9F4),
//                   ],
//                 ),
//               ),
//             ),
//       ),
//       body: Container(
//         // color: Colors.red,
//         width: size.wScreen(100.0),
//         height: size.hScreen(100),
//         child: ListView.builder(
//           itemCount: widget.infoConsignasRealizada!['conAsignacion']!.length,
//           itemBuilder: (BuildContext context, int index) {
//             final consignas =
//                 widget.infoConsignasRealizada!['conAsignacion']![index];
//             return InkWell(
//               onTap: () {
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (context) =>
//                 //         DetalleConsignasRealizadasGuardias(consignas:consignas)));
//               },
//               child: Card(
//                 child: Container(
//                   // color: Colors.red,
//                   padding: EdgeInsets.symmetric(
//                       horizontal: size.iScreen(1.5),
//                       vertical: size.iScreen(0.5)),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             // width: size.wScreen(100.0),
//                             child: Text(
//                               'Consigna: ',
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                           Container(
//                             // color: Colors.red,
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             width: size.wScreen(60.0),
//                             child: Text(
//                               '${widget.infoConsignasRealizada!['conAsunto']}',
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             // width: size.wScreen(100.0),
//                             child: Text(
//                               'Persona: ',
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                           Container(
//                             // color: Colors.red,
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             width: size.wScreen(60.0),
//                             child: Text(
//                               '${consignas['nombres']}',
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             //  color: Colors.red,
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             // width: size.wScreen(100.0),
//                             child: Text(
//                               'Trabajos realizados: ',
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                           Container(
//                             // color: Colors.red,
//                             margin: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.0)),
//                             // width: size.wScreen(60.0),
//                             child: Text(
//                               '${consignas['trabajos']!.length}',
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.lexendDeca(
//                                   fontSize: size.iScreen(1.5),
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );

//             // ListTile(
//             //   title: Text('${consignas.nombres}'),
//             //   subtitle: Row(
//             //     children: [
//             //       Text('${consignas.trabajos!.length}'),
//             //       Text('${consignas.trabajos!.length}'),
//             //     ],
//             //   ),
//             // );
//           },
//         ),
//       ),
//     );
//   }
// }
