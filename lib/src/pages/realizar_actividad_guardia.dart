import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class RealizarActividadGuardia extends StatefulWidget {
  final dynamic infoActividad;
  const RealizarActividadGuardia({Key? key, this.infoActividad})
      : super(key: key);

  @override
  State<RealizarActividadGuardia> createState() =>
      _RealizarActividadGuardiaState();
}

class _RealizarActividadGuardiaState extends State<RealizarActividadGuardia> {
  @override
  Widget build(BuildContext context) {
    final activitiesController = Provider.of<ActivitiesController>(context);
    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
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
              'Realizar Actividad',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, activitiesController);
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
            margin: EdgeInsets.only(top: size.iScreen(3.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: activitiesController.actividadesFormKey,
                child: Column(
                  children: [
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Row(
                        children: [
                          Text('Asunto:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                          Spacer(),
                          Text(
                              ' ${widget.infoActividad['actFecReg']}'
                                  .toString()
                                  .replaceAll(".000Z", "")
                                  .replaceAll("T", " "),
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                      width: size.wScreen(100.0),
                      child: Text(
                        ' "${widget.infoActividad['actAsunto']}"',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.3),
                            fontWeight: FontWeight.normal),
                      ),
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                      width: size.wScreen(100.0),
                      child: Text(
                        ' ${widget.infoActividad['actObservacion']}',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/
                    //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Text('Observaciones:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),

                    TextFormField(
                      maxLines: 2,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(),
                      onChanged: (text) {
                        activitiesController
                            .onInputObservacionesRealizaActivitiesChange(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Observaciones';
                        }
                      },
                      onSaved: (value) {},
                    ),
                    //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),

                    //*****************************************/
                    Consumer<ActivitiesController>(
                      builder: (_, valueQR, __) {
                        return activitiesController.getInfoQR != ''
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: size.wScreen(100.0),
                                    // color: Colors.blue,
                                    child: Text('Informació QR :',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.iScreen(1.0)),
                                    width: size.wScreen(100.0),
                                    child: Text(
                                      ' ${valueQR.getInfoQR}',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          // color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox();
                      },
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    // ==========================================//
                    activitiesController
                            .getListaFotosListaFotosRealizaActividades
                            .isNotEmpty
                        ? _CamaraOption(
                            size: size,
                            activitiesController: activitiesController,
                          )
                        : Container(),
                    // *****************************************/
                    //==========================================//
                    activitiesController.getUrlVideo!.isNotEmpty
                        ? _CamaraVideo(
                            size: size,
                            activitiesController: activitiesController,
                          )
                        : Container(),
                    //*****************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/
                    //========================================//
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
              // ==========================================//
              FloatingActionButton(
                onPressed: () {
                  bottomSheet(activitiesController, context, size);
                },
                backgroundColor: Colors.purpleAccent,
                heroTag: "btnCamara",
                child: const Icon(Icons.camera_alt_outlined),
              ),

              //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
              // ==========================================//
              FloatingActionButton(
                backgroundColor: activitiesController.getPathVideo == ''
                    ? Colors.blue
                    : Colors.grey,
                heroTag: "btnVideo",
                child: activitiesController.getPathVideo == ''
                    ? const Icon(Icons.videocam_outlined, color: Colors.white)
                    : const Icon(
                        Icons.videocam_outlined,
                        color: Colors.black,
                      ),
                onPressed: activitiesController.getVideoUrl.isEmpty
                    ? () {
                        bottomSheetVideo(activitiesController, context, size);
                      }
                    : null,
              ),
              SizedBox(
                height: size.iScreen(1.5),
              ),

              SizedBox(
                height: size.iScreen(1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

//======================== VAALIDA SCANQR =======================//
  void _validaScanQR(
      Responsive size, ActivitiesController activitiesController) async {
    try {
      activitiesController.setInfoQR(await FlutterBarcodeScanner.scanBarcode(
          '#34CAF0', '', false, ScanMode.QR));
      if (!mounted) return;

      ProgressDialog.show(context);
      await activitiesController.validaCodigoQR(context);
      ProgressDialog.dissmiss(context);
    } on PlatformException {
      NotificatiosnService.showSnackBarError('No se pudo escanear ');
    }
  }

  void bottomSheet(
    ActivitiesController consignasController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.camera, consignasController);
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
                    _funcionCamara(ImageSource.gallery, consignasController);
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
      ImageSource source, ActivitiesController activitiesController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    activitiesController
        .setNewPictureFileRealizaActividades('${pickedFile.path}');

    Navigator.pop(context);
  }

  void bottomSheetVideo(
    ActivitiesController activitiesController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(
                        ImageSource.camera, activitiesController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Video',
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
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(
                        ImageSource.gallery, activitiesController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Galería',
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

  void _funcionCamaraVideo(
      ImageSource source, ActivitiesController activitiesController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(
      source: source,
    );

    if (pickedFile == null) {
      return;
    }
    activitiesController.setPathVideo(pickedFile.path);

    Navigator.pop(context);
  }

  //********************************************************************************************************************//
  void _onSubmit(
    BuildContext context,
    ActivitiesController activitiesController,
  ) async {
    final isValid = activitiesController.validateForm();
    if (!isValid) return;
    if (isValid) {
      final conexion = await Connectivity().checkConnectivity();
      if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
        await activitiesController.relizaGuardiaActividad(
            widget.infoActividad['actId'], context);

        Navigator.pop(context);
      }
    }
  }
}
// }

class _CamaraOption extends StatelessWidget {
  final ActivitiesController activitiesController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.activitiesController,
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
            child: Text('Fotografía: ',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
              child: Wrap(
                  children: activitiesController
                      .getListaFotosListaFotosRealizaActividades
                      .map((e) => _ItemFoto(
                          size: size,
                          consignasController: activitiesController,
                          image: e))
                      .toList())),
        ],
      ),
      onTap: () {},
    );
  }
}

class _ItemFoto extends StatelessWidget {
  final CreaNuevaFotoRealizaActividadGuardia? image;
  final ActivitiesController consignasController;

  const _ItemFoto({
    Key? key,
    required this.size,
    required this.consignasController,
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
                  horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.wScreen(95.0),
                  height: size.hScreen(50.0),
                  padding: EdgeInsets.symmetric(
                    vertical: size.iScreen(0.0),
                    horizontal: size.iScreen(0.0),
                  ),
                  child: getImage(image!.path),
                ),
              ),
            ),
          ),
          onTap: () {},
        ),
        Positioned(
          top: -3.0,
          right: 4.0,
          // bottom: -3.0,
          child: IconButton(
            color: Colors.red.shade700,
            onPressed: () {
              consignasController.eliminaFotoRealizaConsigna(image!.id);
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

class _CamaraVideo extends StatelessWidget {
  const _CamaraVideo(
      {Key? key, required this.size, required this.activitiesController})
      : super(key: key);

  final Responsive size;
  final ActivitiesController activitiesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.wScreen(100.0),
          // color: Colors.blue,
          margin: EdgeInsets.symmetric(
            vertical: size.iScreen(1.0),
            horizontal: size.iScreen(0.5),
          ),
          child: Text('Video:',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        ListTile(
          tileColor: Colors.grey.shade300,
          dense: true,
          title: Text(
            'Video seleccionado',
            style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.7),
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          leading: InkWell(
            onTap: () {
              activitiesController.eliminaVideo();
            },
            child: Container(
              margin: EdgeInsets.only(right: size.iScreen(0.5)),
              child:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
          ),
          trailing: Icon(
            Icons.video_file_outlined,
            size: size.iScreen(5.0),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'videoSreen',
                arguments: '${activitiesController.getUrlVideo}');
          },
        ),
      ],
    );
  }
}
