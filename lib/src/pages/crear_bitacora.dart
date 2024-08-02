// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nseguridad/src/controllers/home_ctrl.dart';
// import 'package:provider/provider.dart';
// import 'package:nseguridad/src/controllers/bitacora_controller.dart';
// import 'package:nseguridad/src/controllers/home_controller.dart';
// import 'package:nseguridad/src/models/session_response.dart';
// import 'package:nseguridad/src/pages/buscar_persona_bitacora.dart';
// import 'package:nseguridad/src/service/notifications_service.dart';
// import 'package:nseguridad/src/theme/themes_app.dart';
// import 'package:nseguridad/src/utils/dialogs.dart';
// import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
// import 'package:nseguridad/src/utils/responsive.dart';

// class CrearBitaora extends StatefulWidget {
//   final String? action;
//   final Session? user;
//   const CrearBitaora({Key? key, this.action, this.user}) : super(key: key);

//   @override
//   State<CrearBitaora> createState() => _CrearBitaoraState();
// }

// class _CrearBitaoraState extends State<CrearBitaora> {
//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final _user = context.read<HomeController>();
//      final _ctrlTheme=context.read<ThemeApp>();
//     final bitacoraController = context.read<BitacoraController>();
//       final ctrlTheme = context.read<ThemeApp>();

//     final _action = widget.action;
//     return SafeArea(
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: AppBar(
//             // backgroundColor: primaryColor,
//             // title:  Text('Registrar Bitácora',style:  ),

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
//             title: _action == 'CREATE'
//                 ? Text(
//                     'Crear Bitácora',
//                     // style: Theme.of(context).textTheme.headline2,
//                   )
//                 : Text(
//                     'Editar Bitácoras',
//                     // style: Theme.of(context).textTheme.headline2,
//                   ),
//             actions: [
//               Container(
//                 margin: EdgeInsets.only(right: size.iScreen(1.5)),
//                 child: IconButton(
//                     splashRadius: 28,
//                     onPressed: () {
//                       _onSubmit(context, bitacoraController, _action!);
//                     },
//                     icon: Icon(
//                       Icons.save_outlined,
//                       size: size.iScreen(4.0),
//                     )),
//               ),
//             ],
//           ),
//           body: Container(
//             margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
//             padding: EdgeInsets.only(
//               top: size.iScreen(0.5),
//               left: size.iScreen(0.5),
//               right: size.iScreen(0.5),
//               bottom: size.iScreen(0.5),
//             ),
//             width: size.wScreen(100.0),
//             height: size.hScreen(100),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Form(
//                 key: bitacoraController.bitacoraFormKey,
//                 child: Column(
//                   children: [
//                     Container(
//                         width: size.wScreen(100.0),
//                         margin: const EdgeInsets.all(0.0),
//                         padding: const EdgeInsets.all(0.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text('${_user.getUsuarioInfo!.rucempresa!}  ',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.grey.shade600,
//                                     fontWeight: FontWeight.bold)),
//                             Text('-',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold)),
//                             Text('  ${_user.getUsuarioInfo!.usuario!} ',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.grey.shade600,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         )),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/

//                     Container(
//                       width: size.wScreen(100.0),

//                       // color: Colors.blue,
//                       child: Text('Tipo Persona:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(0.0),
//                     ),
//                     //***********************************************/
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // color: Colors.red,
//                             padding: EdgeInsets.only(
//                               top: size.iScreen(1.0),
//                               right: size.iScreen(0.5),
//                             ),
//                             child: Consumer<BitacoraController>(
//                               builder: (_, personal, __) {
//                                 return (personal.getItemTipoPersonal == '' ||
//                                         personal.getItemTipoPersonal == null)
//                                     ? Text(
//                                         'Seleccione tipo de persona',
//                                         style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       )
//                                     : Text(
//                                         '${personal.getItemTipoPersonal}',
//                                         style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(1.8),
//                                           fontWeight: FontWeight.normal,
//                                           // color: Colors.grey
//                                         ),
//                                       );
//                               },
//                             ),
//                           ),
//                         ),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: GestureDetector(onTap: () {
//                             _modalSeleccionaTipoPersona(
//                                 size, bitacoraController);
//                           }, child: Consumer<ThemeApp>(
//                             builder: (_, valueTheme, __) {
//                               return Container(
//                                 alignment: Alignment.center,
//                                 color: valueTheme.primaryColor,
//                                 width: size.iScreen(3.5),
//                                 padding: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   bottom: size.iScreen(0.5),
//                                   left: size.iScreen(0.5),
//                                   right: size.iScreen(0.5),
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: valueTheme.secondaryColor,
//                                   size: size.iScreen(2.0),
//                                 ),
//                               );
//                             },
//                           )),
//                         ),
//                       ],
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/

//                     Row(
//                       children: [
//                         Container(
//                           width: size.wScreen(15.0),

//                           // color: Colors.blue,
//                           child: Text('Cédula:',
//                               style: GoogleFonts.lexendDeca(
//                                   // fontSize: size.iScreen(2.0),
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.grey)),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(left: size.iScreen(1.0)),
//                           width: size.wScreen(70.0),
//                           // color: Colors.blue,12
//                           child: TextFormField(
//                             maxLength: 10,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.allow(
//                                   RegExp(r'[0-9]')),
//                             ],
//                             decoration: const InputDecoration(
//                                 // suffixIcon: Icon(Icons.beenhere_outlined)
//                                 ),
//                             style: TextStyle(
//                               fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                             ),
//                             onChanged: (text) {
//                               bitacoraController.setItemCedula(text);
//                             },
//                             validator: (text) {
//                               if (text!.trim().isNotEmpty) {
//                                 return null;
//                               } else {
//                                 return 'Ingrese Cédula';
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/
//                     Container(
//                       width: size.wScreen(100.0),

//                       // color: Colors.blue,
//                       child: Text('Apellidos y Nombres: ',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(),
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(),
//                       textInputAction: TextInputAction.done,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(
//                             // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
//                             RegExp(r'^[^\n"]*$')),
//                         UpperCaseText(),
//                       ],
//                       onChanged: (text) {
//                         bitacoraController.setItemNombres(text);
//                       },
//                       validator: (text) {
//                         if (text!.trim().isNotEmpty) {
//                           return null;
//                         } else {
//                           return 'Ingrese Nombres Completos';
//                         }
//                       },
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/
//                     Container(
//                       width: size.wScreen(100.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             width: size.wScreen(20.0),

