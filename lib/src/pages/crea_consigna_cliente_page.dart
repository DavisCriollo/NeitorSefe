// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_downloader/image_downloader.dart';
// // import 'package:image_downloader/image_downloader.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:sincop_app/src/controllers/consignas_clientes_controller.dart';
// import 'package:sincop_app/src/models/crea_foto_consigna_cliente.dart';

// import 'package:sincop_app/src/models/crea_nomina_consigna_cliente.dart';
// import 'package:sincop_app/src/pages/view_photo_consignas_cliente.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';
// import 'package:sincop_app/src/utils/dialogs.dart';
// import 'package:sincop_app/src/utils/responsive.dart';
// import 'package:sincop_app/src/utils/theme.dart';
// import 'package:sincop_app/src/widgets/dropdown_frecuencia_consigna_cliente.dart';
// import 'package:sincop_app/src/widgets/timePicker.dart';
// import 'package:provider/provider.dart';

// class ConsignaClientePage extends StatefulWidget {
//   const ConsignaClientePage({Key? key}) : super(key: key);

//   @override
//   State<ConsignaClientePage> createState() => _ConsignaClientePageState();
// }

// class _ConsignaClientePageState extends State<ConsignaClientePage> {
//   TextEditingController _fechaInicioController = TextEditingController();
//   TextEditingController _fechaFinController = TextEditingController();
//   TextEditingController _horaInicioController = TextEditingController();
//   TextEditingController _horaFinController = TextEditingController();

//   late TimeOfDay timeInicio;
//   late TimeOfDay timeFin;
//   // bool _expanded = false;

//   @override
//   void initState() {
//     initload();
//     super.initState();
//   }

//   void initload() async {
//     timeInicio = TimeOfDay.now();
//     timeFin = TimeOfDay.now();

//     final loadData = ConsignasClientesController();
//     // await loadData.getTodoPersonalDesignadoAlClientes();
//   }

//   @override
//   void dispose() {
//     _fechaInicioController.clear();
//     _fechaFinController.clear();
//     _horaFinController.clear();
//     _horaFinController.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // int _radioSelected = 1;
//     bool _value = false;
//     int val = -1;
//     final Responsive size = Responsive.of(context);
//     final consignaController =
//         Provider.of<ConsignasClientesController>(context);

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: primaryColor,
//             title: const Text('Nueva Consigna'),
//             actions: [
//               Container(
//               margin: EdgeInsets.only(right: size.iScreen(1.5)),
//               child: IconButton(
//                   splashRadius: 28,
//                   onPressed: () {
//                     _onSubmit(context, consignaController);
//                   },
//                   icon: Icon(
//                     Icons.save_outlined,
//                     size: size.iScreen(4.0),
//                   )),
//             ),
//             ],
//           ),
//           body: Container(
//             // color: Colors.red,
//             margin: EdgeInsets.only(top: size.iScreen(0.0)),
//             padding: EdgeInsets.only(
//                 left: size.iScreen(2.0),
//                 right: size.iScreen(2.0),
//                 top: size.iScreen(2.0)),
//             width: size.wScreen(100.0),
//             height: size.hScreen(100),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Form(
//                 key: consignaController.consignasClienteFormKey,
//                 child: Column(
//                   children: [
//                     //*****************************************/
//                     SizedBox(
//                       width: size.wScreen(100.0),
//                       // color: Colors.blue,
//                       child: Text('Asunto:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           suffixIcon: Icon(Icons.beenhere_outlined)),
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(

//                           // fontSize: size.iScreen(3.5),
//                           // fontWeight: FontWeight.bold,
//                           // letterSpacing: 2.0,
//                           ),
//                       onChanged: (text) {
//                         consignaController.onChangeAsunto(text);
//                       },
//                       validator: (text) {
//                         if (text!.trim().isNotEmpty) {
//                           return null;
//                         } else {
//                           return 'Ingrese asunto de la Consigna';
//                         }
//                       },
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),
//                     //*****************************************/
//                     SizedBox(
//                       width: size.wScreen(100.0),
//                       // color: Colors.blue,
//                       child: Text('Detalle:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),
//                     TextFormField(
//                       maxLines: 2,
//                       decoration: const InputDecoration(
//                           suffixIcon: Icon(Icons.article_outlined)),
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(

//                           // fontSize: size.iScreen(3.5),
//                           // fontWeight: FontWeight.bold,
//                           // letterSpacing: 2.0,
//                           ),
//                       onChanged: (text) {
//                         consignaController.onChangeDetalle(text);
//                       },
//                       validator: (text) {
//                         if (text!.trim().isNotEmpty) {
//                           return null;
//                         } else {
//                           return 'Ingrese detalle de la Consigna';
//                         }
//                       },
//                     ),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               'Desde:',
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 color: Colors.black45,
//                                 // fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Container(
//                               width: size.wScreen(35),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: size.wScreen(3.5)),
//                               child: TextFormField(
//                                 textAlign: TextAlign.center,
//                                 readOnly: true,
//                                 controller: _fechaInicioController,
//                                 decoration: InputDecoration(
//                                   hintText: 'yyyy-mm-dd',
//                                   hintStyle:
//                                       const TextStyle(color: Colors.black38),
//                                   suffixIcon: IconButton(
//                                     color: Colors.red,
//                                     splashRadius: 20,
//                                     onPressed: () {
//                                       FocusScope.of(context)
//                                           .requestFocus(FocusNode());
//                                       _selectFechaInicio(
//                                           context, consignaController);
//                                     },
//                                     icon: const Icon(
//                                       Icons.date_range_outlined,
//                                       color: primaryColor,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 // keyboardType: keyboardType,
//                                 // readOnly: readOnly,
//                                 // initialValue: initialValue,
//                                 textInputAction: TextInputAction.none,
//                                 onChanged: (value) {},
//                                 onSaved: (value) {},
//                                 validator: (text) {
//                                   if (text!.trim().isNotEmpty) {
//                                     return null;
//                                   } else {
//                                     return 'Ingrese fecha de inicio';
//                                   }
//                                 },
//                                 style: const TextStyle(
//                                     // letterSpacing: 2.0,
//                                     // fontSize: size.iScreen(3.0),
//                                     // fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Hora:',
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 color: Colors.black45,
//                                 // fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Container(
//                               width: size.wScreen(35),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: size.wScreen(3.5)),
//                               child: TextFormField(
//                                 textAlign: TextAlign.center,
//                                 readOnly: true,
//                                 controller: _horaInicioController,
//                                 decoration: InputDecoration(
//                                   hintText: '00:00',
//                                   hintStyle:
//                                       const TextStyle(color: Colors.black38),
//                                   suffixIcon: IconButton(
//                                     color: Colors.red,
//                                     splashRadius: 20,
//                                     onPressed: () {
//                                       FocusScope.of(context)
//                                           .requestFocus(FocusNode());
//                                       _seleccionaHoraInicio(
//                                           context, consignaController);
//                                       // _selectFechaFin(
//                                       //     context, consignaController);
//                                     },
//                                     icon: const Icon(
//                                       Icons.access_time_outlined,
//                                       color: primaryColor,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 // keyboardType: keyboardType,
//                                 // readOnly: readOnly,
//                                 // initialValue: initialValue,
//                                 textInputAction: TextInputAction.none,
//                                 onChanged: (value) {},
//                                 onSaved: (value) {},
//                                 validator: (text) {
//                                   if (text!.trim().isNotEmpty) {
//                                     return null;
//                                   } else {
//                                     return 'Ingrese hora de inicio';
//                                   }
//                                 },
//                                 style: const TextStyle(
//                                     // letterSpacing: 2.0,
//                                     // fontSize: size.iScreen(3.0),
//                                     // fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     //***********************************************/

//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),

//                     //*******************FECHA HORA HASTA **********************/
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               'Hasta:',
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 color: Colors.black45,
//                                 // fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Container(
//                               width: size.wScreen(35),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: size.wScreen(3.5)),
//                               child: TextFormField(
//                                 textAlign: TextAlign.center,
//                                 readOnly: true,
//                                 controller: _fechaFinController,
//                                 decoration: InputDecoration(
//                                   hintText: 'yyyy-mm-dd',
//                                   hintStyle:
//                                       const TextStyle(color: Colors.black38),
//                                   suffixIcon: IconButton(
//                                     color: Colors.red,
//                                     splashRadius: 20,
//                                     onPressed: () {
//                                       FocusScope.of(context)
//                                           .requestFocus(FocusNode());
//                                       _selectFechaFin(
//                                           context, consignaController);
//                                     },
//                                     icon: const Icon(
//                                       Icons.date_range_outlined,
//                                       color: primaryColor,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 // keyboardType: keyboardType,
//                                 // readOnly: readOnly,
//                                 // initialValue: initialValue,
//                                 textInputAction: TextInputAction.none,
//                                 onChanged: (value) {},
//                                 onSaved: (value) {},
//                                 validator: (text) {
//                                   if (text!.trim().isNotEmpty) {
//                                     return null;
//                                   } else {
//                                     return 'Ingrese fecha de límite';
//                                   }
//                                 },
//                                 style: const TextStyle(
//                                     // letterSpacing: 2.0,
//                                     // fontSize: size.iScreen(3.0),
//                                     // fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               'Hora:',
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 color: Colors.black45,
//                                 // fontWeight: FontWeight.bold,
//                               ),
//                             ),
// // InputTimePiker(label: 'Hora', size: size,),

//                             Container(
//                               width: size.wScreen(35),
//                               margin: EdgeInsets.symmetric(
//                                   horizontal: size.wScreen(3.5)),
//                               child: TextFormField(
//                                 textAlign: TextAlign.center,
//                                 readOnly: true,
//                                 controller: _horaFinController,
//                                 decoration: InputDecoration(
//                                   hintText: '00:00',
//                                   hintStyle:
//                                       const TextStyle(color: Colors.black38),
//                                   suffixIcon: IconButton(
//                                     color: Colors.red,
//                                     splashRadius: 20,
//                                     onPressed: () {
//                                       FocusScope.of(context)
//                                           .requestFocus(FocusNode());
//                                       _seleccionaHoraFin(
//                                           context, consignaController);
//                                       // _selectFechaFin(
//                                       //     context, consignaController);
//                                     },
//                                     icon: const Icon(
//                                       Icons.access_time_outlined,
//                                       color: primaryColor,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 // keyboardType: keyboardType,
//                                 // readOnly: readOnly,
//                                 // initialValue: initialValue,
//                                 textInputAction: TextInputAction.none,
//                                 onChanged: (value) {},
//                                 onSaved: (value) {},
//                                 validator: (text) {
//                                   if (text!.trim().isNotEmpty) {
//                                     return null;
//                                   } else {
//                                     return 'Ingrese hora Límite';
//                                   }
//                                 },
//                                 style: const TextStyle(
//                                     // letterSpacing: 2.0,
//                                     // fontSize: size.iScreen(3.0),
//                                     // fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),

//                     //***************** PERIODO ************************/

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),

