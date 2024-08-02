import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/urls/urls.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ValidaAccesoTurno extends StatefulWidget {
  const ValidaAccesoTurno({Key? key}) : super(key: key);

  @override
  State<ValidaAccesoTurno> createState() => _ValidaAccesoTurnoState();
}

class _ValidaAccesoTurnoState extends State<ValidaAccesoTurno> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    final controllerHome = Provider.of<HomeController>(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
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
                'Validar Acceso',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(5.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.iScreen(3.0)), // color: Colors.blue,
                    child: Text('Ingrese su código de verificación.',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            // color: textPrimaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.wScreen(5.0)),
                    child: Form(
                      key: controllerHome.homeFormKey,
                      child: TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.send,
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Código Invalido';
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        )),
                        style: TextStyle(
                          decoration: null,
                          letterSpacing: 2.0,
                          fontSize: size.iScreen(3.0),
                          fontWeight: FontWeight.normal,
                        ),
                        onChanged: (text) {
                          controllerHome.onChangeCodigoAccesoTurno(text);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(2.5)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF0076A7),
                        ),
                      ),
                      onPressed: () async {
                        _submitValidaTurno(size, controllerHome, context);
                      },
                      child: Text('Validar',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.3),
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            )));
  }

  ///====== MUESTRA MODAL TERMINOS Y CONDICIONES =======//
  void _modalTerminosCondiciones(
      Responsive size, HomeController homeController) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final homeControllers = Provider.of<HomeController>(context);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Términos y Condiciones',
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
              actions: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.wScreen(100),
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Wrap(
                        // direction : Axis.horizontal,
                        runAlignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Text(
                              'Debe aceptar términos y condiciones para poder continuar.',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  // color: textPrimaryColor,
                                  fontWeight: FontWeight.normal)),
                          InkWell(
                            child: Text('Ver más...',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    color: tercearyColor,
                                    fontWeight: FontWeight.bold)),
                            onTap: () => abrirPaginaPazViSeg(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.iScreen(2.0),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: homeControllers.getTerminosCondiciones,
                      onChanged: (bool? value) {
                        homeControllers.setTerminosCondiciones(value!);
                      },
                    ),
                    Text('Términos y Condiciones ',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            // color: textPrimaryColor,
                            fontWeight: FontWeight.normal)),
                    //Checkbox
                  ], //<Widget>[]
                ), //Row

                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: size.iScreen(2.5),
                      horizontal: size.iScreen(2.5)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        !homeControllers.getTerminosCondiciones
                            ? Colors.grey
                            : primaryColor,
                      ),
                    ),
                    onPressed: homeControllers.getTerminosCondiciones
                        ? () async {
                            final status = await Permission.location.request();
                            if (status == PermissionStatus.granted) {
                              ProgressDialog.show(context);
                              await homeControllers.getCurrentPosition();

                              ProgressDialog.dissmiss(context);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  "splash", (Route<dynamic> route) => false);
                              // await controllerHome.getCurrentPosition();
                            }
                            if (status == PermissionStatus.denied ||
                                status == PermissionStatus.restricted ||
                                status == PermissionStatus.permanentlyDenied ||
                                status == PermissionStatus.limited) {
                              openAppSettings();
                            }
                          }
                        : null,
                    child: Text('Aceptar',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.3),
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
              ],
            ),
          );
        });
  }

//======================== VAALIDA SCANQR =======================//
  void _validaFormCodigo(Responsive size, HomeController controllerHome) async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      ProgressDialog.show(context);
      await controllerHome.getCurrentPosition();
      ProgressDialog.dissmiss(context);
      Navigator.pushNamedAndRemoveUntil(
          context, "splash", (Route<dynamic> route) => false);
    }
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.limited) {
      openAppSettings();
    }
  }

  void _submitValidaTurno(Responsive size, HomeController controllerHome,
      BuildContext context) async {
    final isValid = controllerHome.validateForm();
    if (!isValid) return;
    if (isValid) {
      final conexion = await Connectivity().checkConnectivity();
      if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
        _modalTerminosCondiciones(size, controllerHome);
      }
    }
  }
}
