

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';
import 'package:nseguridad/src/utils/correos.dart';
import 'package:nseguridad/src/utils/foto_url.dart';
import 'package:nseguridad/src/utils/sizeApp.dart';
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

class AgregarVicitaBitaora extends StatefulWidget {
 
  final Session? user;
  const AgregarVicitaBitaora({Key? key,  this.user}) : super(key: key);

  @override
  State<AgregarVicitaBitaora> createState() => _AgregarVicitaBitaoraState();
}

class _AgregarVicitaBitaoraState extends State<AgregarVicitaBitaora> {

   TextEditingController _controllerTextCedula= TextEditingController ();



   
  //  TextEditingController _controllerTextCedula =TextEditingController();

  // late TextEditingController _controllerTextCedula;

  // @override
  // void initState() {
  //   super.initState();
  //   _controllerTextCedula = TextEditingController();
  //   _controllerTextCedula.addListener(() {
  //     // No usar `setState` aquí para evitar el error
  //     Provider.of<BitacoraController>(context, listen: false)
  //         .setCedulaVerificar(_controllerTextCedula.text);
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Retrasar la sincronización del controlador
  //   Future.delayed(Duration(milliseconds: 1), () {
  //     final provider = context.read<BitacoraController>();
  //     if (_controllerTextCedula.text != provider.getCedulas) {
  //       _controllerTextCedula.text = provider.getCedulas;
  //       _controllerTextCedula.selection = TextSelection.fromPosition(
  //         TextPosition(offset: _controllerTextCedula.text.length),
  //       );
  //     }
  //   });
  // }
  // late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final textProvider = Provider.of<BitacoraController>(context);
  //   _controller.text = textProvider.getCedulas;
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  //  late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final textProvider = Provider.of<BitacoraController>(context);
  //   if (_controller.text != textProvider.getCedulas) {
  //     _controller.text = textProvider.getCedulas;
  //   }
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
     final _ctrlTheme=context.read<ThemeApp>();
    final ctrResidente = context.read<ResidentesController>();
      final bitacoraController = context.read<BitacoraController>();
      final ctrlTheme = context.read<ThemeApp>();

        final screenSize = ScreenSize(context); 




