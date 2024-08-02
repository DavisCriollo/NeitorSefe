import 'dart:io';

import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';


class DetalleFaltaInjustificada extends StatefulWidget {

  final Session? user;

  const DetalleFaltaInjustificada({Key? key, this.user})
      : super(key: key);

  @override
  State<DetalleFaltaInjustificada> createState() =>
      _DetalleFaltaInjustificadaState();
}

class _DetalleFaltaInjustificadaState extends State<DetalleFaltaInjustificada> {

  @override
  void initState() {
    super.initState();
  }

  void initData() {

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);


  final _user=context.read<HomeController>();
  final _controller=context.read<MultasGuardiasContrtoller>();

   String fechaLocal = DateUtility.fechaLocalConvert(  _controller.getInfoFalta['nomFecha']!.toString());
  final ctrlTheme = context.read<ThemeApp>();
        

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
           title: Text('Detalle de Falta ',
          //  style:  Theme.of(context).textTheme.headline2,
           ),
           
           
          ),
          body: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      //*****************************************/
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
                            Text(fechaLocal,
                                // _controller.getInfoFalta['nomFecha']!
                                //     // .toLocal()
                                //     .toString()
                                //     .substring(0, 16)
                                //     .replaceAll(".000Z", "")
                                //     .replaceAll("T", " "),
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                          '"${ _controller.getInfoFalta!['nomDetalle']}"',
                          textAlign: TextAlign.center,
                          //
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.3),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),

                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Observaciones: ',
                         
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //==========================================//
                      Container(
                        width: size.wScreen(100.0),
                        child: Text(
                          '${ _controller.getInfoFalta!['nomObservacion']}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      //*****************************************/

                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //==========================================//
                      SizedBox(
                        width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Nombre:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                          '${ _controller.getInfoFalta!['nomNombrePer']}',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),

                      //*****************************************/

                      Row(
                        children: [
                          SizedBox(
                            child: Text('Documento:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              ' ${ _controller.getInfoFalta!['nomDocuPer']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                           child: Text('Estado:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(1.0)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              ' ${ _controller.getInfoFalta!['nomEstado']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color:  _controller.getInfoFalta!['nomEstado'] ==
                                                              'APELACION'
                                                          ? secondaryColor
                                                          :  _controller.getInfoFalta!['nomEstado'] ==
                                                                  'EN PROCESO'
                                                              ? tercearyColor
                                                              :  _controller.getInfoFalta!['nomEstado'] ==
                                                                      'ANULADA'
                                                                  ? Colors.red
                                                                  :  _controller.getInfoFalta!['nomEstado'] ==
                                                                          'ASIGNADA'
                                                                      ? primaryColor
                                                                      : Colors
                                                                          .grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                  _controller.getInfoFalta!['nomCorreo'].isNotEmpty?   Column(
                        children: [
                          SizedBox(
                            width: size.wScreen(100.0),
                            child: Text('Correo:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Wrap(children:(_controller.getInfoFalta!['nomCorreo'] as List).map((e) => Container(
                            width: size.wScreen(100.0),
                            color: Colors.grey.shade200,
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.2)),
                            padding: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5),horizontal: size.iScreen(0.5) ),
                            child: Text(
                              ' $e',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),).toList()),
                          
                         
                        ],
                      ):Container(),
                      //***********************************************/

                      // Container(
                      //    width: size.wScreen(100.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                             
                      //          width: size.wScreen(15.0),
                               
                      //        child: Text('Ciudad:',
                      //             style: GoogleFonts.lexendDeca(
                      //                 // fontSize: size.iScreen(2.0),
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Colors.grey)),
                      //       ),
                      //       Container(
                           
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: size.iScreen(1.0)),
                      //         width: size.wScreen(70.0),
                      //         child: Text(
                      //           ' ${ _controller.getInfoFalta!['nomCiudad']}',
                      //           style: GoogleFonts.lexendDeca(
                      //               fontSize: size.iScreen(1.8),
                      //               // color: Colors.white,
                      //               fontWeight: FontWeight.normal),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      //==========================================//

 //***********************************************/

                      Row(
                        children: [
                          SizedBox(
                            child: Text('Ciudad:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                              _controller.getInfoFalta!['nomCiudad'] != ''
                                  ? ' ${ _controller.getInfoFalta!['nomCiudad']}'
                                  : ' --- --- --- ',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color:
                                      _controller.getInfoFalta!['nomCiudad'] !=
                                              ''
                                          ? Colors.black
                                          : Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
  Row(
                        children: [
                          SizedBox(
                            child: Text('Asignado por:',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.5)),
                            // width: size.wScreen(100.0),
                            child: Text(
                               _controller.getInfoFalta!['nomUser'] != ''
                                  ? ' ${ _controller.getInfoFalta!['nomUser'].toString().toUpperCase()}'
                                  : ' --- --- --- ',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color:
                                       _controller.getInfoFalta!['nomUser'] !=
                                              ''
                                          ? Colors.black
                                          : Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),

                      //==========================================//

                      Consumer<AusenciasController>(
                        builder: (_, valueTurno, __) {
                          return valueTurno.getIdsTurnosEmergente.isNotEmpty
                              ? Container(
                                  width: size.wScreen(100),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.wScreen(100),
                                        child: Text(
                                          'Guardia de reemplazo: ',
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
                                                    .getIdsTurnosEmergente)
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
                                                            '${e['turNomPersona']}',
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
                                        'Guardia de reemplazo: ',
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

                      //==========================================//
                      


                      //==========================================//
              
                      Consumer<MultasGuardiasContrtoller>(
                        builder: (_, provders, __) {
                          return provders
                                  .getListaCorreosClienteMultas.isNotEmpty
                              ? _CompartirClienta(
                                  size: size,
                                  multasController: provders)
                              : Container();
                        },
                      ),

                      ( _controller.getInfoFalta!['nomFotos']!.isNotEmpty)
                          ? _CamaraOption(
                              size: size,
                              multasController: _controller,
                              infoMultasGuardia:  _controller.getInfoFalta!)
                          : Container(),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //==========================================//
                       _controller.getInfoFalta!['nomVideo']!.isNotEmpty
                          ? _CamaraVideo(
                              size: size,
                             multa:  _controller.getInfoFalta)
                          : Container(),
                      //*****************************************/

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //==========================================//

                      //*****************************************/
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),

                      //*****************************************/
                    ],
                  ),
                ),
                
//                  _controller.getInfoFalta!['nomEstado'] != 'EN PROCESO'
//                     ? Positioned(
//                         bottom: 50.0,
//                         right: 0.0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: secondaryColor,
//                               borderRadius: BorderRadius.circular(8.0)),
//                           margin: EdgeInsets.only(
//                             // top: size.iScreen(5.0),
//                             right: size.iScreen(0.0),
//                             left: size.iScreen(0.0),
//                             bottom: size.iScreen(2.0),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.iScreen(2.0),
//                               vertical: size.iScreen(0.5)),
//                           child: GestureDetector(
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: size.iScreen(3.5),
//                               // width: size.iScreen(10.0),
//                               child: Text('Ver Apelación',
//                                   style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(2.0),
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.white,
//                                   )),
//                             ),
//                             onTap: () {
//                               multasController.resetValuesMulta();
                              
//                               Navigator.pushNamed(context, 'detalleDeApelacion',
//                                   arguments:
//                                       '${ _controller.getInfoFalta!['nomId']}');
//                             },
//                           ),
//                         ),
//                       )
//                     : Container(),

// // //=================================================================================//
//  _fechaMulta==true
//  ?
//   widget.user!.usuario== _controller.getInfoFalta!['nomDocuPer']
//   ?
// Consumer<MultasGuardiasContrtoller>(
//                         builder: (_, valueApelacion, __) {
//                           return
//                            valueApelacion.labelNombreEstadoMulta ==
//                                   'APELACION'
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ANULADA'  
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ASIGNADA'  
//                                 //  ||  widget.user!.usuario== _controller.getInfoFalta!['nomDocuPer']
                               
                                 
//                             ? Container()
//                               // : widget.user!.usuario== _controller.getInfoFalta!['turUser']?
//                              : Positioned(
//                                   bottom: 0.0,
//                                   right: 0.0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         gradient: const LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomCenter,
//                                             colors: <Color>[
//                                               Color(0XFF153E76),
//                                               Color(0XFF0076A7),
//                                             ]),
//                                         borderRadius:
//                                             BorderRadius.circular(8.0)),
//                                     margin: EdgeInsets.only(
//                                       // top: size.iScreen(5.0),
//                                       right: size.iScreen(0.0),
//                                       left: size.iScreen(0.0),
//                                       bottom: size.iScreen(2.0),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: size.iScreen(2.5),
//                                         vertical: size.iScreen(0.5)),
//                                     child: GestureDetector(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: size.iScreen(3.5),
//                                         // width: size.iScreen(10.0),
//                                         child: Text('Apelar Multa',
//                                             style: GoogleFonts.lexendDeca(
//                                               fontSize: size.iScreen(2.0),
//                                               fontWeight: FontWeight.normal,
//                                               color: Colors.white,
//                                             )),
//                                       ),
//                                       onTap: () {
//                                         multasController.resetValuesMulta();
                                       
//                                         multasController.getInfomacionMulta(
//                                              _controller.getInfoFalta);
//                                         Navigator.pushNamed(
//                                             context, 'crearApelacionPage');
//                                       },
//                                     ),
//                                   ),
//                                 );
//                                 // :Container();
                                        
                                             
//                         },
//                       )
//                       :
//                       Container()
//                       :Positioned(
//                       bottom: 5,
//                       child: SizedBox(
                    
//                         width: size.wScreen(100.0),
//                         child: Center(
//                           child: Text('FUERA DE LA FECHA DE APELACIÓN',
//                                                 style: GoogleFonts.lexendDeca(
//                                                   fontSize: size.iScreen(2.0),
//                                                   fontWeight: FontWeight.bold,
//                                                   color: tercearyColor
//                                                 )),
//                         ),),
//                     ),



// //=================================================================================//
  // widget.user!.usuario=='123'?// _controller.getInfoFalta!['nomDocuPer']?
// Consumer<MultasGuardiasContrtoller>(
//                         builder: (_, valueApelacion, __) {
//                           return
//                            valueApelacion.labelNombreEstadoMulta ==
//                                   'APELACION'
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ANULADA'  
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ASIGNADA'
                                  
//                                 //  ||  widget.user!.usuario== _controller.getInfoFalta!['nomDocuPer']
                               
                                 
//                             ? Container()
//                               // : widget.user!.usuario== _controller.getInfoFalta!['turUser']?
//                              : Positioned(
//                                   bottom: 0.0,
//                                   right: 0.0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         gradient: const LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomCenter,
//                                             colors: <Color>[
//                                               Color(0XFF153E76),
//                                               Color(0XFF0076A7),
//                                             ]),
//                                         borderRadius:
//                                             BorderRadius.circular(8.0)),
//                                     margin: EdgeInsets.only(
//                                       // top: size.iScreen(5.0),
//                                       right: size.iScreen(0.0),
//                                       left: size.iScreen(0.0),
//                                       bottom: size.iScreen(2.0),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: size.iScreen(2.5),
//                                         vertical: size.iScreen(0.5)),
//                                     child: GestureDetector(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: size.iScreen(3.5),
//                                         // width: size.iScreen(10.0),
//                                         child: Text('Apelar Multa',
//                                             style: GoogleFonts.lexendDeca(
//                                               fontSize: size.iScreen(2.0),
//                                               fontWeight: FontWeight.normal,
//                                               color: Colors.white,
//                                             )),
//                                       ),
//                                       onTap: () {
//                                         multasController.resetValuesMulta();
                                       
//                                         multasController.getInfomacionMulta(
//                                              _controller.getInfoFalta);
//                                         Navigator.pushNamed(
//                                             context, 'crearApelacionPage');
//                                       },
//                                     ),
//                                   ),
//                                 );
//                                 // :Container();
                                        
                                             
//                         },
//                       )
// :Container()



// //====VALIDA SI LA FECHA ES LA ADECUADA PARA MOTRAR EL BOTON DE APELAR MULTA======// 
//                 _fechaMulta == true 
// //=================================================================================//
//                     ? 
//                     Consumer<MultasGuardiasContrtoller>(
//                         builder: (_, valueApelacion, __) {
//                           return
//                            valueApelacion.labelNombreEstadoMulta ==
//                                   'APELACION'
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ANULADA'  
//                                   ||valueApelacion.labelNombreEstadoMulta ==
//                                   'ASIGNADA'  
//                                 //  ||  widget.user!.usuario==widget.infoMultaGuardia!['nomDocuPer']
                               
                                 
//                             ? Container()
//                               // : widget.user!.usuario==widget.infoMultaGuardia!['turUser']?
//                              : Positioned(
//                                   bottom: 0.0,
//                                   right: 0.0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         gradient: const LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomCenter,
//                                             colors: <Color>[
//                                               Color(0XFF153E76),
//                                               Color(0XFF0076A7),
//                                             ]),
//                                         borderRadius:
//                                             BorderRadius.circular(8.0)),
//                                     margin: EdgeInsets.only(
//                                       // top: size.iScreen(5.0),
//                                       right: size.iScreen(0.0),
//                                       left: size.iScreen(0.0),
//                                       bottom: size.iScreen(2.0),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: size.iScreen(2.5),
//                                         vertical: size.iScreen(0.5)),
//                                     child: GestureDetector(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: size.iScreen(3.5),
//                                         // width: size.iScreen(10.0),
//                                         child: Text('Apelar Multa',
//                                             style: GoogleFonts.lexendDeca(
//                                               fontSize: size.iScreen(2.0),
//                                               fontWeight: FontWeight.normal,
//                                               color: Colors.white,
//                                             )),
//                                       ),
//                                       onTap: () {
//                                         multasController.resetValuesMulta();
                                       
//                                         multasController.getInfomacionMulta(
//                                             widget.infoMultaGuardia);
//                                         Navigator.pushNamed(
//                                             context, 'crearApelacionPage');
//                                       },
//                                     ),
//                                   ),
//                                 );
//                                 // :Container();
                                        
                                             
//                         },
//                       )
                    
                    
                    // :
                    //  Positioned(
                    //   bottom: 5,
                    //   child: SizedBox(
                    
                    //     width: size.wScreen(100.0),
                    //     child: Center(
                    //       child: Text('FUERA DE LA FECHA DE APELACIÓN',
                    //                             style: GoogleFonts.lexendDeca(
                    //                               fontSize: size.iScreen(2.0),
                    //                               fontWeight: FontWeight.bold,
                    //                               color: tercearyColor
                    //                             )),
                    //     ),),
                    // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(
    BuildContext context,
    MultasGuardiasContrtoller controller,
  ) async {
    ProgressDialog.show(context);
    await controller.creaMultaGuardia(context);

    ProgressDialog.dissmiss(context);

  }
}

class _CamaraOption extends StatelessWidget {
  final MultasGuardiasContrtoller multasController;
  final dynamic infoMultasGuardia;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.multasController,
    required this.infoMultasGuardia,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: size.wScreen(100.0),
          
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografías: ${infoMultasGuardia['nomFotos']!.length}',
                style: GoogleFonts.lexendDeca(
                   fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
            child: Wrap(
                children: (infoMultasGuardia['nomFotos'] as List).map((e) {
              return Stack(
                children: [
                  GestureDetector(
                   
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.0),
                          vertical: size.iScreen(1.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(
                             
                              ),
                          width: size.wScreen(100.0),
                          // height: size.hScreen(20.0),
                          padding: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.0),
                            horizontal: size.iScreen(0.0),
                          ),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/imgs/loader.gif'),
                            image: NetworkImage(e['url']!),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                     },
                  ),
                ],
              );
            }).toList()),
          ),
        ],
      ),
      onTap: () {
      
      },
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return const FadeInImage(
      placeholder: AssetImage('assets/imgs/loader.gif'),
      image: NetworkImage('url'),
    );
  }

  return Image.file(
    File(picture),
    fit: BoxFit.cover,
  );
}