//                     //*****************   FRECUENCIA ************************/
//                     Container(
//                       // color: Colors.red,
//                       margin:
//                           EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
//                       padding: EdgeInsets.only(
//                         top: size.iScreen(0.5),
//                         left: size.iScreen(1.0),
//                         right: size.iScreen(0.5),
//                         bottom: size.iScreen(0.5),
//                       ),
//                       width: size.wScreen(100.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Frecuencia:',
//                             style: GoogleFonts.lexendDeca(
//                               fontSize: size.iScreen(1.8),
//                               color: Colors.black45,
//                               // fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const DropMenuFrecuenciaCliente(
//                             // title: 'Tipo de documento:',
//                             data: [
//                               '1',
//                               '2',
//                               '3',
//                               '4',
//                               '5',
//                               '6',
//                               '7',
//                               '8',
//                               '9',
//                               '10',
//                               '11',
//                               '12',
//                             ],
//                             hinText: 'Seleccione',
//                           ),
//                         ],
//                       ),
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),
//                     //*****************************************/
//                     // ===========PRIORIDAD==============

//                     // ===========PRIORIDAD==============
//                     Container(
//                       // color: Colors.red,
//                       margin:
//                           EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: size.iScreen(1.5),
//                           vertical: size.iScreen(0.5)),
//                       width: size.wScreen(100.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             width: size.wScreen(100.0),
//                             child: Text(
//                               'Prioridad:',
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.7),
//                                 color: Colors.black54,
//                                 // fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           //***********************************************/
//                           SizedBox(
//                             height: size.iScreen(2.0),
//                           ),
//                           //*****************************************/
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     'baja',
//                                     style: GoogleFonts.lexendDeca(
//                                       fontSize: size.iScreen(1.7),
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Radio(
//                                     value: 3,
//                                     groupValue: consignaController
//                                         .getprioridadValueCliente,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         val = 3;
//                                         consignaController
//                                             .onPrioridadClienteChange(value);
//                                         // print(val);
//                                       });
//                                     },
//                                     activeColor: primaryColor,
//                                     toggleable: true,
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     'Media',
//                                     style: GoogleFonts.lexendDeca(
//                                       fontSize: size.iScreen(1.7),
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Radio(
//                                     value: 2,
//                                     groupValue: consignaController
//                                         .getprioridadValueCliente,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         val = 2;
//                                         consignaController
//                                             .onPrioridadClienteChange(value);
//                                         // print(val);
//                                       });
//                                     },
//                                     activeColor: primaryColor,
//                                     toggleable: true,
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     'Alta',
//                                     style: GoogleFonts.lexendDeca(
//                                       fontSize: size.iScreen(1.7),
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Radio(
//                                     value: 1,
//                                     groupValue: consignaController
//                                         .getprioridadValueCliente,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         val = 1;
//                                         consignaController
//                                             .onPrioridadClienteChange(value);
//                                         // print(val);
//                                       });
//                                     },
//                                     activeColor: primaryColor,
//                                     toggleable: true,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),
//                     //*****************************************/
//                     // =========== REPETIR ==============

//                     Container(
//                       // color: Colors.red,
//                       margin:
//                           EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: size.iScreen(0.0),
//                           vertical: size.iScreen(0.5)),
//                       width: size.wScreen(100.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Consumer<ConsignasClientesController>(
//                             builder: (_, values, __) {
//                               return SizedBox(
//                                 width: size.wScreen(100.0),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Repetir:',
//                                       style: GoogleFonts.lexendDeca(
//                                         fontSize: size.iScreen(1.7),
//                                         color: Colors.black54,
//                                         // fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       ' ${values.getDiaSemana!.length}',
//                                       style: GoogleFonts.lexendDeca(
//                                         fontSize: size.iScreen(2.0),
//                                         color: Colors.grey,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           //***********************************************/
//                           SizedBox(
//                             height: size.iScreen(2.0),
//                           ),
//                           //*****************************************/
//                           Consumer<ConsignasClientesController>(
//                             builder: (_, providerDia, __) {
//                               return Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (providerDia.getDiaLunes == true) {
//                                         providerDia.eliminaDia('LUNES');
//                                       } else {
//                                         providerDia.setDiaLunes('LUNES');
//                                       }
//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color: (providerDia.getDiaLunes == true)
//                                             ? Colors.blue
//                                             : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'L',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (providerDia.getDiaLunes ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                        if (providerDia.getDiaMartes == true) {
//                                         providerDia.eliminaDia('MARTES');
//                                       } else {
//                                         providerDia.setDiaMartes('MARTES');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             (providerDia.getDiaMartes == true)
//                                                 ? Colors.blue
//                                                 : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'M',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (providerDia.getDiaMartes ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (providerDia.getDiaMiercoles == true) {
//                                         providerDia.eliminaDia('MIERCOLES');
//                                       } else {
//                                         providerDia.setDiaMiercoles('MIERCOLES');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color: (providerDia.getDiaMiercoles ==
//                                                 true)
//                                             ? Colors.blue
//                                             : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'M',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color:
//                                                 (providerDia.getDiaMiercoles ==
//                                                         true)
//                                                     ? Colors.white
//                                                     : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                     if (providerDia.getDiaJueves == true) {
//                                         providerDia.eliminaDia('JUEVES');
//                                       } else {
//                                         providerDia.setDiaJueves('JUEVES');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             (providerDia.getDiaJueves == true)
//                                                 ? Colors.blue
//                                                 : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'J',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (providerDia.getDiaJueves ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       if (providerDia.getDiaViernes == true) {
//                                         providerDia.eliminaDia('VIERNES');
//                                       } else {
//                                         providerDia.setDiaViernes('VIERNES');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             (providerDia.getDiaViernes == true)
//                                                 ? Colors.blue
//                                                 : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'V',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (providerDia.getDiaViernes ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                         if (providerDia.getDiaSabado == true) {
//                                         providerDia.eliminaDia('SABADO');
//                                       } else {
//                                         providerDia.setDiaSabado('SABADO');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             (providerDia.getDiaSabado == true)
//                                                 ? Colors.blue
//                                                 : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'S',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (providerDia.getDiaSabado ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                      if (providerDia.getDiaDomingo == true) {
//                                         providerDia.eliminaDia('DOMINGO');
//                                       } else {
//                                         providerDia.setDiaDomingo('DOMINGO');
//                                       }

//                                     },
//                                     child: Container(
//                                       width: size.iScreen(5.0),
//                                       height: size.iScreen(5.0),
//                                       // padding: EdgeInsets.all(size.iScreen(1.0)),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             (providerDia.getDiaDomingo == true)
//                                                 ? Colors.blue
//                                                 : Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'D',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             color: (consignaController
//                                                         .getDiaDomingo ==
//                                                     true)
//                                                 ? Colors.white
//                                                 : Colors.blue,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                     ),

//                       //==========================================//
//                     consignaController.getListaFotos.isNotEmpty
//                         ? _CamaraOption(
//                             size: size, consignaController: consignaController)
//                         : Container(),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(2.0),
//                     ),
//                     //*****************************************************/
//                      Row(
//                       children: [
//                         Container(
//                           // width: size.wScreen(100.0),

//                           // color: Colors.blue,
//                           child: Row(
//                             children: [
//                               Text('Guardias: ',
//                                   style: GoogleFonts.lexendDeca(
//                                       // fontSize: size.iScreen(2.0),
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey)),
//                               (consignaController
//                                       .getListaGuardiasConsigna.isNotEmpty)
//                                   ? Text(
//                                       ' ${consignaController.getListaGuardiasConsigna.length}',
//                                       style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(1.7),
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey))
//                                   : const SizedBox(),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: size.iScreen(1.0)),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: GestureDetector(
//                             onTap: () {
//                               // consignaController.buscaGuardiaInforme('');
//                               Navigator.pushNamed(
//                                   context, 'buscaGuardiaConsigna');
//                               // Navigator.pushReplacement(
//                               //     context,
//                               //     MaterialPageRoute<void>(
//                               //         builder: (BuildContext context) =>
//                               //             const BuscarPersonalInformes()));
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               color: primaryColor,
//                               width: size.iScreen(3.05),
//                               padding: EdgeInsets.only(
//                                 top: size.iScreen(0.5),
//                                 bottom: size.iScreen(0.5),
//                                 left: size.iScreen(0.5),
//                                 right: size.iScreen(0.5),
//                               ),
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                                 size: size.iScreen(2.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                    //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/
//                     //==========================================//
//                     consignaController.getListaGuardiasConsigna.isNotEmpty
//                         ? _ListaGuardias(
//                             size: size, controllerConsinas: consignaController)
//                         : Text('Debe seleccionar guardias',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey)),

//                     //========================================//

// //*****************************************/

//                     SizedBox(
//                       height: size.iScreen(3.0),
//                     ),
//                     //*****************************************/

//                     // ExpansionPanelList(
//                     //   animationDuration: const Duration(milliseconds: 1000),
//                     //   children: [
//                     //     ExpansionPanel(
//                     //       headerBuilder: (context, isExpanded) {
//                     //         return ListTile(
//                     //           onTap: () {},
//                     //           // onAllClicked(selectAll, consignaController),
//                     //           // leading: Checkbox(
//                     //           //     value: consignaController.getSelectAllItemChecbox,
//                     //           //     onChanged: (value) {
//                     //           //       consignaController.setSelectAllItemChecbox(value);
//                     //           //       // onAllClicked(selectAll, consignaController);
//                     //           //       //  _showMultipleChoiceDialog(context);
//                     //           //     }),
//                     //           title: Row(
//                     //             mainAxisAlignment: MainAxisAlignment.start,
//                     //             children: [
//                     //               Text(
//                     //                 'Asignación :  ',
//                     //                 overflow: TextOverflow.ellipsis,
//                     //                 style: GoogleFonts.lexendDeca(
//                     //                     fontSize: size.iScreen(1.7),
//                     //                     color: Colors.grey,
//                     //                     fontWeight: FontWeight.normal),
//                     //               ),
//                     //               Text(
//                     //                 // ' ${consignaController.listaTemporalGuardias.length}',
//                     //                 ' ${consignaController.getListaGuardia.length}',
//                     //                 overflow: TextOverflow.ellipsis,
//                     //                 style: GoogleFonts.lexendDeca(
//                     //                     fontSize: size.iScreen(2.0),
//                     //                     color: Colors.grey,
//                     //                     fontWeight: FontWeight.bold),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         );
//                     //       },
//                     //       body: Column(
//                     //         children: [
//                     //           Container(
//                     //             width: size.wScreen(100),
//                     //             height: //size.iScreen(50),
//                     //                 size.iScreen(consignaController
//                     //                         .getListaListaPersonalDesignadoCliente
//                     //                         .length
//                     //                         .toDouble() *
//                     //                     6.0),
//                     //             // color: Colors.red,
//                     //             padding: EdgeInsets.symmetric(
//                     //                 horizontal: size.iScreen(1.0),
//                     //                 vertical: size.iScreen(0.0)),
//                     //             child: ListView.builder(
//                     //               scrollDirection: Axis.vertical,
//                     //               itemCount: consignaController
//                     //                   .getListaListaPersonalDesignadoCliente
//                     //                   .length,
//                     //               itemBuilder:
//                     //                   (BuildContext context, int index) {
//                     //                 // print('====> s${consignaController
//                     //                 //     .getListaListaPersonalDesignadoCliente[
//                     //                 // index]}');
//                     //                 final persona = consignaController
//                     //                         .getListaListaPersonalDesignadoCliente[
//                     //                     index];
//                     //                 return Container(
//                     //                   decoration: BoxDecoration(
//                     //                     color: Colors.grey.shade200,
//                     //                     borderRadius: BorderRadius.circular(5),
//                     //                   ),
//                     //                   margin: EdgeInsets.only(
//                     //                       bottom: size.iScreen(0.5)),
//                     //                   padding: EdgeInsets.only(
//                     //                       top: size.iScreen(0.0),
//                     //                       left: size.iScreen(0.5),
//                     //                       right: size.iScreen(0.5),
//                     //                       bottom: size.iScreen(0.0)),
//                     //                   // width: size.wScreen(100.0),
//                     //                   child: Row(
//                     //                     children: [
//                     //                       Checkbox(
//                     //                           visualDensity:
//                     //                               VisualDensity.compact,
//                     //                           value: consignaController
//                     //                                   .getlistaEstadoPersonalDesignadoCliente[
//                     //                               index],
//                     //                           onChanged: (value) {
//                     //                             consignaController
//                     //                                 .setSelectItemChecbox(
//                     //                                     consignaController
//                     //                                             .getlistaEstadoPersonalDesignadoCliente[
//                     //                                         index] = value,
//                     //                                     persona);
//                     //                             // consignaController.setItemtCheckboxGuardia(persona);

//                     //                             // consignaController
//                     //                             //   .getlistaEstadoPersonalDesignadoCliente[index]=!value;
//                     //                             print(
//                     //                                 'estado del check : $value');
//                     //                           }),
//                     //                       Expanded(
//                     //                         child: Text(
//                     //                           '${persona.perNombres} ${persona.perApellidos}',
//                     //                           style: GoogleFonts.lexendDeca(
//                     //                               fontSize: size.iScreen(1.8),
//                     //                               color: Colors.black54,
//                     //                               fontWeight:
//                     //                                   FontWeight.normal),
//                     //                         ),
//                     //                       ),
//                     //                     ],
//                     //                   ),
//                     //                 );
//                     //                 //  Text('${persona.perNombres}${persona.perApellidos}');
//                     //               },
//                     //             ),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //       isExpanded: _expanded,
//                     //       canTapOnHeader: true,
//                     //     ),
//                     //   ],
//                     //   dividerColor: Colors.grey,
//                     //   expansionCallback: (panelIndex, isExpanded) {
//                     //     _expanded = !_expanded;
//                     //     setState(() {
//                     //       // consignaController
//                     //       //     .getTodoPersonalDesignadoAlClientes();
//                     //     });
//                     //   },
//                     // ),

//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               bottomSheet(consignaController, context, size);
//             },
//             backgroundColor: Colors.purpleAccent,
//             heroTag: "btnCamara",
//             child: const Icon(Icons.camera_alt_outlined),
//           ),
//         ),
//       ),
//     );
//   }

//   //================================================= SELECCIONA FECHA INICIO ==================================================//
//   _selectFechaInicio(BuildContext context,
//       ConsignasClientesController consignaController) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2025),
//       locale: const Locale('es', 'ES'),
//     );
//     if (picked != null) {
//       String? anio, mes, dia;
//       anio = '${picked.year}';
//       mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
//       dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

//       // setState(() {
//       final _fechaInicio =
//           '${anio.toString()}-${mes.toString()}-${dia.toString()}';
//       _fechaInicioController.text = _fechaInicio;
//       consignaController.onInputFechaInicioConsignaChange(_fechaInicio);
//       // print('FechaInicio: $_fechaInicio');
//       // });
//     }
//   }

//   //================================================= SELECCIONA FECHA FIN ==================================================//
//   _selectFechaFin(BuildContext context,
//       ConsignasClientesController consignaController) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2025),
//       locale: const Locale('es', 'ES'),
//     );
//     if (picked != null) {
//       String? anio, mes, dia;
//       anio = '${picked.year}';
//       mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
//       dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

//       setState(() {
//         final _fechaFin =
//             '${anio.toString()}-${mes.toString()}-${dia.toString()}';
//         _fechaFinController.text = _fechaFin;
//         consignaController.onInputFechaFinConsignaChange(_fechaFin);
//         // print('FechaFin: $_fechaFin');
//       });
//     }
//   }

//   //================================================= SELECCIONA FECHA FIN ==================================================//
//   _selectHoraInicio(BuildContext context,
//       ConsignasClientesController consignaController) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2025),
//       locale: const Locale('es', 'ES'),
//     );
//     if (picked != null) {
//       String? anio, mes, dia;
//       anio = '${picked.year}';
//       mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
//       dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

//       setState(() {
//         final _fechaFin =
//             '${anio.toString()}-${mes.toString()}-${dia.toString()}';
//         _fechaFinController.text = _fechaFin;
//         consignaController.onInputFechaFinConsignaChange(_fechaFin);
//         // print('FechaFin: $_fechaFin');
//       });
//     }
//   }
//   //================================================= SELECCIONA FECHA FIN ==================================================//
//   // _selectHoraFin(BuildContext context,
//   //     ConsignasClientesController consignaController) async {
//   //   DateTime? picked = await showDatePicker(
//   //     context: context,
//   //     initialDate: DateTime.now(),
//   //     firstDate: DateTime(2020),
//   //     lastDate: DateTime(2025),
//   //     locale: const Locale('es', 'ES'),
//   //   );
//   //   if (picked != null) {
//   //     String? anio, mes, dia;
//   //     anio = '${picked.year}';
//   //     mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
//   //     dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

//   //     setState(() {
//   //       final _fechaFin =
//   //           '${anio.toString()}-${mes.toString()}-${dia.toString()}';
//   //       _fechaFinController.text = _fechaFin;
//   //       consignaController.onInputFechaFinConsignaChange(_fechaFin);
//   //       // print('FechaFin: $_fechaFin');
//   //     });
//   //   }
//   // }
//   void _seleccionaHoraInicio(
//       context, ConsignasClientesController consignaController) async {
//     TimeOfDay? _hora =
//         await showTimePicker(context: context, initialTime: timeInicio);

//     if (_hora != null) {
//       setState(() {
//         timeInicio = _hora;
//         String horaInicio = '${timeInicio.hour}:${timeInicio.minute}';
//         _horaInicioController.text = horaInicio;
//         consignaController.onInputHoraInicioConsignaChange(horaInicio);
//         //  print('si: $horaInicio');
//       });
//     }
//   }

//   void _seleccionaHoraFin(
//       context, ConsignasClientesController consignaController) async {
//     TimeOfDay? _hora =
//         await showTimePicker(context: context, initialTime: timeFin);
//     if (_hora != null) {
//       setState(() {
//         timeFin = _hora;
//         print(timeFin.format(context));
//         String horaFin = '${timeFin.hour}:${timeFin.minute}';
//         _horaFinController.text = horaFin;
//         consignaController.onInputHoraFinConsignaChange(horaFin);
//         //  print('si: $horaFin');
//       });
//     }
//   }

//   //********************************************************************************************************************//
//   void _onSubmit(
//       BuildContext context, ConsignasClientesController controller) async {
//     final isValid = controller.validateForm();
//     if (!isValid) return;
//     if (isValid) {
//       if (controller.getListaGuardiasConsigna.isEmpty) {
//         NotificatiosnService.showSnackBarDanger('Debe asignar el personal');
//       } else if (controller.getDiaSemana!.isEmpty) {
//         NotificatiosnService.showSnackBarDanger(
//             'Debe elegir los días a repetir');
//       } else {
//         final conexion = await Connectivity().checkConnectivity();
//         if (conexion == ConnectivityResult.none) {
//           NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
//         } else if (conexion == ConnectivityResult.wifi ||
//             conexion == ConnectivityResult.mobile) {
//           ProgressDialog.show(context);
//           await controller.creaConsignaCliente(context);
//           // await controller.upLoadImagen();
//           ProgressDialog.dissmiss(context);
//           Navigator.pop(context);
//         }
//       }
//     }
//   }

//   void bottomSheet(
//     ConsignasClientesController controllerConsinas,
//     BuildContext context,
//     Responsive size,
//   ) {
//     showCupertinoModalPopup(
//         context: context,
//         builder: (_) => CupertinoActionSheet(
//               // title: Text(title, style: GoogleFonts.lexendDeca(
//               //               fontSize: size.dp(1.8),
//               //               fontWeight: FontWeight.w500,
//               //               // color: Colors.white,
//               //             )),

//               actions: [
//                 CupertinoActionSheetAction(
//                   onPressed: () {
//                     // urls.launchWaze(lat, lng);s
//                     _funcionCamara(ImageSource.camera, controllerConsinas);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Abrir Cámara',
//                           style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(2.2),
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           )),
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                             horizontal: size.iScreen(2.0),
//                           ),
//                           child: Icon(Icons.camera_alt_outlined,
//                               size: size.iScreen(3.0))),
//                     ],
//                   ),
//                 ),
//                 CupertinoActionSheetAction(
//                   onPressed: () {
//                     _funcionCamara(ImageSource.gallery, controllerConsinas);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Abrir Galería',
//                           style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(2.2),
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           )),
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                             horizontal: size.iScreen(2.0),
//                           ),
//                           child: Icon(Icons.image_outlined,
//                               size: size.iScreen(3.0))),
//                     ],
//                   ),
//                 ),
//               ],
//               // cancelButton: CupertinoActionSheetAction(
//               //   onPressed: () => Navigator.of(context).pop(),
//               //   child: Text('Close'),
//               // ),
//             ));
//   }

