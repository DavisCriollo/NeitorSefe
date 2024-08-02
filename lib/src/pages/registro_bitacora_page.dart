import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';

import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';

import 'package:nseguridad/src/utils/responsive.dart';


import '../controllers/home_controller.dart';

class RegitroBiracora extends StatefulWidget {
  final String? action;
  const RegitroBiracora({Key? key, this.action}) : super(key: key);

  @override
  State<RegitroBiracora> createState() => _RegitroBiracoraState();
}

class _RegitroBiracoraState extends State<RegitroBiracora> {
  final bitacoraController = BitacoraController();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
        final _ctrlTheme=context.read<ThemeApp>();
    final _action = widget.action;

        
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            
         flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _ctrlTheme.primaryColor,
                  _ctrlTheme.secondaryColor,
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
                key: bitacoraController.bitacoraFormKey,
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
             
                       //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                 Consumer<BitacoraController>(builder: (_, value, __) {  
                  return  Container(
                    width: size.wScreen(100.0),
    
                    // color: Colors.blue,
                    child: Text('${value.getItemMotivo}',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  );
                 },),
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),
    
                    // color: Colors.blue,
                    child: Text('Tipo Persona:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                 


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
                                        : 
                                        Text(
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
                              child: GestureDetector(
                                onTap: () {
                                  _modalSeleccionaTipoPersona(
                                      size,bitacoraController);
                                },
                                child:  Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
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
                                    )
                              ),
                            ),
                          ],
                        ),

                    //***********************************************/
                    // SizedBox(
                    //   height: size.iScreen(2.0),
                    // ),
                    //*****************************************/

                    // Row(
                    //   children: [
                    //     Container(
                    //       width: size.wScreen(15.0),

                    //       // color: Colors.blue,
                    //       child: Text('Persona:',
                    //           style: GoogleFonts.lexendDeca(
                    //               // fontSize: size.iScreen(2.0),
                    //               fontWeight: FontWeight.normal,
                    //               color: Colors.grey)),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.only(left: size.iScreen(1.0)),
                    //       width: size.wScreen(70.0),
                    //       // color: Colors.blue,12
                    //       child: TextFormField(
                    //         initialValue: _action == 'CREATE'
                    //             ? ''
                    //             : bitacoraController.getItemTipoPersona,
                    //         style: const TextStyle(),
                    //         textInputAction: TextInputAction.done,
                    //         inputFormatters: <TextInputFormatter>[
                    //           FilteringTextInputFormatter.allow(
                    //               // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                    //               RegExp(r'^[^\n"]*$')),
                    //           UpperCaseText(),
                    //         ],
                    //         onChanged: (text) {
                    //           bitacoraController.setItemTipoPersona(text);
                    //         },
                    //         validator: (text) {
                    //           if (text!.trim().isNotEmpty) {
                    //             return null;
                    //           } else {
                    //             return 'Ingrese tipo de persona';
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Row(
                      children: [
                        Container(
                          width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: Text('Cédula:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.iScreen(1.0)),
                          width: size.wScreen(70.0),
                          // color: Colors.blue,12
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: const InputDecoration(
                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                ),
                            style: TextStyle(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ),
                            onChanged: (text) {
                              bitacoraController.setItemCedula(text);
                            },
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese Cédula';
                              }
                            },
                          ),
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

                      // color: Colors.blue,
                      child: Text('Apellidos y Nombres: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
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
                        bitacoraController.setItemNombres(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Nombres Completos';
                        }
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: size.wScreen(20.0),

                            // color: Colors.blue,
                            child: Text('Teléfono:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            width: size.wScreen(50.0),
                            child: TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: const InputDecoration(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(),
                              onChanged: (text) {
                                bitacoraController.setItemTelefono(text);
                              },
                              validator: (text) {
                                if (text!.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Debe ingresar teléfono';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Se dirige a:',
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
                        bitacoraController.setItemSeDirigeA(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese lugar de destino';
                        }
                      },
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Motivo:',
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
                        bitacoraController.setItemMotivo(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese lugar de destino';
                        }
                      },
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
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Observación';
                        }
                      },
                    ),
                    //  //==========================================//
                    //     bitacoraController.getListaFotosUrl!.isNotEmpty
                    //         ? _CamaraOption(
                    //             size: size,controller: bitacoraController,)
                    //         : Container(),
                    //     //*****************************************/

// Consumer<BitacoraController>(builder: (_, valueFoto, __) {
//   return
//                     valueFoto.getListaFotosCreaBitacora.isNotEmpty
//                         ? _CamaraOption(
//                             size: size,controller: bitacoraController,)
//                         : Container();
                    //*****************************************/
//  },)
                    //*****************************************/
                   
                   
                    Consumer<BitacoraController>(
                      builder: (_, valueFoto, __) {
                        return

                            valueFoto.listaImages.isNotEmpty
                          ?  Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               Container(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                margin: EdgeInsets.symmetric(
                  vertical: size.iScreen(1.0),
                  horizontal: size.iScreen(0.0),
                ),
                child:
                    Text('Fotografías:  ${valueFoto.listaImages.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
                              Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: List.generate(valueFoto.listaImages.length,
                                        (index) {
                                      final image = valueFoto.listaImages[index];
                                      return Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.iScreen(1.5)),
                                            // width: 80,
                                            // height: 80,
                                            child: Image.file(image),
                                          ),
                                          // Positioned(
                                          //   top: 0,
                                          //   right: 0,
                                          //   child: IconButton(
                                          //     icon: Icon(Icons.close),
                                          //     onPressed: () {
                                          //       valueFoto.removeImage(image);
                                          //     },
                                          //   ),
                                          // ),
                                          Positioned(
                                            top: 10.0,
                                            right: 2.0,
                                            // bottom: -3.0,
                                            child: IconButton(
                                              color: Colors.red.shade700,
                                              onPressed: () {
                                                valueFoto.removeImage(image);
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
                                    })),
                            ],
                          )
                                :Container();
                      },
                    )

                    //*****************************************/
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final _controller = context.read<BitacoraController>();
              bottomSheet(context, size, _controller);
            },
            backgroundColor:    _ctrlTheme.primaryColor,
            heroTag: "btnCamara",
            child: const Icon(Icons.camera_alt_outlined),
          ),
        ),
      ),
    );
  }