     return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.grey.shade50,
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
            title:  Text(
                    'Registrar Visita',
                    // style: Theme.of(context).textTheme.headline2,
                  ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, bitacoraController);
                    },
                    icon: Icon(
                      Icons.save,
                      size: size.iScreen(4.0),
                    )),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
            padding: EdgeInsets.only(
              top: size.iScreen(0.5),
              left: size.iScreen(0.5),
              right: size.iScreen(0.5),
              bottom: size.iScreen(0.5),
            ),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: bitacoraController.bitacoraRegistroFormKey,
                child: Column(
                  children: [
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
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    // Container(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('Residente:',
                    //       style: GoogleFonts.lexendDeca(
                    //           fontSize: size.iScreen(1.8),
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey)),
                    // ),

                   
             
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/

                    // Container(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('${ctrResidente.getInfoResidente['resNombres']}',
                    //       style: GoogleFonts.lexendDeca(
                    //           fontSize: size.iScreen(1.8),
                    //           fontWeight: FontWeight.normal,
                    //           // color: Colors.grey
                    //           )),
                    // ),

                   
                      //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),
                      height: size.iScreen(1.0),

                      color: Colors.grey.shade200,
                      // child: Text('PERSONAL:',
                      //     style: GoogleFonts.lexendDeca(
                      //         fontSize: size.iScreen(1.8),
                      //         fontWeight: FontWeight.normal,
                      //         color: Colors.grey)),
                    ),
                        //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    // //***********************************************/
                    // Container(
                    //     // color: Colors.green,
                    //   margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                    //    padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                    //   child: Card(
                    //     child: Container(
                    //          padding: EdgeInsets.only(left: size.iScreen(1.0),right: size.iScreen(1.0),bottom: size.iScreen(1.0)),
                    //       child: Column(
                    //         children: [
                    //            SizedBox(
                    //       height: size.iScreen(1.0),
                    //   ),
                    //   //***********************************************/
                    //       Container(
                          
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: Text('Tipo Persona:',
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               fontWeight: FontWeight.normal,
                    //               color: Colors.grey)),
                    //   ),

                    //   //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(0.0),
                    // ),
                    // //***********************************************/
                    // Row(
                    //   children: [
                    //       Expanded(
                    //         child: Container(
                    //           // color: Colors.red,
                    //           padding: EdgeInsets.only(
                    //             top: size.iScreen(1.0),
                    //             right: size.iScreen(0.5),
                    //           ),
                    //           child: Consumer<BitacoraController>(
                    //             builder: (_, personal, __) {
                    //               return (personal.getItemTipoPersonal == '' ||
                    //                       personal.getItemTipoPersonal == null)
                    //                   ? Text(
                    //                       'Seleccione tipo de persona',
                    //                       style: GoogleFonts.lexendDeca(
                    //                           fontSize: size.iScreen(1.8),
                    //                           fontWeight: FontWeight.bold,
                    //                           color: Colors.grey),
                    //                     )
                    //                   : Text(
                    //                       '${personal.getItemTipoPersonal}',
                    //                       style: GoogleFonts.lexendDeca(
                    //                         fontSize: size.iScreen(1.8),
                    //                         fontWeight: FontWeight.normal,
                    //                         // color: Colors.grey
                    //                       ),
                    //                     );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       ClipRRect(
                    //         borderRadius: BorderRadius.circular(8),
                    //         child: GestureDetector(onTap: () {
                    //           _modalSeleccionaTipoPersona(
                    //               size, bitacoraController);
                    //         }, child: Consumer<ThemeApp>(
                    //           builder: (_, valueTheme, __) {
                    //             return Container(
                    //               alignment: Alignment.center,
                    //               color: valueTheme.primaryColor,
                    //               width: size.iScreen(3.5),
                    //               padding: EdgeInsets.only(
                    //                 top: size.iScreen(0.5),
                    //                 bottom: size.iScreen(0.5),
                    //                 left: size.iScreen(0.5),
                    //                 right: size.iScreen(0.5),
                    //               ),
                    //               child: Icon(
                    //                 Icons.add,
                    //                 color: valueTheme.secondaryColor,
                    //                 size: size.iScreen(2.0),
                    //               ),
                    //             );
                    //           },
                    //         )),
                    //       ),
                    //   ],
                    // ),
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(0.0),
                    // ),
                    // //*****************************************/
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    
                  
                    
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
                                return Text(
                                        personal.getItemPersonaDestinol!.isNotEmpty?'${personal.getItemPersonaDestinol!['nombre'].replaceAll('"',"")}':'Seleccione Residente',
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
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(onTap: () {
                        //     _modalSeleccionaDestinoPersona(
                        //         size, bitacoraController);
                        //   }, child: Consumer<ThemeApp>(
                        //     builder: (_, valueTheme, __) {
                        //       return Container(
                        //         alignment: Alignment.center,
                        //         color: valueTheme.primaryColor,
                        //         width: size.iScreen(3.5),
                        //         padding: EdgeInsets.only(
                        //           top: size.iScreen(0.5),
                        //           bottom: size.iScreen(0.5),
                        //           left: size.iScreen(0.5),
                        //           right: size.iScreen(0.5),
                        //         ),
                        //         child: Icon(
                        //           Icons.add,
                        //           color: valueTheme.secondaryColor,
                        //           size: size.iScreen(2.0),
                        //         ),
                        //       );
                        //     },
                        //   )),
                        // ),
                      ],
                    ),
                    //  //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                   
                    //   Container(
                    //   width: size.wScreen(100.0),

                    //   // color: Colors.blue,
                    //   child: Text('',
                    //       style: GoogleFonts.lexendDeca(
                    //           fontSize: size.iScreen(1.8),
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey)),
                    // ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //***********************************************/
                      //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),
                      height: size.iScreen(1.0),

                      color: Colors.grey.shade200,
                      // child: Text('PERSONAL:',
                      //     style: GoogleFonts.lexendDeca(
                      //         fontSize: size.iScreen(1.8),
                      //         fontWeight: FontWeight.normal,
                      //         color: Colors.grey)),
                    ),
                     
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //***********************************************/
                      Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Tipo de Ingreso:',
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         // color: Colors.red,
                    //         padding: EdgeInsets.only(
                    //           top: size.iScreen(1.0),
                    //           right: size.iScreen(0.5),
                    //         ),
                    //         child: Consumer<BitacoraController>(
                    //           builder: (_, ingreso, __) {
                    //             return (ingreso.getItemTipoIngreso == '' ||
                    //                     ingreso.getItemTipoIngreso == null)
                    //                 ? Text(
                    //                     'Seleccione tipo de ingreso',
                    //                     style: GoogleFonts.lexendDeca(
                    //                         fontSize: size.iScreen(1.8),
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.grey),
                    //                   )
                    //                 : Text(
                    //                     '${ingreso.getItemTipoIngreso}',
                    //                     style: GoogleFonts.lexendDeca(
                    //                       fontSize: size.iScreen(1.8),
                    //                       fontWeight: FontWeight.normal,
                    //                       // color: Colors.grey
                    //                     ),
                    //                   );
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: GestureDetector(onTap: () {
                    //         _modalSeleccionaTipoIngreso(
                    //             size, bitacoraController);
                    //       }, child: Consumer<ThemeApp>(
                    //         builder: (_, valueTheme, __) {
                    //           return Container(
                    //             alignment: Alignment.center,
                    //             color: valueTheme.primaryColor,
                    //             width: size.iScreen(3.5),
                    //             padding: EdgeInsets.only(
                    //               top: size.iScreen(0.5),
                    //               bottom: size.iScreen(0.5),
                    //               left: size.iScreen(0.5),
                    //               right: size.iScreen(0.5),
                    //             ),
                    //             child: Icon(
                    //               Icons.add,
                    //               color: valueTheme.secondaryColor,
                    //               size: size.iScreen(2.0),
                    //             ),
                    //           );
                    //         },
                    //       )),
                    //     ),
                    //   ],
                    // ),
                   
                    Row(
                      children: [
                            Container(
                              // width: size.wScreen(30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Consumer<BitacoraController>(
                                    builder: (_, valueRadioIngreso, __) {
                                      return Container(
                                        // color: Colors.red,
                                        width: size.wScreen(95.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  // width: size.wScreen(20.0),
                                                  child: Text('RECEPCION',
                                                      style: GoogleFonts.lexendDeca(
                                                         fontSize: size.iScreen(1.8),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          // color: Colors.grey
                                                          ),
                                                      textAlign: TextAlign.center),
                                                ),
                                                   Radio<int>(
                                              activeColor:
                                                  Colors.orange.shade700,
                                              value: 0,
                                              groupValue: valueRadioIngreso
                                                  .radioValueTipoIngreso,
                                              onChanged:
                                                  (int? value) {
                                                          if (value != null) {
                                                            valueRadioIngreso
                                                                .setRadioTipoIngreso(
                                                                    value);
                                                          }
                                                        }
                                                    
                                            ),
                                              ],
                                            ),
                                         
                                            Row(
                                              children: [
                                                SizedBox(
                                                  // width: size.wScreen(20.0),
                                                  child: Text('PARQUEADERO',
                                                      style: GoogleFonts.lexendDeca(
                                                         fontSize: size.iScreen(1.8),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          // color: Colors.grey
                                                          ),
                                                      textAlign: TextAlign.center),
                                                ),
                                                   Radio<int>(
                                              activeColor:
                                                  Colors.orange.shade700,
                                              value: 1,
                                              groupValue: valueRadioIngreso
                                                  .radioValueTipoIngreso,
                                              onChanged:
                                                
                                                    valueRadioIngreso.getDataVehiculo.isEmpty?   (int? value) {
                                                          if (value != null) {
                                                          valueRadioIngreso.setIsValidate(2)  ;
                                                            valueRadioIngreso
                                                                .setRadioTipoIngreso(
                                                                    value);
                                                          }
                                                        }:null
                                                      
                                            ),
                                              ],
                                            ),
                                         
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          
                      ],
                    ),
                   
                   
                   
                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                   
                    //***********************************************/
                      Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Tipo Persona:',
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
                                return (personal.getItemTipoPersonal == '' ||
                                        personal.getItemTipoPersonal == null)
                                    ? Text(
                                        'Seleccione tipo de persona',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    : Text(
                                        '${personal.getItemTipoPersonal}',
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(onTap: () {
                            _modalSeleccionaTipoPersona(
                                size, bitacoraController, screenSize);
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
                        ),
                      ],
                    ),
                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                   
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Asunto:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      // minLines: 1,
                      // maxLines: 3,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style:  TextStyle(fontSize: size.iScreen(2.0),),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                            RegExp(r'^[^\n"]*$')),
                        UpperCaseText(),
                      ],
                      onChanged: (text) {
                        bitacoraController.setItemAsunto(text);
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
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                  Consumer<BitacoraController>(builder: (_, value, __) {  
                    return 
                    value.radioValueTipoIngreso==1
                   ? Column(
                      children: [
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Documento:',
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
                                return (personal.getItemTipoDocumento == '' ||
                                        personal.getItemTipoDocumento == null)
                                    ? Text(
                                        'Seleccione tipo de documento',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    : Text(
                                        '${personal.getItemTipoDocumento}',
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(onTap: () {
                           _modalSeleccionaTipoDocumento(
                                size, bitacoraController,screenSize);
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
                        ),
                      ],
                    ),
                   
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    //  Container(
                    //       width: size.wScreen(100.0),

                    //       // color: Colors.blue,
                    //       child: 
                    //       Consumer<BitacoraController>(builder: (_, values, __) { 
                    //           return values.getItemTipoDocumento!.isNotEmpty
                    //           ? Row(
                    //             children: [
                    //               Text('Foto de ',
                    //               style: GoogleFonts.lexendDeca(
                    //                   fontSize: size.iScreen(1.8),
                    //                   fontWeight: FontWeight.normal,
                    //                   color: Colors.grey)),
                    //                   Text(' ${values.getItemTipoDocumento} :',
                    //               style: GoogleFonts.lexendDeca(
                    //                   fontSize: size.iScreen(1.8),
                    //                   fontWeight: FontWeight.normal,
                    //                   // color: Colors.grey
                    //                   )),
                    //             ],
                    //           )
                    //               : Container();
                    //        },),
                          
                    //     ),
            // SizedBox(
            //           height: size.iScreen(1.0),
            //         ),



Consumer<BitacoraController>(builder: (_, valueDoc, __) {  

                

                      return 

                   
    valueDoc.getItemTipoDocumento=='CEDULA' || valueDoc.getItemTipoDocumento=='PASAPORTE'                   
?Container(
  margin:EdgeInsets.only(top:size.iScreen(1.0)),
  child:   Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: size.iScreen(1.0)),
      Container(
        // Añadir borde
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Color del borde
          borderRadius: BorderRadius.circular(8.0), // Radio del borde
        ),
        width: size.wScreen(80.0), // Ajustar el ancho según sea necesario
        child: Row(
          children: [
            Container(
              color: Colors.amber,
              width: size.iScreen(1.0)), 
            // Espaciado entre el texto y el campo de texto
            Text(
              '${valueDoc.getItemTipoDocumento!.toLowerCase()}:',
              style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                height: size.iScreen(5.0), // Ajustar la altura de la caja de texto
                child: 
                
                  Consumer<BitacoraController>(
            builder: (context, providers, child) {
              //  _controllerTextCedula.text = providers.getCedulas;
              return

                TextFormField(
                  controller: providers.getControllerCedula,
                  // initialValue:providers.getCedulas,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remover el borde por defecto
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Ajustar el padding vertical
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.iScreen(2.5)),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (text) {
                    providers.setCedulaVerificar(text);
                  },
                );
            }),


                
              ),
            ),
            IconButton(
              icon: Icon(Icons.search), // Icono del botón de búsqueda
              onPressed: valueDoc.getCedulas.isNotEmpty?
              () async{

                 bool existeCedula = valueDoc.verificarCedulaVisita();
                // print('LA CEDULA ES: ${valueDoc.listaVisitas[0]['cedulaVisita']}');
                print('LA CEDULA ES: ${existeCedula}');

                            
                            if (existeCedula) {
                              NotificatiosnService.showSnackBarDanger('Visitantante ya registrado');
                            } else {
                              valueDoc.setIsValidate(1);
                               ProgressDialog.show(context);
                            final response = await valueDoc.getCedulaVisitas(valueDoc.getCedulas);
                            ProgressDialog.dissmiss(context);
                            if (response!=null) {
                               valueDoc.setIsValidate(2);
                               NotificatiosnService.showSnackBarSuccsses('Datos Correctos');
                               valueDoc.setCedulaOk(false);
                            } else {
                              valueDoc.setDataCedula({});
                              valueDoc.setTextCedulaIngresoVisita(valueDoc.getCedulas);
                               valueDoc.setCedulaOk(true);
                                valueDoc.setIsValidate(1);
                                // NotificatiosnService.showSnackBarDanger('No Incorrectos');
                            }

                            }
                            
                           


                        }:null
            ),
            SizedBox(width: 8.0), // Espaciado entre el campo de texto y el botón
          ],
        ),
      ),
    ],
  ))
  :Container();

                      
                       }),
Consumer<BitacoraController>( builder: (_, value, __) { 

  return 
  value.getIsValidate==1
  ?
  Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
 SizedBox(
  height: size.iScreen(1.0),
),

 Text(
        'Validando Documento, por favor espere ...  ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(1.8),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: size.iScreen(1.0)), // Espacio entre el texto y el indicador
      CircularProgressIndicator(
        color: ctrlTheme.secondaryColor,
        strokeWidth : 3.0), 
                  ]):Container();
 },),

   

                           //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/

            //         //*****************************************/


                   
                      
  


                           Consumer<BitacoraController>(builder: (_, valuesNomCed, __) { 
                              return 
                            // valuesNomCed.getCedulaOK==false &&valuesNomCed.getDataCedula.isNotEmpty
                            // valuesNomCed.getIsValidate==false && valuesNomCed.getDataCedula.isNotEmpty
                          valuesNomCed.getIsValidate==2 
                         
                                                ? Column(
                          children: [
                   //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Visitante:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                           //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      // child: Text(valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${valuesNomCed.getExtractedDataCedulaA['APELLIDOS']} ${valuesNomCed.getExtractedDataCedulaA['NOMBRES']}':'--- --- --- ---',
                      child:  Text( valuesNomCed.getNombreVisitantes.isNotEmpty ?' ${valuesNomCed.getNombreVisitantes}':'--- --- --- ---',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey
                              ),
                             ),
                    ),
                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/


                    Row(
                      children: [
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: Text('Cédula:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: 
                          
                          //  Text( valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${removeNULCedula('${valuesNomCed.getExtractedDataCedulaA['NUL']}')}':'--- --- --- ---',
                            Text( valuesNomCed.getDataCedula.isNotEmpty ?' ${valuesNomCed.getDataCedula['perDocNumero']}':'--- --- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                  )),
                        ),
                   
                      ],
                    ),
                    
                          ],
                        ):Container();
  
                           },),
                   
                       //***********************************************/

 Consumer<BitacoraController>(builder: (_, value, __) { 
return //value.getCedulaOK==true && value.getDataCedula.isEmpty 
//  value.getCedulaOK==true && value.getDataCedula.isEmpty
//  value.getIsValidate==1 
 value.getIsValidate==0 
?Column( children: [
  Container(
    padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
    color: Colors.grey.shade200,
    width: size.wScreen(100.0),
    child: Text(
              'INGRESE DATOS DEL VISITANTE',
              style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
  ),
          SizedBox(height: size.iScreen(1.0)),
  SizedBox(
                      height: size.iScreen(1.0)
                    ),
                    //*****************************************/
                   
                  Container(
  width: size.wScreen(100.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Documento :',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(1.8),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: size.iScreen(1.0), ),
      SizedBox(
       width: size.wScreen(45.0),
        child: 
                Consumer<BitacoraController>(
            builder: (context, providers, child) {
              //  _controllerTextCedula.text = providers.getCedulas;
              return

            //     TextFormField(
            //       controller: providers.getControllerCedula,
            //       // initialValue:providers.getCedulas,
            //       decoration: const InputDecoration(
            //         border: InputBorder.none, // Remover el borde por defecto
            //         contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Ajustar el padding vertical
            //       ),
            //       textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: size.iScreen(2.5)),
            //       textInputAction: TextInputAction.done,
            //       keyboardType: TextInputType.number,
            //       inputFormatters: <TextInputFormatter>[
            //         FilteringTextInputFormatter.digitsOnly,
            //       ],
            //       onChanged: (text) {
            //         providers.setCedulaVerificar(text);
            //       },
            //     );
            // }),
        
        TextFormField(
         controller: providers.getControllerCedulaIngresoVisita,
          decoration: const InputDecoration(),
          textAlign: TextAlign.center,
          style:  TextStyle(fontSize: size.iScreen(2.5),),
          textInputAction: TextInputAction.done,
           keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (text) {
            value.setCedulaVisitantes(text);
          },
        );
        }),
      ),
    ],
  ),
),
  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                   
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Nombres:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style:  TextStyle(fontSize: size.iScreen(2.5),),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                            RegExp(r'^[^\n"]*$')),
                        UpperCaseText(),
                      ],
                      onChanged: (text) {
                        value.setNombreVisitantes(text);
                      },
                      // validator: (text) {
                      //   if (text!.trim().isNotEmpty) {
                      //     return null;
                      //   } else {
                      //     return 'Ingrese Observación';
                      //   }
                      // },
                    ),

                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                  
                    // //*****************************************/
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                  
                    // //*****************************************/

                     //*/*/*/*/*/*asdads

 ],):Container();
        

  },),
  
  
  //  //***********************************************/
  //                   SizedBox(
  //                     height: size.iScreen(1.0),
  //                   ),
  //                   //*****************************************/
  //                   Consumer<BitacoraController>(builder: (_, valueDoc, __) {  
  //                     return  Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         GestureDetector(
  //                           onTap:  valueDoc.isPicking ? null :() {
  //                             valueDoc.pickFrontImage();
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
  //                             width: size.iScreen(18.0),
  //                              height: size.iScreen(10.0),
                             
  //                             child: valueDoc.frontImage == null
  //                                          ?  Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),)
  //                                          : Image.file(File(valueDoc.frontImage!.path)),),
  //                         ),
  //                         GestureDetector(
  //                           onTap:  valueDoc.isPicking ? null :() {
  //                             valueDoc.pickBackImage();
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
  //                             width: size.iScreen(18.0),
  //                              height: size.iScreen(10.0),
                             
  //                             child: valueDoc.backImage == null
  //                                          ?  Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),)
  //                                          : Image.file(File(valueDoc.backImage!.path)),),
  //                         ),   
  //                       ],
  //                     );
  //                   },),
                     


                      //***********************************************/
                                  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                        //      Container(
                        //       alignment: Alignment.centerLeft,
                        //        child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: GestureDetector(onTap: () {
                        //    bitacoraController.setIsFotoVisita(!bitacoraController.getIsFotoVisita);
                        //   }, child: Consumer<ThemeApp>(
                        //     builder: (_, valueTheme, __) {
                        //         return Container(
                        //           alignment: Alignment.center,
                        //           color: valueTheme.primaryColor,
                        //           width: size.iScreen(4.0),
                        //            height: size.iScreen(4.0),
                        //           padding: EdgeInsets.only(
                        //             top: size.iScreen(0.5),
                        //             bottom: size.iScreen(0.5),
                        //             left: size.iScreen(0.5),
                        //             right: size.iScreen(0.5),
                        //           ),
                        //           child: Icon(
                        //             Icons.camera_front_outlined,
                        //             color: valueTheme.secondaryColor,
                        //             size: size.iScreen(2.0),
                        //           ),
                        //         );
                        //     },
                        //   )),
                        // ),
                        //      ),

        

 Consumer<BitacoraController>(builder: (_, valueIsFoto, __) { 
                              return  
                              valueIsFoto.visitanteImage != null?
                               Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade400,),
                                width: size.iScreen(25.0),
                                 height: size.iScreen(25.0),
                               
                                child: 
                                valueIsFoto.visitanteImage == null
                                             ?  
                                            
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.camera_front_outlined,size: size.iScreen(4.0),),
                                                  Text(
                                        'Tomar foto Visitante',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.grey
                                        ),
                                      ),
                                                ],
                                              )
                                             : 
                                            //  valueIsFoto.getUrlVisitante.isNotEmpty
                                            //  ?
                                            //  FadeInImage(
                                            //                 placeholder:
                                            //                     const AssetImage(
                                            //                           'assets/imgs/loader.gif'),
                                            //                 image: NetworkImage(
                                            //                   '${valueIsFoto.getUrlVisitante}',
                                            //                 ),
                                            //               )
                                            //               : Image.asset('assets/imgs/loader.gif'),),
                                             
                                              Image.file(File(valueIsFoto.visitanteImage!.path),),),
                                          
                                             Positioned(
                                              top: 8.0,
                                              right: 2.0,
                                              child: 
                                              //  valueIsFoto.getUrlVisitante.isNotEmpty?
                                               valueIsFoto.visitanteImage != null?
                                              GestureDetector(
                                                onTap: () async {
                                              //      ProgressDialog.show(context);
                                              // final response = await eliminaUrlServer(valueIsFoto.getUrlVisitante);
                                              //   ProgressDialog.dissmiss(context);
                                              //       if (response) {
                                              //          valueIsFoto.removeVisitanteImage();
                                              //          valueIsFoto.setUrlVisitante('');
                                              //            NotificatiosnService.showSnackBarDanger('Foto eliminada correctamente');
                                              //       } else {
                                              //          NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                              //       }
                                                valueIsFoto.removeVisitanteImage();
                                                
                                                },
                                                child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,)): Container())
                            ],
                          ):Container();

                              },),

