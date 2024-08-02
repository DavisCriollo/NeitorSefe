

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';



class CrearApelacionPage extends StatefulWidget {
  const CrearApelacionPage({Key? key}) : super(key: key);

  @override
  State<CrearApelacionPage> createState() => _CrearApelacionPageState();
}

class _CrearApelacionPageState extends State<CrearApelacionPage> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final multasController = Provider.of<MultasGuardiasContrtoller>(context);
     final _user=context.read<HomeController>();
       final ctrlTheme = context.read<ThemeApp>();
         
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: const Color(0xFFEEEEEE),
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
              title: Text(
                  'Apelación Multa  ${multasController.getDataMulta['nomPorcentaje']}%',
                  // style:  Theme.of(context).textTheme.headline2,
                  ),
            
              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(context, multasController);
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
                    key: multasController.validaMultasApelacionFormKey,
                    child: Column(
                      children: [
                         //*****************************************/
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
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Text('Descripción de multa:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                              Spacer(),
                             
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                           '"${multasController.getDataMulta['nomDetalle']}"',
                            textAlign: TextAlign.center,
                            //
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.3),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),

                        SizedBox(
                          width: size.wScreen(100.0),

                          child: Text('Detalle de apelación:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                             ),
                          textAlign: TextAlign.start,
                          style: const TextStyle(

                             ),
                          onChanged: (text) {
                            multasController
                                .onInputDetalleApelacionChange(text);
                          },
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese detalle de la apelación';
                            }
                          },
                        ),
                        //***********************************************/
                        //==========================================//
                        multasController.getListaFotosUrlApelacion!.isNotEmpty
                            ? _CamaraOption(
                                size: size, multasController: multasController)
                            : Container(),
                        //*****************************************/
                      ],
                    ),
                  ),
                )),
            floatingActionButton:
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                onPressed: () {
                  bottomSheet(multasController, context, size);
                },
                backgroundColor: Colors.purpleAccent,
                heroTag: "btnCamara",
                child: const Icon(Icons.camera_alt_outlined),
              ),
              SizedBox(
                height: size.iScreen(1.5),
              ),
            ])),
      ),
    );
  }

  void _onSubmit(
      BuildContext context, MultasGuardiasContrtoller controller) async {
    final isValid = controller.validateFormApelacionMulta();
    if (!isValid) return;
    if (isValid) {
     await controller.creaApelacionMulta(context);
     Navigator.pop(context);
     Navigator.pop(context);
    }
  }

  void bottomSheet(
    MultasGuardiasContrtoller multasController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
             

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                   _funcionCamara(ImageSource.camera, multasController);
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
                    _funcionCamara(ImageSource.gallery, multasController);
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

  void _funcionCamara(
    ImageSource source,
    MultasGuardiasContrtoller multasController,
  ) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    multasController.setNewPictureFileApelacion('${pickedFile.path}');
  
    Navigator.pop(context);

  }
}




class _CamaraOption extends StatefulWidget {
 final MultasGuardiasContrtoller multasController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.multasController,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<MultasGuardiasContrtoller>(
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
                    Text('Fotografía:  ${fotoUrl.getListaFotosUrlApelacion!.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
              SingleChildScrollView(
                child:
                                Wrap(
                        children: fotoUrl.getListaFotosUrlApelacion!
                            .map(
                              (e) => Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget.size.iScreen(1.5)),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),//
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




// class _CamaraOption extends StatelessWidget {
//   final MultasGuardiasContrtoller multasController;
//   const _CamaraOption({
//     Key? key,
//     required this.size,
//     required this.multasController,
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
//             child: Wrap(
//                 children: multasController.getListaFotosUrlApelacion!
//                     .map((e) => _ItemFoto(
//                         size: size,
//                         multasController: multasController,
//                         image: e.url))
//                     .toList()),
//           ),
//         ],
//       ),
//       onTap: () {
//         print('activa FOTOGRAFIA');
//       },
//     );
//   }
// }

// class _ItemFoto extends StatelessWidget {
//   final CreaNuevaFotoMultas? image;
//   final MultasGuardiasContrtoller multasController;

//   const _ItemFoto({
//     Key? key,
//     required this.size,
//     required this.multasController,
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
//                   horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     // color: Colors.red,
//                     // border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   width: size.wScreen(90.0),
//                   // height: size.hScreen(100.0),
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
//             // Navigator.of(context).push(MaterialPageRoute(
//             //     builder: (context) => PreviewScreenMultas(image: image)));
//           },
//         ),
//         Positioned(
//           top: -3.0,
//           right: 4.0,
//           // bottom: -3.0,
//           child: IconButton(
//             color: Colors.red.shade700,
//             onPressed: () {
//               multasController.eliminaFoto(image!.id);
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

class _CompartirClienta extends StatelessWidget {
  final MultasGuardiasContrtoller multasController;
  const _CompartirClienta({
    Key? key,
    required this.size,
    required this.multasController,
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
            child: Text('Compartir a:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          Consumer<MultasGuardiasContrtoller>(
            builder: (_, provider, __) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
                //color: Colors.red,
                width: size.wScreen(100.0),
                height: size.iScreen(
                    provider.getListaCorreosClienteMultas.length.toDouble() *
                        6.3),
                child: ListView.builder(
                  itemCount: provider.getListaCorreosClienteMultas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cliente =
                        provider.getListaCorreosClienteMultas[index];
                    return Card(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.eliminaClienteMulta(cliente['id']);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: size.iScreen(0.5)),
                              child: const Icon(Icons.delete_forever_outlined,
                                  color: Colors.red),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0),
                                  vertical: size.iScreen(1.0)),
                              child: Text(
                                '${cliente['nombres']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.7),
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    // Card(
                    //   child: ListTile(
                    //     visualDensity: VisualDensity.compact,
                    //     title: Text(
                    //       '${cliente['nombres']}',
                    //       style: GoogleFonts.lexendDeca(
                    //           fontSize: size.iScreen(1.6),
                    //           // color: Colors.black54,
                    //           fontWeight: FontWeight.normal),
                    //     ),
                    //     // subtitle: Text(
                    //     //   '{cliente.cliCelular} - {cliente.cliTelefono}',
                    //     //   style: GoogleFonts.lexendDeca(
                    //     //       fontSize: size.iScreen(1.7),
                    //     //       // color: Colors.black54,
                    //     //       fontWeight: FontWeight.normal),
                    //     // ),
                    //     onTap: () {
                    //       // provider.setListaClienteMultasClear();
                    //       provider.eliminaClienteMulta(cliente['id']);
                    //       // print('${cliente['id']}');

                    //     },
                    //     trailing:const Icon(Icons.delete_forever_outlined,color:
                    //     Colors.red)
                    //   ),
                    // );
                  },
                ),
              );
            },
          )
        ],
      ),
      onTap: () {
        print('activa FOTOGRAFIA');
      },
    );
  }
}
