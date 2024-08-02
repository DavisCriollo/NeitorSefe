import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class DetalleNotificacion1Page extends StatefulWidget {
  final informacion;
  const DetalleNotificacion1Page({Key? key, this.informacion})
      : super(key: key);

  @override
  State<DetalleNotificacion1Page> createState() =>
      _DetalleNotificacion1PageState();
}

class _DetalleNotificacion1PageState extends State<DetalleNotificacion1Page> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    return Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
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
         title:  Text('Actividad',
        //  style:  Theme.of(context).textTheme.headline2,
         ),
        
        ),
        body:
            Container(
          margin: EdgeInsets.only(top: size.iScreen(1.0)),
          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
          width: size.wScreen(100.0),
          height: size.hScreen(100),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                          ' ${widget.informacion['notFecReg']}'
                              .toString()
                              .replaceAll(".000Z", " ")
                              .replaceAll("T", "   "),
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.1)),
                  width: size.wScreen(100.0),
                  child: Text(
                    // 'item Novedad: ${controllerActividades.getItemMulta}',
                    '"${widget.informacion['notContenido']}" ',
                    textAlign: TextAlign.center,
                    //
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
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
                  child: Text('Persona:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  width: size.wScreen(100.0),
                  child: Text(
                    '${widget.informacion['notNombrePersona']}',
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
                  child: Text('Empresa:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  width: size.wScreen(100.0),
                  child: Text(
                    '${widget.informacion['notEmpresa']}',
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
                  child: Text('Fecha:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Desde',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${widget.informacion['notInformacion']['actDesde']}'
                              .toString()
                              .replaceAll(".000Z", "")
                              .replaceAll("T", "   "),
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hasta',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${widget.informacion['notInformacion']['actHasta']}'
                              .toString()
                              .replaceAll(".000Z", "")
                              .replaceAll("T", "   "),
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Prioridad',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${widget.informacion['notInformacion']['actPrioridad']}',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Frecuencia',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${widget.informacion['notInformacion']['actFrecuencia']}'
                             ,
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                 //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
              //*****************************************/
              SizedBox(
                width: size.wScreen(100.0),
                child: Text(
                  'Repetir:',
                  style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(1.8),
                    color: Colors.black45,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
 //***********************************************/
              SizedBox(
                width: size.wScreen(100.0),
                height: size.iScreen(5.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.informacion['notInformacion']['actDiasRepetir'].length,
                  itemBuilder: (BuildContext context, int index) {
                    String dia = widget.informacion['notInformacion']['actDiasRepetir'][index];

                    return Container(
                      width: size.iScreen(5.0),
                      height: size.iScreen(5.0),
                      margin: EdgeInsets.symmetric(
                        horizontal: size.iScreen(1.8),
                      ),
                      // padding: EdgeInsets.all(size.iScreen(1.0)),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          dia.substring(0, 2),
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              ],
            ),
          ),
        ));
  }
}
