import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class DetalleCambioPuesto extends StatelessWidget {
  const DetalleCambioPuesto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<CambioDePuestoController>();

  final _user=context.read<HomeController>();
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
              title:  Text('Detalle cambio de puesto',
              // style:  Theme.of(context).textTheme.headline2,
              ),
             
            ),
            body: Container(
             margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                     Container(
                                                 width: size.wScreen(100.0),
                                                 margin: const EdgeInsets.all(0.0),
                                                 padding: const EdgeInsets.all(0.0),
                                                 child: Row(
                                                   mainAxisAlignment:
                                                       MainAxisAlignment.end,
                                                   children: [
                                                     Text(
                                                         '${_user.getUsuarioInfo!.rucempresa!}  ',
                                                         style: GoogleFonts.lexendDeca(
                                                             fontSize:
                                                                 size.iScreen(1.5),
                                                             color:
                                                                 Colors.grey.shade600,
                                                             fontWeight:
                                                                 FontWeight.bold)),
                                                     Text('-',
                                                         style: GoogleFonts.lexendDeca(
                                                             fontSize:
                                                                size.iScreen(1.5),
                                                             color: Colors.grey,
                                                             fontWeight:
                                                                 FontWeight.bold)),
                                                     Text(
                                                         '  ${_user.getUsuarioInfo!.usuario!} ',
                                                         style: GoogleFonts.lexendDeca(
                                                             fontSize:
                                                                 size.iScreen(1.5),
                                                             color:
                                                                 Colors.grey.shade600,
                                                             fontWeight:
                                                                 FontWeight.bold)),
                                                   ],
                                                 )),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
                    Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.3),
                          vertical: size.iScreen(0.3)),
                      width: size.wScreen(100.0),
                      child: Text(
                        'Información de Guardia:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                         child: Text('Cédula: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                         child: Text(
                            '${infoContrtoller.getInfoPuesto['camDocuPersona']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                               fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                          child: Text('Nombres: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            child: Text(
                              '${infoContrtoller.getInfoPuesto['camNomPersona']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                         child: Text('Fecha: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                           child: Text(
                              '${infoContrtoller.getInfoPuesto['camFecha']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                          child: Text('Motivo: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            child: Text(
                              '${infoContrtoller.getInfoPuesto['camMotivo']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
                    Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.3),
                          vertical: size.iScreen(0.3)),
                      width: size.wScreen(100.0),
                      child: Text(
                        'Puesto anterior',
                       style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Cliente: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            child: Text(
                              infoContrtoller.getInfoPuesto['camActualPuesto']
                                          .length >
                                      0
                                 ? '${infoContrtoller.getInfoPuesto['camNomCliente']}'
                                  : 'No Aignado',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
                    Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.3),
                          vertical: size.iScreen(0.3)),
                      width: size.wScreen(100.0),
                      child: Text(
                        'Nuevo Puesto',
                        // textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                   
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Ubicación: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              '${infoContrtoller.getInfoPuesto['camNuevoPuesto'][0]['ubicacion']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                         child: Text('Puesto: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              '${infoContrtoller.getInfoPuesto['camNuevoPuesto'][0]['puesto']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: Text('Horas de servicio: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              infoContrtoller.getInfoPuesto['camNuevoPuesto'][0]
                                          ['horasservicio'] !=
                                      null
                                  ? '${infoContrtoller.getInfoPuesto['camNuevoPuesto'][0]['horasservicio']}'
                                  : 'No Asignadas',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //*****************************************/
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