//   void _funcionCamara(ImageSource source,
//       ConsignasClientesController consignasController) async {
//     final picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: source,
//       imageQuality: 100,
//     );

//     if (pickedFile == null) {
//       return;
//     }
//     consignasController.setNewPictureFile('${pickedFile.path}');
//     print('TENEMOS IMAGEN:=====>  ${pickedFile.path}');

// //===============================//
//     _downloadImage(pickedFile.path);
// //===============================//
//     Navigator.pop(context);

//     // Navigator.pop(context);
//   }
// }

// class ItemDia extends StatelessWidget {
//   final String label;
//   final void Function()? onTap;
//   final ConsignasClientesController controller;
//   final Responsive size;

//   const ItemDia(
//       {Key? key,
//       required this.label,
//       required this.size,
//       this.onTap,
//       required this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: size.iScreen(5.0),
//         height: size.iScreen(5.0),
//         // padding: EdgeInsets.all(size.iScreen(1.0)),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: GoogleFonts.lexendDeca(
//               fontSize: size.iScreen(1.8),
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyItemGuardia {
//   bool isExpanded = false;
//   final String? header;
//   final List<String>? body;

//   MyItemGuardia(this.header, this.body);
// }

// class ItemNominaGuardias extends StatelessWidget {
//   final String? nomina;

//   final Responsive size;

//   const ItemNominaGuardias({Key? key, required this.nomina, required this.size})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       // splashColor: Colors.brown.shade50,
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         margin: EdgeInsets.only(bottom: size.iScreen(0.5)),
//         padding: EdgeInsets.only(
//             top: size.iScreen(0.9),
//             left: size.iScreen(0.5),
//             right: size.iScreen(0.5),
//             bottom: size.iScreen(0.9)),
//         // width: size.wScreen(100.0),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.check,
//               color: Colors.green,
//             ),
//             Expanded(
//               child: Text(
//                 nomina!,
//                 style: GoogleFonts.lexendDeca(
//                     fontSize: size.iScreen(1.8),
//                     color: Colors.black54,
//                     fontWeight: FontWeight.normal),
//               ),
//             ),
//             // const Icon(Icons.chevron_right_outlined),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _downloadImage(String? image) async {
//   try {
//     // Saved with this method.
//     var imageId = await ImageDownloader.downloadImage(image!);
//     if (imageId == null) {
//       return;
//     }
//     NotificatiosnService.showSnackBarSuccsses("Descarga realizada");

//     // Below is a method of obtaining saved image information.
//     var fileName = await ImageDownloader.findName(imageId);
//     var path = await ImageDownloader.findPath(imageId);
//     var size = await ImageDownloader.findByteSize(imageId);
//     var mimeType = await ImageDownloader.findMimeType(imageId);
//   } on PlatformException catch (error) {
//     print(error);
//   }
// }

// class _CamaraOption extends StatelessWidget {
//   final ConsignasClientesController consignaController;
//   const _CamaraOption({
//     Key? key,
//     required this.size,
//     required this.consignaController,
//   }) : super(key: key);

//   final Responsive size;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Column(
//         children: [
//           Container(
//             width: size.wScreen(100.0),
//             // color: Colors.blue,
//             margin: EdgeInsets.symmetric(
//               vertical: size.iScreen(1.0),
//               horizontal: size.iScreen(0.0),
//             ),
//             child: Text('Fotografía:',
//                 style: GoogleFonts.lexendDeca(
//                     // fontSize: size.iScreen(2.0),
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey)),
//           ),
//           SingleChildScrollView(
//               child: Wrap(
//                   children: consignaController.getListaFotos
//                       .map((e) => _ItemFoto(
//                           size: size,
//                           controllerConsinas: consignaController,
//                           image: e))
//                       .toList())),
//         ],
//       ),
//       onTap: () {
//         print('activa FOTOGRAFIA');
//       },
//     );
//   }
// }

