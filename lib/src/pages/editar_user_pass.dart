import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/password_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:provider/provider.dart';

class UpdatePassUser extends StatefulWidget {
  const UpdatePassUser({Key? key}) : super(key: key);

  @override
  State<UpdatePassUser> createState() => _UpdatePassUserState();
}

class _UpdatePassUserState extends State<UpdatePassUser> {
  bool _obscureTextClave = true;

  bool _obscureTextRepeatClave = true;

  // TextEditingController? _textEmpresa = TextEditingController();
  TextEditingController? _textUsuario = TextEditingController();
  TextEditingController? _textClave = TextEditingController();
  TextEditingController? _textRepeatClave = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrlTheme = context.read<ThemeApp>();
    final ctrlHome = context.read<HomeController>();




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
        centerTitle: true,
        title: Text(
          'Mi Perfil',
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
              left: size.iScreen(1.0),
              right: size.iScreen(1.0)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: ctrlHome.perfilFormKey,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: size.iScreen(2.0),
                  // ),
                  Container(
                      width: size.wScreen(100.0),
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${ctrlHome.getUsuarioInfo!.rucempresa!}  ',
                              style: GoogleFonts.roboto(
                                  fontSize: size.iScreen(1.5),
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold)),
                          Text('-',
                              style: GoogleFonts.roboto(
                                  fontSize: size.iScreen(1.5),
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Text('  ${ctrlHome.getUsuarioInfo!.usuario!} ',
                              style: GoogleFonts.roboto(
                                  fontSize: size.iScreen(1.5),
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  //      Container(
                  //       // color: Colors.red,
                  //   margin: EdgeInsets.only(
                  //       bottom: size.iScreen(1.0),
                  //       top: size.iScreen(1.0),
                  //       right: size.iScreen(2.0)),
                  //   width: size.iScreen(10.0),
                  //   height: size.iScreen(10.0),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(
                  //         100.0), // 50.0 es un radio grande para hacer la imagen completamente redonda
                  //     child: CachedNetworkImage(
                  //       imageUrl: '${ctrlHome.getUsuarioInfo!.foto}',
                  //       fit: BoxFit.fill,
                  //       placeholder: (context, url) =>
                  //           const CupertinoActivityIndicator(),
                  //       // Image.asset(
                  //       //     'assets/imgs/loader.gif'),

                  //       errorWidget: (context, url, error) =>
                  //           const Icon(Icons.error),
                  //     ),
                  //     //Image.asset('assets/imgs/no-image.jpg'),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(size.iScreen(0.5)),
                    width: size.iScreen(12.0),
                    height: size.iScreen(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100.0), // 50.0 es un radio grande para hacer la imagen completamente redonda
                      child: 
                     ctrlHome.getUsuarioInfo!.foto==null ?Image.asset('assets/imgs/no-image.jpg'):
                      CachedNetworkImage(
                        imageUrl: '${ctrlHome.getUsuarioInfo!.foto}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        // Image.asset(
                        //     'assets/imgs/loader.gif'),

                        errorWidget: (context, url, error) =>
                            // const Icon(Icons.error),
                            Image.asset('assets/imgs/no-image.jpg'),
                      ),
                    ),
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  //***********************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.5),
                  // ),
                  //*****************************************/
                  Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     top: size.iScreen(0.5),
                        //     bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          'Cédula: ',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                          '${ctrlHome.getUsuarioInfo!.usuario!}',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  //***********************************************/
                  // SizedBox(
                  //   height: size.iScreen(0.5),
                  // ),
                  //*****************************************/
                  Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     top: size.iScreen(0.5),
                        //     bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          'Cargo: ',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                          '${ctrlHome.getUsuarioInfo!.rol![0]}',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

         //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                   Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     top: size.iScreen(0.5),
                        //     bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          'Nombre: ',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                        width: size.wScreen(70.0),
                        child: Text(
                          // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                          '${ctrlHome.getUsuarioInfo!.nombre!}',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  
                    //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                   Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     top: size.iScreen(0.5),
                        //     bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          'Usuario: ',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                          '${ctrlHome.getUsuarioInfo!.usuario!}',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                   Container(
                    color: Colors.grey.shade200,
                        margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                        padding: EdgeInsets.symmetric(vertical: size.iScreen(1.0),horizontal: size.iScreen(1.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                          'Actualizar Clave ',
                          style: GoogleFonts.roboto(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                        ),
                      ),
                
                  // //***********************************************/
                  // SizedBox(
                  //   height: size.iScreen(2.0),
                  // ),
                  // //*****************************************/
                  // //*****************************************/
                  // SizedBox(
                  //   width: size.wScreen(100.0),
                  //   // color: Colors.blue,
                  //   child: Text('Usuario',
                  //       style: GoogleFonts.roboto(
                  //         fontSize: size.iScreen(2.0),
                  //         fontWeight: FontWeight.normal,
                  //         color: Colors.grey,
                  //       )),
                  // ),
                  // TextFormField(
                  //   initialValue: ctrlHome.getUsuarioInfo!.usuario == ''
                  //       ? ''
                  //       : ctrlHome.getUsuarioInfo!.usuario,
                  //   decoration: const InputDecoration(
                  //     suffixIcon: Icon(Icons.person_outline_outlined),
                  //   ),
                  //   inputFormatters: [
                  //     LengthLimitingTextInputFormatter(15),
                  //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  //     NoSpaceFormatter(),
                  //   ],
                  //   textAlign: TextAlign.start,
                  //   style: const TextStyle(),
                  //   onChanged: (text) {
                  //     ctrlHome.onChangeUser(text);
                  //   },
                  //   validator: (text) {
                  //     if (text!.trim().isNotEmpty) {
                  //       return null;
                  //     } else {
                  //       return 'Ingrese Usuario';
                  //     }
                  //   },
                  //   onSaved: (value) {
                  //       ctrlHome.onChangeUser(value!);

                  //   },
                  // ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //*****************************************/

              
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Nueva Clave',
                        style: GoogleFonts.roboto(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                  ),
                  TextFormField(
                    controller: _textClave,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      // labelText: 'Repetir Clave',
                      suffixIcon: IconButton(
                          splashRadius: 5.0,
                          onPressed: () {
                            setState(() {
                              _obscureTextClave = !_obscureTextClave;
                            });
                          },
                          icon: _obscureTextClave
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.remove_red_eye_outlined)),
                    ),
                    obscureText: _obscureTextClave,
                    textAlign: TextAlign.start,
                    onChanged: (text) {
                      ctrlHome.onChangeClaveNueva(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese Nueva Clave';
                      }
                    },
                    onSaved: (value) {
                      ctrlHome.onChangeClaveNueva(value!);
                    },
                  ),

                  //***********************************************/
                  // SizedBox(
                  //   height: size.iScreen(2.0),
                  // ),
                  // //*****************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Repetir Clave',
                        style: GoogleFonts.roboto(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                  ),
                  TextFormField(
                    controller: _textRepeatClave,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      // labelText: 'Repetir Clave',
                      suffixIcon: IconButton(
                          splashRadius: 5.0,
                          onPressed: () {
                            setState(() {
                              _obscureTextRepeatClave =
                                  !_obscureTextRepeatClave;
                            });
                          },
                          icon: _obscureTextRepeatClave
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.remove_red_eye_outlined)),
                    ),
                    obscureText: _obscureTextRepeatClave,
                    textAlign: TextAlign.start,
                    onChanged: (text) {
                      ctrlHome.onChangeRepearClave(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Repita Nueva Clave';
                      }
                    },
                    onSaved: (value) {
                      ctrlHome.onChangeRepearClave(value!);
                    },
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
                            style: GoogleFonts.roboto(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            )),
                      ),
                      onTap: () => onSubmit(context, ctrlHome,size),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(BuildContext context, HomeController controller,Responsive size) async {
    final isValid = controller.validatePerfilForm();
    if (!isValid) return;
    if (isValid) {

      final isOk = controller.verificaClave();
      if (isOk) {
        //  NotificatiosnService.showSnackBarSuccsses("CLAVE IGUAL ");
        ProgressDialog.show(context);
      final response = await controller.cambiaClaveusuario(context);
      ProgressDialog.dissmiss(context);
      if (response != null) {
        // Dialogs.alert(context, title: 'Información', description: '${response['msg']},Es necesario iniciar sesión nuevamente.');
        _modalCambioClaveOK(context,'${response['msg']}, Es necesario iniciar sesión nuevamente con los cambios realizados.',size);
      }
      } else {

      NotificatiosnService.showSnackBarError("CLAVE INCORRECTA ");      }
      
    }
  }






//====== MUESTRA MODAL DE MOTIVO =======//
  void _modalCambioClaveOK(
    BuildContext context,
    String _info,
    size,
  ) {
    final _user = context.read<HomeController>();
   
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Información',
                          style: GoogleFonts.roboto(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
                      // IconButton(
                      //     splashRadius: size.iScreen(3.0),
                      //     onPressed: () async{
                      //       Navigator.pop(context);
                             
                      //     },
                      //     icon: Icon(
                      //       Icons.close,
                      //       color: Colors.red,
                      //       size: size.iScreen(3.5),
                      //     )),
                    ],
                  ),
                  Container(
                    width: size.wScreen(100.0),
                    // height: size.hScreen(30.0),
                    child: Column(
                      children: [
                        Text(_info,  style: GoogleFonts.roboto(
                                  fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.white,
                                )),
                      ],
                    ),
                  )
                ],
              
              ),
              actions: [
                 CupertinoDialogAction(
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
              child: Text("OK",
                  style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )),
            ),
            onPressed: () async {
             
              final _ctrlHome = context.read<HomeController>();
                      

                       
                        _ctrlHome.resetNotificaciones();
                        // _ctrlHome.setGetTestTurno(false);
                        _ctrlHome.setBotonTurno(false);
                        _ctrlHome.setIndex(0);
                           _ctrlHome.sentTokenDelete();
                        await Auth.instance.deleteTurnoSesion();
                       
                        
                          await Auth.instance.deleteDataRecordarme();
             await Auth.instance.deleteSesion(context);


            },
          ),
              ],
            ),
          );
        });
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

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
