import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/login_controller.dart';
import 'package:nseguridad/src/controllers/login_ctrl.dart';

import 'package:nseguridad/src/pages/permisos_page.dart';
import 'package:nseguridad/src/pages/home.dart';
import 'package:nseguridad/src/pages/splash_screen.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
// import 'package:nseguridad/src/services/notifications_service.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/modal_permisos.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final controlador=LoginController();
  bool _obscureText = true;
  TextEditingController? _textEmpresa = TextEditingController();
  TextEditingController? _textUsuario = TextEditingController();
  TextEditingController? _textClave = TextEditingController();
  final logData = LoginController();
  bool _isCheck = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    inicialData();
    super.initState();
  }

  void inicialData() async {
    final datosRecordarme = await Auth.instance.getDataRecordarme();
    if (datosRecordarme != null && datosRecordarme[0] == 'true') {
      _textEmpresa!.text = '${datosRecordarme[1]}';
      _textUsuario!.text = '${datosRecordarme[2]}';
      _textClave!.text = '${datosRecordarme[3]}';

      logData.onRecuerdaCredenciales(true);

      logData.setLabelNombreEmpresa(datosRecordarme[1]);
      logData.onChangeUser(datosRecordarme[2]);
      logData.onChangeClave(datosRecordarme[3]);
    } else if (datosRecordarme == null || datosRecordarme[0] == 'false') {
      _textEmpresa!.text = '';
      _textUsuario!.text = '';
      _textClave!.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
  

    final Responsive size = Responsive.of(context);

    return GestureDetector(
       onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ChangeNotifierProvider(
              create: (_) => LoginController(),
              builder: (context, __) {
                final controller = Provider.of<LoginController>(context);
    
                return Container(
                  // color:Colors.green,
                  width: size.iScreen(100.0),
                  height: size.iScreen(100.0),
                  margin: EdgeInsets.only(
                      bottom: size.iScreen(0.0), top: size.iScreen(0.0)),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.only(
                              bottom: size.iScreen(4.0), top: size.iScreen(4.0)),
                          width: size.wScreen(70.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                100.0), // 50.0 es un radio grande para hacer la imagen completamente redonda
                            child: Image.asset('assets/imgs/logoNsafe.png',),
                          ),
                        ),
    
                        Form(
                          key: controller.loginFormKey,
                          child: Container(
                            // color:Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(5.0)),
                            margin: EdgeInsets.only(bottom: size.iScreen(1.0)),
                            width: size.wScreen(100.0),
    
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _textEmpresa,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Empresa',
                                    suffixIcon: Icon(Icons.factory_outlined),
                                  ),
                                  inputFormatters: [
                                    UpperCaseText(),
                                  ],
                                  textAlign: TextAlign.start,
                                  onChanged: (text) {
                                    controller.setLabelNombreEmpresa(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Ingrese nombre de Empresa';
                                    }
                                  },
                                  onSaved: (value) {
                                    // codigo = value;
                                    controller.setLabelNombreEmpresa(value!);
                                  },
                                ),
    
                            
                              
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
    
                                //*****************************************/
    
                                TextFormField(
                                  controller: _textUsuario,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Usuario',
                                    suffixIcon:
                                        Icon(Icons.person_outline_outlined),
                                  ),
                                  textAlign: TextAlign.start,
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
                                  onSaved: (value) {
                                    controller.onChangeUser(value!);
                                  },
                                ),
    
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(2.0),
                                ),
                                //*****************************************/
                                TextFormField(
                                  controller: _textClave,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Clave',
                                    suffixIcon: IconButton(
                                        splashRadius: 5.0,
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: _obscureText
                                            ? const Icon(
                                                Icons.visibility_off_outlined)
                                            : const Icon(
                                                Icons.remove_red_eye_outlined)),
                                  ),
                                  obscureText: _obscureText,
                                  textAlign: TextAlign.start,
                                  onChanged: (text) {
                                    controller.onChangeClave(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Ingrese su Clave';
                                    }
                                  },
                                  onSaved: (value) {
                                    controller.onChangeClave(value!);
                                  },
                                ),
    
                                //***********************************************/
                              ],
                            ),
                          ),
                        ),
                        //===========================================//
                        Container( 
                          // color: Colors.red,
                          width: size.wScreen(90.0),
                         margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
                         
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               Container(
                                // color: Colors.blue,
                                margin: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  bottom: size.iScreen(.0),
                                  left: size.iScreen(0.0),
                                  right: size.iScreen(4.0),
                                ),
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  bottom: size.iScreen(0.0),
                                  left: size.iScreen(0.0),
                                  right: size.iScreen(0.0),
                                ),
                                //
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'password');
                                  },
                                  child: Text(
                                    '¿Olvidé mi Clave?',
                                    style: GoogleFonts.roboto(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(
                                  top: size.iScreen(3.0),
                                  bottom: size.iScreen(3.0),
                                  left: size.iScreen(0.0),
                                  right: size.iScreen(1.0),
                                ),
                                child: Row(
                                  children: [
                                    Consumer<LoginController>(
                                      builder: (_, provider, __) {
                                        return Container(
                                          // color: Colors.red,
                                          child: Checkbox(
                                              focusColor: Colors.white,
                                              value:
                                                  provider.getRecuerdaCredenciales,
                                              onChanged: (value) {
                                                provider
                                                    .onRecuerdaCredenciales(value!);
                                                // print(value);
                                              }),
                                        );
                                      },
                                    ),
                                    Text(
                                      'Recordarme',
                                      style: GoogleFonts.roboto(
                                          fontSize: size.iScreen(1.8),
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        //========================================//
                        GestureDetector(
                            onTap: () {
                              _onSubmit(context,controller,size);
                            },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8.0)),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.iScreen(5.0),
                                vertical: size.iScreen(3.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(3.0),
                                vertical: size.iScreen(0.5)),
                            child: Container(
                              alignment: Alignment.center,
                              height: size.iScreen(3.5),
                              width: size.iScreen(20.0),
                              child: Text('Entrar',
                                  style: GoogleFonts.roboto(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        //===========================================//
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //*******************************************************//
//   void _onSubmit(BuildContext contextResponsive,LoginController ctrllogin,size) async {
//     final ctrlHome=context.read<HomeController>();
  
//     final isValid = ctrllogin.validateForm();
//     ctrllogin.loginFormKey.currentState?.save();
//     if (!isValid) return;
//     if (isValid) {
        
//       //********************//
// final conexion = await Connectivity().checkConnectivity();
//       if (ctrllogin.getlNombreEmpresa == null) {
//         NotificatiosnService.showSnackBarError('Seleccione Empresa');
//       } else if (conexion == ConnectivityResult.none) {
//         NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
//       } else if (conexion == ConnectivityResult.wifi ||
//           conexion == ConnectivityResult.mobile) {
    
//         final status = await Permission.location.request();
//         if (status == PermissionStatus.granted) {
//           await ctrlHome.getCurrentPosition();
//           if (ctrlHome.getCoords != '') {
//             ProgressDialog.show(context);
//             final response = await ctrllogin.loginApp(context);
//             ProgressDialog.dissmiss(context);
//             if (response != null) {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute<void>(
//                       builder: (BuildContext context) => const SplashPage()));
//             }
//             else{
//               // NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
//             }
//           }
//         } else {
//           // print('============== NOOOO TIENE PERMISOS');
//           Navigator.pushNamed(context, 'gps');
//         }
      // }
      
void _onSubmit(BuildContext contextResponsive, LoginController ctrllogin, Responsive size) async {
  final ctrlHome = context.read<HomeController>();
ctrlHome.activateAlarm(false);
  final isValid = ctrllogin.validateForm();
  ctrllogin.loginFormKey.currentState?.save();
  if (!isValid) return;

  print('Formulario validado.');

  if (isValid) {
    final conexion = await Connectivity().checkConnectivity();
    print('Estado de conectividad: $conexion');

    if (ctrllogin.getlNombreEmpresa == null) {
      NotificatiosnService.showSnackBarError('Seleccione Empresa');
    } else if (conexion == ConnectivityResult.none) {
      NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
    } else if (conexion == ConnectivityResult.wifi || conexion == ConnectivityResult.mobile) {
      final status = await Permission.location.request();
      print('Permiso de ubicación: $status');

      if (status == PermissionStatus.granted) {
        await ctrlHome.getCurrentPosition();
        // print('Posición actual obtenida: ${ctrlHome.getCoords}');

        if (mounted && ctrlHome.getCoords != '') {
          ProgressDialog.show(context);
          print('Mostrando ProgressDialog.');

          final response = await ctrllogin.loginApp(context);
          // print('Respuesta del login: $response');

          if (mounted) {
            ProgressDialog.dissmiss(context);
            print('Ocultando ProgressDialog.');

            if (response != null) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                if (mounted) {
                  // print('Navegando a SplashPage.');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SplashPage()));
                }
              });
            } else {
              // print('Error en la respuesta del servidor.');
              // NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
            }
          }
        }
      } else {
        if (mounted) {
          // print('Permiso de ubicación no concedido, navegando a gps.');
          Navigator.pushNamed(context, 'gps');
        }
      }
    }
  }
}








    
  
}