// class _ItemFoto extends StatelessWidget {
//   final CreaNuevaFotoConsignaCliente? image;
//   final ConsignasClientesController controllerConsinas;

//   const _ItemFoto({
//     Key? key,
//     required this.size,
//     required this.controllerConsinas,
//     required this.image,
//   }) : super(key: key);

//   final Responsive size;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           child: Hero(
//             tag: image!.id,
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     // color: Colors.red,
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   width: size.wScreen(35.0),
//                   height: size.hScreen(20.0),
//                   padding: EdgeInsets.symmetric(
//                     vertical: size.iScreen(0.0),
//                     horizontal: size.iScreen(0.0),
//                   ),
//                   child: getImage(image!.path),
//                 ),
//               ),
//             ),
//           ),
//           onTap: () {
//             // Navigator.pushNamed(context, 'viewPhoto');
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => PreviewScreenConsignas(image: image)));
//           },
//         ),
//         Positioned(
//           top: -3.0,
//           right: 4.0,
//           // bottom: -3.0,
//           child: IconButton(
//             color: Colors.red.shade700,
//             onPressed: () {
//               controllerConsinas.eliminaFoto(image!.id);
//               // bottomSheetMaps(context, size);
//             },
//             icon: Icon(
//               Icons.delete_forever,
//               size: size.iScreen(3.5),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget? getImage(String? picture) {
//   if (picture == null) {
//     return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
//   }
//   if (picture.startsWith('http')) {
//     return const FadeInImage(
//       placeholder: AssetImage('assets/imgs/loader.gif'),
//       image: NetworkImage('url'),
//     );
//   }