//  //***********************************************/
//                     SizedBox(
//                       height: size.iScreen(1.0),
//                     ),
//                     //*****************************************/


                    
       
                    Consumer<BitacoraController>(builder: (_, valueDoc, __) {  
                      return  
                      valueDoc.getItemTipoDocumento=='PASAPORTE'
                     ? Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
                                width: size.iScreen(40.0),
                                 height: size.iScreen(25.0),
                               
                                child: valueDoc.pasaporteImage == null
                                             ?  GestureDetector(
                                               onTap:  valueDoc.isPicking ? null :() {
                            valueDoc.pickPasaporteImage(context);
                          },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),),
                                                  Text(
                                        'Tomar foto del pasaporte',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.grey
                                        ),
                                      ),
                                                ],
                                              ))
                                             : 
                                            //  valueDoc.getUrlPasaporte.isNotEmpty
                                            //  ?
                                            //  FadeInImage(
                                            //                 placeholder:
                                            //                     const AssetImage(
                                            //                           'assets/imgs/loader.gif'),
                                            //                 image: NetworkImage(
                                            //                   '${valueDoc.getUrlPasaporte}',
                                            //                 ),
                                            //               )
                                            //               : Image.asset('assets/imgs/loader.gif'),),
                                             
                                             Image.file(File(valueDoc.pasaporteImage!.path)),),
                                          
                                             Positioned(
                                              top: 8.0,
                                              right: 2.0,
                                              child: 
                                              //  valueDoc.getUrlPasaporte.isNotEmpty?
                                              valueDoc.pasaporteImage!=null?
                                              GestureDetector(
                                                onTap: ()async{
                                              //     ProgressDialog.show(context);
                                              // final response = await eliminaUrlServer(valueDoc.getUrlPasaporte);
                                              //   ProgressDialog.dissmiss(context);
                                              //       if (response) {
                                                      
                                              //           valueDoc.removePasaporteImage();
                                              //          valueDoc.setUrlPasaporte('');
                                              //            NotificatiosnService.showSnackBarDanger('Foto eliminada correctamente');
                                              //       } else {
                                              //          NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                              //       }
                                                  valueDoc.removePasaporteImage();
                                                   valueDoc.setDataCedula({});
                                              //  valueDoc.removeFrontImage();
                                                  valueDoc.resetIsValidate();
                                                },
                                                child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,)): Container())
                            ],
                          )


                      : valueDoc.getItemTipoDocumento=='CEDULA'
                     ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                    //         //*************FOTO VISITANTE***************
                    //          //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/
                    //          Container(
                    //           alignment: Alignment.centerLeft,
                    //            child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: GestureDetector(onTap: () {
                    //        valueDoc.setIsFotoVisita(!valueDoc.getIsFotoVisita);
                    //       }, child: Consumer<ThemeApp>(
                    //         builder: (_, valueTheme, __) {
                    //             return Container(
                    //               alignment: Alignment.center,
                    //               color: valueTheme.primaryColor,
                    //               width: size.iScreen(4.0),
                    //                height: size.iScreen(4.0),
                    //               padding: EdgeInsets.only(
                    //                 top: size.iScreen(0.5),
                    //                 bottom: size.iScreen(0.5),
                    //                 left: size.iScreen(0.5),
                    //                 right: size.iScreen(0.5),
                    //               ),
                    //               child: Icon(
                    //                 Icons.camera_front_outlined,
                    //                 color: valueTheme.secondaryColor,
                    //                 size: size.iScreen(2.0),
                    //               ),
                    //             );
                    //         },
                    //       )),
                    //     ),
                    //          ),

                            
                             
                          /**************************/
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
                                width: size.iScreen(40.0),
                                 height: size.iScreen(25.0),
                               
                                child: valueDoc.frontImage == null
                                             ?  GestureDetector(
                                               onTap:  valueDoc.isPicking ? null :() async{

                            valueDoc.pickFrontImage(context);

                          //   // if (valueDoc.frontImage == null) {
                          //         if (valueDoc.getCedulas.isNotEmpty) {

                          //           print('esta es la cedula : ${valueDoc.getCedulas}');
                                    //  ProgressDialog.show(context);
                          // // await valueDoc.getCedulaVisitante(valueDoc.getCedulas);
                          // //  ProgressDialog.dissmiss(context);
                          //         } else {

                          //         }
                               
                          //   // } else {
                          //   // }
                        // if (valueDoc.getCedulas.isNotEmpty) {

                        //    print('SI HAY IMAGEN : ${valueDoc.getCedulas}');


                        // }
                        // else{
                        //    print('NOOOOOOOOO HAY IMAGEN : ${valueDoc.getCedulas}');
                        // }

         
          // // print('Respuesta del login: $response');

          
                                  // if (valueDoc.isLoading) {
                                  //     

                                  //     print('SI SE PUEDE ${valueDoc.getDataCedula}');
                                    
                                  // } else {
                                  // }




                          },


            

                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),),
                                                  Text(
                                        'Tomar foto parte frontal de la cédula horizontalmente',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.grey
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                                ],
                                              ))
                                             : 
                                            //   valueDoc.getUrlCedulaFront.isNotEmpty
                                            //  ?
                                            // //  FadeInImage(
                                            // //                 placeholder:
                                            // //                     const AssetImage(
                                            // //                           'assets/imgs/loader.gif'),
                                            // //                 image: NetworkImage(
                                            // //                   '${valueDoc.getUrlCedulaFront}',
                                            // //                 ),
                                            // //               )
                                            // //               : Image.asset('assets/imgs/loader.gif'),),

                                              // valueDoc.getUrlCedulaFront.isNotEmpty
                                            //  ?
                                             Image.file(File(valueDoc.frontImage!.path))),
                                          
                                             Positioned(
                                              top: 8.0,
                                              right: 2.0,
                                              child: 
                                              //  valueDoc.getUrlCedulaFront.isNotEmpty?
                                              valueDoc.frontImage!=null?
                                              GestureDetector(
                                                onTap: ()async {
                                              //     ProgressDialog.show(context);
                                              // final response = await eliminaUrlServer(valueDoc.getUrlCedulaFront);
                                              //   ProgressDialog.dissmiss(context);
                                              //       if (response) {
                                                      
                                              //           valueDoc.removeFrontImage();
                                              //          valueDoc.setUrlCedulaFront('');
                                              //            NotificatiosnService.showSnackBarDanger('Foto eliminada correctamente');
                                              //       } else {
                                              //          NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                              //       }
                                                valueDoc.setDataCedula({});
                                               valueDoc.removeFrontImage();
                                                  valueDoc.resetIsValidate();
                                                 
                                                },
                                                child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,)): Container())
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                              
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
                                width: size.iScreen(40.0),
                                 height: size.iScreen(25.0),
                               
                                child: valueDoc.backImage == null
                                             ?  GestureDetector(
                                               onTap:  valueDoc.isPicking ? null :() {
                            valueDoc.pickBackImage();
                          },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  
                                                  Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),),
                                                  Text(
                                        'Tomar foto parte posterior de la cédula horizontalmente',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.grey
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                                ],
                                              ))
                                             : 
                                            //      valueDoc.getUrlCedulaBack.isNotEmpty
                                            //  ?
                                            //  FadeInImage(
                                            //                 placeholder:
                                            //                     const AssetImage(
                                            //                           'assets/imgs/loader.gif'),
                                            //                 image: NetworkImage(
                                            //                   '${valueDoc.getUrlCedulaBack}',
                                            //                 ),
                                            //               )
                                            //               : Image.asset('assets/imgs/loader.gif'),),
                                             Image.file(File(valueDoc.backImage!.path)),),
                                          
                                             Positioned(
                                              top: 8.0,
                                              right: 2.0,
                                              child: 
                                              //  valueDoc.getUrlCedulaBack.isNotEmpty?
                                               valueDoc.backImage!=null?
                                              GestureDetector(
                                                onTap: () async{
                                                  
                                              //          ProgressDialog.show(context);
                                              // final response = await eliminaUrlServer(valueDoc.getUrlCedulaBack);
                                              //   ProgressDialog.dissmiss(context);
                                              //       if (response) {
                                                      
                                              //           valueDoc.removeBackImage();
                                              //          valueDoc.setUrlCedulaBack('');
                                              //            NotificatiosnService.showSnackBarDanger('Foto eliminada correctamente');
                                              //       } else {
                                              //          NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                              //       }
                                               valueDoc.removeBackImage();
                                                },
                                                child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,)): Container())
                            ],
                          ),  
                        ],
                      )
                      :Container();
                    },),
                     
                      ],
                    ):Container();
                   
                  },),
                    
                     
                  // //***********************************************/
                  //   SizedBox(
                  //     height: size.iScreen(1.0),
                  //   ),
                  //   //*****************************************/

                    Row(
                      children: [
                        Container(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Tiene Vehículo:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                         Container(
                              // width: size.wScreen(30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Consumer<BitacoraController>(
                                    builder: (_, valueRadioVehiculo, __) {
                                      return Container(
                                        // color: Colors.red,
                                        width: size.wScreen(50.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              // width: size.wScreen(20.0),
                                              child: Text('SI',
                                                  style: GoogleFonts.lexendDeca(
                                                     fontSize: size.iScreen(1.8),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // color: Colors.grey
                                                      ),
                                                  textAlign: TextAlign.center),
                                            ),
                                            Radio<int>(
                                              activeColor:
                                                  Colors.orange.shade700,
                                              value: 0,
                                              groupValue: valueRadioVehiculo
                                                  .radioValueVehiculo,
                                              onChanged:
                                                  (int? value) {
                                                          if (value != null) {
                                                            valueRadioVehiculo
                                                                .setRadioVehiculo(
                                                                    value);
                                                          }
                                                        }
                                                    
                                            ),
                                            SizedBox(
                                              // width: size.wScreen(20.0),
                                              child: Text('No',
                                                  style: GoogleFonts.lexendDeca(
                                                     fontSize: size.iScreen(1.8),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // color: Colors.grey
                                                      ),
                                                  textAlign: TextAlign.center),
                                            ),
                                            Radio<int>(
                                              activeColor:
                                                  Colors.orange.shade700,
                                              value: 1,
                                              groupValue: valueRadioVehiculo
                                                  .radioValueVehiculo,
                                              onChanged:
                                                
                                                    valueRadioVehiculo.getDataVehiculo.isEmpty?   (int? value) {
                                                          if (value != null) {
                                                            valueRadioVehiculo
                                                                .setRadioVehiculo(
                                                                    value);
                                                          }
                                                        }:null
                                                      
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          
                      ],
                    ),
                    ///****************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/


Consumer<BitacoraController>(builder: (_, valuePlaca, __) {  

                

                      return 

   valuePlaca.radioValueVehiculo==0                  
                       
?Container(
  margin:EdgeInsets.only(top:size.iScreen(1.0)),
  child:   Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: size.iScreen(1.0)),
      Container(
        // Añadir borde
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Color del borde
          borderRadius: BorderRadius.circular(8.0), // Radio del borde
        ),
        width: size.wScreen(80.0), // Ajustar el ancho según sea necesario
        child: Row(
          children: [
            SizedBox(width: 8.0), // Espaciado entre el texto y el campo de texto
            Text(
              'Placa:',
              style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                height: size.iScreen(5.0), // Ajustar la altura de la caja de texto
                child: 
                
                  Consumer<BitacoraController>(
            builder: (context, providerPlaca, child) {
              //  _controllerTextCedula.text = providers.getCedulas;
              return

                TextFormField(
                  controller: providerPlaca.getControllerPlaca,
                  // initialValue:providers.getCedulas,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remover el borde por defecto
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Ajustar el padding vertical
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.iScreen(2.5)),
                   textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[^\n"]*$'),
                ),
                UpperCaseText(),
              ],
                  onChanged: (text) {
                    providerPlaca.setPlacaVerificar(text);
                  },
                );
            }),


                
              ),
            ),
            IconButton(
              icon: Icon(Icons.search), // Icono del botón de búsqueda
              onPressed: valuePlaca.getPlacas.isNotEmpty? () async{
                            ProgressDialog.show(context);
                                valuePlaca.setIsValidatePlaca(1);

          final response = await valuePlaca.getVehiculoPlavaVisitante(valuePlaca.getPlacas);
                            ProgressDialog.dissmiss(context);
                            if (response!=null) {
                               NotificatiosnService.showSnackBarSuccsses('Datos Correctos');
                               valuePlaca.setPlacaOk(false);
                               valuePlaca.setTextPlaca('');
                               valuePlaca.setIsValidatePlaca(2);
                            } else {
                              valuePlaca.setTextPlacaVehiculoPropietarioVisita(valuePlaca.getPlacas);
                              valuePlaca.setDataPlaca({});
                               valuePlaca.setPlacaOk(true);
                               valuePlaca.setIsValidatePlaca(1);
                                // NotificatiosnService.showSnackBarDanger('No Incorrectos');
                            }
                        }:null
            ),
            SizedBox(width: 8.0), // Espaciado entre el campo de texto y el botón
          ],
        ),
      ),
    ],
  ))
  :Container();

                      
                       }),
 //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
