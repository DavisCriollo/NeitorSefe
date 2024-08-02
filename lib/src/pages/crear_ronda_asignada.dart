import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/crea_uuid.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/service/notifications_service.dart' as snaks;


class CrearRondaAsignada extends StatefulWidget {
final String lugar;
  final Map<String,dynamic> requeridos;

  const CrearRondaAsignada({Key? key,  required this.lugar, required this.requeridos}) : super(key: key);

  @override
  State<CrearRondaAsignada> createState() => _CrearRondaAsignadaState();
}

class _CrearRondaAsignadaState extends State<CrearRondaAsignada> {
  @override
  Widget build(BuildContext context) {
    // print('LUGAR DE ACTIVIDAD ${widget.lugar}');
        final _user = context.read<HomeController>();
  final _controller = context.read<ActividadesAsignadasController>();
    final ctrlTheme = context.read<ThemeApp>();
        

 final _isRequiered=widget.requeridos;
  // print('EL MAPAasdasd : ${widget.requeridos}');
  // print('EL _isRequiered : $_isRequiered');
    final Responsive size = Responsive.of(context);
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
                  ctrlTheme.primaryColor,
                  ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
              title: Text(
                ' Crear ${widget.lugar}',
                // style: Theme.of(context).textTheme.headline2,
              ),
               actions: [
    
                  Container(
                    margin: EdgeInsets.only(right: size.iScreen(1.5)),
                    child:
                     IconButton(
                        splashRadius: 28,
                        onPressed: () {

                       _onSubmit(context,_controller,'');
                       
    
                        },
                        icon: Icon(
                          Icons.save_outlined,
                          size: size.iScreen(4.0),
                        )),
   
                  )
                ],
            ),
          body: Container(
             margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                 //*****************************************/
                
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                
            //                     //==========================================//
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
              //*****************************************/
                
                      SizedBox(
                        height: size.iScreen(0.5),
                      ),
                
            //                     //==========================================//
                SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Text('Actividad:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                      width: size.wScreen(100.0),
                      child: Text(
                        '"${_controller.getNombreEvento}"',
                        textAlign: TextAlign.center,
                        //
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.3),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),

             //********************** EL TEXTO*************************/
            
            
                
             //***********************************************/
             _isRequiered.containsKey('texto') && _isRequiered['texto'] == 'SI'
                     ? Column(
                        children: [
                          SizedBox(
                            height: size.iScreen(0.5),
                          ),
                          //==========================================//
                            
                                  Container(
                                    width: size.wScreen(100.0),
                
                                    // color: Colors.blue,
                                    child: Text('Observación:',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        // suffixIcon: Icon(Icons.beenhere_outlined)
                                        ),
                                    textAlign: TextAlign.start,
                                                                   minLines: 1,
          maxLines: 3,
          style: const TextStyle(),
          textInputAction: TextInputAction.done,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
             RegExp(r'^[^\n"]*$')),
          ],
                                    onChanged: (text) {
                                      _controller.setInputTituloRonda(text);
                                    },
                                    validator: (text) {
                                      if (text!.trim().isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'Ingrese Título de actividad';
                                      }
                                    },
                                  ),
            //                  
             //***********************************************/
                        ],
                      ):Container(),
                
              _isRequiered.containsKey('qr') && _isRequiered['qr'] == 'SI'
                     ?
                Column(
                  children: [
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                      //*****************************************/
                Row(
                  children: [
                    SizedBox(
                     child: Text('Escanear QR ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //***********************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/
    
                  ],
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
                        child: Consumer<ActividadesAsignadasController>(
                          builder: (_, valueQr, __) {
                           
                            return (valueQr.getDataQR == '' ||
                                    valueQr.getDataQR == null)
                                ? Text(
                                    'No hay informacón de QR',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    '${valueQr.getDataQR} ',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
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
                                // _modalSeleccionaGuardia(
                                //     size, ausenciaController);
                                _validaScanQR(size,_controller);
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
                                        Icons.qr_code_2_outlined,
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
                  ],
                ):Container(),
              
            //                     //*****************************************/
                
                      SizedBox(
                        height: size.iScreen(0.5),
                      ),
                
                  //================================================================//
                   //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
               
           
                  Consumer<ActividadesAsignadasController>(
                    builder: (_, valueFoto, __) {
                      return valueFoto.getListaFotosUrl!.isNotEmpty
                          ? _CamaraOption(
                              size: size, actividadController: valueFoto)
                          : Container();
                    },
                  ),
                  //*****************************************/
                  Consumer<ActividadesAsignadasController>(
                    builder: (_, valueVideo, __) {
                      return valueVideo.getUrlVideo!.isNotEmpty
                          ? _CamaraVideo(
                              size: size,
                              informeController: valueVideo,
                            )
                          : Container();
                    },
                  ),
                  //***********************************************/
                  SizedBox(
                    width: size.iScreen(1.0),
                  ),
                 

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(3.0),
                  ),
                  //================================================================//





                ],
              )),
         ),
                floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isRequiered.containsKey('foto') && _isRequiered['foto'] == 'SI'
                       ?  FloatingActionButton(
                onPressed: () {
                  bottomSheet(_controller, context, size);
                },
                backgroundColor: Colors.purpleAccent,
                heroTag: "btnCamara",
                child: const Icon(Icons.camera_alt_outlined),
              ):Container(),
              SizedBox(
                height: size.iScreen(1.5),
              ),
             
              //********************VIDEO***************************//
              _isRequiered.containsKey('video') && _isRequiered['video'] == 'SI'
                       ?  FloatingActionButton(
                backgroundColor: _controller.getPathVideo!.isEmpty
                    ? Colors.blue
                    : Colors.grey,
                   
                heroTag: "btnVideo",
                child: 
                
                // _controller.getPathVideo!.isEmpty
                //     ? const Icon(Icons.videocam_outlined, color: Colors.white)
                //     : const Icon(
                //         Icons.videocam_outlined,
                //         color: Colors.black,
                //       ),
               const Icon(Icons.videocam_outlined, color: Colors.white),
                   
                onPressed:
                 _controller.getPathVideo!.isEmpty
                    ? () {
                        bottomSheetVideo(_controller, context, size);
                       
                      }
                    : null,
                //  () {
                //         bottomSheetVideo(_controller, context, size);
                       
                //       }
                   
              ):Container(),
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

   void _onSubmit(BuildContext context, ActividadesAsignadasController _actividadController, String _estado)  async{

final _controller=context.read<ActividadesAsignadasController>();


//  final isValid = _controller.validateFormRonda();
//     if (!isValid) return;
//     if (isValid)  {


    



 final conexion = await Connectivity().checkConnectivity();
      if (_controller.getInputTituloRonda == null ||_controller.getInputTituloRonda == '') {
        NotificatiosnService.showSnackBarError('Debe agregar Título de actividad');
      } 
      // else if (widget.lugar=='RONDAS'&&_controller.getInfoDataQR == null ||widget.lugar=='RONDAS'&&_controller.getInfoDataQR == '' ||widget.lugar=='RONDAS'&&_controller.getCoords==''||_controller.getCoords==null) {
      //   NotificatiosnService.showSnackBarDanger('Debe escanear QR');
      // }
      else if ( widget.requeridos.containsKey('texto')&&widget.requeridos['texto'] == 'SI' && _controller.getInputTituloRonda!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe ingresar observación');
      }
      else if ( widget.requeridos.containsKey('qr')&&widget.requeridos['qr'] == 'SI' && _controller.getDataQR == '' ) {
        NotificatiosnService.showSnackBarDanger('Debe ingresar código QR');
      }
      else if ( widget.requeridos.containsKey('foto')&&widget.requeridos['foto'] == 'SI' && _controller.getListaFotosInforme.isEmpty ) {
        NotificatiosnService.showSnackBarDanger('Debe agregar foto');
      }
      else if ( widget.requeridos.containsKey('video')&&widget.requeridos['video'] == 'SI' && _controller.getUrlVideo!.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar video');
      }

      else if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      }
       else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
              
               if(widget.lugar=='RONDAS'){
             ProgressDialog.show(context);

            // await _controller.getCurrentPosition();

             

            String _uuidV4 = generateUniqueId();

           final  response = await _controller.guardaActividadRonda(context,widget.lugar);
               ProgressDialog.dissmiss(context);
            if (response != null) {


                if (response.statusCode == 200) {
                   
                  Navigator.pop(context);
              Navigator.pop(context);
               _controller.resetValuesActividades();
                    _controller.borrarDatos();
                    _controller.agruparProductos();
                    _controller.getActividadesAsignadas('', 'false');
                    
//                     if (response.containsKey('data') && response['data'].containsKey('msg')) {
//                           // La clave 'msg' está presente en la respuesta
//                           String errorMsg = response['data']['msg'];
//                           snaks.NotificatiosnService.showSnackBarDanger(errorMsg);
//   print('Mensaje: $errorMsg');
// } else {
//   // La clave 'msg' no está presente en la respuesta
  print('La clave "msg" +++++++++++++++++++++++++> ${response.body.runtimeType}');
    Map<String, dynamic> data = jsonDecode(response.body);
  //  if (responseMap.containsKey('msg')) {
  //     String message = responseMap['msg'];
  //       snaks.NotificatiosnService.showSnackBarDanger(message);
  //     print('La propiedad "msg" está presente con el valor: $message');
  //   } else {
  //     print('La propiedad "msg" no está presente en la respuesta');
  //   }
  
   
    if (data.containsKey('msg')) {
      String message = data['msg'];
      print('La propiedad "msg" está presente con el valor: $message');
    } else {
      print('La propiedad "msg" no está presente en la respuesta');
       String message = data['data']['msg'].toString();
        snaks.NotificatiosnService.showSnackBarDanger(message);
    }
  
// }
                    //  String errorMsg = json.decode(response.body)['msg'];

             
                } else {
                  String errorMsg = json.decode(response.body)['data']['msg'];
snaks.NotificatiosnService.showSnackBarDanger(errorMsg);
                }
              
             

            }else{
              Navigator.pop(context);
              Navigator.pop(context);
              NotificatiosnService.showSnackBarDanger('problemas al guardar el registro');
            }
               }else  
              //  if(widget.lugar=='INVENTARIO EXTERNO')
               {
  ProgressDialog.show(context);
            final response = await _controller.guardaActividadInventarioExterno(context,widget.lugar);
    ProgressDialog.dissmiss(context);
            if (response != null) {
              
              Navigator.pop(context);
              Navigator.pop(context);
              // _controller.resetValuesActividades();
                    _controller.borrarDatos();
                    _controller.agruparProductos();
              _controller.getActividadesAsignadas('','false');

            }else{
             NotificatiosnService.showSnackBarDanger(' Problemas al guardar registro ');
            }
               }
           
       
        } 
      // }




      // if (_actividadController.getTextDirigido!.isEmpty) {
      //   NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
      // } else if (_actividadController.getTextDirigido == null) {
      //   NotificatiosnService.showSnackBarDanger('Debe elegir a persona');
      // } else {
      //   await _actividadController.crearInforme(context);
      //   Navigator.pop(context);
      // }
    }

