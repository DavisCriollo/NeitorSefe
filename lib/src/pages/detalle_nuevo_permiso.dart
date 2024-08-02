import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/new_permisos_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import '../utils/theme.dart';

class DetalleNuevoPermiso extends StatelessWidget {
  const DetalleNuevoPermiso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<NuevoPermisoController>();
    final _user = context.read<HomeController>();
      final ctrlTheme = context.read<ThemeApp>();
         
    String fechaLocal = DateUtility.fechaLocalConvert(
        infoContrtoller.getInfoAusencia['permiFecReg']!.toString());

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
                'Detalle Permiso',
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
                    Container(
                        width: size.wScreen(100.0),
                        margin: const EdgeInsets.all(0.0),
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold)),
                            Text('-',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            Text('  ${_user.getUsuarioInfo!.usuario!} ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),

                    //==========================================//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              // width: size.wScreen(100.0),
                              // color: Colors.blue,
                              child: Text('Estado: ',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5)),
                              child: Text(
                                '${infoContrtoller.getInfoAusencia['permiEstado']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: infoContrtoller
                                                .getInfoAusencia['permiEstado'] ==
                                            'EN PROCESO'
                                        ? tercearyColor
                                        : infoContrtoller.getInfoAusencia[
                                                    'permiEstado'] ==
                                                'ACTIVA'
                                            ? secondaryColor
                                            : Colors.red,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              // width: size.wScreen(100.0),
                              // color: Colors.blue,
                              child: Text('F. Registro: ',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5)),
                              child: Text(
                                fechaLocal,
                                // '${infoContrtoller.getInfoAusencia['ausEstado']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                          // width: size.wScreen(100.0),
                          child: Text(
                            '${infoContrtoller.getInfoAusencia['cedula']}',
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
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            child: Text(
                              '${infoContrtoller.getInfoAusencia['nombres']}',
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

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //  //==========================================//
                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),

                    //     //*****************************************/
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Column(
                    //           children: [

                    //              Text(
                    //               'Desde:',
                    //               style: GoogleFonts.lexendDeca(
                    //                 fontSize: size.iScreen(1.8),
                    //                 color: Colors.black45,
                    //                 // fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //               //*****************************************/

                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),

                    // //==========================================//
                    //             Text(
                    //           '${infoContrtoller.getInfoAusencia['ausFechaDesde']}' .toString()
                    //                         .substring(0,16)
                    //                         .replaceAll("T", " ")
                    //                         .replaceAll(
                    //                             "000Z", " "),
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               // color: Colors.white,
                    //               fontWeight: FontWeight.normal),
                    //         ),

                    //           ],
                    //         ),
                    //         Column(
                    //           children: [

                    //              Text(
                    //               'Hasta:',
                    //               style: GoogleFonts.lexendDeca(
                    //                 fontSize: size.iScreen(1.8),
                    //                 color: Colors.black45,
                    //                 // fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //               //*****************************************/

                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),

                    // //==========================================//
                    //             Text(
                    //           '${infoContrtoller.getInfoAusencia['ausFechaHasta']}' .toString()
                    //                         .substring(0,16)
                    //                         .replaceAll("T", " ")
                    //                         .replaceAll(
                    //                             "000Z", " "),
                    //           style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               // color: Colors.white,
                    //               fontWeight: FontWeight.normal),
                    //         ),

                    //           ],
                    //         ),

                    //       ],
                    //     ),
                    /***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

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
                            child: Text( '${infoContrtoller.getInfoAusencia['dias'].length}',
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

                    //*****************************************/

                    infoContrtoller.getInfoAusencia['dias'].isNotEmpty
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
                                child: Text('fecha de  Permiso: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Wrap(
                                children: (infoContrtoller
                                        .getInfoAusencia['dias'] as List)
                                    .map((e) {

 DateTime fechaBase = DateTime.parse( e['fecha_inicio']!.toString());

//   // Extrae la fecha sin la información de la hora y minutos
  String _fechaLocal = "${fechaBase.year}-${_formatNumero(fechaBase.month)}-${_formatNumero(fechaBase.day)}";

                                        
      
                                      
                                  return  Chip(
                                                  backgroundColor: Colors.grey.shade300,
                                                   
                                                    label: Text(
                                                     _fechaLocal,
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        // color: Colors.grey
                                                      ),
                                                    ),
                                                  );
                                    
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       vertical: size.iScreen(0.5)),
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: size.iScreen(0.5),
                                  //       vertical: size.iScreen(0.5)),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     color: Colors.grey.shade200,
                                  //   ),
                                  //   child: Column(
                                  //     children: [
                                  //       Container(
                                  //         width: size.wScreen(100),
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: size.iScreen(0.5),
                                  //             vertical: size.iScreen(0.5)),
                                  //         child: Row(
                                  //           children: [
                                              
                                  //             Expanded(
                                  //               child: Text(
                                  //                   '${e['fecha_inicio'].toString().replaceAll('T', " ")} ',
                                  //                   style:
                                  //                       GoogleFonts.lexendDeca(
                                  //                           fontSize: size.iScreen(2.0),
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .normal,
                                  //                           color:
                                  //                               Colors.black)),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                       
                                  //     ],
                                  //   ),
                                  // );
                                }).toList(),
                              ),
                            ],
                          )
                        : Container(),
                    //*****************************************/
                   /*****************************************/

                    SizedBox(
                      height: size.iScreen(0.5),
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
                              '${infoContrtoller.getInfoAusencia['permiMotivo']}',
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
                              '${infoContrtoller.getInfoAusencia['permiDetalle']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // infoContrtoller.getInfoAusencia.contain['turPuesto'].isNotEmpty
                    // infoContrtoller.getInfoAusencia.containsKey('turPuesto')
                    //     ?
                         Column(
                            children: [
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //==========================================//

                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Lugar: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                                Container(
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
                                                    '${infoContrtoller.getInfoAusencia['ubicacion']} ',
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
                                                child: Text('${infoContrtoller.getInfoAusencia['puesto']} ',
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
                                  )
                              // Wrap(
                              //   children: (infoContrtoller
                              //           .getInfoAusencia['turPuesto'] as List)
                              //       .map((e) {
                              //     return 
                              //     Container(
                              //       margin: EdgeInsets.symmetric(
                              //           vertical: size.iScreen(0.5)),
                              //       padding: EdgeInsets.symmetric(
                              //           horizontal: size.iScreen(0.0),
                              //           vertical: size.iScreen(0.5)),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(8.0),
                              //         color: Colors.grey.shade200,
                              //       ),
                              //       child: Column(
                              //         children: [
                              //           Container(
                              //             width: size.wScreen(100),
                              //             padding: EdgeInsets.symmetric(
                              //                 horizontal: size.iScreen(0.5),
                              //                 vertical: size.iScreen(0.5)),
                              //             child: Row(
                              //               children: [
                              //                 Text('Ubicación: ',
                              //                     style: GoogleFonts.lexendDeca(
                              //                         // fontSize: size.iScreen(2.0),
                              //                         fontWeight:
                              //                             FontWeight.normal,
                              //                         color: Colors.grey)),
                              //                 Expanded(
                              //                   child: Text(
                              //                       '${e['ubicacion']} ',
                              //                       style:
                              //                           GoogleFonts.lexendDeca(
                              //                               // fontSize: size.iScreen(2.0),
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .normal,
                              //                               color:
                              //                                   Colors.black)),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //           Container(
                              //             width: size.wScreen(100),
                              //             decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(8.0),
                              //               color: Colors.grey.shade200,
                              //             ),
                              //             padding: EdgeInsets.symmetric(
                              //                 horizontal: size.iScreen(0.5),
                              //                 vertical: size.iScreen(0.5)),
                              //             child: Row(
                              //               children: [
                              //                 Text('Puesto: ',
                              //                     style: GoogleFonts.lexendDeca(
                              //                         // fontSize: size.iScreen(2.0),
                              //                         fontWeight:
                              //                             FontWeight.normal,
                              //                         color: Colors.grey)),
                              //                 Expanded(
                              //                   child: Text('${e['puesto']} ',
                              //                       style:
                              //                           GoogleFonts.lexendDeca(
                              //                               // fontSize: size.iScreen(2.0),
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .normal,
                              //                               color:
                              //                                   Colors.black)),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),
                           
                           
                           
                           
                           
                            ],
                          ),
                        // : Container(),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    // //==========================================//
                    Consumer<NuevoPermisoController>(
                      builder: (_, valuePuestos, __) {
                        return valuePuestos.getGuardiasReemplatoPermiso.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: size.wScreen(100.0),
                                    // color: Colors.blue,
                                    child: Text('Guardias Reemplazo: ',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  Consumer<ThemeApp>(
                                    builder: (_, valueTheme, __) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(1.0),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Wrap(
                                            children:
                                                (valuePuestos .getGuardiasReemplatoPermiso as List)
                                                    .map((e) => Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: valueTheme
                                                                .primaryColor,
                                                          ),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.3)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.0),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.3)),
                                                          width:
                                                              size.wScreen(100),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: size
                                                                          .wScreen(
                                                                              100),
                                                                      child:
                                                                          Text(
                                                                        '${e['nombres']}',
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize:
                                                                                size.iScreen(2.0),
                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    //*****************************************/
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.3),
                                                                    ),
                                                                    //*****************************************/
                                                                    Container(
                                                                      width: size
                                                                          .wScreen(
                                                                              100),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            'Días : ',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.6),
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Text(
                                                                            '${e['dias'].length}',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                fontSize: size.iScreen(1.6),
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    //*****************************************/
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.0),
                                                                    ),
                                                                    //*****************************************/
                                                                    Container(
                                                                      width: size
                                                                          .wScreen(
                                                                              100),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                size.wScreen(100),
                                                                            child:
                                                                                Text(
                                                                              'Fecha de reemplazo: ',
                                                                              style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.6), fontWeight: FontWeight.normal, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              width: size.wScreen(100),
                                                                              child: Wrap(
                                                                                spacing: 3.0,
                                                                                alignment: WrapAlignment.start,
                                                                                children: (e['dias'] as List)
                                                                                    .map(
                                                                                      (e) {
                                                                                         DateTime fechaBase = DateTime.parse( e['fecha_inicio']!.toString());

                                                                                                  //   // Extrae la fecha sin la información de la hora y minutos
                                                                                   String _fechaLocal = "${fechaBase.year}-${_formatNumero(fechaBase.month)}-${_formatNumero(fechaBase.day)}";
                                                                                        return Chip(
                                                  backgroundColor: Colors.white,
                                                   
                                                    label: Text(
                                                     _fechaLocal,
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        // color: Colors.grey
                                                      ),
                                                    ),
                                                  );
                                                                                      }
                                                                                    //   Container(
                                                                                    //     margin: EdgeInsets.all(size.iScreen(0.1)),
                                                                                    //     child: ClipRRect(
                                                                                    //       borderRadius: BorderRadius.circular(8.0),
                                                                                    //       child: Container(
                                                                                    //           alignment: Alignment.center,
                                                                                    //           padding: EdgeInsets.all(size.iScreen(0.2)),
                                                                                    //           decoration: BoxDecoration(
                                                                                    //               // color: Colors.grey.shade200,
                                                                                    //               // color: Colors.grey.shade100,
                                                                                    //               ),
                                                                                    //           // width: size.iScreen(12.0),
                                                                                    //           child: Row(
                                                                                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    //             children: [
                                                                                    //               Text(
                                                                                    //                 e['fecha_inicio'].toString().replaceAll('T', ' '),
                                                                                    //                 // e.toString(),
                                                                                    //                 // .toString().replaceAll('T',' '),
                                                                                    //                 // .substring(0, 10),
                                                                                    //                 style: GoogleFonts.lexendDeca(
                                                                                    //                   fontSize: size.iScreen(2.0),
                                                                                    //                   color: Colors.white,
                                                                                    //                   // fontWeight: FontWeight.bold,
                                                                                    //                 ),
                                                                                    //               ),
                                                                                    //               Text(
                                                                                    //                 e['fecha_inicio'] == null ? '' : e['fecha_inicio'].toString().replaceAll('T', ' '),

                                                                                    //                 // .toString().replaceAll('T',' '),
                                                                                    //                 // .substring(0, 10),
                                                                                    //                 style: GoogleFonts.lexendDeca(
                                                                                    //                   fontSize: size.iScreen(2.0),
                                                                                    //                   color: Colors.white,
                                                                                    //                   // fontWeight: FontWeight.bold,
                                                                                    //                 ),
                                                                                    //               ),
                                                                                    //             ],
                                                                                    //           )),
                                                                                    //     ),
                                                                                    //   ),
                                                                                    )
                                                                                    .toList(),
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    //*****************************************/
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.1),
                                                                    ),
                                                                    //*****************************************/
                                                                    //                   Container(

                                                                    //                      width: size.wScreen(50),
                                                                    //                     child:      Wrap(
                                                                    // alignment: WrapAlignment.center,
                                                                    // children:( e['fechas'] as List)
                                                                    //           .map(
                                                                    //             (e) => Container(
                                                                    //               margin: EdgeInsets.all(
                                                                    //                   size.iScreen(0.6)),
                                                                    //               child: ClipRRect(
                                                                    //                 borderRadius:
                                                                    //                     BorderRadius.circular(8.0),
                                                                    //                 child: Container(
                                                                    //                     alignment: Alignment.center,
                                                                    //                     padding: EdgeInsets.all(
                                                                    //                         size.iScreen(0.5)),
                                                                    //                     decoration: BoxDecoration(
                                                                    //                       // color: Colors.grey.shade200,
                                                                    //                       color: Colors.grey.shade100,
                                                                    //                     ),
                                                                    //                     // width: size.iScreen(12.0),
                                                                    //                     child: Row(
                                                                    //                       mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                    //                       children: [

                                                                    //                         Text(
                                                                    //                           e['desde'].toString().replaceAll('T', ' '),
                                                                    //                               // .toString().replaceAll('T',' '),
                                                                    //                               // .substring(0, 10),
                                                                    //                           style: GoogleFonts
                                                                    //                               .lexendDeca(
                                                                    //                             fontSize:
                                                                    //                                 size.iScreen(1.8),
                                                                    //                             // color: Colors.white,
                                                                    //                             // fontWeight: FontWeight.bold,
                                                                    //                           ),
                                                                    //                         ),
                                                                    //                         // Text(
                                                                    //                         //   e['desde'].toString().replaceAll('T', ' '),

                                                                    //                         //       // .toString().replaceAll('T',' '),
                                                                    //                         //       // .substring(0, 10),
                                                                    //                         //   style: GoogleFonts
                                                                    //                         //       .lexendDeca(
                                                                    //                         //     fontSize:
                                                                    //                         //         size.iScreen(1.8),
                                                                    //                         //     // color: Colors.white,
                                                                    //                         //     // fontWeight: FontWeight.bold,
                                                                    //                         //   ),
                                                                    //                         // ),

                                                                    //                       ],
                                                                    //                     )),
                                                                    //               ),
                                                                    //             ),
                                                                    //           )
                                                                    //           .toList(),
                                                                    //                               )
                                                                    //                   ),
                                                                    //*****************************************/
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.5),
                                                                    ),
                                                                    //*****************************************/
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                    .toList()),
                                      );
                                    },
                                  )
                                ],
                              )
                            : Container(
                                // child: Text(
                                //   'No tiene guardia designado para el permiso',
                                //   // .toString().replaceAll('T',' '),
                                //   // .substring(0, 10),
                                //   style: GoogleFonts.lexendDeca(
                                //     fontSize: size.iScreen(1.8),
                                //     color: Colors.grey,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              );
                      },
                    ),
                    // //*****************************************/

                    // SizedBox(
                    //   height: size.iScreen(1.0),
                    // ),

                    // //==========================================//

                    // // //==========================================//
                    // infoContrtoller.getInfoAusencia['ausFotos']!.isNotEmpty
                    //     ? Column(
                    //         children: [
                    //           Container(
                    //             width: size.wScreen(100.0),
                    //             // color: Colors.blue,
                    //             margin: EdgeInsets.symmetric(
                    //               vertical: size.iScreen(1.0),
                    //               horizontal: size.iScreen(0.0),
                    //             ),
                    //             child: Text(
                    //                 'Fotografía: ${infoContrtoller.getInfoAusencia['ausFotos'].length}',
                    //                 style: GoogleFonts.lexendDeca(
                    //                     // fontSize: size.iScreen(2.0),
                    //                     fontWeight: FontWeight.normal,
                    //                     color: Colors.grey)),
                    //           ),
                    //           SingleChildScrollView(
                    //             child: Wrap(
                    //                 children: (infoContrtoller
                    //                             .getInfoAusencia['ausFotos']
                    //                         as List)
                    //                     .map((e) {
                    //               return Container(
                    //                 margin: EdgeInsets.symmetric(
                    //                     horizontal: size.iScreen(2.0),
                    //                     vertical: size.iScreen(1.0)),
                    //                 child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   child: Container(
                    //                     decoration: const BoxDecoration(),
                    //                     width: size.wScreen(100.0),
                    //                     padding: EdgeInsets.symmetric(
                    //                       vertical: size.iScreen(0.0),
                    //                       horizontal: size.iScreen(0.0),
                    //                     ),
                    //                     child: FadeInImage(
                    //                       placeholder: const AssetImage(
                    //                           'assets/imgs/loader.gif'),
                    //                       image: NetworkImage(e['url']),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             }).toList()),
                    //           ),
                    //         ],
                    //       )
                    //     : Container(),

                    //*****************************************/
                  ],
                ),
              ),
            ),
          )),
    );
  }



  String _formatNumero(int numero) {
  // Formatea el número para agregar un cero adelante si es menor a 10
  return numero < 10 ? '0$numero' : '$numero';
}

}