Consumer<BitacoraController>( builder: (_, values, __) { 

  return 
  values.getIsValidatePlaca==1
  ?
  Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
 SizedBox(
  height: size.iScreen(1.0),
),

 Text(
        'Validando Documento, por favor espere ...  ',
        style: GoogleFonts.lexendDeca(
          fontSize: size.iScreen(1.8),
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: size.iScreen(1.0)), // Espacio entre el texto y el indicador
      CircularProgressIndicator(
        color: ctrlTheme.secondaryColor,
        strokeWidth : 3.0), 
                  ]):Container();
 },),

   

                           //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
            //         //*****************************************/

// Consumer<BitacoraController>(builder: (_, valuePlaca, __) {  

                 

//                       return 

//                     valuePlaca.getPlacas.isNotEmpty  
//                        ? InkWell(
//                         onTap: () async{
//                             ProgressDialog.show(context);
         

//           final response = await valuePlaca.getVehiculoPlavaVisitante(valuePlaca.getPlacas);
//                             ProgressDialog.dissmiss(context);
//                             if (response!=null) {
//                                NotificatiosnService.showSnackBarSuccsses('Datos Correctos');
//                               valuePlaca.setPlacaOk(false);
//                             } else {
//                               valuePlaca.setPlacaOk(true);
                                
