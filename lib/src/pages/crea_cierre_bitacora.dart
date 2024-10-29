import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/cierre_bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../models/session_response.dart';


class CreaCierreBotacora extends StatefulWidget {
   final Session? usuario;
  final String? action;
  const CreaCierreBotacora({Key? key, this.usuario, this.action}) : super(key: key);

  @override
  State<CreaCierreBotacora> createState() => _CreaCierreBotacoraState();
}

class _CreaCierreBotacoraState extends State<CreaCierreBotacora> {


  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
        final _action = widget.action;
    final _user = context.read<HomeController>();
      final ctrl = context.read<CierreBitacoraController>();
              final ctrlTheme = context.read<ThemeApp>();
    return GestureDetector(
         onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
         appBar: AppBar(
                  // backgroundColor: appBarColor,
                  
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
                          'Crear Cierre Bitácora',
                          // style: Theme.of(context).textTheme.headline2,
                        )
                      : Text(
                          'Editar Cierre Bitácora',
                          // style: Theme.of(context).textTheme.headline2,
                        ),
                  actions: [
                    Container(
                      margin: EdgeInsets.only(right: size.iScreen(1.5)),
                      child: IconButton(
                          splashRadius: 28,
                          onPressed: () {
                            _onSubmit(context, ctrl, _action.toString());
                          },
                          icon: Icon(
                            Icons.save_outlined,
                            size: size.iScreen(4.0),
                          )),
                    )
                  ],
                ),
        body: Container(
          // color: Colors.red,
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
              key: ctrl.cierreBitacoraFormKey,
              child: Column(children: [
                           Container(
                                                       width: size.wScreen(100.0),
                                                       margin: const EdgeInsets.all(0.0),
                                                       padding: const EdgeInsets.all(0.0),
                                                       child: Row(
                                                         mainAxisAlignment:
                                                             MainAxisAlignment.end,
                                                         children: [
                                                           Text(
                                                               '${_user.getUsuarioInfo!.rucempresa!}  ',
                                                               style: GoogleFonts.lexendDeca(
                                                                   fontSize:
                                                                       size.iScreen(1.5),
                                                                   color:
                                                                       Colors.grey.shade600,
                                                                   fontWeight:
                                                                       FontWeight.bold)),
                                                           Text('-',
                                                               style: GoogleFonts.lexendDeca(
                                                                   fontSize:
                                                                      size.iScreen(1.5),
                                                                   color: Colors.grey,
                                                                   fontWeight:
                                                                       FontWeight.bold)),
                                                           Text(
                                                               '  ${_user.getUsuarioInfo!.usuario!} ',
                                                               style: GoogleFonts.lexendDeca(
                                                                   fontSize:
                                                                       size.iScreen(1.5),
                                                                   color:
                                                                       Colors.grey.shade600,
                                                                   fontWeight:
                                                                       FontWeight.bold)),
                                                         ],
                                                       )),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/

                SizedBox(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child: Row(
                    children: [
                      Text('Fecha :',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                              Consumer<CierreBitacoraController>(builder: (_, value, __) {
                                return Text('${value.getFechaActual}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.bold,
                              color: Colors.black));
                                },),
                              
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

                  child: Text('Observación:',
                      style: GoogleFonts.lexendDeca(
                         fontSize: size.iScreen(1.8),
                         fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                     ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(

                      ),
                  textInputAction: TextInputAction.done,
                         inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@#-+.,{""}\\s]"),),UpperCaseText(),],
                      
                  onChanged: (text) {
                    ctrl.onObservacionChange(text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Ingrese observación';
                    }
                  },
                  minLines: 1,
                  maxLines: 5,
                ),
             //************/
                SizedBox(
                  height: size.iScreen(2.0),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100.0),
                            
                  child: 
                  Consumer<CierreBitacoraController>(builder: (_, values, __) {  
                    return Row(
                      children: [
                        Text('Fotos: ',
                          style: GoogleFonts.lexendDeca(
                             fontSize: size.iScreen(1.8),
                             fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                              Text(values.photos.isNotEmpty?'${values.photos.length}':'0',
                          style: GoogleFonts.lexendDeca(
                             fontSize: size.iScreen(2.0),
                             fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      ],
                    );
                  },)
                  
                ),
                   /**************************/
                   //************/
                SizedBox(
                  height: size.iScreen(2.0),
                ),
                //*****************************************/
                  Consumer<CierreBitacoraController>(
              builder: (context, photoProvider, child) {
                if (photoProvider.photos.isEmpty) {
                  return Center(child: Text("No hay fotos agregadas", style: GoogleFonts.lexendDeca(
                             fontSize: size.iScreen(2.0),
                             fontWeight: FontWeight.bold,
                              color: Colors.grey)));
                }
                return Wrap(
                  spacing: 8.0, // Espacio horizontal entre las fotos
                  runSpacing: 8.0, // Espacio vertical entre las filas
                  children: List.generate(photoProvider.photos.length, (index) {
                    final photo = photoProvider.photos[index];
                    return Container(
                      width: size.wScreen(85.0), // Ancho de cada foto
                      height: size.hScreen(40), // Alto de cada foto
                      child: Stack(
                        alignment : AlignmentDirectional.center,
                        children: [
                          Image.file(
                            File(photo.path),
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                        top: 0.0,
                        right: 0.0,

                    child:
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async{
                          await photoProvider.deleteOriginalFiles(photo.path);
                        photoProvider.removePhoto(index);
                      },
                    ),)
                        ],
                      ),
                    );
                  }),
                );
              },
            ),     
                
                ])
       )
       )
       ),
       floatingActionButton:  FloatingActionButton(
                onPressed: () {
                  bottomSheet(ctrl, context, size);
                },
                backgroundColor: Colors.purpleAccent,
                heroTag: "btnCamara",
                child: const Icon(Icons.camera_alt_outlined),
              ),
       )
       );
    
  }
  void bottomSheet(
   CierreBitacoraController ctrl,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
             
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                     ctrl.pickImageFromCamera();
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
                 
                    ctrl.pickImageFromGallery();
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
             
            ));
  }

  void _onSubmit(BuildContext context, CierreBitacoraController crtl, String _action) async{

 final isValid = crtl.validateForm();
    if (!isValid) return;
    if (isValid) {

        if (_action == 'CREATE')  {
          // await crtl.crearTurno(context);
          if (crtl.photos.isNotEmpty) {
             ProgressDialog.show(context);
              bool result = await crtl.enviarImagenesAlServidor();
                ProgressDialog.dissmiss(context);
              if (result) {
                    print('Las imágenes se enviaron correctamente.');
                    crtl.crearCierreBitacora(context);

                  } else {
                     NotificatiosnService.showSnackBarDanger('Ocurrio un Error');
                     
                   
                  }
          } else {
              crtl.crearCierreBitacora(context);
          }
           crtl.buscaBitacorasCierre('', 'false');
          Navigator.pop(context);


        }
        if (_action == 'EDIT')  {
          // await crtl.crearTurno(context);
          if (crtl.photos.isNotEmpty) {
             ProgressDialog.show(context);
              bool result = await crtl.enviarImagenesAlServidor();
                ProgressDialog.dissmiss(context);
              if (result) {
                    print('Las imágenes se enviaron correctamente.');
                    crtl.crearCierreBitacora(context);

                  } else {
                     NotificatiosnService.showSnackBarDanger('Ocurrio un Error');
                     
                   
                  }
          } else {
              crtl.crearCierreBitacora(context);
          }
           crtl.buscaBitacorasCierre('', 'false');
          Navigator.pop(context);


        }


  }
  }
 
}