//======================== VAALIDA SCANQR =======================//
  void _validaScanQR(Responsive size, ActividadesAsignadasController _controller) async {
    bool _isMounted = false;

    
  String scanResult ='';



  
    try {
    scanResult=await FlutterBarcodeScanner.scanBarcode(
          '#34CAF0', '', false, ScanMode.QR);
      if (!mounted) return;

      _isMounted = true;

       print("=================El String QR $scanResult");
      final status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
       
          ProgressDialog.show(context);
          
          await _controller.getCurrentPosition();
          if (_isMounted) {

            
                if( scanResult!="-1"){
                 

List<String> parts = scanResult.split(RegExp(r"[-\*]")).where((part) => !part.contains("@") && part.isNotEmpty).toList();

  // if (parts.length >= 2 && parts[1] == _controller.getNombreEvento.toString()) {
   _controller.setInfoDataQR('');
                    _controller.setInfoDataQR(scanResult);
                    _controller.setDataQR(parts[1].trim());
                      NotificatiosnService.showSnackBarSuccsses('Datos Correctos ');
  // } 
  // else {
  //    _controller.setInfoDataQR('');
  //                     _controller.setDataQR('');
  //                 NotificatiosnService.showSnackBarError('Los Datos no cumplen con los requisitos');
  //   print("=================El String no cumple con los requisitos");
  // }
                 
             }
                else
                {
                   _controller.setInfoDataQR('');
                     _controller.setDataQR('');
                    NotificatiosnService.showSnackBarDanger('Scaner Cancelado ');
                }


            ProgressDialog.dissmiss(context);
          
        
      }
      if (status == PermissionStatus.denied ||
          status == PermissionStatus.restricted ||
          status == PermissionStatus.permanentlyDenied ||
          status == PermissionStatus.limited) {
        openAppSettings();
      }
  }
    } on PlatformException {
      NotificatiosnService.showSnackBarError('No se pudo escanear ');
    }
}


