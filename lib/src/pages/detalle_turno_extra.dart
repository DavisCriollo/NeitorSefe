import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';

import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class DetalleTurnoExtra extends StatelessWidget {
  const DetalleTurnoExtra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<TurnoExtraController>();
     final _user=context.read<HomeController>();
  final ctrlTheme = context.read<ThemeApp>();
         
         String fechaLocal = DateUtility.fechaLocalConvert( infoContrtoller.getTurnoExtra['turFecReg']!.toString());

    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                'Detalle Turno Extra',
                // style: Theme.of(context).textTheme.headline2,
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
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
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
                            '${infoContrtoller.getTurnoExtra['turDocuPersona']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
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
                              '${infoContrtoller.getTurnoExtra['turNomPersona']}',
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
                              // '${infoContrtoller.getTurnoExtra['turFecReg']}'
                              //     .toString()
                              //     .substring(0, 16)
                              //     .replaceAll("T", " ")
                              //     .replaceAll("000Z", " "),
                              fechaLocal,
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
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
                        'Puesto Designado',
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
                            // width: size.wScreen(100.0),
                            child: Text(
                              infoContrtoller.getTurnoExtra['turNomCliente']
                                          .length >
                                      0
                                  ? '${infoContrtoller.getTurnoExtra['turNomCliente']}'
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
                   

                     infoContrtoller.getTurnoExtra.containsKey('turPuesto')
                        ? Column(
                            children: [
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //==========================================//

                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Puestos: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Wrap(
                                children: ( infoContrtoller.getTurnoExtra['turPuesto'] as List)
                                    .map((e) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.iScreen(0.5)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(0.0),
                                        vertical: size.iScreen(0.5)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(0.5),
                                              vertical: size.iScreen(0.5)),
                                          child: Row(
                                            children: [
                                              Text('Ubicación: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Expanded(
                                                child: Text(
                                                    '${e['ubicacion']} ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: size.wScreen(100),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.grey.shade200,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(0.5),
                                              vertical: size.iScreen(0.5)),
                                          child: Row(
                                            children: [
                                              Text('Puesto: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Expanded(
                                                child: Text('${e['puesto']} ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        : Container(),


                    //==========================================//
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//

        

                    Row(
                      children: [
                        Container(
                          width: size.wScreen(30.0),

                          // color: Colors.blue,
                          child: Text('Días Permiso:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                            width: size.wScreen(20.0),
                            child: Text(
                                '${infoContrtoller.getTurnoExtra['turDiasTurno']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)))
                      ],
                    ),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
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
                            // width: size.wScreen(100.0),
                            child: Text(
                              '${infoContrtoller.getTurnoExtra['turMotivo']}',
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
                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Detalle: ',
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
                              '${infoContrtoller.getTurnoExtra['turDetalle']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),


                        //==========================================//
                         //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//

                      Consumer<TurnoExtraController>(
                        builder: (_, valueTurno, __) {
                          return valueTurno.getListaIdTurnoAsignado.isNotEmpty
                              ? Container(
                                  width: size.wScreen(100),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.wScreen(100),
                                        child: Text(
                                          'Guardia a reemplazar: ',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      //*****************************************/

                                      SizedBox(
                                        height: size.iScreen(0.5),
                                      ),
                                      //==========================================//
                                      Container(
                                          width: size.wScreen(100),
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: (valueTurno
                                                    .getListaIdTurnoAsignado)
                                                .map(
                                                  (e) => Container(
                                                    // color: Colors.grey.shade200,
                                                    margin: EdgeInsets.all(
                                                        size.iScreen(0.1)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  size.iScreen(
                                                                      0.2)),
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: primaryColor.withOpacity(0.8),
                                                            color: Colors
                                                                .grey.shade200,
                                                          ),
                                                          // width: size.iScreen(12.0),
                                                          child: Text(
                                                            '${e['nomNombrePer']}',
                                                            // e.toString(),
                                                            // .toString().replaceAll('T',' '),
                                                            // .substring(0, 10),
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(2.0),
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          )),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      width: size.wScreen(100),
                                      child: Text(
                                        'Guardia a reemplazar: ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.6),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    //*****************************************/

                                    SizedBox(
                                      height: size.iScreen(0.5),
                                    ),
                                    //==========================================//
                                    Container(
                                      width: size.wScreen(100),
                                      child: Text(
                                        'No tiene asignado un reemplazo ',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                        },
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
