

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/agregar_visita_bitacora.dart';
import 'package:nseguridad/src/pages/crear_bitacora.dart';
import 'package:nseguridad/src/pages/info_detalle_visita.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';

import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleResidente extends StatelessWidget {
   
  final Session? user;
  const DetalleResidente({Key? key,  required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<ResidentesController>();
     final _user=context.read<HomeController>();
       final ctrlTheme = context.read<ThemeApp>();
        

    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
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
                'Detalle de Residente',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
              child: Consumer(builder: (BuildContext context, value, Widget? child) {  

                return
                 DefaultTabController(
                length: 2, // Número de pestañas
                child: Column(
                  children: [
                    // Pestañas

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


                    const TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: ' RESIDENTE'),
                        Tab(text: ' VISITAS'),
                      ],
              //              onTap: (int index) {
              //                 _controller.resetValuesBitacora();
              //               if (index==0) {
                             

              // // _controller.getBitacoras('', 'false'); ///*********este es el principal  */
            
                
                              
              //               } else {
                              
              //                 _controller.getAllVisitasBitacoras('', 'false','INGRESO'); 
              //               }
              
             
             
               
                
                
              
               
              // },
                  
                    ),
                    Expanded(
                      child: Consumer(builder: (BuildContext context, value, Widget? child) {  
                          return  TabBarView(
                             physics:  BouncingScrollPhysics(),
                            children:[
                            

                                //====================================================================//

                                  SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(1.0),
                                        ),
                                  
                                        //==========================================//
                                  
                                           //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                         Container(
                                          width: size.wScreen(100),
                                          color: Colors.grey.shade100,
                                          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
                                              child: Text('UBICACIÓN ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                           //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text('Ruc: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                                              child: Text(
                                                '${infoContrtoller.getInfoResidente['resCliDocumento']}',
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
                                              child: Text('Cliente: ',
                                                  style: GoogleFonts.lexendDeca(
                                                       fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                  '${infoContrtoller.getInfoResidente['resCliNombre']}',
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
                                              child: Text('Puesto: ',
                                                  style: GoogleFonts.lexendDeca(
                                                       fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                  '${infoContrtoller.getInfoResidente['resCliPuesto']}'
                                                      ,
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
                                  
                                        //==========================================//
                                         Container(
                                          width: size.wScreen(100),
                                          color: Colors.grey.shade100,
                                          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
                                              child: Text('PROPIETARIO ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                           //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                             //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text('Cédula: ',
                                                  style: GoogleFonts.lexendDeca(
                                                       fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                infoContrtoller.getInfoResidente['resCedulaPropietario']!=null?  '${infoContrtoller.getInfoResidente['resCedulaPropietario']}':'--- --- --- --- --- ',
                                                      
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
                                  
                                        //==========================================//
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text('Nombre: ',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                 infoContrtoller.getInfoResidente['resNombrePropietario']!=null? '${infoContrtoller.getInfoResidente['resNombrePropietario']}':'--- --- --- --- --- '
                                                      ,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                         
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        // //==========================================//
                                            SizedBox(
                                              width: size.wScreen(100.0),
                                              child: Text('Teléfonos: ',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                        //     Expanded(
                                        //       child: 
                                       infoContrtoller.getInfoResidente['resTelefonoPropietario']!=null? Container(
                                         width: size.wScreen(100.0),
                                         child: Wrap(
                                                  // alignment : WrapAlignment.start,
                                                  children: (infoContrtoller.getInfoResidente['resTelefonoPropietario'] as List).map((e) => Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: size.iScreen(0.3)),
                                                    child: 
                                                      GestureDetector(
                                                        onDoubleTap: () {
                                                            _callNumber('$e');
                                                        },
                                                        child: Row(
                                                        children: [
                                                          Chip(label:Row(
                                                            children: [
                                                              SelectableText(
                                                                '$e'
                                                                    ,
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size.iScreen(1.8),
                                                                    fontWeight: FontWeight.normal),
                                                              ),
                                                               Icon(Icons.phone_android_outlined)
                                                            ],
                                                          ),),
                                                         
                                                        ],
                                                                                      ),
                                                      )
                                                    
                                                  ),).toList()),
                                       ): Container(),
                                      //  SizedBox(
                                      //         width: size.wScreen(100.0),
                                      //         child: Text('--- --- --- --- ---',
                                      //             style: GoogleFonts.lexendDeca(
                                      //               fontSize: size.iScreen(1.8),
                                      //                 fontWeight: FontWeight.normal,
                                      //                 color: Colors.black)),
                                      //       ),
                                        //     ),
                                        // //*****************************************/
                                        // Column(
                                        //   // mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //         //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                          infoContrtoller.getInfoResidente['resCorreoPropietario']!=null?   Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: size.wScreen(100.0),
                                                  child: Text('Correo: ',
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                ),
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Wrap(
                                                    alignment : WrapAlignment.start,
                                                    children: (infoContrtoller.getInfoResidente['resCorreoPropietario'] as List).map((e) => Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: size.iScreen(0.3)),
                                                      child: 
                                                      Chip(label:SelectableText(
                                                        '$e'
                                                            ,
                                                        style: GoogleFonts.lexendDeca(
                                                            fontSize: size.iScreen(1.8),
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                      )
                                                      
                                                    ),).toList()),
                                                ),
                                                
                                              ],
                                            ):Container(),
                                        // //==========================================//
                                            // Column(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: size.wScreen(100.0),
                                            //       child: Text('Personas Autorizadas: ',
                                            //           style: GoogleFonts.lexendDeca(
                                            //             fontSize: size.iScreen(1.8),
                                            //               fontWeight: FontWeight.normal,
                                            //               color: Colors.grey)),
                                            //     ),
                                            //     Wrap(
                                            //       // alignment : WrapAlignment.start,
                                            //       children: (infoContrtoller.getInfoResidente['resPersonasAutorizadas'] as List).map((e) => Container(
                                            //         margin: EdgeInsets.symmetric(
                                            //             horizontal: size.iScreen(0.3)),
                                            //         child: 
                                            //         Chip(label:SelectableText(
                                            //           '$e'
                                            //               ,
                                            //           style: GoogleFonts.lexendDeca(
                                            //               fontSize: size.iScreen(1.8),
                                            //               fontWeight: FontWeight.normal),
                                            //         ),)
                                                    
                                            //       ),).toList()),
                                                
                                            //   ],
                                            // ),
                                        //   ],
                                        // ),
                                             //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                        // Row(
                                        //   children: [
                                        //     SizedBox(
                                        //       child: Text('Estado: ',
                                        //           style: GoogleFonts.lexendDeca(
                                        //             fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal,
                                        //               color: Colors.grey)),
                                        //     ),
                                        //     Expanded(
                                        //       child: Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             vertical: size.iScreen(0.5)),
                                        //         child:
                                        //         Text(
                                        //                             '${infoContrtoller.getInfoResidente['resEstado']}',
                                        //                             style: GoogleFonts.lexendDeca(
                                        //                                 fontSize: size.iScreen(1.6),
                                        //                                 // color: _colorEstado,
                                        //                                 color: infoContrtoller.getInfoResidente['resEstado'] ==
                                        //                                         'ACTIVA'
                                        //                                     ? secondaryColor
                                                                           
                                        //                                                 : Colors.red,
                                                                                       
                                        //                                 fontWeight: FontWeight.bold),
                                        //                           ),
                                        //         //  Text(
                                        //         //   '${infoContrtoller.getInfoResidente['resEstado']}'
                                        //         //       ,
                                        //         //   style: GoogleFonts.lexendDeca(
                                        //         //       fontSize: size.iScreen(1.8),
                                        //         //       fontWeight: FontWeight.normal),
                                        //         // ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                             //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                        // Row(
                                        //   children: [
                                        //     SizedBox(
                                        //       child: Text('Departamento: ',
                                        //           style: GoogleFonts.lexendDeca(
                                        //             fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal,
                                        //               color: Colors.grey)),
                                        //     ),
                                        //     Expanded(
                                        //       child: Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             vertical: size.iScreen(0.5)),
                                        //         child: Text(
                                        //           '${infoContrtoller.getInfoResidente['resDepartamento']}'
                                        //               ,
                                        //           style: GoogleFonts.lexendDeca(
                                        //               fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        
                                    SizedBox(height: size.iScreen(0.5),),
                                         Container(
                                          width: size.wScreen(100),
                                          color: Colors.grey.shade100,
                                          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.5)),
                                              child: Text('ARRENDATARIO ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                           //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                             //*****************************************/
                                  
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        //==========================================//
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text('Cédula: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                 infoContrtoller.getInfoResidente['resCedula']!=null? '${infoContrtoller.getInfoResidente['resCedula']}':'--- --- --- --- --- '
                                                      ,
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
                                  
                                        //==========================================//
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Text('Nombre: ',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5)),
                                                child: Text(
                                                infoContrtoller.getInfoResidente['resNombres']!=null? '${infoContrtoller.getInfoResidente['resNombres']}':'--- --- --- --- --- ' 
                                                      ,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                         
                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),
                                  
                                        // //==========================================//
                                            SizedBox(
                                              width: size.wScreen(100.0),
                                              child: Text('Teléfonos: ',
                                                  style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                        //     Expanded(
                                        //       child: 
                                          infoContrtoller.getInfoResidente['resTelefono']!=null?
                                        Container(
                                          width: size.wScreen(100.0),
                                          child: 
                                          Wrap(
                                                  // alignment : WrapAlignment.start,
                                                  children: (infoContrtoller.getInfoResidente['resTelefono'] as List).map((e) => Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: size.iScreen(0.3)),
                                                    child: 
                                                    GestureDetector(
                                                      onDoubleTap: () {
                                                            _callNumber('$e');
                                                        },
                                                      child: Row(
                                                        children: [
                                                          Chip(label:Row(
                                                            children: [
                                                              SelectableText(
                                                                '$e'
                                                                    ,
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size.iScreen(1.8),
                                                                    fontWeight: FontWeight.normal),
                                                              ),
                                                               GestureDetector(
                                                                  onTap: () {
                                                                   _callNumber('$e');
                                                                },
                                                                child: Icon(Icons.phone_android_outlined))
                                                            ],
                                                          ),),
                                                         
                                                        ],
                                                      ),
                                                    )
                                                    
                                                  ),).toList()),
                                        ):Text('--- --- --- --- --- ',
                                                  style: GoogleFonts.lexendDeca(
                                                 fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey)),
                                            
                                            //****************//
                                  
                                               infoContrtoller.getInfoResidente['resTelefono']!=null?    Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: size.wScreen(100.0),
                                                  child: Text('Correo: ',
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey)),
                                                ),
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Wrap(
                                                    alignment : WrapAlignment.start,
                                                    children: (infoContrtoller.getInfoResidente['resCorreo'] as List).map((e) => Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: size.iScreen(0.3)),
                                                      child: 
                                                      Chip(label:SelectableText(
                                                        '$e'
                                                            ,
                                                        style: GoogleFonts.lexendDeca(
                                                            fontSize: size.iScreen(1.8),
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                      )
                                                      
                                                    ),).toList()),
                                                ),
                                                
                                              ],
                                            ):Container(),
                                  
                                                                          SizedBox(height: size.iScreen(0.5),),
                                                                      Column(
                                                                        children: [
                                                                         Container(
                                                                          width: size.wScreen(100.0),
                                                                          height: size.iScreen(0.5),
                                                                          color: Colors.grey.shade100,
                                                                         ),
                                                                         
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: size
                                                                                    .iScreen(0.5),
                                                                                bottom: size
                                                                                    .iScreen(0.0)),
                                                                            // width: size.wScreen(100.0),
                                                                            child: Text(
                                                                              'Departamento : ',
                                                                              style: GoogleFonts
                                                                                  .lexendDeca(
                                                                                      fontSize: size
                                                                                          .iScreen(
                                                                                              1.8),
                                                                                      color: Colors
                                                                                          .grey,
                                                                                      fontWeight:
                                                                                          FontWeight
                                                                                              .normal),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Container(
                                                                              // width: size.iScreen(28.0),
                                                                              // color: Colors.red,
                                                                              margin:
                                                                                  EdgeInsets.only(
                                                                                      top: size
                                                                                          .iScreen(
                                                                                              0.5),
                                                                                      bottom: size
                                                                                          .iScreen(
                                                                                              0.0)),
                                  
                                                                              child: Text(
                                                                                ' ${infoContrtoller.getInfoResidente['resDepartamento'][0]['nombre_dpt']}',
                                                                                overflow:
                                                                                    TextOverflow
                                                                                        .ellipsis,
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    fontSize: size
                                                                                        .iScreen(
                                                                                            1.8),
                                                                                    color: Colors
                                                                                        .black87,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .bold),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: size
                                                                                    .iScreen(0.5),
                                                                                bottom: size
                                                                                    .iScreen(0.0)),
                                                                            // width: size.wScreen(100.0),
                                                                            child: Text(
                                                                              'Número : ',
                                                                              style: GoogleFonts
                                                                                  .lexendDeca(
                                                                                      fontSize: size
                                                                                          .iScreen(
                                                                                              1.8),
                                                                                      color: Colors
                                                                                          .grey,
                                                                                      fontWeight:
                                                                                          FontWeight
                                                                                              .normal),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Container(
                                                                              // width: size.iScreen(28.0),
                                                                              // color: Colors.red,
                                                                              margin:
                                                                                  EdgeInsets.only(
                                                                                      top: size
                                                                                          .iScreen(
                                                                                              0.5),
                                                                                      bottom: size
                                                                                          .iScreen(
                                                                                              0.0)),
                                  
                                                                              child: Text(
                                                                                ' ${infoContrtoller.getInfoResidente['resDepartamento'][0]['numero']}',
                                                                                overflow:
                                                                                    TextOverflow
                                                                                        .ellipsis,
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    fontSize: size
                                                                                        .iScreen(
                                                                                            1.8),
                                                                                    color: Colors
                                                                                        .black87,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .bold),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                       Row(
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: size
                                                                                    .iScreen(0.5),
                                                                                bottom: size
                                                                                    .iScreen(0.0)),
                                                                            // width: size.wScreen(100.0),
                                                                            child: Text(
                                                                              'Ubicación : ',
                                                                              style: GoogleFonts
                                                                                  .lexendDeca(
                                                                                      fontSize: size
                                                                                          .iScreen(
                                                                                              1.8),
                                                                                      color: Colors
                                                                                          .grey,
                                                                                      fontWeight:
                                                                                          FontWeight
                                                                                              .normal),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Container(
                                                                              // width: size.iScreen(28.0),
                                                                              // color: Colors.red,
                                                                              margin:
                                                                                  EdgeInsets.only(
                                                                                      top: size
                                                                                          .iScreen(
                                                                                              0.5),
                                                                                      bottom: size
                                                                                          .iScreen(
                                                                                              0.0)),
                                  
                                                                              child: Text(
                                                                                ' ${infoContrtoller.getInfoResidente['resDepartamento'][0]['ubicacion']}',
                                                                                overflow:
                                                                                    TextOverflow
                                                                                        .ellipsis,
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    fontSize: size
                                                                                        .iScreen(
                                                                                            1.8),
                                                                                    color: Colors
                                                                                        .black87,
                                                                                    fontWeight:
                                                                                        FontWeight
                                                                                            .bold),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                       SizedBox(height: size.iScreen(0.5),),
                                                                       Container(
                                                                          width: size.wScreen(100.0),
                                                                          height: size.iScreen(0.5),
                                                                          color: Colors.grey.shade100,
                                                                         ),
                                                                     
                                                                        ],
                                                                      ),
                                                                     
                                                                        SizedBox(height: size.iScreen(0.5),),
                                            //*****************************************/
                                        //     ),
                                        // //*****************************************/
                                        // Column(
                                        //   // mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //         //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                            // Column(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: size.wScreen(100.0),
                                            //       child: Text('Correo: ',
                                            //           style: GoogleFonts.lexendDeca(
                                            //             fontSize: size.iScreen(1.8),
                                            //               fontWeight: FontWeight.normal,
                                            //               color: Colors.grey)),
                                            //     ),
                                            //     // Wrap(
                                            //     //   // alignment : WrapAlignment.start,
                                            //     //   children: (infoContrtoller.getInfoResidente['resCorreo'] as List).map((e) => Container(
                                            //     //     margin: EdgeInsets.symmetric(
                                            //     //         horizontal: size.iScreen(0.3)),
                                            //     //     child: 
                                            //     //     Chip(label:SelectableText(
                                            //     //       '$e'
                                            //     //           ,
                                            //     //       style: GoogleFonts.lexendDeca(
                                            //     //           fontSize: size.iScreen(1.8),
                                            //     //           fontWeight: FontWeight.normal),
                                            //     //     ),)
                                                    
                                            //     //   ),).toList()),
                                                
                                            //   ],
                                            // ),
                                        // //==========================================//
                                            // Column(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: size.wScreen(100.0),
                                            //       child: Text('Personas Autorizadas: ',
                                            //           style: GoogleFonts.lexendDeca(
                                            //               // fontSize: size.iScreen(2.0),
                                            //               fontWeight: FontWeight.normal,
                                            //               color: Colors.grey)),
                                            //     ),
                                            //     Wrap(
                                            //       // alignment : WrapAlignment.start,
                                            //       children: (infoContrtoller.getInfoResidente['resPersonasAutorizadas'] as List).map((e) => Container(
                                            //         margin: EdgeInsets.symmetric(
                                            //             horizontal: size.iScreen(0.3)),
                                            //         child: 
                                            //         Chip(label:SelectableText(
                                            //           '$e'
                                            //               ,
                                            //           style: GoogleFonts.lexendDeca(
                                            //               fontSize: size.iScreen(1.8),
                                            //               fontWeight: FontWeight.normal),
                                            //         ),)
                                                    
                                            //       ),).toList()),
                                                
                                            //   ],
                                            // ),
                                        //   ],
                                        // ),
                                             //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                        // Row(
                                        //   children: [
                                        //     SizedBox(
                                        //       child: Text('Estado: ',
                                        //           style: GoogleFonts.lexendDeca(
                                        //               // fontSize: size.iScreen(2.0),
                                        //               fontWeight: FontWeight.normal,
                                        //               color: Colors.grey)),
                                        //     ),
                                        //     Expanded(
                                        //       child: Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             vertical: size.iScreen(0.5)),
                                        //         child:
                                        //         Text(
                                        //                             '${infoContrtoller.getInfoResidente['resEstado']}',
                                        //                             style: GoogleFonts.lexendDeca(
                                        //                                 fontSize: size.iScreen(1.6),
                                        //                                 // color: _colorEstado,
                                        //                                 color: infoContrtoller.getInfoResidente['resEstado'] ==
                                        //                                         'ACTIVA'
                                        //                                     ? secondaryColor
                                                                           
                                        //                                                 : Colors.red,
                                                                                       
                                        //                                 fontWeight: FontWeight.bold),
                                        //                           ),
                                        //         //  Text(
                                        //         //   '${infoContrtoller.getInfoResidente['resEstado']}'
                                        //         //       ,
                                        //         //   style: GoogleFonts.lexendDeca(
                                        //         //       fontSize: size.iScreen(1.8),
                                        //         //       fontWeight: FontWeight.normal),
                                        //         // ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //      //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                        // Row(
                                        //   children: [
                                        //     SizedBox(
                                        //       child: Text('Departamento: ',
                                        //           style: GoogleFonts.lexendDeca(
                                        //             fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal,
                                        //               color: Colors.grey)),
                                        //     ),
                                        //     Expanded(
                                        //       child: Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             vertical: size.iScreen(0.5)),
                                        //         child: Text(
                                        //           '${infoContrtoller.getInfoResidente['resDepartamento']}'
                                        //               ,
                                        //           style: GoogleFonts.lexendDeca(
                                        //               fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //     //*****************************************/
                                  
                                        // SizedBox(
                                        //   height: size.iScreen(0.0),
                                        // ),
                                  
                                        // //==========================================//
                                        // Row(
                                        //   children: [
                                        //     SizedBox(
                                        //       child: Text('Ubicación: ',
                                        //           style: GoogleFonts.lexendDeca(
                                        //             fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal,
                                        //               color: Colors.grey)),
                                        //     ),
                                        //     Expanded(
                                        //       child: Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             vertical: size.iScreen(0.5)),
                                        //         child: Text(
                                        //           '${infoContrtoller.getInfoResidente['resUbicacion']}'
                                        //               ,
                                        //           style: GoogleFonts.lexendDeca(
                                        //               fontSize: size.iScreen(1.8),
                                        //               fontWeight: FontWeight.normal),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                       
                                      ],
                                    ),
                                  ),


                                //====================================================================//



                                 Consumer<ResidentesController>(
                                  builder: (_, providers, __) {
                                    return (providers.getListaVisitasResidente.isEmpty)
                                        ? 
                                        // Center(
                                        //     child: Column(
                                        //     children: [
                                        //       CircularProgressIndicator(),
                                        //       Text('No hay resultados ....')
                                        //     ],
                                        //   ))
                                        NoData(label:'No tiene visitas registradas')
                                        : (providers.getListaVisitasResidente.length > 0)
                                            ? ListView.builder(
                                               physics: const BouncingScrollPhysics(),
                                                itemCount: providers
                                                    .getListaVisitasResidente.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  // print('SE RECARGO.....!!!!');
                                                  final visitante = providers.getListaVisitasResidente[index];
                                                      
                                                      //****************FECHA LOCAL INGRESO****************//
                                                      String fechaLocalIngreso ='';
                                                     if ( visitante['bitFechaIngreso']!=null) {
                                                      fechaLocalIngreso = DateUtility.fechaLocalConvert( visitante['bitFechaIngreso']!.toString());
                                                     } else {
                                                      fechaLocalIngreso='--- --- --- --- --- ';
                                                     }
                                                        //****************FECHA LOCAL SALIDA****************//
                                                      String fechaLocalSalida ='';
                                                     if ( visitante['bitFechaSalida']!=null) {
                                                      fechaLocalSalida = DateUtility.fechaLocalConvert( visitante['bitFechaSalida']!.toString());
                                                     } else {
                                                      fechaLocalSalida='--- --- --- --- --- ';
                                                     }

                                                  return
                                                      // Text(cliente['residenteNombre']);
                                                      //==================================//

                                                      GestureDetector(
                                                         onTap:()
                                                          {
                                                            final _crtBitacora=context.read<BitacoraController>();
                                                             _crtBitacora.setInfoVisita(visitante);
                                                             Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InfoVisita(
                       
                      )));
                                                          },
                                                        child: Card(
                                                                                                          child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8)),
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: size
                                                                    .iScreen(0.5),
                                                                vertical:
                                                                    size.iScreen(
                                                                        0.5)),
                                                        width: size.wScreen(100),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Aquí puedes añadir una imagen de la foto si la tienes
                                                                // por ejemplo usando un Image.network si la foto es una URL
                                                                visitante["bitFotoPersona"]!=null
                                                                    ? Container(
                                                                       width: size
                                                                              .iScreen(5.5),
                                                                              height: size
                                                                              .iScreen(5.5),
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .grey.shade300,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0)),
                                                                        child:
                                                                        //  Image
                                                                        //     .network(
                                                                        //   visitante[
                                                                        //       "foto"]!,
                                                                        //   width: size
                                                                        //       .iScreen(3.0),
                                                                        //   height:
                                                                        //       size.iScreen(3.0),
                                                                        //   fit: BoxFit
                                                                        //       .cover,
                                                                        // ),
                                                              //            FadeInImage(
                                                              //   placeholder:
                                                              //       const AssetImage(
                                                              //             'assets/imgs/loader.gif'),
                                                              //   image: NetworkImage(
                                                              //     '${visitante['bitFotoPersona']}',
                                                              //   ),
                                                              // )
                                                              FadeInImage(
                                                            placeholder: const AssetImage('assets/imgs/loader.gif'),
                                                            image: NetworkImage(visitante['bitFotoPersona']),
                                                            imageErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                              return Image.asset('assets/imgs/no-image.png'); // Imagen de respaldo
                                                            },)
                                                            
                                                                      )
                                                                    : Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .grey.shade300,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0)),
                                                                        width: size
                                                                            .iScreen(
                                                                                6.0),
                                                                        height: size
                                                                            .iScreen(
                                                                                6.0),
                                                                        child: Icon(
                                                                            Icons
                                                                                .person),
                                                                      ),
                                                                      
                                                                SizedBox(
                                                                    width: 10),
                                                                Container(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      
                                                                      Container(
                                                                          // color: Colors.green,
                                                                          width: size.wScreen(
                                                                              70.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                "Documento: ",
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.grey, fontWeight: FontWeight.normal),
                                                                              ),
                                                                              Text(
                                                                               visitante["bitVisitanteCedula"]!=null ?"${visitante["bitVisitanteCedula"]}":'--- --- --- --- ---',
                                                                                style: GoogleFonts.lexendDeca(fontSize: size.iScreen(1.8), color: Colors.black87, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      SizedBox(
                                                                          height:
                                                                              size.iScreen(0.5)),
                                                                      Container(
                                                                        // color: Colors.red,
                                                                        width: size
                                                                            .wScreen(
                                                                                70.0),
                                                                        child:
                                                                            Text(
                                                                         visitante["bitVisitanteNombres"]!=null? "${visitante["bitVisitanteNombres"]}":'--- --- --- --- --- ',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize:
                                                                                  size.iScreen(1.8),
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    size.iScreen(
                                                                        0.5)),
                                                                            Container(
                                                                          padding:EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(0.5)),
                                                                          color:Colors.grey.shade100,
                                                                            width: size.wScreen(100),
                                                                  child: Text(
                                                                        "Se dirige a: ",
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen( 1.7),
                                                                            color: Colors.grey,
                                                                            fontWeight:FontWeight.normal),
                                                                      ),
                                                                        ),
                                                            Container(
                                                              width: size
                                                                  .wScreen(100),
                                                              // color:Colors.red,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Persona: ",
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.8),
                                                                            color: Colors
                                                                                .grey,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      Container(
                                                                        //  color:Colors.red,
                                                                        width: size
                                                                            .wScreen(
                                                                                70),
                                                                        child:
                                                                            Text(
                                                                           visitante["bitResApellidos"].isEmpty ||visitante["bitResApellidos"]!=null?"${visitante["bitResApellidos"]} ${visitante["bitResNombres"]}":'--- --- --- --- ---',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize:
                                                                                  size.iScreen(1.8),
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.5)),
                                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Departamento: ",
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.8),
                                                                            color: Colors
                                                                                .grey,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      Container(
                                                                        width: size
                                                                            .wScreen(
                                                                                60),
                                                                        child:
                                                                            Text(
                                                                          visitante["bitNombre_dpt"]!=null?"${visitante["bitNombre_dpt"]}":'--- --- --- --- ---',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize:
                                                                                  size.iScreen(1.8),
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.5)),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Número: ",
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.8),
                                                                            color: Colors
                                                                                .grey,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      Container(
                                                                        width: size
                                                                            .wScreen(
                                                                                65),
                                                                        child:
                                                                            Text(
                                                                         visitante["bitNumero_dpt"]!=null?"${visitante["bitNumero_dpt"]}":'--- --- --- --- ---',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize:
                                                                                  size.iScreen(1.8),
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              0.5)),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Ubicación: ",
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.8),
                                                                            color: Colors
                                                                                .grey,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      Container(
                                                                        width: size
                                                                            .wScreen(
                                                                                65),
                                                                        child:
                                                                            Text(
                                                                         visitante["bitCliUbicacion"]!=null? "${visitante["bitCliUbicacion"]}":'',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize:
                                                                                  size.iScreen(1.8),
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              1.0)),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: size.iScreen(
                                                                                1.0),
                                                                            vertical:
                                                                                size.iScreen(0.5)),
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .green
                                                                                .shade200,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0)),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text(
                                                                              "Ingreso ",
                                                                              style: GoogleFonts.lexendDeca(
                                                                                  fontSize: size.iScreen(1.8),
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight.normal),
                                                                            ),
                                                                            SizedBox(
                                                                                height: size.iScreen(0.5)),
                                                                            Text(
                                                                              "${fechaLocalIngreso}",
                                                                              style: GoogleFonts.lexendDeca(
                                                                                  fontSize: size.iScreen(1.8),
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          //  _controller.setInfoVisitante(visitante);
                                                      
                                                                          // showExitConfirmationDialog(context,size);
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: size.iScreen(
                                                                                  1.0),
                                                                              vertical:
                                                                                  size.iScreen(0.5)),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors
                                                                                  .grey
                                                                                  .shade300,
                                                                              borderRadius:
                                                                                  BorderRadius.circular(8.0)),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Salida ",
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    fontSize: size.iScreen(1.8),
                                                                                    color: Colors.black87,
                                                                                    fontWeight: FontWeight.normal),
                                                                              ),
                                                                              SizedBox(
                                                                                  height: size.iScreen(0.5)),
                                                                              Text(
                                                                                 "$fechaLocalSalida",
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    fontSize: size.iScreen(1.8),
                                                                                    color: Colors.black87,
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              1.0)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                                                                          ),
                                                                                                        ),
                                                      );

                                                  //********************************//
                                                },
                                              )
                                            : NoData(
                                                label: 'No existen Datos',
                                              );
                                  },
                                ),
                            ]);
                      },),
                    )
                    
                  ],
                  
                    ));



              },)
              
            
            ),
            floatingActionButton:
          //  //***********************************************/
         FloatingActionButton(
                  backgroundColor:  ctrlTheme.primaryColor,
                  child: const Icon(Icons.add),
                  onPressed: () {
                     final _ctrlResidente = context.read<ResidentesController>();
                    final _controller = context.read<BitacoraController>();
                    _controller.resetFormBitacora();
                  
                    _controller.setResidente(_ctrlResidente.getInfoResidente);
                    _controller.setDataVehiculo({});
                     _controller.eliminaALLItemVisitas();

                  
                                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: ((context) => const RegitroBiracora(
                                      builder: ((context) => CrearBitaora(
                                            user: user,
                                            action: 'CREATE',
                                          ))));
                                      //*******************************//


                  },
                )
          )
          ),
    );
  }


_callNumber(String numero) async {
  await FlutterPhoneDirectCaller.callNumber(numero);
}

}