//                             }
//                         },
//                          child:
//                           Center(child: 
//                                         Container(
//                                         //    width: size.iScreen(5.0),
//                                         // height: size.iScreen(5.0),
//                                         decoration:BoxDecoration(
//                                          gradient: LinearGradient(
//                                        begin: Alignment.center,
//                                        end: Alignment.bottomRight,
//                                        colors: <Color>[
//                                          ctrlTheme.secondaryColor,
//                                          ctrlTheme.primaryColor,
                                         
//                                        ],
//                                      ),
//                                           borderRadius: BorderRadius.circular(8)
//                                         ),
//                                         padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0),vertical:size.iScreen(1.5)),
                                         
//                                           child:
//                                           //  Text('Validar Cédula ${valueCed.getCedulas}')))
//                          Text(
//                                           'Validar Placa ${valuePlaca.getPlacas}',
//                                           style: GoogleFonts.lexendDeca(
//                                             fontSize: size.iScreen(1.8),
//                                             fontWeight: FontWeight.normal,
//                                             color: Colors.white
//                                           ),
//                                         ))),
//                        )
                                      
//                                       :Container(child:  Text(
//                                         'Validar',
//                                         style: GoogleFonts.lexendDeca(
//                                           fontSize: size.iScreen(1.8),
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.white
//                                         ),
//                                       ),);
                      
//                        }),
                        SizedBox(
                                          height: size.iScreen(1.0),
                                        ),
                                           

                               Consumer<BitacoraController>(builder: (_, valuesPlaca, __) { 
                              return 
                              valuesPlaca.getDataPlaca.isNotEmpty
                               ?
                               Column(
                          children: [
                   //***********************************************/
                   
                    //    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),
                    // //*****************************************/


                    // Row(
                    //   children: [
                    //     Container(
                    //       // width: size.wScreen(15.0),

                    //       // color: Colors.blue,
                    //       child: Text('Código Dactilar:',
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               fontWeight: FontWeight.normal,
                    //               color: Colors.grey)),
                    //     ),
                    //     Container(
                    //       // width: size.wScreen(15.0),

                    //       // color: Colors.blue,
                    //       child: 
                          
                    //       //  Text( valuesNomCed.getExtractedDataCedulaB.isNotEmpty ?' ${'${valuesNomCed.getExtractedDataCedulaB['CÓDIGO DACTILAR']}'}':'--- --- --- ---',
                    //        Text( '--- --- --- ---',
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               fontWeight: FontWeight.normal,
                    //               // color: Colors.grey
                    //               )),
                    //     ),
                   
                    //   ],
                    // ),
                        
                       Row(
                      children: [
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: Text('Placa:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: 
                          
                          //  Text( valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${removeNULCedula('${valuesNomCed.getExtractedDataCedulaA['NUL']}')}':'--- --- --- ---',
                            Text( valuesPlaca.getPlacaPropVehiculo.isNotEmpty ?' ${valuesPlaca.getPlacaPropVehiculo}':'--- --- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                  )),
                        ),
                   
                      ],
                    ),
                        //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                     Container(
                       width: size.wScreen(100.0),

                       // color: Colors.blue,
                       child: Text('Modelo:',
                           style: GoogleFonts.lexendDeca(
                               fontSize: size.iScreen(1.8),
                               fontWeight: FontWeight.normal,
                               color: Colors.grey)),
                     ),
                     Container(
                       width: size.wScreen(100.0),

                       // color: Colors.blue,
                       child: 
                       
                       //  Text( valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${removeNULCedula('${valuesNomCed.getExtractedDataCedulaA['NUL']}')}':'--- --- --- ---',
                         Text( valuesPlaca.getModeloPropVehiculo.isNotEmpty ?' ${valuesPlaca.getModeloPropVehiculo}':'--- --- --- ---',
                           style: GoogleFonts.lexendDeca(
                               fontSize: size.iScreen(1.8),
                               fontWeight: FontWeight.normal,
                               // color: Colors.grey
                               )),
                     ),
                        //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Propietario:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                           //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      // child: Text(valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${valuesNomCed.getExtractedDataCedulaA['APELLIDOS']} ${valuesNomCed.getExtractedDataCedulaA['NOMBRES']}':'--- --- --- ---',
                      child:  Text( valuesPlaca.getNombrePropVehiculo.isNotEmpty ?' ${valuesPlaca.getNombrePropVehiculo}':'--- --- --- ---',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey
                              ),
                             ),
                    ),
                     SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/


                    Row(
                      children: [
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: Text('Cédula:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          // width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: 
                          
                          //  Text( valuesNomCed.getExtractedDataCedulaA.isNotEmpty ?' ${removeNULCedula('${valuesNomCed.getExtractedDataCedulaA['NUL']}')}':'--- --- --- ---',
                            Text( valuesPlaca.getNombrePropVehiculo.isNotEmpty ?' ${valuesPlaca.getCedulaPropVehiculo}':'--- --- --- ---',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                  )),
                        ),
                   
                      ],
                    ),



                          ],
                        ):Container();
  
                           },),
                   //dasdasd//
                     
 //***********************************************/

 Consumer<BitacoraController>(builder: (_, value, __) { 
return  value.radioValueVehiculo==0   &&  value.getDataPlaca.isEmpty
// value.getPlacaOk==true
                                                  
?
Column( children: [
  Container(
    padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
    color: Colors.grey.shade200,
    width: size.wScreen(100.0),
    child: Text(
              'INGRESE DATOS DEL PROPIETARIO DEL VIHÍCULO',
              style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
  ),
          SizedBox(height: size.iScreen(1.0)),
  SizedBox(
                      height: size.iScreen(1.0)
                    ),
                    //*****************************************/
                   
                  Container(
  width: size.wScreen(100.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cédula :',
            style: GoogleFonts.lexendDeca(
              fontSize: size.iScreen(1.8),
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: size.iScreen(1.0)),
          SizedBox(
            width: size.wScreen(45.0), // Adjust width as needed
            child: TextFormField(
             
              decoration: const InputDecoration(),
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: size.iScreen(2.5),),
              textInputAction: TextInputAction.done,
               keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (text) {
                bitacoraController.setCedulaPropVehiculo(text);
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Placa :',
            style: GoogleFonts.lexendDeca(
              fontSize: size.iScreen(1.8),
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: size.iScreen(1.0)),
          SizedBox(
            width: size.wScreen(45.0), // Adjust width as needed
            child:
            //  TextFormField(
              
            //   decoration: const InputDecoration(),
            //   textAlign: TextAlign.center,
            //   style:  TextStyle(fontSize: size.iScreen(3.0),),
            //   textInputAction: TextInputAction.done,
            //   inputFormatters: <TextInputFormatter>[
            //     FilteringTextInputFormatter.allow(
            //       RegExp(r'^[^\n"]*$'),
            //     ),
            //     UpperCaseText(),
            //   ],
            //   onChanged: (text) {
            //     bitacoraController.setPlacaPropVehiculo(text);
            //   },
            // ),
            Consumer<BitacoraController>(
            builder: (context, providers, child) {
              //  _controllerTextCedula.text = providers.getCedulas;
              return
       
       TextFormField(
                controller: providers.getControllerPlacaVehiculoPropietarioVisita,
              decoration: const InputDecoration(),
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: size.iScreen(3.0),),
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[^\n"]*$'),
                ),
                UpperCaseText(),
              ],
              onChanged: (text) {
                bitacoraController.setPlacaPropVehiculo(text);
              },
            );
        }),
          ),
        ],
      ),
    ],
  ),
),
  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                   
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Modelo:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style:  TextStyle(fontSize: size.iScreen(2.5),),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                            RegExp(r'^[^\n"]*$')),
                        UpperCaseText(),
                      ],
                      onChanged: (text) {
                        bitacoraController.setModeloPropVehiculo(text);
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
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                   
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Propietario:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style:  TextStyle(fontSize: size.iScreen(2.5),),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                            RegExp(r'^[^\n"]*$')),
                        UpperCaseText(),
                      ],
                      onChanged: (text) {
                        bitacoraController.setNombrePropVehiculo(text);
                      },
                      // validator: (text) {
                      //   if (text!.trim().isNotEmpty) {
                      //     return null;
                      //   } else {
                      //     return 'Ingrese Observación';
                      //   }
                      // },
                    ),
                    

                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                  
                    // //*****************************************/
                    // //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                  
                    // //*****************************************/

                     //*/*/*/*/*/*asdads

 ],):Container();
        

  },),

             
                           //***********************************************/
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    //*****************************************/
                 
                    Consumer<BitacoraController>(builder: (_, valueVehiculo, __) {  
                      return 
                      valueVehiculo.radioValueVehiculo==0
                       ?
                       Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey.shade300,),
                            width: size.iScreen(40.0),
                             height: size.iScreen(15.0),
                           
                            child: 
                            // valueVehiculo.getUrlPlaca.isNotEmpty
                            valueVehiculo.placaImage!=null

                                         ?  Image.file(File(valueVehiculo.placaImage!.path))
                                         : valueVehiculo.getUrlPlaca.isNotEmpty?
                                         FadeInImage(
                                                            placeholder:
                                                                const AssetImage(
                                                                      'assets/imgs/loader.gif'),
                                                            image: NetworkImage(
                                                              '${valueVehiculo.getUrlPlaca}',
                                                            ),
                                                          )
                                         :GestureDetector(
                                           onTap:  valueVehiculo.isPicking ? null :() {
                        valueVehiculo.pickPlacaImage(context);
                      },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo_outlined,size: size.iScreen(4.0),),
                                              Text(
                                        'Tomar foto placa del Vehículo',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.grey
                                        ),
                                      ),
                                            ],
                                          ))
                                         
                                          // valueVehiculo.getUrlPlaca.isNotEmpty
                                          //    ?
                                          //    FadeInImage(
                                          //                   placeholder:
                                          //                       const AssetImage(
                                          //                             'assets/imgs/loader.gif'),
                                          //                   image: NetworkImage(
                                          //                     '${valueVehiculo.getUrlPlaca}',
                                          //                   ),
                                          //                 )
                                          //                 : Image.asset('assets/imgs/loader.gif'),),
                                         
                                        //  Image.file(File(valueVehiculo.placaImage!.path)),
                                         ),
                                      
                                         Positioned(
                                          top: 8.0,
                                          right: 2.0,
                                          child: 
                                          //  valueVehiculo.getUrlPlaca.isNotEmpty ?
                                          valueVehiculo.placaImage!=null?
                                          GestureDetector(
                                            onTap: () async{
                                             

                                              //  ProgressDialog.show(context);
                                              // final response = await eliminaUrlServer(valueVehiculo.getUrlPlaca);
                                              //   ProgressDialog.dissmiss(context);
                                              //       if (response) {
                                                      
                                              //           valueVehiculo.removePlacaImage();
                                              //          valueVehiculo.setUrlPlaca('');
                                              //            NotificatiosnService.showSnackBarDanger('Foto eliminada correctamente');
                                              //       } else {
                                              //          NotificatiosnService.showSnackBarError('Error al eliminar foto !! ');
                                              //       }


                                               valueVehiculo.removePlacaImage();
                                                valueVehiculo.resetIsValidatePlaca();
                                            },
                                            child: Icon(Icons.close_outlined,size: size.iScreen(4.0),color: Colors.redAccent,)): Container())
                        ],
                      ):Container();
                    },),
                     
                  //***********************************************/
               

                    Consumer<BitacoraController>(builder: (_, values, __) { 
                      return  
                     values.getItemObservacionBitacora!.isNotEmpty 
                     ? Column(
                        children: [
                               SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                          Container(
                          width: size.wScreen(100.0),
                          child: Text('Observación:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                    ),
                     //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                   
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('${values.getItemObservacionBitacora}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey
                              )),
                    ),
                        ],
                      ):Container();
                   
                 
                     },),
                   
                   
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(3.0),
                    ),
                  
                    //*****************************************/
                  ],
                ),
              ),
            ),
          ),
         floatingActionButton: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FloatingActionButton(
      heroTag: 'photoButton',  // Proporciona un tag único
      onPressed: bitacoraController.isPicking ? null :() async{
       

                            bitacoraController.pickVisitanteImage();
                        
      },
      backgroundColor: ctrlTheme.secondaryColor, // Color de fondo
      // Color del texto
    
      child: Icon(Icons.camera_front),
      tooltip: 'Tomar Foto', // Muestra un texto al pasar el cursor sobre el botón
    ),
    SizedBox(height: 16), // Espacio entre los botones
    FloatingActionButton.extended(
      heroTag: 'noteButton',  // Proporciona un tag único
      onPressed: () {
        _showModalObservacion(context, size,screenSize);
      },
       backgroundColor: ctrlTheme.secondaryColor,
    
     label: Text('Observación'),
  icon: Icon(Icons.comment),
    ),
  ],
),

        ),
      ),
    );
  }