//   return Image.file(
//     File(picture),
//     fit: BoxFit.cover,
//   );
// }

// class _ListaGuardias extends StatelessWidget {
//   final ConsignasClientesController controllerConsinas;
//   const _ListaGuardias({
//     Key? key,
//     required this.size,
//     required this.controllerConsinas,
//   }) : super(key: key);

//   final Responsive size;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Consumer<ConsignasClientesController>(
//         builder: (_, provider, __) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
//             // color: Colors.red,
//             width: size.wScreen(100.0),
//             height: size.iScreen(
//                 provider.getListaGuardiasConsigna.length.toDouble() * 5.5),
//             child: ListView.builder(
//               itemCount: provider.getListaGuardiasConsigna.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final guardia = provider.getListaGuardiasConsigna[index];
//                 return Card(
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           provider.eliminaGuardiaConsigna(guardia['id']);
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(right: size.iScreen(0.5)),
//                           child: const Icon(Icons.delete_forever_outlined,
//                               color: Colors.red),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: size.iScreen(1.0),
//                               vertical: size.iScreen(1.0)),
//                           child: Text(
//                             '${guardia['nombres']}',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.7),
//                                 // color: Colors.black54,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       onTap: () {
//         print('activa FOTOGRAFIA');
//       },
//     );
//   }
// }
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';

