import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';

class ValidaAccesoMultas extends StatefulWidget {
  const ValidaAccesoMultas({Key? key}) : super(key: key);

  @override
  State<ValidaAccesoMultas> createState() => _ValidaAccesoMultasState();
}

class _ValidaAccesoMultasState extends State<ValidaAccesoMultas> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void dispose() {
    _textSearchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final controllerMultas = Provider.of<MultasGuardiasContrtoller>(context);
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
                'Valida Acceso',
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
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.wScreen(5.0)),
                    child: Form(
                      key: controllerMultas.validaMultasGuardiaFormKey,
                      child: TextFormField(
                        controller: _textSearchController,
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
                          controllerMultas.onInputBuscaGuardiaChange(text);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(2.5)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF0A4280),
                        ),
                      ),
                      onPressed: () {
                        _submit(controllerMultas);
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

  void _submit(MultasGuardiasContrtoller controllerMultas) async {
    final isValid = controllerMultas.validateFormValidaMulta();
    if (!isValid) return;
    if (isValid) {
      final conexion = await Connectivity().checkConnectivity();
      if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
        ProgressDialog.show(context);
        await controllerMultas.buscaGuardiaMultas('');
        ProgressDialog.dissmiss(context);
        final response = controllerMultas.getErrorInfoMultaGuardia;
        if (response == true) {
          Navigator.pushNamed(context, 'crearMultasGuardias');
        } else {
          NotificatiosnService.showSnackBarDanger('No existe registrto');
        }
      }
    }
  }
}