//   void _onSubmit(BuildContext context, BitacoraController _controller,
//     ) async {

//     final isValid = _controller.validateFormRegistro();
//     if (!isValid) return;
//     if (isValid) {
//       if (_controller.getItemTipoPersonal == '' ||
//           _controller.getItemTipoPersonal == null) {
//         NotificatiosnService.showSnackBarDanger('Seleccione tipo de Persona');
//       } 
//       else if (_controller.getItemTipoDocumento == '' ||
//           _controller.getItemTipoDocumento == null) {
//         NotificatiosnService.showSnackBarDanger('Seleccione tipo de Documeto');
//       } 
//        else if (_controller.getCedulaVisitantes == 'CEDULA') {
        
//         if (_controller.getCedulaVisitantes == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
//       }
//        else if (_controller.getNombreVisitantes == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
//       }
//       else if (_controller.frontImage == null) {
//         NotificatiosnService.showSnackBarDanger('Agregue foto parte frontal de la Cédula');
//       }
//        else if (_controller.backImage == null) {
//         NotificatiosnService.showSnackBarDanger('Agregue foto parte posterior de la Cédula');
//       }

//       }
//        else if (_controller.getCedulaVisitantes == 'PASAPORTE') {
        
//         if (_controller.getCedulaVisitantes == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
//       }
//        else if (_controller.getNombreVisitantes == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
//       }
//       else if (_controller.pasaporteImage == null) {
//         NotificatiosnService.showSnackBarDanger('Agregue foto parte frontal de la Cédula');
//       }
       

//       }
      

//        else if (_controller.radioValueVehiculo ==0) {

//          if (_controller.getCedulaPropVehiculo == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese cédula del Propietario del Vehículo');
//       }
//        else if (_controller.getNombrePropVehiculo == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese Nombre del Propietario del Vehículo');
//       }
//        else if (_controller.getPlacaPropVehiculo == '') {
//         NotificatiosnService.showSnackBarDanger('Ingrese placa del Vehículo');
//       }
//        else if (_controller.placaImage == null) {
//         NotificatiosnService.showSnackBarDanger('Agregue foto de placa del Vehículo');
//       }
//       }




      
//       // else if (_controller.getItemAutorizadoPor == '' ||
//       //     _controller.getItemAutorizadoPor == null) {
//       //   NotificatiosnService.showSnackBarDanger('Seleccione quién autoriza');
//       // } else if (_controller.getItemTelefono!.length < 9 ||
//       //     _controller.getItemTelefono!.length > 10) {
//       //   NotificatiosnService.showSnackBarDanger(
//       //       'Numero de teléfono incorrecto');
//       // } else if (_action == 'CREATE') {
//       //   String _persona = '';
//       //   if (widget.user!.rol!.contains('GUARDIA')) {
//       //     _persona = "GUARDIA";
//       //     await _controller.enviarImagenesAlServidor(context, _persona);
//       //   } else if (widget.user!.rol!.contains('RESIDENTE')) {
//       //     _persona = "RESIDENTE";
//       //     await _controller.enviarImagenesAlServidor(context, _persona);
//       //   }

//         // _controller.setVisitas(
//         //   {"id":'1'},
//         //    _controller.getCedulaVisita!,
//         //     _controller.getPasaporteVisita!,
//         //      _controller.getOpcionVehiculo,
//         //       'JOSE MARIA RAMOS LEONEL',
//         //        '54646V4545',
//         //         'HOMBRE',
//         //          _controller.getItemObservacion!,
                 

//         // );
//         // Navigator.pop(context);

//       // }
      
          

//                     // Crear el mapa del registro
//                     // Map<String, dynamic> nuevoRegistro = {
//                     //   'nombre': '', // Asigna el nombre aquí si lo necesitas
//                     //   'direccion': '', // Asigna la dirección aquí si lo necesitas
//                     //   'frontImage': _controller.frontImage!.path,
//                     //   'backImage': _controller.backImage!.path,
//                     //   'placaImage': _controller.placaImage!.path,
//                     //   'pasaporteImage': _controller.pasaporteImage!.path,
//                     // };
//  Map<String, dynamic> nuevoRegistro = {
//        "id": _controller.getResidente['id'] ?? '',
//       "cedula": "123456789",
//       "cliente": "RODRIGUEZ LOOR JOSE EDUARDO",
//       "piso": _controller.getResidente['piso'] ?? '',
//       "oficina": _controller.getResidente['oficina'] ?? '',
//       "fotoVisitante": _controller.visitanteImage?.path ?? '',
//       "cedulaVisita": _controller.getCedulaVisitantes,
//       "nombreVisita": _controller.getNombreVisitantes,
//       "fotoCedula": {
//         "cedulaFront": _controller.frontImage?.path ?? '',
//         "cedulaBack": _controller.backImage?.path ?? '',
//       },
//       "pasaporteVisita": _controller.getPasaporteVisita,
//       "fotoPasaporte": _controller.pasaporteImage?.path ?? '',
//       "vehiculo": _controller.getOpcionVehiculo,
//       "fotoPlaca": _controller.placaImage?.path ?? '',
      
