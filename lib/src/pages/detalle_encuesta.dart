import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';

import 'package:nseguridad/src/utils/responsive.dart';

class DetalleEncuesta extends StatelessWidget {
  const DetalleEncuesta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _controller = context.read<EncuestasController>();
  final ctrlTheme = context.read<ThemeApp>();
        
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
              'Mi Encuesta',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: Container(
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
              child: Column(
                children: [
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //***********************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Tema:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      // 'item Novedad: ${controllerActividades.getItemMulta}',
                      '"${_controller.getInfoEncuesta!['docTitulo']}"',
                      textAlign: TextAlign.center,
                      //
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.3),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.5),
                  ),
                  //***********************************************/
                  Container(
                    width: size.wScreen(100.0),
                    alignment: Alignment.center,
                    color: Colors.grey[300],
                    child: Text('BANCO DE PREGUNTAS',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/

                  Wrap(
                    children:
                        (_controller.getInfoEncuesta['docPreguntas'] as List)
                            .map(
                              (e) => Column(
                                children: [
                                  Container(
                                    width: size.wScreen(100.0),

                                    // color: Colors.blue,
                                    child: Text('${e['pregunta']} :',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                    width: size.wScreen(100.0),
                                    child: Text(
                                      '${e['pregunta']} ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          // color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(0.5),
                                  ),
                                  //*****************************************/
                                ],
                              ),
                            )
                            .toList(),
                  ),
                  //*****************************************/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
