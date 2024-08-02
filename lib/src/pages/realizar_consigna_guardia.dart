import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/consignas_clientes_controller.dart';
import 'package:nseguridad/src/models/crea_foto_realiza_consigna_guardia.dart';

import 'package:nseguridad/src/pages/view_photo_realiza_consigna_guardia.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';

class RealizarConsignaPage extends StatefulWidget {
  final dynamic infoConsignaGuardia;
  const RealizarConsignaPage({Key? key, this.infoConsignaGuardia})
      : super(key: key);

  @override
  State<RealizarConsignaPage> createState() => _RealizarConsignaPageState();
}

class _RealizarConsignaPageState extends State<RealizarConsignaPage> {
  @override
  Widget build(BuildContext context) {
    final consignasController =
        Provider.of<ConsignasClientesController>(context, listen: false);
    final Responsive size = Responsive.of(context);
        final _ctrlTheme=context.read<ThemeApp>();
      String fechaLocal =  widget.infoConsignaGuardia!['conFecReg']==''?'--- --- ':DateUtility.fechaLocalConvert(  widget.infoConsignaGuardia!['conFecReg']!.toString());
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
                  _ctrlTheme.primaryColor,
                  _ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
            title: Text(
              'Realizar Consigna',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, consignasController,
                          widget.infoConsignaGuardia);
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.iScreen(3.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: consignasController.consignasClienteFormKey,
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
                              // widget.infoConsignaGuardia!['conFecReg']
                              //     .toString()
                              //     .replaceAll(".000Z", "")
                              //     .replaceAll("T", " "),
                              fechaLocal,
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
                        '"${widget.infoConsignaGuardia!['conAsunto']}"',
                        textAlign: TextAlign.center,
                        //
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
                        '${widget.infoConsignaGuardia!['conDetalle']}',
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
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                       FilteringTextInputFormatter.deny(RegExp(r'[\n]')), //// NO PERMITE INGRESAR ENTER
                      ],
                      onChanged: (text) {
                        consignasController
                            .onInputObservacionesRealizaConsignaChange(text);
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

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //==========================================//

                    Consumer<ConsignasClientesController>(
                      builder: (_, valueFotos, __) {
                        return valueFotos.getListaFotosListaFotosRealizaConsigna
                                .isNotEmpty
                            ? _CamaraOption(
                                size: size, consignasController: valueFotos)
                            : Container();
                      },
                    ),

                    //========================================//
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bottomSheet(consignasController, context, size);
            },
            backgroundColor:    _ctrlTheme.primaryColor,
            heroTag: "btnCamara",
            child: const Icon(Icons.camera_alt_outlined),
          ),
        ),
      ),
    );
  }

  void bottomSheet(
    ConsignasClientesController consignasController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    // urls.launchWaze(lat, lng);s
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

  void _funcionCamara(ImageSource source,
      ConsignasClientesController consignasController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    consignasController.setNewPictureFileRealizaConsigna('${pickedFile.path}');

//===============================//
    _downloadImage(pickedFile.path);
//===============================//
    Navigator.pop(context);

    // Navigator.pop(context);
  }

  void _downloadImage(String? image) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(image!);
      if (imageId == null) {
        return;
      }

      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {}
  }

  //********************************************************************************************************************//
  void _onSubmit(
      BuildContext context,
      ConsignasClientesController consignasController,
      dynamic infoConsignaGuardia) async {
    final isValid = consignasController.validateForm();
    if (!isValid) return;
    if (isValid) {
      final conexion = await Connectivity().checkConnectivity();
      if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
        await consignasController.relizaGuardiaConsigna(
            infoConsignaGuardia!['conId'], context);
        Navigator.pop(context);
        Navigator.pop(context);
         
      }
    }
  }
}

class _CamaraOption extends StatelessWidget {
  final ConsignasClientesController consignasController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.consignasController,
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
            child: Text(
                'Fotografía: ${consignasController.getListaFotosListaFotosRealizaConsigna.length}',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
              child: Wrap(
                  children: consignasController
                      .getListaFotosListaFotosRealizaConsigna
                      .map((e) => _ItemFoto(
                          size: size,
                          consignasController: consignasController,
                          image: e))
                      .toList())),
        ],
      ),
      onTap: () {},
    );
  }
}

class _ItemFoto extends StatelessWidget {
  final CreaNuevaFotoRealizaConsignaGuardia? image;
  final ConsignasClientesController consignasController;

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
                  horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                builder: (context) =>
                    PreviewScreenRealizaConsignaGuardia(image: image)));
          },
        ),
        Positioned(
          top: -3.0,
          right: 4.0,
          // bottom: -3.0,
          child: IconButton(
            color: Colors.red.shade700,
            onPressed: () {
              consignasController.eliminaFotoRealizaConsigna(image!.id);
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