import 'package:image_picker/image_picker.dart';

import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/models/crea_foto_consigna_cliente.dart';


import 'package:nseguridad/src/pages/view_photo_consignas_cliente.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';

import 'package:provider/provider.dart';

import 'package:awesome_calendar/awesome_calendar.dart';

class ConsignaClientePage extends StatefulWidget {
  const ConsignaClientePage({Key? key}) : super(key: key);

  @override
  State<ConsignaClientePage> createState() => _ConsignaClientePageState();
}

class _ConsignaClientePageState extends State<ConsignaClientePage> {
 

// ===================///
  DateTime initialDate = DateTime.now();

  DateTime embeddedCalendar = DateTime.now();
  // List<DateTime>? multiSelect;

// ===================///

  @override
  void initState() {
    initload();
    super.initState();
  }

  void initload() async {
    // timeInicio = TimeOfDay.now();
    // timeFin = TimeOfDay.now();

    // final loadData = ConsignasClientesController();
    // await loadData.getTodoPersonalDesignadoAlClientes();
  }

  @override
  void dispose() {
    // _fechaInicioController.clear();
    // _fechaFinController.clear();
    // _horaFinController.clear();
    // _horaFinController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int _radioSelected = 1;
    bool _value = false;
    int val = -1;
    final Responsive size = Responsive.of(context);
    final consignaController =
        Provider.of<ConsignasController>(context);

    return
     GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: primaryColor,
            title:  Text('Nueva Consigna',
            // style:  Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Consumer<SocketService>(builder: (_, valueSave, __) { 
                return  valueSave.serverStatus == ServerStatus.Online
  ?
                 Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, consignaController);
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              ):Container();
               },)
             
            ],
          ),
          body:
Consumer<SocketService>(builder: (_, valueSocket, __) {  
  return  valueSocket.serverStatus == ServerStatus.Online
  ?Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: size.iScreen(0.0)),
            padding: EdgeInsets.only(
                left: size.iScreen(2.0),
                right: size.iScreen(2.0),
                top: size.iScreen(2.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: consignaController.consignasClienteFormKey,
                child: Column(
                  children: [
                    //*****************************************/

                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Text('Asunto:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      // decoration: const InputDecoration(
                      //     suffixIcon: Icon(Icons.beenhere_outlined)),
                      textAlign: TextAlign.start,
                      style: const TextStyle(

                          // fontSize: size.iScreen(3.5),
                          // fontWeight: FontWeight.bold,
                          // letterSpacing: 2.0,
                          ),
                      onChanged: (text) {
                        consignaController.onChangeAsunto(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese asunto de la Consigna';
                        }
                      },
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Text('Detalle:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      // maxLines: 2,
                      // decoration: const InputDecoration(
                      //     suffixIcon: Icon(Icons.article_outlined)),
                      textAlign: TextAlign.start,
                      style: const TextStyle(

                          // fontSize: size.iScreen(3.5),
                          // fontWeight: FontWeight.bold,
                          // letterSpacing: 2.0,
                          ),
                      onChanged: (text) {
                        consignaController.onChangeDetalle(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese detalle de la Consigna';
                        }
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/
                    ElevatedButton(
                      onPressed: () => multiSelectPicker(consignaController),
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor, // Background color
                          onPrimary:
                              Colors.white // Text Color (Foreground color)
                          ),
                      child: Text(
                        'Seleccione Fecha',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      // alignment: Alignment.,
                      width: size.wScreen(100.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.0),
                          vertical: size.iScreen(0.1)),
                      child: consignaController.getLitaSeleccionada != null
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              children: consignaController.getLitaSeleccionada!
                                  .map(
                                    (e) => Container(
                                      margin: EdgeInsets.all(size.iScreen(0.6)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(
                                                size.iScreen(0.5)),
                                            decoration: BoxDecoration(
                                              // color: Colors.grey.shade200,
                                              color: Color(0xff2BADEC),
                                            ),
                                            width: size.iScreen(12.0),
                                            child: Text(
                                              e.toString().substring(0, 10),
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Container(),

                      // height: size.iScreen(consignaController.getLitaSeleccionada!.length.toDouble()*3),
                    ),
              
 //***********************************************/
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          //*****************************************/
                    // ===========PRIORIDAD==============
                    // Container(
                    //   // color: Colors.red,
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: size.iScreen(1.5),
                    //       vertical: size.iScreen(0.5)),
                    //   width: size.wScreen(100.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Container(
                    //         width: size.wScreen(100.0),
                    //         child: Text(
                    //           'Prioridad:',
                    //           style: GoogleFonts.lexendDeca(
                    //             fontSize: size.iScreen(1.7),
                    //             color: Colors.black54,
                    //             // fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //       //***********************************************/
                    //       SizedBox(
                    //         height: size.iScreen(2.0),
                    //       ),
                    //       //*****************************************/
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: [
                    //           Column(
                    //             children: [
                    //               Text(
                    //                 'baja',
                    //                 style: GoogleFonts.lexendDeca(
                    //                   fontSize: size.iScreen(1.7),
                    //                   color: Colors.black54,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               Radio(
                    //                 value: 3,
                    //                 groupValue: consignaController
                    //                     .getprioridadValueCliente,
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     val = 3;
                    //                     consignaController
                    //                         .onPrioridadClienteChange(value);
                    //                     // print(val);
                    //                   });
                    //                 },
                    //                 activeColor: primaryColor,
                    //                 toggleable: true,
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             children: [
                    //               Text(
                    //                 'Media',
                    //                 style: GoogleFonts.lexendDeca(
                    //                   fontSize: size.iScreen(1.7),
                    //                   color: Colors.black54,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               Radio(
                    //                 value: 2,
                    //                 groupValue: consignaController
                    //                     .getprioridadValueCliente,
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     val = 2;
                    //                     consignaController
                    //                         .onPrioridadClienteChange(value);
                    //                     // print(val);
                    //                   });
                    //                 },
                    //                 activeColor: primaryColor,
                    //                 toggleable: true,
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             children: [
                    //               Text(
                    //                 'Alta',
                    //                 style: GoogleFonts.lexendDeca(
                    //                   fontSize: size.iScreen(1.7),
                    //                   color: Colors.black54,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               Radio(
                    //                 value: 1,
                    //                 groupValue: consignaController
                    //                     .getprioridadValueCliente,
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     val = 1;
                    //                     consignaController
                    //                         .onPrioridadClienteChange(value);
                    //                     // print(val);
                    //                   });
                    //                 },
                    //                 activeColor: primaryColor,
                    //                 toggleable: true,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                   
                   

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************************/
                    Row(
                      children: [
                        Container(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Text('Guardias: ',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                              (consignaController
                                      .getListaGuardiasConsigna.isNotEmpty)
                                  ? Text(
                                      ' ${consignaController.getListaGuardiasConsigna.length}',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.7),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey))
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(width: size.iScreen(1.0)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              consignaController.buscaGuardiasConsigna('');
                              Navigator.pushNamed(
                                  context, 'buscaGuardiaConsigna');
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute<void>(
                              //         builder: (BuildContext context) =>
                              //             const BuscarPersonalInformes()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: primaryColor,
                              width: size.iScreen(3.05),
                              padding: EdgeInsets.only(
                                top: size.iScreen(0.5),
                                bottom: size.iScreen(0.5),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: size.iScreen(2.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    //==========================================//

                    Consumer<ConsignasController>(builder: (_, valueListaGuardias, __) {  
                      return valueListaGuardias.getListaGuardiasConsigna.isNotEmpty
                      ? _ListaGuardias(
                            size: size, controllerConsinas: valueListaGuardias)
                        : Text('Debe seleccionar guardias',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey));
                    },),
                    
                        

                    //========================================//
 //==========================================//
                    consignaController.getListaFotos.isNotEmpty
                        ? _CamaraOption(
                            size: size, consignaController: consignaController)
                        : Container(),
//*****************************************/

                    SizedBox(
                      height: size.iScreen(3.0),
                    ),
                    //*****************************************/

                  ],
                ),
              ),
            ),
          ):const NoData(label: 'Sin conexión a Internet');
          
          
},),

          
          
          floatingActionButton: 
          Consumer<SocketService>(builder: (_, valuesSave, __) { 
                return  valuesSave.serverStatus == ServerStatus.Online
  ?
                 FloatingActionButton(
            onPressed: () {
              bottomSheet(consignaController, context, size);
            },
            backgroundColor: Colors.purpleAccent,
            heroTag: "btnCamara",
            child: const Icon(Icons.camera_alt_outlined),
          ):Container();
               },)
          
          
        ),
      ),
    );
  
  
  
  }

  //================================================= NUEVO PICKER==================================================//

//

  Future<void> multiSelectPicker(
      ConsignasController consignaController) async {
    final List<DateTime>? picked = await showDialog<List<DateTime>>(
      context: context,
      builder: (BuildContext context) {
        // print('picked: $rangeSelect');
        return AwesomeCalendarDialog(
          selectedDates: consignaController.getLitaSeleccionada,
          selectionMode: SelectionMode.multi,
        );
      },
    );
    if (picked != null) {
      consignaController.setListMultiSelect(picked);
      //   multiSelect = picked;
      // setState(() {
      // });
    }
  }

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  // _selectFechaInicio(BuildContext context,
  //     ConsignasClientesController consignaController) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2025),
  //     locale: const Locale('es', 'ES'),
  //   );
  //   if (picked != null) {
  //     String? anio, mes, dia;
  //     anio = '${picked.year}';
  //     mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
  //     dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

  //     // setState(() {
  //     final _fechaInicio =
  //         '${anio.toString()}-${mes.toString()}-${dia.toString()}';
  //     _fechaInicioController.text = _fechaInicio;
  //     consignaController.onInputFechaInicioConsignaChange(_fechaInicio);
  //     // print('FechaInicio: $_fechaInicio');
  //     // });
  //   }
  // }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  // _selectFechaFin(BuildContext context,
  //     ConsignasClientesController consignaController) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2025),
  //     locale: const Locale('es', 'ES'),
  //   );
  //   if (picked != null) {
  //     String? anio, mes, dia;
  //     anio = '${picked.year}';
  //     mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
  //     dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

  //     setState(() {
  //       final _fechaFin =
  //           '${anio.toString()}-${mes.toString()}-${dia.toString()}';
  //       _fechaFinController.text = _fechaFin;
  //       consignaController.onInputFechaFinConsignaChange(_fechaFin);
  //       // print('FechaFin: $_fechaFin');
  //     });
  //   }
  // }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  // _selectHoraInicio(BuildContext context,
  //     ConsignasClientesController consignaController) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2025),
  //     locale: const Locale('es', 'ES'),
  //   );
  //   if (picked != null) {
  //     String? anio, mes, dia;
  //     anio = '${picked.year}';
  //     mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
  //     dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

  //     setState(() {
  //       final _fechaFin =
  //           '${anio.toString()}-${mes.toString()}-${dia.toString()}';
  //       _fechaFinController.text = _fechaFin;
  //       consignaController.onInputFechaFinConsignaChange(_fechaFin);
  //       // print('FechaFin: $_fechaFin');
  //     });
  //   }
  // }
 
  // void _seleccionaHoraInicio(
  //     context, ConsignasClientesController consignaController) async {
  //   TimeOfDay? _hora =
  //       await showTimePicker(context: context, initialTime: timeInicio);

  //   if (_hora != null) {
  //     setState(() {
  //       timeInicio = _hora;
  //       String horaInicio = '${timeInicio.hour}:${timeInicio.minute}';
  //       _horaInicioController.text = horaInicio;
  //       consignaController.onInputHoraInicioConsignaChange(horaInicio);
  //       //  print('si: $horaInicio');
  //     });
  //   }
  // }

  // void _seleccionaHoraFin(
  //     context, ConsignasClientesController consignaController) async {
  //   TimeOfDay? _hora =
  //       await showTimePicker(context: context, initialTime: timeFin);
  //   if (_hora != null) {
  //     setState(() {
  //       timeFin = _hora;
  //       print(timeFin.format(context));
  //       String horaFin = '${timeFin.hour}:${timeFin.minute}';
  //       _horaFinController.text = horaFin;
  //       consignaController.onInputHoraFinConsignaChange(horaFin);
  //       //  print('si: $horaFin');
  //     });
  //   }
  // }

  //********************************************************************************************************************//
  void _onSubmit(
      BuildContext context, ConsignasController controller) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getListaGuardiasConsigna.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe asignar el personal');
      }
       else if (controller.getLitaSeleccionada == null|| controller.getLitaSeleccionada!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe elegir fecha');
      } else {
        final conexion = await Connectivity().checkConnectivity();
        if (conexion == ConnectivityResult.none) {
          NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
        } else if (conexion == ConnectivityResult.wifi ||
            conexion == ConnectivityResult.mobile) {
          // ProgressDialog.show(context);
          await controller.creaConsignaCliente(context);
          // await controller.upLoadImagen();
          // ProgressDialog.dissmiss(context);
          Navigator.pop(context);
        }
      }
    }
  }

  void bottomSheet(
    ConsignasController controllerConsinas,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              // title: Text(title, style: GoogleFonts.lexendDeca(
              //               fontSize: size.dp(1.8),
              //               fontWeight: FontWeight.w500,
              //               // color: Colors.white,
              //             )),

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    // urls.launchWaze(lat, lng);s
                    _funcionCamara(ImageSource.camera, controllerConsinas);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.gallery, controllerConsinas);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
              // cancelButton: CupertinoActionSheetAction(
              //   onPressed: () => Navigator.of(context).pop(),
              //   child: Text('Close'),
              // ),
            ));
  }

  void _funcionCamara(ImageSource source,
      ConsignasController consignasController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    consignasController.setNewPictureFile('${pickedFile.path}');


//===============================//
    _downloadImage(pickedFile.path);
//===============================//
    Navigator.pop(context);

    // Navigator.pop(context);
  }
}

class ItemDia extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final ConsignasController controller;
  final Responsive size;

  const ItemDia(
      {Key? key,
      required this.label,
      required this.size,
      this.onTap,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.iScreen(5.0),
        height: size.iScreen(5.0),
        // padding: EdgeInsets.all(size.iScreen(1.0)),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lexendDeca(
              fontSize: size.iScreen(1.8),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyItemGuardia {
  bool isExpanded = false;
  final String? header;
  final List<String>? body;

  MyItemGuardia(this.header, this.body);
}

class ItemNominaGuardias extends StatelessWidget {
  final String? nomina;

  final Responsive size;

  const ItemNominaGuardias({Key? key, required this.nomina, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: Colors.brown.shade50,
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: size.iScreen(0.5)),
        padding: EdgeInsets.only(
            top: size.iScreen(0.9),
            left: size.iScreen(0.5),
            right: size.iScreen(0.5),
            bottom: size.iScreen(0.9)),
        // width: size.wScreen(100.0),
        child: Row(
          children: [
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
            Expanded(
              child: Text(
                nomina!,
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.8),
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
            ),
            // const Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}

void _downloadImage(String? image) async {
  try {
    // Saved with this method.
    var imageId = await ImageDownloader.downloadImage(image!);
    if (imageId == null) {
      return;
    }
    NotificatiosnService.showSnackBarSuccsses("Descarga realizada");

    // Below is a method of obtaining saved image information.
    var fileName = await ImageDownloader.findName(imageId);
    var path = await ImageDownloader.findPath(imageId);
    var size = await ImageDownloader.findByteSize(imageId);
    var mimeType = await ImageDownloader.findMimeType(imageId);
  } on PlatformException catch (error) {
   
  }
}

class _CamaraOption extends StatelessWidget {
  final ConsignasController consignaController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.consignaController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: size.wScreen(100.0),
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografía:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
              child: Wrap(
                  children: consignaController.getListaFotos
                      .map((e) => _ItemFoto(
                          size: size,
                          controllerConsinas: consignaController,
                          image: e))
                      .toList())),
        ],
      ),
      onTap: () {
   
      },
    );
  }
}

class _ItemFoto extends StatelessWidget {
  final CreaNuevaFotoConsignaCliente? image;
  final ConsignasController controllerConsinas;

  const _ItemFoto({
    Key? key,
    required this.size,
    required this.controllerConsinas,
    required this.image,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Hero(
            tag: image!.id,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: size.wScreen(35.0),
                  // height: size.hScreen(20.0),
                  padding: EdgeInsets.symmetric(
                    vertical: size.iScreen(0.0),
                    horizontal: size.iScreen(0.0),
                  ),
                  child: getImage(image!.path),
                ),
              ),
            ),
          ),
          onTap: () {
            // Navigator.pushNamed(context, 'viewPhoto');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PreviewScreenConsignas(image: image)));
          },
        ),
        Positioned(
          top: -3.0,
          right: 4.0,
          // bottom: -3.0,
          child: IconButton(
            color: Colors.red.shade700,
            onPressed: () {
              controllerConsinas.eliminaFoto(image!.id);
              // bottomSheetMaps(context, size);
            },
            icon: Icon(
              Icons.delete_forever,
              size: size.iScreen(3.5),
            ),
          ),
        ),
      ],
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return const FadeInImage(
      placeholder: AssetImage('assets/imgs/loader.gif'),
      image: NetworkImage('url'),
    );
  }

  return Image.file(
    File(picture),
    fit: BoxFit.cover,
  );
}