//                             // color: Colors.blue,
//                             child: Text('Teléfono:',
//                                 style: GoogleFonts.lexendDeca(
//                                     // fontSize: size.iScreen(2.0),
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.grey)),
//                           ),
//                           Container(
//                             width: size.wScreen(50.0),
//                             child: TextFormField(
//                               maxLength: 10,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: <TextInputFormatter>[
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]')),
//                               ],
//                               decoration: const InputDecoration(),
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(),
//                               onChanged: (text) {
//                                 bitacoraController.setItemTelefono(text);
//                               },
//                               validator: (text) {
//                                 if (text!.trim().isNotEmpty) {
//                                   return null;
//                                 } else {
//                                   return 'Debe ingresar teléfono';
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/

//                     Container(
//                       width: size.wScreen(100.0),

//                       // color: Colors.blue,
//                       child: Text('Se dirige a:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(0.0),
//                     ),
//                     //***********************************************/
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // color: Colors.red,
//                             padding: EdgeInsets.only(
//                               top: size.iScreen(1.0),
//                               right: size.iScreen(0.5),
//                             ),
//                             child: Consumer<BitacoraController>(
//                               builder: (_, personal, __) {
//                                 return (personal.getItemSeDirigeA == '' ||
//                                         personal.getItemSeDirigeA == null)
//                                     ? Text(
//                                         'Seleccione donde se dirige',
//                                         style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       )
//                                     : Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: size.iScreen(0.5),
//                                             vertical: size.iScreen(0.5)),
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey.shade100,
//                                             border: Border.all(
//                                                 color: Colors.grey,
//                                                 width: 0.1)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Container(
//                                               width: size.wScreen(100),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     'Nombre: ',
//                                                     style: GoogleFonts.lexendDeca(
//                                                       // fontSize: size.iScreen(1.8),
//                                                       fontWeight: FontWeight.normal,
//                                                       color: Colors.grey
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     child: Text(
//                                                       '${personal.getItemSeDirigeA}',
//                                                       style: GoogleFonts.lexendDeca(
//                                                         fontSize: size.iScreen(1.8),
//                                                         fontWeight: FontWeight.normal,
//                                                         // color: Colors.grey
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Divider(height: 0.2),
//                                             Container(
//                                               width: size.wScreen(100),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     'Casa o Departamento : ',
//                                                     style: GoogleFonts.lexendDeca(
//                                                       // fontSize: size.iScreen(1.8),
//                                                       fontWeight: FontWeight.normal,
//                                                       color: Colors.grey
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     child: Text(
//                                                       // '${personal.getItemCedula}',
//                                                       '${personal.getItemCasaDepartamento} ',
//                                                       style: GoogleFonts.lexendDeca(
//                                                         fontSize: size.iScreen(1.8),
//                                                         fontWeight: FontWeight.normal,
//                                                         // color: Colors.grey
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                               },
//                             ),
//                           ),
//                         ),
//                         widget.user!.rol!.contains('RESIDENTE')
//                             ? Container()
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: GestureDetector(onTap: () {
//                                   // _modalSeleccionaSeDirigeA(
//                                   //     size,bitacoraController);

//                                   bitacoraController
//                                       .getTodasPersonasBitacora('');

//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           // builder: ((context) => const RegitroBiracora(
//                                           builder: ((context) =>
//                                               const BuscarPersonaBitacora(

//                                                   // action: 'CREATE',

//                                                   ))));
//                                 }, child: Consumer<ThemeApp>(
//                                   builder: (_, valueTheme, __) {
//                                     return Container(
//                                       alignment: Alignment.center,
//                                       color: valueTheme.primaryColor,
//                                       width: size.iScreen(3.5),
//                                       padding: EdgeInsets.only(
//                                         top: size.iScreen(0.5),
//                                         bottom: size.iScreen(0.5),
//                                         left: size.iScreen(0.5),
//                                         right: size.iScreen(0.5),
//                                       ),
//                                       child: Icon(
//                                         Icons.add,
//                                         color: valueTheme.secondaryColor,
//                                         size: size.iScreen(2.0),
//                                       ),
//                                     );
//                                   },
//                                 )),
//                               ),
//                       ],
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/

//                     Container(
//                       width: size.wScreen(100.0),

//                       // color: Colors.blue,
//                       child: Text('Autorizado por:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(0.0),
//                     ),
//                     //***********************************************/
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // color: Colors.red,
//                             padding: EdgeInsets.only(
//                               top: size.iScreen(1.0),
//                               right: size.iScreen(0.5),
//                             ),
//                             child: Consumer<BitacoraController>(
//                               builder: (_, personal, __) {
//                                 return (personal.getItemAutorizadoPor == '' ||
//                                         personal.getItemAutorizadoPor == null)
//                                     ? Text(
//                                         'Seleccione persona que autoriza',
//                                         style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       )
//                                     : Text(
//                                         '${personal.getItemAutorizadoPor}',
//                                         style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(1.8),
//                                           fontWeight: FontWeight.normal,
//                                           // color: Colors.grey
//                                         ),
//                                       );
//                               },
//                             ),
//                           ),
//                         ),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: GestureDetector(onTap: () {
//                             // print("esta es la lista : ${bitacoraController.getInfPersonaDirige['resPersonasAutorizadas']}");
//                             _modalSeleccionaAutorizadoPor(
//                                 size,
//                                 bitacoraController,
//                                 bitacoraController.getListaAutorizadosBitacora);
//                           }, child: Consumer<ThemeApp>(
//                             builder: (_, valueTheme, __) {
//                               return Container(
//                                 alignment: Alignment.center,
//                                 color: valueTheme.primaryColor,
//                                 width: size.iScreen(3.5),
//                                 padding: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   bottom: size.iScreen(0.5),
//                                   left: size.iScreen(0.5),
//                                   right: size.iScreen(0.5),
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: valueTheme.secondaryColor,
//                                   size: size.iScreen(2.0),
//                                 ),
//                               );
//                             },
//                           )),
//                         ),
//                       ],
//                     ),

//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/
//                     Container(
//                       width: size.wScreen(100.0),
//                       child: Text('Motivo:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),
//                     TextFormField(
//                       minLines: 1,
//                       maxLines: 3,
//                       decoration: const InputDecoration(),
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(),
//                       textInputAction: TextInputAction.done,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(
//                             // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
//                             RegExp(r'^[^\n"]*$')),
//                         UpperCaseText(),
//                       ],
//                       onChanged: (text) {
//                         bitacoraController.setItemMotivo(text);
//                       },
//                       validator: (text) {
//                         if (text!.trim().isNotEmpty) {
//                           return null;
//                         } else {
//                           return 'Ingrese lugar de destino';
//                         }
//                       },
//                     ),
//                     //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/
//                     Container(
//                       width: size.wScreen(100.0),
//                       child: Text('Observación:',
//                           style: GoogleFonts.lexendDeca(
//                               // fontSize: size.iScreen(2.0),
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey)),
//                     ),
//                     TextFormField(
//                       minLines: 1,
//                       maxLines: 3,
//                       decoration: const InputDecoration(),
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(),
//                       textInputAction: TextInputAction.done,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(
//                             // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
//                             RegExp(r'^[^\n"]*$')),
//                         UpperCaseText(),
//                       ],
//                       onChanged: (text) {
//                         bitacoraController.setItemObservacion(text);
//                       },
//                       // validator: (text) {
//                       //   if (text!.trim().isNotEmpty) {
//                       //     return null;
//                       //   } else {
//                       //     return 'Ingrese Observación';
//                       //   }
//                       // },
//                     ),

//                     //*****************************************/

//                     Consumer<BitacoraController>(
//                       builder: (_, valueFoto, __) {
//                         return valueFoto.listaImages.isNotEmpty
//                             ? Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     width: size.wScreen(100.0),
//                                     // color: Colors.blue,
//                                     margin: EdgeInsets.symmetric(
//                                       vertical: size.iScreen(1.0),
//                                       horizontal: size.iScreen(0.0),
//                                     ),
//                                     child: Text(
//                                         'Fotografías:  ${valueFoto.listaImages.length}   ',
//                                         style: GoogleFonts.lexendDeca(
//                                             // fontSize: size.iScreen(2.0),
//                                             fontWeight: FontWeight.normal,
//                                             color: Colors.grey)),
//                                   ),
//                                   Wrap(
//                                       spacing: 8,
//                                       runSpacing: 8,
//                                       children: List.generate(
//                                           valueFoto.listaImages.length,
//                                           (index) {
//                                         final image =
//                                             valueFoto.listaImages[index];
//                                         return Stack(
//                                           children: [
//                                             Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: size.iScreen(1.5)),
//                                               // width: 80,
//                                               // height: 80,
//                                               child: Image.file(image),
//                                             ),
//                                             // Positioned(
//                                             //   top: 0,
//                                             //   right: 0,
//                                             //   child: IconButton(
//                                             //     icon: Icon(Icons.close),
//                                             //     onPressed: () {
//                                             //       valueFoto.removeImage(image);
//                                             //     },
//                                             //   ),
//                                             // ),
//                                             Positioned(
//                                               top: 10.0,
//                                               right: 2.0,
//                                               // bottom: -3.0,
//                                               child: IconButton(
//                                                 color: Colors.red.shade700,
//                                                 onPressed: () {
//                                                   valueFoto.removeImage(image);
//                                                   // bottomSheetMaps(context, size);
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.delete_forever,
//                                                   size: size.iScreen(3.5),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       })),
//                                 ],
//                               )
//                             : Container();
//                       },
//                     )

//                     //*****************************************/
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               final _controller = context.read<BitacoraController>();
//               bottomSheet(context, size, _controller);
//             },
//             backgroundColor: _ctrlTheme.primaryColor,
//             heroTag: "btnCamara",
//             child: const Icon(Icons.camera_alt_outlined),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onSubmit(BuildContext context, BitacoraController _controller,
//       String _action) async {
// //  ProgressDialog.show(context);
// //         //  final response= _controller.enviarImagenesAlServidor();

// //       ProgressDialog.dissmiss(context);

//     // print('la respuesta es: $response.');

//     final isValid = _controller.validateForm();
//     if (!isValid) return;
//     if (isValid) {
//       if (_controller.getItemTipoPersonal == '' ||
//           _controller.getItemTipoPersonal == null) {
//         NotificatiosnService.showSnackBarDanger('Seleccione tipo de Persona');
//       } else if (_controller.getItemSeDirigeA == '' ||
//           _controller.getItemSeDirigeA == null) {
//         NotificatiosnService.showSnackBarDanger('Seleccione donde se dirige');
//       } else if (_controller.getItemCedula!.length > 10 ||
//           _controller.getItemCedula!.length < 10) {
//         NotificatiosnService.showSnackBarDanger('Ingrese cédula correcta');
//       } else if (_controller.getItemAutorizadoPor == '' ||
//           _controller.getItemAutorizadoPor == null) {
//         NotificatiosnService.showSnackBarDanger('Seleccione quién autoriza');
//       } else if (_controller.getItemTelefono!.length < 9 ||
//           _controller.getItemTelefono!.length > 10) {
//         NotificatiosnService.showSnackBarDanger(
//             'Numero de teléfono incorrecto');
//       } else if (_action == 'CREATE') {
//         String _persona = '';
//         if (widget.user!.rol!.contains('GUARDIA')) {
//           _persona = "GUARDIA";
//           await _controller.enviarImagenesAlServidor(context, _persona);
//         } else if (widget.user!.rol!.contains('RESIDENTE')) {
//           _persona = "RESIDENTE";
//           await _controller.enviarImagenesAlServidor(context, _persona);
//         }

//         // ProgressDialog.show(context);

//         // ProgressDialog.dissmiss(context);

//         // print('la respuesta es: $response');
//         // if(response==true){

//         // }

// //           _controller.creaBitacora(context);
// // //  print('_action: $_action');
//         Navigator.pop(context);
//       }
//       // else if (_action == 'EDIT') {
//       //   // await _controller.editaAusencia(context);
//       //   Navigator.pop(context);
//       // }

//     }
//   }

//   //====== MUESTRA MODAL DE SEDIRIGE A =======//
//   void _modalSeleccionaSeDirigeA(Responsive size, BitacoraController _control) {
//     final _data = [
//       'PERSONAL PROPIO',
//       'VISITANTES',
//       'CONTRATISTA',
//       'PROVEEDORES',
//     ];
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: AlertDialog(
//               insetPadding: EdgeInsets.symmetric(
//                   horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(' SE DIRIGE A:',
//                           style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(2.0),
//                             fontWeight: FontWeight.bold,
//                             // color: Colors.white,
//                           )),
//                       IconButton(
//                           splashRadius: size.iScreen(3.0),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.red,
//                             size: size.iScreen(3.5),
//                           )),
//                     ],
//                   ),
//                   Container(
//                     width: size.wScreen(100),
//                     height: size.hScreen(26),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: _data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _control.setItemSeDirigeA(_data[index]);
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             color: Colors.grey[100],
//                             margin: EdgeInsets.symmetric(
//                                 vertical: size.iScreen(0.3)),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: size.iScreen(1.0),
//                                 vertical: size.iScreen(1.0)),
//                             child: Text(
//                               _data[index],
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   //====== MUESTRA MODAL DE AUTORIZADO POR  =======//
//   void _modalSeleccionaAutorizadoPor(
//       Responsive size, BitacoraController _control, List _data) {
// // final  _data=[ 'PERSONAL PROPIO',
// //                       'VISITANTES',
// //                       'CONTRATISTA',
// //                       'PROVEEDORES',
// //                       ];
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: AlertDialog(
//               insetPadding: EdgeInsets.symmetric(
//                   horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(' AUTORIZADO POR:',
//                           style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(2.0),
//                             fontWeight: FontWeight.bold,
//                             // color: Colors.white,
//                           )),
//                       IconButton(
//                           splashRadius: size.iScreen(3.0),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.red,
//                             size: size.iScreen(3.5),
//                           )),
//                     ],
//                   ),
//                   Container(
//                     width: size.wScreen(100),
//                     height: size.hScreen(26),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: _data.length,
//                       // itemCount: _control.getInfoBitacora['resPersonasAutorizadas'].length,
//                       itemBuilder: (BuildContext context, int index) {
//                         ;
//                         return GestureDetector(
//                           onTap: () {
//                             _control.setItemAutorizadoPor(_data[index]);
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             color: Colors.grey[100],
//                             margin: EdgeInsets.symmetric(
//                                 vertical: size.iScreen(0.3)),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: size.iScreen(1.0),
//                                 vertical: size.iScreen(1.0)),
//                             child: Text(
//                               _data[index],
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
//   void _modalSeleccionaTipoPersona(
//       Responsive size, BitacoraController _control) {
//     final _data = [
//       'PERSONAL PROPIO',
//       'VISITANTES',
//       'CONTRATISTA',
//       'PROVEEDORES',
//     ];
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: AlertDialog(
//               insetPadding: EdgeInsets.symmetric(
//                   horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(' TIPO DE PERSONA',
//                           style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(2.0),
//                             fontWeight: FontWeight.bold,
//                             // color: Colors.white,
//                           )),
//                       IconButton(
//                           splashRadius: size.iScreen(3.0),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.red,
//                             size: size.iScreen(3.5),
//                           )),
//                     ],
//                   ),
//                   Container(
//                     width: size.wScreen(100),
//                     height: size.hScreen(26),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: _data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _control.setItemTipoPersona(_data[index]);
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             color: Colors.grey[100],
//                             margin: EdgeInsets.symmetric(
//                                 vertical: size.iScreen(0.3)),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: size.iScreen(1.0),
//                                 vertical: size.iScreen(1.0)),
//                             child: Text(
//                               _data[index],
//                               style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.8),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   //********************************************** FOTOGRAFIA **********************************************************************//
//   void bottomSheet(
//       BuildContext context, Responsive size, BitacoraController _controller) {
//     showCupertinoModalPopup(
//         context: context,
//         builder: (_) => CupertinoActionSheet(
//               actions: [
//                 CupertinoActionSheetAction(
//                   onPressed: () async {
//                     // _funcionCamara(ImageSource.camera);
//                     final picker = ImagePicker();
//                     final pickedFile =
//                         await picker.pickImage(source: ImageSource.camera);
//                     if (pickedFile != null) {
//                       File image = File(pickedFile.path);
//                       _controller.addImage(image);
//                       Navigator.pop(context);
//                     }
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
//                   onPressed: () async {
//                     // _funcionCamara(ImageSource.gallery);
//                     final picker = ImagePicker();
//                     final pickedFile =
//                         await picker.pickImage(source: ImageSource.gallery);
//                     if (pickedFile != null) {
//                       File image = File(pickedFile.path);
//                       _controller.addImage(image);
//                       Navigator.pop(context);
//                     }
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
//             ));
//   }
// }

//********************************* NUEVA FORMA ***************************************//

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';
import 'package:nseguridad/src/pages/agregar_visita_bitacora.dart';
import 'package:nseguridad/src/utils/foto_url.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/buscar_persona_bitacora.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class CrearBitaora extends StatefulWidget {
  final String? action;
  final Session? user;
  const CrearBitaora({Key? key, this.action, this.user}) : super(key: key);

  @override
  State<CrearBitaora> createState() => _CrearBitaoraState();
}

class _CrearBitaoraState extends State<CrearBitaora> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
    final _ctrlTheme = context.read<ThemeApp>();
    final bitacoraController = context.read<BitacoraController>();
    final ctrlTheme = context.read<ThemeApp>();

    final _action = widget.action;
    return WillPopScope(
          onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              // final controllerMulta = context.read<MultasGuardiasContrtoller>();
          
              return AlertDialog(
                title: const Text('Aviso'),
                content: const Text('¿Desea cancelar el ingreso de la visita?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        final providerVisita = context.read<BitacoraController>();
             

                        if(providerVisita.listaVisitas.isNotEmpty){

                          //*********************//
                          // for (var item in ausenciaController.getlistaGuardiasSeleccionados) {

                          //    providerTurno.eliminaTurnoExtra(int.parse(item['turId'].toString()));
                          //   print('EL ID:${item['turId']}');
                             
                          // }
                            //  Navigator.of(context).pop(true);

                            //***************//
                                                                     List<String> urlList = [];

for (var registro in providerVisita.listaVisitas) {
  if (registro['fotoVisitante'] != null && registro['fotoVisitante'].isNotEmpty) {
    urlList.add(registro['fotoVisitante']);
  }
  if (registro['fotoCedulaFront'] != null && registro['fotoCedulaFront'].isNotEmpty) {
    urlList.add(registro['fotoCedulaFront']);
  }
  if (registro['fotoCedulaBack'] != null && registro['fotoCedulaBack'].isNotEmpty) {
    urlList.add(registro['fotoCedulaBack']);
  }
  if (registro['fotoPasaporte'] != null && registro['fotoPasaporte'].isNotEmpty) {
    urlList.add(registro['fotoPasaporte']);
  }
  if (registro['fotoPlaca'] != null && registro['fotoPlaca'].isNotEmpty) {
    urlList.add(registro['fotoPlaca']);
  }
}

print('LOS URL DE LA LISTA DE VICITANTES >>>>>> $urlList');




 ProgressDialog.show(context);
                                                  final response = await   eliminaAllUrlServer(urlList); 
                                                    ProgressDialog.dissmiss(context);
                                                        if (response) {
                                                          
                                                             providerVisita.eliminaALLItemVisitas();
                                                             NotificatiosnService.showSnackBarDanger('Registro cancelado correctamente');
                                                              Navigator.of(context).pop(true);
                                                        } else {
                                                           NotificatiosnService.showSnackBarError('Error al eliminar Registros agregados!! ');
                                                        }




              



                            //***************//


                        }
                        else{
                             Navigator.of(context).pop(true);

                        }

                      },
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                      )),
                ],
              );
            });
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            // backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              // backgroundColor: primaryColor,
              // title:  Text('Registrar Bitácora',style:  ),
    
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
              title: _action == 'CREATE'
                  ? Text(
                      'Crear Bitácora',
                      // style: Theme.of(context).textTheme.headline2,
                    )
                  : Text(
                      'Editar Bitácora',
                      // style: Theme.of(context).textTheme.headline2,
                    ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(context, bitacoraController, _action!);
                      },
                      icon: Icon(
                        Icons.save_outlined,
                        size: size.iScreen(4.0),
                      )),
                ),
              ],
            ),
            body:
           
    
                Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
              padding: EdgeInsets.all(size.iScreen(0.5)),
              child: Form
              (
                key: bitacoraController.bitacoraFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      width: size.wScreen(100.0),
                      child: Text(
                        '${_user.getUsuarioInfo!.rucempresa!}  - ${_user.getUsuarioInfo!.usuario!}',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.5),
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.iScreen(1.0)),
                   
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //***********************************************/
                          Container(
                          width: size.wScreen(100.0),
              
                          // color: Colors.blue,
                          child: Text('Residente:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
              
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.0),
                        ),
                        //***********************************************/
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                  top: size.iScreen(1.0),
                                  right: size.iScreen(0.5),
                                ),
                                child: Consumer<BitacoraController>(
                                  builder: (_, personal, __) {
                                    return (personal.getItemPersonaDestinol!['nombre'] == {} ||
                                           personal.getItemPersonaDestinol!['nombre'] == null)
                                        ? Text(
                                            'Seleccione residente',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${personal.getItemPersonaDestinol!['nombre'].replaceAll('"',"")}',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),

                            Consumer<BitacoraController>(builder: (_, values, __) { 
                              return  
                              values.listaVisitas.isEmpty
                               ?ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(onTap: () {
              final _ctrl=context.read<ResidentesController>();
                                _modalSeleccionaDestinoPersona(
                                    size, bitacoraController,_ctrl.getInfoResidente,);
                              }, child: Consumer<ThemeApp>(
                                builder: (_, valueTheme, __) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: valueTheme.primaryColor,
                                    width: size.iScreen(3.5),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: valueTheme.secondaryColor,
                                      size: size.iScreen(2.0),
                                    ),
                                  );
                                },
                              )),
                            ):Container();
                             },),
                          
                          ],
                        ),
                    //      //***********************************************/
                    //     SizedBox(
                    //       height: size.iScreen(1.0),
                    //     ),
                    //     //*****************************************/
                    // SizedBox(height: size.iScreen(1.0)),
                    // Text(
                    //   '${bitacoraController.getResidente['cliente']}',
                    //   style: GoogleFonts.lexendDeca(
                    //     fontSize: size.iScreen(1.8),
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    // // SizedBox(height: size.iScreen(1.0)),
                    // // Container(
                    // //   height: size.iScreen(1.0),
                    // //   color: Colors.grey.shade200,
                    // // ),
                      //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                       
                        //   Container(
                        //   width: size.wScreen(100.0),
              
                        //   // color: Colors.blue,
              
                        //   child: 
                        //   Consumer<BitacoraController>(builder: (_, valueDestino,__) {  
                        //       return Text('SDJHFSJDHFJK ',
                        //       style: GoogleFonts.lexendDeca(
                        //           fontSize: size.iScreen(1.8),
                        //           fontWeight: FontWeight.normal,
                        //           color: Colors.grey));
                        //   },),
                          
                        // ),
              
                    
                    SizedBox(height: size.iScreen(1.0)),
                    Row(
                      children: [
                        Text(
                          'Registrar Persona ',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: size.iScreen(2)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                            if ( bitacoraController.getItemPersonaDestinol!.isNotEmpty) {
                               bitacoraController.removeFrontBackPlacaImage();
                               bitacoraController.setCedulaOk(false);
                               bitacoraController.setDataCedula({});
                              
                                if (bitacoraController.getDataVehiculo.isNotEmpty) {
              
                                   print('LA FOTO DE LA PLACA ES ${bitacoraController.getDataVehiculo}');
                                  // bitacoraController.setUrlPlaca(bitacoraController.getDataVehiculo['fotoPlaca']);
                                }else{
                                  bitacoraController.setUrlPlaca('');
                                } 
                    
              
                    // print('LA FOTO DE LA PLACA ES ${bitacoraController.getDataVehiculo['fotoPlaca']}');
                    // bitacoraController.setNombrePropVehiculo();
                    // bitacoraController.setPlacaPropVehiculo();
                    // bitacoraController.setModeloPropVehiculo();
                   bitacoraController.setUrlVisitante('');
                  
                   bitacoraController.setCedulaVisitaBitacora('');
                   bitacoraController.setNombreVisitaBitacora('');
                 
                   bitacoraController.setUrlCedulaFront('');
                   bitacoraController.setUrlCedulaBack('');
                 
                   bitacoraController.setPasaporteVisita('');
                   bitacoraController.setUrlPasaporte('');
                   bitacoraController.setItemAsunto('');
                              
              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => AgregarVicitaBitaora(
                                        user: widget.user,
                                      )),
                                ),
                              );
                              
                            } else {
              
                               NotificatiosnService.showSnackBarDanger('Seleccione Residente');
                            }
                             
                              //  bitacoraController.removeFrontBackPlacaImage();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: ((context) => AgregarVicitaBitaora(
                              //           user: widget.user,
                              //         )),
                              //   ),
                              // );
                              
                            
                            },
                            child: Consumer<ThemeApp>(
                              builder: (_, valueTheme, __) {
                                return Container(
                                  alignment: Alignment.center,
                                  color: valueTheme.primaryColor,
                                  width: size.iScreen(4.0),
                                  height: size.iScreen(4.0),
                                  padding: EdgeInsets.all(size.iScreen(0.5)),
                                  child: Icon(
                                    Icons.person_add_alt_outlined,
                                    color: valueTheme.secondaryColor,
                                    size: size.iScreen(3.0),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.iScreen(1.0)),
                    Container(
                      height: size.iScreen(1.0),
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: size.iScreen(1.0)),
                    Expanded(
                      child: 
                      Consumer<BitacoraController>(builder: (_, valueListaVisitas, __) {  
                          return   
                          valueListaVisitas.listaVisitas.isNotEmpty
                           ?ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: valueListaVisitas.listaVisitas.length, // Número de elementos de la lista
                        itemBuilder: (context, index) {
              
                            final  registro=valueListaVisitas.listaVisitas[index];
              
                          return
                              //***********************************************/
                              // SizedBox(
                              //   height: size.iScreen(1.0),
                              // ),
                              //*****************************************/
                          //     Consumer<BitacoraController>(
                          //   builder: (_, valueListaVisitas, __) {
                          //     return 
                          
                          //   },
                          // );
                          
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(0.0),
                                        vertical: size.iScreen(0)),
                                    child: Card(
                                      elevation: 6,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.0),
                                            vertical: size.iScreen(0.0)),
                                        child: Column(
                                          children: [
                                            //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                            //*****************************************/
              
                                            Container(
                                              width: size.wScreen(100.0),
                                              child: Text('Nombre:',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
              
                                            SizedBox(
                                              height: size.iScreen(0.0),
                                            ),
                                            Container(
                                              width: size.wScreen(100.0),
                                              child: Text(
                                                  '${registro['nombreVisita']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      // color: Colors.grey
                                                      )),
                                            ),
                                          //  Container(
                                          //     width: size.wScreen(100.0),
                                          //     child: Row(
                                          //       children: [
                                          //         Text('Sexo: ',
                                          //             style: GoogleFonts.lexendDeca(
                                          //                 fontSize: size.iScreen(1.8),
                                          //                 fontWeight: FontWeight.normal,
                                          //                 color: Colors.grey)),
                                          //                   Container(
                                          //     // width: size.wScreen(100.0),
                                          //     child: Text(
                                          //         'NOMBRE',
                                          //         style: GoogleFonts.lexendDeca(
                                          //             fontSize: size.iScreen(1.8),
                                          //             fontWeight: FontWeight.normal,
                                          //             // color: Colors.grey
                                          //             )),
                                          //   ),
                                          //       ],
                                          //     ),
                                          //   ),
                                            Container(
                                              width: size.wScreen(100.0),
                                              child: Row(
                                                children: [
                                                  Text('Documento: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                            Container(
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                  '${registro['cedulaVisita']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      // color: Colors.grey
                                                      )),
                                            ),
                                                ],
                                              ),
                                            ),
              
                                          
                                          
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                                 
                                            //***********************************************/
                                          registro['fotoCedulaFront']!=''
                                            ?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                   GestureDetector(
                                                      onTap: 
                                                      // valueListaVisitas.isPicking
                                                      //     ? null
                                                      //     :
                                                           () {
                                                              // valueListaVisitas.pickFrontImage();
                                                            },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        width: size.iScreen(14.0),
                                                        height: size.iScreen(18.0),
                                                        child: 
                                                        //  valueListaVisitas.frontImage == null
                                                        //     ? Icon(
                                                        //         Icons.add_a_photo_outlined,
                                                        //         size: size.iScreen(4.0),
                                                        //       )
                                                        //     :
                                                            registro['fotoVisitante'].isNotEmpty? 
                                                            // Image.file(File(registro['fotoVisitante']))
                                                             FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoVisitante']}',
                                                                ),
                                                              )
                                                            :Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: 
                                                      // valueListaVisitas.isPicking
                                                      //     ? null
                                                      //     :
                                                           () {
                                                              // valueListaVisitas.pickFrontImage();
                                                            },
                                                      child: Container(
                                                        margin: EdgeInsets.all(size.iScreen(0.5)),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        width: size.iScreen(17.0),
                                                        height: size.iScreen(10.0),
                                                        child: 
                                                        //  valueListaVisitas.frontImage == null
                                                        //     ? Icon(
                                                        //         Icons.add_a_photo_outlined,
                                                        //         size: size.iScreen(4.0),
                                                        //       )
                                                        //     :
                                                            //  Image.file(File(registro['fotoCedula']['cedulaFront'])),
                                                            registro['fotoCedulaFront'].isNotEmpty? 
                                                              FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoCedulaFront']}',
                                                                ),
                                                              ):Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: 
                                                      // valueListaVisitas.isPicking
                                                      //     ? null
                                                      //     :
                                                           () {
                                                              // valueListaVisitas.pickBackImage();
                                                            },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        width: size.iScreen(17.0),
                                                        height: size.iScreen(10.0),
                                                        child:
                                                        // valueListaVisitas.backImage == null
                                                        //     ? Icon(
                                                        //         Icons.add_a_photo_outlined,
                                                        //         size: size.iScreen(4.0),
                                                        //       )
                                                        //     : 
                                                         registro['fotoCedulaBack'].isNotEmpty? 
                                                         FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoCedulaBack']}',
                                                                ),
                                                              ):Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                            // Image.file(File(registro['fotoCedula']['cedulaBack'])),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                            : Container(),
                                           
                                           
                                         registro['fotoPasaporte']!=''
                                            ?
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        width: size.iScreen(14.0),
                                                        height: size.iScreen(18.0),
                                                        child: 
                                                        //  valueListaVisitas.frontImage == null
                                                        //     ? Icon(
                                                        //         Icons.add_a_photo_outlined,
                                                        //         size: size.iScreen(4.0),
                                                        //       )
                                                        //     :
                                                            registro['fotoVisitante'].isNotEmpty? 
                                                            // Image.file(File(registro['fotoVisitante']))
                                                            FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoVisitante']}',
                                                                ),
                                                              )
                                                            :Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                      ),
                                                GestureDetector(
                                                  onTap: 
                                                  // valueListaVisitas.isPicking
                                                  //     ? null
                                                  //     : 
                                                      () {
                                                          // valueListaVisitas.pickFrontImage();
                                                        },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8.0),
                                                      color: Colors.grey.shade300,
                                                    ),
                                                    width: size.iScreen(18.0),
                                                    height: size.iScreen(10.0),
                                                    child:
                                                    //  valueListaVisitas.pasaporteImage == null  && valueListaVisitas.pasaporteImage==''
                                                    //     ? Icon(
                                                    //         Icons.add_a_photo_outlined,
                                                    //         size: size.iScreen(4.0),
                                                    //       )
                                                    //    : 
                                                      //  Image.file(File(registro['fotoPasaporte'])),
                                                       registro['fotoPasaporte'].isNotEmpty? 
                                                      FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoPasaporte']}',
                                                                ),
                                                              )
                                                            :Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                  ),
                                                ),
                                                
                                              ],
                                            )
                                              :Container(),
                                             //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                            //*****************************************/
                                          Container(
                                              width: size.wScreen(100.0),
                                              child: Row(
                                                children: [
                                                  Text('Vehículo: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                            Container(
                                              // width: size.wScreen(100.0),
                                              child: Text('${registro['placa']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      // color: Colors.grey
                                                      )),
                                            ),
                                            registro['vehiculo']=='NO'
                                            ?Container(
                                              // width: size.wScreen(100.0),
                                              margin: EdgeInsets.only(left: size.iScreen(5.0)),
                                              child: Text(
                                                  '${registro['vehiculo']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.bold,
                                                      // color: Colors.grey
                                                      )),
                                            )
                                            :Container(),
                                                ],
                                              ),
                                            ),
                                             SizedBox(
                                                  height: size.iScreen(1.0),
                                                ),
                                                //*****************************************/
                                          registro['modelo'].isNotEmpty
                                          ?   Column(
                                               children: [
                                                 Container(
                                                  width: size.wScreen(100.0),
                                                  child:  Text('Modelo: ',
                                                          style: GoogleFonts.lexendDeca(
                                                              fontSize: size.iScreen(1.8),
                                                              fontWeight: FontWeight.normal,
                                                              color: Colors.grey)),
                                            ),
                                              SizedBox(
                                              height: size.iScreen(0.5),
                                            ),
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('${registro['modelo']}',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          // color: Colors.grey
                                                          )),
                                            ),
                                             
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                                 
                                               ],
                                             ):Container(),
                                           
                                            //***********************************************/
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: 
                                                  // valueListaVisitas.isPicking
                                                  //     ? null
                                                  //     : 
                                                      () {
                                                          // valueListaVisitas.pickFrontImage();
                                                        },
                                                  child: 
                                                   registro['fotoPlaca']!=''
                                            ?
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8.0),
                                                      color: Colors.grey.shade300,
                                                    ),
                                                    width: size.iScreen(18.0),
                                                    height: size.iScreen(10.0),
                                                    child:
                                                    //  valueListaVisitas.placaImage == null
                                                    //     ? Icon(
                                                    //         Icons.add_a_photo_outlined,
                                                    //         size: size.iScreen(4.0),
                                                    //       )
                                                    //     :   
                                                        // Image.file(File(registro['fotoPlaca'])),
                                                          registro['fotoPlaca'].isNotEmpty? 
                                                      FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${registro['fotoPlaca']}',
                                                                ),
                                                              )
                                                            :Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover)
                                                  ):Container(),
                                                ),
                                               
                                              ],
                                            ),
                                             //***********************************************/
              
                                  registro['cedulaPropietarioVehiculo']!=''
              
                                         ?   Column(
                                              children: [
                                                SizedBox(
                                                  height: size.iScreen(1.0),
                                                ),
                                                //*****************************************/
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('Documento: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('${registro['cedulaPropietarioVehiculo']}',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          // color: Colors.grey
                                                          )),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                              //***********************************************/
                                             //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                            //*****************************************/
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('Propietario Vehiculo: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('${registro['nombrePropietarioVehiculo']}',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          // color: Colors.grey
                                                          )),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                              ],
                                            )
                                            :Container(),
                                            
                                              //***********************************************/
              
                                           
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('Observación: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.0),
                                            ),
                                             Container(
                                              width: size.wScreen(100.0),
                                              child:  Text('${registro['observacion']}',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          // color: Colors.grey
                                                          )),
                                            ),
                                             SizedBox(
                                              height: size.iScreen(1.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  
                                  
                                   Positioned(
                                                  top: 20.0,
                                                  right: 10.0,
                                                  child: 
                                                  //  valueListaVisitas.frontImage != null?
                                                  GestureDetector(
                                                    onTap: ()async {
              
                                                      // valueListaVisitas.eliminaItemVisita(registro['cedulaVisita']);
                                                      // print('LA DATA DE LA LISTA ********< $registro');
              
                                                      List<String> urlList = [];
              
                if (registro['fotoVisitante'] != null && registro['fotoVisitante'].isNotEmpty) {
                  urlList.add(registro['fotoVisitante']);
                }
                if (registro['fotoCedulaFront'] != null && registro['fotoCedulaFront'].isNotEmpty) {
                  urlList.add(registro['fotoCedulaFront']);
                }
                if (registro['fotoCedulaBack'] != null && registro['fotoCedulaBack'].isNotEmpty) {
                  urlList.add(registro['fotoCedulaBack']);
                }
                if (registro['fotoPasaporte'] != null && registro['fotoPasaporte'].isNotEmpty) {
                  urlList.add(registro['fotoPasaporte']);
                }
                if (registro['fotoPlaca'] != null && registro['fotoPlaca'].isNotEmpty) {
                  urlList.add(registro['fotoPlaca']);
                }
              
              ProgressDialog.show(context);
                                                  final response = await   eliminaAllUrlServer(urlList); 
                                                    ProgressDialog.dissmiss(context);
                                                        if (response) {
                                                          
                                                             valueListaVisitas.eliminaItemVisita(registro['cedulaVisita']);
                                                             NotificatiosnService.showSnackBarDanger('Registro eliminado correctamente');
                                                        } else {
                                                           NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                                        }
                
                                                 
                                                    
                                                    
                                                    },
                                                    child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,))
                                                    // : Container()
                                                    )
                                ],
                              );
                          
                          
              
                          //   //***********************************************/
                          // SizedBox(
                          //   height: size.iScreen(1.0),
                          // ),
                          // //*****************************************/
                        },
                      )
                      :NoData(label: 'Agregar Persona');
                   
                      },),
                   
                   
                    ),
                  //    ***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),
                          child: Text('Observaciones:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(),
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                RegExp(r'^[^\n"]*$')),
                            UpperCaseText(),
                          ],
                          onChanged: (text) {
                            bitacoraController.setItemObservacion(text);
                          },
                          // validator: (text) {
                          //   if (text!.trim().isNotEmpty) {
                          //     return null;
                          //   } else {
                          //     return 'Ingrese Observación';
                          //   }
                          // },
                        ),
                               //***********************************************/
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
              //                     //*****************************************/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, BitacoraController _controller,
      String _action) async {
//  ProgressDialog.show(context);
//         //  final response= _controller.enviarImagenesAlServidor();

//       ProgressDialog.dissmiss(context);

    // print('la respuesta es: $response.');

    final isValid = _controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      // if (_controller.getItemTipoPersonal == '' ||
      //     _controller.getItemTipoPersonal == null) {
      //   NotificatiosnService.showSnackBarDanger('Seleccione tipo de Persona');
      // } else if (_controller.getItemSeDirigeA == '' ||
      //     _controller.getItemSeDirigeA == null) {
      //   NotificatiosnService.showSnackBarDanger('Seleccione donde se dirige');
      // } else if (_controller.getItemCedula!.length > 10 ||
      //     _controller.getItemCedula!.length < 10) {
      //   NotificatiosnService.showSnackBarDanger('Ingrese cédula correcta');
      // } else if (_controller.getItemAutorizadoPor == '' ||
      //     _controller.getItemAutorizadoPor == null) {
      //   NotificatiosnService.showSnackBarDanger('Seleccione quién autoriza');
      // } else if (_controller.getItemTelefono!.length < 9 ||
      //     _controller.getItemTelefono!.length > 10) {
      //   NotificatiosnService.showSnackBarDanger(
      //       'Numero de teléfono incorrecto');
      // } else if (_action == 'CREATE') {
      //   String _persona = '';
      //   if (widget.user!.rol!.contains('GUARDIA')) {
      //     _persona = "GUARDIA";
      //     await _controller.enviarImagenesAlServidor(context, _persona);
      //   } else if (widget.user!.rol!.contains('RESIDENTE')) {
      //     _persona = "RESIDENTE";
      //     await _controller.enviarImagenesAlServidor(context, _persona);
      //   }

            await _controller.creaBitacoraVisitante(context);
      //  print('LA DATA PARA EL SOCKET: ${_controller.listaVisitas}');

        Navigator.pop(context);
        Navigator.pop(context);
      // }

    }
  }

  //====== MUESTRA MODAL DE SEDIRIGE A =======//
  void _modalSeleccionaSeDirigeA(Responsive size, BitacoraController _control) {
    final _data = [
      'PERSONAL PROPIO',
      'VISITANTES',
      'CONTRATISTA',
      'PROVEEDORES',
    ];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' SE DIRIGE A:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
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
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _control.setItemSeDirigeA(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE AUTORIZADO POR  =======//
  void _modalSeleccionaAutorizadoPor(
      Responsive size, BitacoraController _control, List _data) {
// final  _data=[ 'PERSONAL PROPIO',
//                       'VISITANTES',
//                       'CONTRATISTA',
//                       'PROVEEDORES',
//                       ];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' AUTORIZADO POR:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
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
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      // itemCount: _control.getInfoBitacora['resPersonasAutorizadas'].length,
                      itemBuilder: (BuildContext context, int index) {
                        ;
                        return GestureDetector(
                          onTap: () {
                            _control.setItemAutorizadoPor(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  void _modalSeleccionaTipoPersona(
      Responsive size, BitacoraController _control) {
    final _data = [
      'PERSONAL PROPIO',
      'VISITANTES',
      'CONTRATISTA',
      'PROVEEDORES',
    ];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' TIPO DE PERSONA',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
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
                    height: size.hScreen(24),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _control.setItemTipoPersona(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  void _modalSeleccionaDestinoPersona(Responsive size, BitacoraController _control, Map data) {
 List<Map<String,dynamic>> _data=[];
 
 data['resCedulaPropietario']!=null
 ?
     _data = [
    {
      "tipo":"PROPIETARIO",
       "id":data['resPerIdPropietario'],
      "cedula":data['resCedulaPropietario'],
      "nombre":data['resNombrePropietario'],  
    },
    {
      "tipo":"ARRENDATARIO",
       "id":data['resPerId'],
      "cedula":data['resCedula'],
      "nombre":data['resNombres'],  
    },

    ]
    :_data = [ {
      "tipo":"ARRENDATARIO",
      "id":data['resPerId'],
      "cedula":data['resCedula'],
      "nombre":data['resNombres'],  
    }, ];

  
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' SELECCIONE RESIDENTE',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
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
                    height: size.hScreen(12),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _control.setItemPersonaDestino(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                             '${ _data[index]['nombre'].replaceAll('"','')}',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const BouncingScrollPhysics(),
                    //   itemCount: _data.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         _control.setItemPersonaDestino(_data[index]);
                    //         Navigator.pop(context);
                    //       },
                    //       child: Container(
                    //         color: Colors.grey[100],
                    //         margin: EdgeInsets.symmetric(
                    //             vertical: size.iScreen(0.3)),
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: size.iScreen(1.0),
                    //             vertical: size.iScreen(1.0)),
                    //         child: Text(
                    //           _data[index],
                    //           style: GoogleFonts.lexendDeca(
                    //             fontSize: size.iScreen(1.8),
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black54,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  // ),
                ],
              ),
            ),
          );
        });
  }



}