//********************************************** SELECT DE TIPO DE PERSONA **********************************************************************//

  //====== MUESTRA MODAL DE TIPO DE PERSONA =======//
  void _modalSeleccionaTipoPersona(
      Responsive size, BitacoraController _control) {

final  _data=[ 'PERSONAL PROPIO',
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
                    height: size.hScreen(26),
                    child: ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            _control.setItemTipoPersona( _data[index]);
            Navigator.pop(context);
          },
          child: Container(color: Colors.grey[100],
          margin: EdgeInsets.symmetric(vertical: size.iScreen(0.3)),
          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(1.0)),
            child:Text(
                        _data[index],
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),),
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
//********************************************** FOTOGRAFIA **********************************************************************//
  void bottomSheet(
      BuildContext context, Responsive size, BitacoraController _controller) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async{
                    // _funcionCamara(ImageSource.camera);
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      File image = File(pickedFile.path);
                      _controller.addImage(image);
                      Navigator.pop(context);
                    }

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
                  onPressed: () async {
                    // _funcionCamara(ImageSource.gallery);
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      File image = File(pickedFile.path);
                      _controller.addImage(image);
                      Navigator.pop(context);
                    }
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

//******************************************** FUNCION DE LA CAMARA  ********************************************************************************//
  void _funcionCamara(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    bitacoraController.setNewPictureFile('${pickedFile.path}');

    Navigator.pop(context);
  }

//********************************************************************************************************************************//
  void _onSubmit(BuildContext context, BitacoraController _controller,
      String _action) async {
//     final isValid = _controller.validateForm();
//     if (!isValid) return;
//     if (isValid) {
//       if (_controller.getItemTelefono!.length < 9 ||
//           _controller.getItemTelefono!.length > 10) {
//         NotificatiosnService.showSnackBarDanger(
//             'Numero de teléfono incorrecto');
//       }
// //  print('Número válido: ${_controller.getItemTelefono}');

//       else if (_controller.getItemTelefono!.length == 9 ||
//           _controller.getItemTelefono!.length == 10) {
//         if (_action == 'CREATE') {
//           _controller.creaBitacora(context);

//           Navigator.pop(context);
//         } else if (_action == 'EDIT') {
//           // await _controller.editaAusencia(context);
//           Navigator.pop(context);
//         }
//       }
//     } else {
      
//     }

// _controller.enviarImagenesAlServidor();

 print('Número válido: ${_controller.listaImages}');




  }
}

class _CamaraOption extends StatefulWidget {
  final BitacoraController controller;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<BitacoraController>(
        builder: (_, fotoUrl, __) {
          return Column(
            children: [
              Container(
                width: widget.size.wScreen(100.0),
                // color: Colors.blue,
                margin: EdgeInsets.symmetric(
                  vertical: widget.size.iScreen(1.0),
                  horizontal: widget.size.iScreen(0.0),
                ),
                child:
                    Text('Fotografía:  ${fotoUrl.getListaFotosUrl!.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
              SingleChildScrollView(
                child: Wrap(
                    children: fotoUrl.getListaFotosUrl!
                        .map(
                          (e) => Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.size.iScreen(1.5)),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/imgs/loader.gif'), //
                                  image: NetworkImage('${e['url']}'),
                                ),
                              ),
                              Positioned(
                                top: -3.0,
                                right: 4.0,
                                // bottom: -3.0,
                                child: IconButton(
                                  color: Colors.red.shade700,
                                  onPressed: () {
                                    setState(() {
                                      fotoUrl.eliminaFotoUrl(e['url']);
                                    });
                                    // bottomSheetMaps(context, size);
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    size: widget.size.iScreen(3.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
            ],
          );
        },
      ),
      onTap: () {
        print('activa FOTOGRAFIA');
      },
    );
  }
}

//==========================================================//

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:sincop_app/src/controllers/bitacora_controller.dart';

// class RegitroBiracora extends StatelessWidget {
//    final  String? action;
//   const RegitroBiracora({Key? key, this.action}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final imageProvider = Provider.of<BitacoraController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Fotos'),
//       ),
//       body: ListView.builder(
//         itemCount: imageProvider.images.length,
//         itemBuilder: (context, index) {
//           final image = imageProvider.images[index];
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                   width: 100,
//                   height: 100,
//                   child: Image.file(image),),

//                 IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: () {
//                     imageProvider.removeImage(image);
//                   },
//                 ),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final picker = ImagePicker();
//           final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//           if (pickedFile != null) {
//             File image = File(pickedFile.path);
//             imageProvider.addImage(image);
//           }
//         },
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }
// //==========================================================//