class _CamaraVideo extends StatelessWidget {
  final dynamic multa;
  const _CamaraVideo({
    Key? key,
    required this.size,
    //required this.informeController,
    required this.multa,
    // required this.videoController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.wScreen(100.0),
          // color: Colors.blue,
          margin: EdgeInsets.symmetric(
            vertical: size.iScreen(1.0),
            horizontal: size.iScreen(0.0),
          ),
          child: Text('Video:',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        AspectRatio(
          aspectRatio: 16 / 16,
          child: BetterPlayer.network(
            '${multa!['nomVideo']![0]['url']}',
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 16,
            ),
          ),
        )
      ],
    );
  }
}

class _CompartirClienta extends StatelessWidget {
  final MultasGuardiasContrtoller multasController;
  const _CompartirClienta({
    Key? key,
    required this.size,
    required this.multasController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: size.wScreen(100.0),
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Compartir a:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          Consumer<MultasGuardiasContrtoller>(
            builder: (_, provider, __) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
                //color: Colors.red,
                width: size.wScreen(100.0),
                height: size.iScreen(
                    provider.getListaCorreosClienteMultas.length.toDouble() *
                        6.3),
                child: ListView.builder(
                  itemCount: provider.getListaCorreosClienteMultas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cliente =
                        provider.getListaCorreosClienteMultas[index];
                    return Card(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.eliminaClienteMulta(cliente['id']);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: size.iScreen(0.5)),
                              child: const Icon(Icons.delete_forever_outlined,
                                  color: Colors.red),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0),
                                  vertical: size.iScreen(1.0)),
                              child: Text(
                                '${cliente['nombres']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.7),
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                   
                  },
                ),
              );
            },
          )
        ],
      ),
      onTap: () {
      },
    );
  }
}
