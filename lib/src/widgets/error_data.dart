import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/pages/splash_screen.dart';
// import 'package:nseguridad/src/pages/splash_page.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class ErrorData extends StatefulWidget {
  const ErrorData({Key? key}) : super(key: key);

  @override
  State<ErrorData> createState() => _ErrorDataState();
}

class _ErrorDataState extends State<ErrorData> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(size.iScreen(5.0)),
          // color: Colors.red,
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Ocurrió un error, restablecer servicios',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8.0)),
                margin: EdgeInsets.symmetric(
                    horizontal: size.iScreen(5.0), vertical: size.iScreen(3.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: size.iScreen(3.0), vertical: size.iScreen(0.5)),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: size.iScreen(3.5),
                    width: size.iScreen(15.0),
                    child: Text('Restablecer',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        )),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SplashPage())).then((value){
                                setState(() {
                                  
                                });

                                });
                    // _showMultipleChoiceDialog(context);

                    // _onSubmit(context, tipoMultaController);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