void bottomSheet(
    ActividadesAsignadasController _controller,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
             
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                   _funcionCamara(ImageSource.camera, _controller);
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
                    _funcionCamara(ImageSource.gallery, _controller);
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

  void bottomSheetVideo(
    ActividadesAsignadasController _controller,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
             

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(ImageSource.camera, _controller);
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
                    _funcionCamaraVideo(ImageSource.gallery, _controller);
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

  void _funcionCamara(
      ImageSource source, ActividadesAsignadasController  _actController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    _actController.setNewPictureFile('${pickedFile.path}');

    Navigator.pop(context);

  }

  void _funcionCamaraVideo(
      ImageSource source, ActividadesAsignadasController _actController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(
      source: source,
    );

    if (pickedFile == null) {
      return;
    }
  _actController.setPathVideo(pickedFile.path);
 Navigator.pop(context);

  }





}


class _CamaraVideo extends StatelessWidget {
  const _CamaraVideo({
    Key? key,
    required this.size,
    required this.informeController,
  }) : super(key: key);

  final Responsive size;
  final ActividadesAsignadasController informeController;

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
              informeController.eliminaVideo();
            },
            child: Container(
              margin: EdgeInsets.only(right: size.iScreen(0.5)),
              child:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
          ),
          //  const Icon(Icons.delete_forever_outlined,
          //   color: Colors.red),

          trailing: Icon(
            Icons.video_file_outlined,
            size: size.iScreen(5.0),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'videoSreen',
                arguments: '${informeController.getUrlVideo}');
          },
        ),
       
      ],
    );
  }
}

class _CamaraOption extends StatefulWidget {
  final ActividadesAsignadasController actividadController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.actividadController,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<ActividadesAsignadasController>(
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
                    Text('Fotografía:  ${fotoUrl.getListaFotosInforme.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
              SingleChildScrollView(
                child:
                    
                    Wrap(
                        children: fotoUrl.getListaFotosUrl!
                            .map(
                              (e) => Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget.size.iScreen(1.5)),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),
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
     },
    );
  }
}