//       // "dactilar": _controller.getdactilarVisita,
//       // "sexo": _controller.getResidente['sexo'],
//        "cedulaPropietarioVehiculo": _controller.getCedulaPropVehiculo,
//       "nombrePropietarioVehiculo": _controller.getNombrePropVehiculo,
//       "placa": _controller.getPlacaPropVehiculo,
//       "observacion": _controller.getItemObservacionBitacora,

//  };



//                     // Agregar el registro al provider
//                     // _controller.addVisita(nuevoRegistro);

//                     // // Luego de guardar, podrías limpiar los datos si es necesario
//                     // _controller.clearData();

//                     // Navigator.pop(context);
                  

//     }
//   }
void _onSubmit(BuildContext context, BitacoraController _controller) async {
  final isValid = _controller.validateFormRegistro();
  if (!isValid) return;


      bool existeCedula = _controller.verificarCedulaVisita();
                // print('LA CEDULA ES: ${valueDoc.listaVisitas[0]['cedulaVisita']}');
                print('LA CEDULA ES: ${existeCedula}');

                            
                            if (existeCedula) {
                              NotificatiosnService.showSnackBarDanger('Visitantante ya registrado');
                            } else {


  
  if (_controller.getItemTipoPersonal == '' || _controller.getItemTipoPersonal == null) {
    NotificatiosnService.showSnackBarDanger('Seleccione tipo de Persona');
    return;
  }  
  if (_controller.getItemTipoDocumento == '' || _controller.getItemTipoDocumento == null) {
    NotificatiosnService.showSnackBarDanger('Seleccione tipo de Documento');
    return;
  } 
  // if (_controller.getItemTipoIngreso == '' || _controller.getItemTipoIngreso == null) {
  //   NotificatiosnService.showSnackBarDanger('Seleccione tipo de Ingreso');
  //   return;
  // } 
  

  // if (_controller.getItemTipoDocumento == 'CEDULA') {
  //   print('EL TIPO ES: ${_controller.getItemTipoDocumento}' );
  //   if (_controller.getCedulaVisitantes == '') {
  //     NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
  //     return;
  //   }
  //   if (_controller.getNombreVisitantes == '') {
  //     NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
  //     return;
  //   }
  //   if (_controller.getUrlCedulaFront.isEmpty) {
  //     NotificatiosnService.showSnackBarDanger('Agregue foto parte frontal de la Cédula');
  //     return;
  //   }
  //   if (_controller.getUrlCedulaFront.isEmpty) {
  //     NotificatiosnService.showSnackBarDanger('Agregue foto parte posterior de la Cédula');
  //     return;
  //   }
  // }

  // if (_controller.getItemTipoDocumento == 'PASAPORTE') {

  //   print('EL TIPO ES: ${_controller.getItemTipoDocumento}' );
  //   if (_controller.getCedulaVisitantes == '') {
  //     NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
  //     return;
  //   }
  //   if (_controller.getNombreVisitantes == '') {
  //     NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
  //     return;
  //   }
  //   if (_controller.getUrlPasaporte.isEmpty) {
  //     NotificatiosnService.showSnackBarDanger('Agregue foto del Pasaporte');
  //     return;
  //   }
  // }

if (_controller.getItemTipoDocumento == 'CEDULA') {
  print('EL TIPO ES: ${_controller.getItemTipoDocumento}');
  if (_controller.getCedulaVisitantes.isEmpty) {
    NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
    return;
  }
  if (_controller.getNombreVisitantes.isEmpty) {
    NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
    return;
  }
  // if (_controller.getUrlCedulaFront.isEmpty) {
  //   NotificatiosnService.showSnackBarDanger('Agregue foto parte frontal de la Cédula');
  //   return;
  // }
  // if (_controller.getUrlCedulaBack.isEmpty) { // Cambiado a getUrlCedulaBack
  //   NotificatiosnService.showSnackBarDanger('Agregue foto parte posterior de la Cédula');
  //   return;
  // }
  if (_controller.frontImage==null) {
    NotificatiosnService.showSnackBarDanger('Agregue foto parte frontal de la Cédula');
    return;
  }
  if (_controller.backImage==null) { // Cambiado a getUrlCedulaBack
    NotificatiosnService.showSnackBarDanger('Agregue foto parte posterior de la Cédula');
    return;
  }
}

if (_controller.getItemTipoDocumento == 'PASAPORTE') {
  print('EL TIPO ES: ${_controller.getItemTipoDocumento}');
  if (_controller.getCedulaVisitantes.isEmpty) {
    NotificatiosnService.showSnackBarDanger('Ingrese Cédula del Visitante');
    return;
  }
  if (_controller.getNombreVisitantes.isEmpty) {
    NotificatiosnService.showSnackBarDanger('Ingrese Nombres del Visitante');
    return;
  }
  // if (_controller.getUrlPasaporte.isEmpty) {
  //   NotificatiosnService.showSnackBarDanger('Agregue foto del Pasaporte');
  //   return;
  // }
  if (_controller.pasaporteImage==null) {
    NotificatiosnService.showSnackBarDanger('Agregue foto del Pasaporte');
    return;
  }
}



  if (_controller.radioValueVehiculo == 0) {
    if (_controller.getCedulaPropVehiculo == '') {
      NotificatiosnService.showSnackBarDanger('Ingrese cédula del Propietario del Vehículo');
      return;
    }
    if (_controller.getNombrePropVehiculo == '') {
      NotificatiosnService.showSnackBarDanger('Ingrese Nombre del Propietario del Vehículo');
      return;
    }
    if (_controller.getPlacaPropVehiculo == '') {
      NotificatiosnService.showSnackBarDanger('Ingrese placa del Vehículo');
      return;
    }
    // if (_controller.getUrlPlaca.isEmpty) {
    //   NotificatiosnService.showSnackBarDanger('Agregue foto de placa del Vehículo');
    //   return;
    // }
    if (_controller.placaImage==null && _controller.getUrlPlaca.isEmpty) {
      NotificatiosnService.showSnackBarDanger('Agregue foto de placa del Vehículo');
      return;
    }
  }


 //************************************************OBTENEMOS LOS URLS LOCAL IMAGE********************************************************/
    print('****** URLS LOCAL ******');
     print('****** URLS LOCAL VISITANTE ${_controller.visitanteImage?.path} ******');
      print('****** URLS LOCAL FRONTAL ${_controller.frontImage?.path}******');
       print('****** URLS LOCAL POSTERIOR ${_controller.backImage?.path}******');
              print('****** URLS LOCAL PASAPORTE ${_controller.pasaporteImage?.path}******');
        print('****** URLS LOCAL PLACA ${_controller.placaImage?.path}******');

         ProgressDialogUpLoads.show(context);
        

          final response = await _controller.uploadImagesAndPrintUrls();
       
            ProgressDialogUpLoads.dissmiss(context);

              if (response ==true) {
                 print('****** LOS URLS OBTENIDOS:  ${_controller.getUrlsVisitas} ');


                // ********************************************************************************************************/
//   // Si todas las validaciones pasan, construye el mapa nuevoRegistro
//   Map<String, dynamic> nuevoRegistro = {
//     "id": _controller.getItemPersonaDestinol!['id'] ?? '',
//     "cedula": _controller.getResidente['resCliDocumento'] ?? '',
//     "cliente": _controller.getResidente['resCliNombre'] ?? '',
//     "numeroDepartamento": _controller.getResidente['resDepartamento'][0]['nombre_dpt'] ?? '',
//     "depatamento":_controller.getResidente['resDepartamento'][0]['numero']?? '',
//      "tipoPersona":_controller.getItemTipoPersonal,
//      "asunto":_controller.getItemAsunto,
//     "fotoVisitante": _controller.getUrlVisitante,
    
//     "cedulaVisita": _controller.getCedulaVisitantes,
//     "nombreVisita": _controller.getNombreVisitantes,
//      "telefonoVisita": _controller.getTelefonoVisitantes,
   
//       "fotoCedulaFront": _controller.getUrlCedulaFront, //_controller.frontImage?.path ?? '',
//       "fotoCedulaBack":   _controller.getUrlCedulaBack,//_controller.backImage?.path ?? '',
   
//     "pasaporteVisita": _controller.getPasaporteVisita,
//     "fotoPasaporte": _controller.getUrlPasaporte,
    
//     //_controller.pasaporteImage?.path ?? '',
//     "vehiculo": _controller.getOpcionVehiculo,
//     "fotoPlaca":_controller.getUrlPlaca,// _controller.placaImage?.path ?? '',
//     "cedulaPropietarioVehiculo": _controller.getCedulaPropVehiculo,
//     "nombrePropietarioVehiculo": _controller.getNombrePropVehiculo,
//     "placa": _controller.getPlacaPropVehiculo,
//     "modelo": _controller.getModeloPropVehiculo,
//     "observacion": _controller.getItemObservacionBitacora,
//   };


//   print('LA DATA PARA LA LISTA VISITA ============> $nuevoRegistro');

//   // Agregar el registro al provider
  _controller.addVisita();

// if (_controller.getDataVehiculo.isEmpty) {
//   _controller.setDataVehiculo(
//   {
// "dni":_controller.getCedulaPropVehiculo,
// "fullname":_controller.getNombrePropVehiculo,
// "carRegistration":_controller.getPlacaPropVehiculo,
// "model":_controller.getModeloPropVehiculo,
// "fotoPlaca":_controller.getUrlPlaca,
//   }
// );
// }

  // Luego de guardar, podrías limpiar los datos si es necesario
  _controller.clearData();

  // Navegar de vuelta
  Navigator.pop(context);





 

              }else {
                   NotificatiosnService.showSnackBarDanger('Ocurrió un error al guardar imágenes');

              }






  //********************************************************************************************************/
                            }
}




  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  // void _modalSeleccionaTipoIngreso(
  //     Responsive size, BitacoraController _control) {
  //   final _data = [
  //     'RECEPCION',
  //     'PARQUEADERO',
  //   ];
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return GestureDetector(
  //           onTap: () => FocusScope.of(context).unfocus(),
  //           child: AlertDialog(
  //              shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             insetPadding: EdgeInsets.symmetric(
  //                 horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(' TIPO DE INGRESO',
  //                         style: GoogleFonts.lexendDeca(
  //                           fontSize: size.iScreen(2.0),
  //                           fontWeight: FontWeight.bold,
  //                           // color: Colors.white,
  //                         )),
  //                     IconButton(
  //                         splashRadius: size.iScreen(3.0),
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         icon: Icon(
  //                           Icons.close,
  //                           color: Colors.red,
  //                           size: size.iScreen(3.5),
  //                         )),
  //                   ],
  //                 ),
  //                 Container(
  //                   width: size.wScreen(100),
  //                   height: size.hScreen(24),
  //                   child: ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const BouncingScrollPhysics(),
  //                     itemCount: _data.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return GestureDetector(
  //                         onTap: () {
  //                           _control.setItemTipoIngreso(_data[index]);
  //                           Navigator.pop(context);
  //                         },
  //                         child: Container(
  //                           color: Colors.grey[100],
  //                           margin: EdgeInsets.symmetric(
  //                               vertical: size.iScreen(0.3)),
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: size.iScreen(1.0),
  //                               vertical: size.iScreen(1.0)),
  //                           child: Text(
  //                             _data[index],
  //                             style: GoogleFonts.lexendDeca(
  //                               fontSize: size.iScreen(1.8),
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black54,
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }


  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  void _modalSeleccionaTipoPersona(
      Responsive size, BitacoraController _control,ScreenSize screenSize) {
    final _data = [
      'PERSONAL INTERNO',
      'FAMILIARES',
      'VISITANTES',
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
              content: SizedBox(
          //        // Ajusta la altura según el tamaño de la pantalla
          // height: screenSize.width>600? size.iScreen(60) : size.iScreen(40.0),
                child: Column(
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
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  // void _modalSeleccionaDestinoPersona(
  //     Responsive size, BitacoraController _control) {
  //   final _data = [
  //     'PROPIETARIO',
  //     'ARRENDATARIO',
  //   ];
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return GestureDetector(
  //           onTap: () => FocusScope.of(context).unfocus(),
  //           child: AlertDialog(
  //              shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             insetPadding: EdgeInsets.symmetric(
  //                 horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(' SELECCIONE RESIDENTE',
  //                         style: GoogleFonts.lexendDeca(
  //                           fontSize: size.iScreen(2.0),
  //                           fontWeight: FontWeight.bold,
  //                           // color: Colors.white,
  //                         )),
  //                     IconButton(
  //                         splashRadius: size.iScreen(3.0),
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         icon: Icon(
  //                           Icons.close,
  //                           color: Colors.red,
  //                           size: size.iScreen(3.5),
  //                         )),
  //                   ],
  //                 ),
  //                 Container(
  //                   width: size.wScreen(100),
  //                   height: size.hScreen(12),
  //                   child: ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const BouncingScrollPhysics(),
  //                     itemCount: _data.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return GestureDetector(
  //                         onTap: () {
  //                           _control.setItemPersonaDestino(_data[index]);
  //                           Navigator.pop(context);
  //                         },
  //                         child: Container(
  //                           color: Colors.grey[100],
  //                           margin: EdgeInsets.symmetric(
  //                               vertical: size.iScreen(0.3)),
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: size.iScreen(1.0),
  //                               vertical: size.iScreen(1.0)),
  //                           child: Text(
  //                             _data[index],
  //                             style: GoogleFonts.lexendDeca(
  //                               fontSize: size.iScreen(1.8),
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black54,
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }


  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  void _modalSeleccionaTipoDocumento(
      Responsive size, BitacoraController _control, ScreenSize screenSize) {
    final _data = [
      'CEDULA',
      'PASAPORTE',
      
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
                    height: size.hScreen(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {

                              _control.removeVisitanteImage();
                             _control.removeFrontImage();
                              _control.removeBackImage();
                                _control.removePasaporteImage();
                                _control.setTextCedula('');
                                  _control.setTextPlaca('');
                                 
                                   _control.setCedulaVerificar('');
                                  //  _control.setPlacaVerificar('');
                                    _control.resetIsValidate();
                                     _control.setDataCedula({});

                            _control.setItemTipoDocumento(_data[index]);
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



void modalValidaCedula(BuildContext context, Responsive size, ScreenSize screenSize) {
  // final ausenciaController = context.read<BitacoraController>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: const Text('Validar Documento'),
        actions: <Widget>[
          
          TextButton(
            onPressed: () async {
              // final providerTurno = context.read<TurnoExtraController>();

              // if (ausenciaController.getlistaGuardiasSeleccionados.isNotEmpty) {
              //   for (var item in ausenciaController.getlistaGuardiasSeleccionados) {
              //     providerTurno.eliminaTurnoExtra(int.parse(item['turId'].toString()));
              //     print('EL ID:${item['turId']}');
              //   }
              //   Navigator.of(context).pop(true);
              // } else {
              //   Navigator.of(context).pop(true);
              // }
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Aceptar',
              style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      );
    },
  );
}

//****************//
// void _showModalObservacion(BuildContext context,Responsive size) {

//  final TextEditingController _textController = TextEditingController();
//  final _ctrl=context.read<BitacoraController>();

//      showDialog(
//       barrierDismissible :false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(

//           title: Text('Ingresar Observación'),
//           content: Form(
//             key: _ctrl.bitacoraObservacionFormKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
               
               
//                 TextFormField(
//                  controller: _textController,
//                   inputFormatters: <TextInputFormatter>[
//                    FilteringTextInputFormatter.allow(
//                     RegExp(r'^[^\n"]*$'),
//                   ),
//                   UpperCaseText(),
//                   ],
//                   minLines: 1,
//                   maxLines: 4,
//                   decoration: const InputDecoration(),
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(),
//                   textInputAction: TextInputAction.done,
//                   onChanged: (text) {
//                     // bitacoraController.setItemObservacion(text);
//                   },
//                    validator: (text) {
//                                     if (text!.trim().isNotEmpty) {
//                                       return null;
//                                     } else {
//                                       return 'Ingrese Observación';
//                                     }
//                                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancelar'),
//               onPressed: () {
//                 _textController.dispose();
//                 Navigator.of(context).pop();
                 
//               },
//             ),
//             TextButton(
//               child: Text('Agregar'),
//               onPressed: () {
//                 // Aquí puedes agregar la lógica para manejar el texto ingresado

// //                    final isValid = _ctrl.validateFormObservacion();
// //   _ctrl.bitacoraObservacionFormKey.currentState?.save();
// //   if (!isValid) return;

  

// //   if (isValid) {
// // _ctrl.setItemObservacionBitacora(_textController.text);
// // _textController.dispose();
// //  Navigator.of(context).pop();

// //   }

//  if (_ctrl.validateFormObservacion()) {
//                   _ctrl.setItemObservacionBitacora(_textController.text);
//                   Navigator.of(context).pop();
//                   _textController.dispose(); // Dispose the controller when closing the modal
//                 }
  



//                 // Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
  
//   void _showModalObservacion(BuildContext context, Responsive size) {
//   final TextEditingController _textController = TextEditingController();
//   final _ctrl = context.read<BitacoraController>();

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Ingresar Observación'),
//         content: Form(
//           key: _ctrl.bitacoraObservacionFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _textController,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'^[^\n"]*$')),
//                   UpperCaseText(),
//                 ],
//                 minLines: 1,
//                 maxLines: 4,
//                 decoration: const InputDecoration(),
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(),
//                 textInputAction: TextInputAction.done,
//                 validator: (text) {
//                   if (text!.trim().isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Ingrese Observación';
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancelar'),
//             onPressed: () {
//               _textController.dispose();
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('Agregar'),
//             onPressed: () {
//               if (_ctrl.validateFormObservacion()) {
//                 _ctrl.setItemObservacionBitacora(_textController.text);
//                  _textController.dispose(); 
//                 Navigator.of(context).pop();
//                // Dispose the controller when closing the modal
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }




void _showModalObservacion(BuildContext context, Responsive size, ScreenSize screenSize) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return _ModalContent(size: size);
    },
  );
}


}

class _ModalContent extends StatefulWidget {
  final Responsive size;

  _ModalContent({required this.size});

  @override
  __ModalContentState createState() => __ModalContentState();
}

class __ModalContentState extends State<_ModalContent> {
  late TextEditingController _textController;
  late BitacoraController _ctrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _ctrl = context.read<BitacoraController>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ingresar Observación'),
      content: Form(
        key: _ctrl.bitacoraObservacionFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _textController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[^\n"]*$')),
                UpperCaseText(),
              ],
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(),
              textAlign: TextAlign.start,
              style: const TextStyle(),
              textInputAction: TextInputAction.done,
              validator: (text) {
                if (text!.trim().isNotEmpty) {
                  return null;
                } else {
                  return 'Ingrese Observación';
                }
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Agregar'),
          onPressed: () {
            if (_ctrl.validateFormObservacion()) {
              _ctrl.setItemObservacionBitacora(_textController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }



}
