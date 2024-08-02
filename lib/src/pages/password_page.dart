import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/password_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:provider/provider.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
         
    return ChangeNotifierProvider<PasswordController>(
      create: (_) => PasswordController(),
      builder: (_, __) {
        final controller = _.read<PasswordController>();

        return Scaffold(
          backgroundColor: Colors.white,
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
              'Recuperar Contraseña',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: size.wScreen(100),
              height: size.hScreen(100),
              margin: EdgeInsets.only(
                  bottom: size.iScreen(2),
                  left: size.iScreen(4.0),
                  right: size.iScreen(4.0)),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: controller.formKeyPassword,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      const LogoImage(),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: size.iScreen(2),
                            left: size.iScreen(2),
                            right: size.iScreen(2)),
                        child: Text(
                          '¿ Olvidaste tu Contraseña ?',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(1.0),
                            horizontal: size.iScreen(0.0)),
                        child: Text(
                          'Escribe tu usuario y código de empresa para recuperarla.',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.9),
                            fontWeight: FontWeight.w400,
                            // color: quinaryColor
                          ),
                        ),
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      //*****************************************/
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Usuario',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            )),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline_outlined),
                        ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(),
                        onChanged: (text) {
                          controller.onChangeUser(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Usuario Inválido';
                          }
                        },
                        onSaved: (value) {},
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      //*****************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      //*****************************************/
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Empresa',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            )),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.apartment_outlined),
                        ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(),
                        onChanged: (text) {
                          controller.onChangeEmpresa(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Código de empresa Inválido';
                          }
                        },
                        onSaved: (value) {},
                      ),
                      //***********************************************/

                      Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(5.0),
                            vertical: size.iScreen(3.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.iScreen(3.0),
                            vertical: size.iScreen(0.5)),
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: size.iScreen(3.5),
                            width: size.iScreen(10.0),
                            child: Text('Enviar',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                )),
                          ),
                          onTap: () => onSubmit(context, controller),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onSubmit(BuildContext context, PasswordController controller) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      ProgressDialog.show(context);
      final response = await controller.passwordRecovery();
      ProgressDialog.dissmiss(context);
      if (response != null) {
        NotificatiosnService.showSnackBarSuccsses("${response["msg"]}");
      }
    }
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: size.iScreen(0.0)),
      width: size.wScreen(60),
      child: Image.asset('assets/imgs/logoNsafe.png'),
    );
  }
}