class _ListaGuardias extends StatelessWidget {
  final ConsignasController controllerConsinas;
  const _ListaGuardias({
    Key? key,
    required this.size,
    required this.controllerConsinas,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<ConsignasController>(
        builder: (_, provider, __) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
            // color: Colors.red,
            width: size.wScreen(100.0),
            height: size.iScreen(
                provider.getListaGuardiasConsigna.length.toDouble() *6),
            child: Wrap(children: provider.getListaGuardiasConsigna.map((e) => Card(
                 color: Colors.grey.shade200,
                  child: InkWell(
                    onTap: (() =>  provider.eliminaGuardiaConsigna(e['id'])),
                    child: Row(
                      children: [
                        // Container(
                        //   // color: Colors.green,
                        //   margin: EdgeInsets.only(right: size.iScreen(0.0)),
                        //   padding: EdgeInsets.all( size.iScreen(0.5)),
                        //   child:
                        //   //  Text('X', style: GoogleFonts.lexendDeca(
                        //   //       fontSize: size.iScreen(2.0),
                        //   //       color: Colors.red,
                        //   //       fontWeight: FontWeight.normal),), 
                        //   // Icon(Icons.delete_forever_outlined,
                        //   //     color: Colors.red,size: size.iScreen(3.5),),
                        // ),
                        Expanded(
                          child: Container(
                                 margin: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              '${e['nombres']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.7),
                                  // color: Colors.black54,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )).toList(),)
            // ListView.builder(
            //   itemCount: provider.getListaGuardiasConsigna.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final guardia = provider.getListaGuardiasConsigna[index];
            //     return Card(
            //       child: Row(
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               provider.eliminaGuardiaConsigna(guardia['id']);
            //             },
            //             child: Container(
            //               margin: EdgeInsets.only(right: size.iScreen(0.5)),
            //               child: const Icon(Icons.delete_forever_outlined,
            //                   color: Colors.red),
            //             ),
            //           ),
            //           Expanded(
            //             child: Container(
            //               margin: EdgeInsets.symmetric(
            //                   horizontal: size.iScreen(1.0),
            //                   vertical: size.iScreen(1.0)),
            //               child: Text(
            //                 '${guardia['nombres']}',
            //                 style: GoogleFonts.lexendDeca(
            //                     fontSize: size.iScreen(1.7),
            //                     // color: Colors.black54,
            //                     fontWeight: FontWeight.normal),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          );
        },
      ),
      onTap: () {
     
      },
    );
  }
}

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date,
      void Function(DateTime datetime)? onTap) {
    return DefaultDayTile(
      date: date,
      onTap: onTap,
      selectedDayColor: Colors.cyan,
      currentDayBorderColor: Colors.grey,
    );
  }
}
