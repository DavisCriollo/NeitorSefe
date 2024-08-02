import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/dataTable/lista_pedidos_datasource.dart';
import 'package:nseguridad/src/dataTable/pedidos_supervisor_datasource.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class DetallePedidoGuardia extends StatefulWidget {
  // final int? codigoPedido;
  const DetallePedidoGuardia({Key? key}) : super(key: key);

  @override
  State<DetallePedidoGuardia> createState() => _DetallePedidoGuardiaState();
}

class _DetallePedidoGuardiaState extends State<DetallePedidoGuardia> {
  @override
  Widget build(BuildContext context) {
    final _infoPedido = {};
    
    final List<Map<String,dynamic>> _listaPedidosImplementos = [];
    final List<Map<String,dynamic>> _listaPedidosMuniciones = [];
     final _user=context.read<HomeController>();
   

    final pedidoController =  Provider.of<LogisticaController>(context, listen: false);

   for (var item in  pedidoController.getinfoPedido['disVestimenta']) {

     _listaPedidosImplementos.add(item);
   }
   for (var item in  pedidoController.getinfoPedido['disMuniciones']) {

     _listaPedidosMuniciones.add(item);
   }


    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
         
    return Scaffold(
      // backgroundColor: const Color(0xffF2F2F2),
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
          'Detalle de Pedido',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: 
      
//       FutureBuilder(
//         future: pedidoController.getTodosLosPedidosGuardias('', 'false'),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasData) {
//             for (var e in pedidoController.getListaTodosLosPedidosGuardias) {
//               if (e['disId'] == widget.codigoPedido) {
//                 _infoPedido.addAll(e);
//                 _listaPedidos.addAll(e['disPedidos']);
//                 return Container(
//                   // color: Colors.red,
//                   margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
//                   padding: EdgeInsets.only(
//                     // top: size.iScreen(0.5),
//                     left: size.iScreen(0.5),
//                     right: size.iScreen(0.5),
//                     // bottom: size.iScreen(0.5),
//                   ),
//                   width: size.wScreen(100.0),
//                   height: size.hScreen(100),
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [


//                          Container(
//                              width: size.wScreen(100.0),
//                              margin: const EdgeInsets.all(0.0),
//                              padding: const EdgeInsets.all(0.0),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.end,
//                                children: [
//                                  Text(
//                                      '${_user.getUsuarioInfo!.rucempresa!}  ',
//                                      style: GoogleFonts.lexendDeca(
//                                          fontSize:
//                                              size.iScreen(1.5),
//                                          color:
//                                              Colors.grey.shade600,
//                                          fontWeight:
//                                              FontWeight.bold)),
//                                  Text('-',
//                                      style: GoogleFonts.lexendDeca(
//                                          fontSize:
//                                             size.iScreen(1.5),
//                                          color: Colors.grey,
//                                          fontWeight:
//                                              FontWeight.bold)),
//                                  Text(
//                                      '  ${_user.getUsuarioInfo!.usuario!} ',
//                                      style: GoogleFonts.lexendDeca(
//                                          fontSize:
//                                              size.iScreen(1.5),
//                                          color:
//                                              Colors.grey.shade600,
//                                          fontWeight:
//                                              FontWeight.bold)),
//                                ],
//                              )),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(1.0),
//                         ),
//                         //*****************************************/
//                         Row(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   bottom: size.iScreen(0.0)),
//                               // width: size.wScreen(100.0),
//                               child: Text(
//                                 'Estado: ',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   bottom: size.iScreen(0.0)),
//                               width: size.wScreen(60.0),
//                               child: Text(
//                                 '${_infoPedido['disEstado']}',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color:
//                                         (_infoPedido['disEstado'] == 'ENVIADO')
//                                             ? Colors.blue
//                                             : (_infoPedido['disEstado'] ==
//                                                     'PENDIENTE')
//                                                 ? Colors.orange
//                                                 : (_infoPedido['disEstado'] ==
//                                                         'RECIBIDO')
//                                                     ? Colors.green
//                                                     : Colors.red,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.5),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             'Cliente: ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ), //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.1),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             _infoPedido['disNombreCliente'],
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.5),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             'Guardias: ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.1),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: _infoPedido['disPersonas'].isEmpty
//                               ? Text(
//                                   _infoPedido['disPersonas'].isEmpty
//                                       ? 'No Designados'
//                                       : _infoPedido['disPersonas'][0]
//                                           ['nombres'],
//                                   style: GoogleFonts.lexendDeca(
//                                       fontSize: size.iScreen(1.5),
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               : Wrap(
//                                   children: (_infoPedido['disPersonas'] as List)
//                                       .map((e) => Container(
//                                             width: size.wScreen(100.0),
//                                             color: Colors.white,
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: size.iScreen(0.2)),
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: size.iScreen(0.5),
//                                                 horizontal: size.iScreen(0.5)),
//                                             child: Text(
//                                               '${e['nombres']}',
//                                               style: GoogleFonts.lexendDeca(
//                                                   fontSize: size.iScreen(1.5),
//                                                   color: Colors.black54,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ))
//                                       .toList()),
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Row(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: size.iScreen(0.5),
//                                   bottom: size.iScreen(0.0)),
//                               // width: size.wScreen(100.0),
//                               child: Text(
//                                 'Tipo de entrega: ',
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                   top: size.iScreen(0.1),
//                                   bottom: size.iScreen(0.0)),
//                               // width: size.wScreen(100.0),
//                               child: Text(
//                                 // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
//                                 _infoPedido['disEntrega'],
//                                 style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.5),
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/

//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.5),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             'Observación: ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.1),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             _infoPedido['disObservacion'],
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: size.iScreen(0.5),
//                               bottom: size.iScreen(0.0)),
//                           width: size.wScreen(100.0),
//                           child: Text(
//                             'Pedidos: ',
//                             style: GoogleFonts.lexendDeca(
//                                 fontSize: size.iScreen(1.5),
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(0.5),
//                         ),
//                         //*****************************************/
//                         _listaPedidos.isNotEmpty
//                             ? Container(
//                                 margin: EdgeInsets.only(
//                                     top: size.iScreen(0.1),
//                                     bottom: size.iScreen(0.0)),
//                                 width: size.wScreen(100.0),
//                                 child: PaginatedDataTable(
//                                   arrowHeadColor: primaryColor,
//                                   columns: [
//                                     DataColumn(
//                                         label: Text('Nombre',
//                                             style: GoogleFonts.lexendDeca(
//                                                 // fontSize: size.iScreen(2.0),
//                                                 fontWeight: FontWeight.normal,
//                                                 color: Colors.grey))),
//                                     DataColumn(
//                                         numeric: true,
//                                         label: Text('Cantidad',
//                                             style: GoogleFonts.lexendDeca(
//                                                 // fontSize: size.iScreen(2.0),
//                                                 fontWeight: FontWeight.normal,
//                                                 color: Colors.grey))),
//                                     DataColumn(
//                                         label: Text('Serie',
//                                             style: GoogleFonts.lexendDeca(
//                                                 fontWeight: FontWeight.normal,
//                                                 color: Colors.grey))),
//                                   ],
//                                   source: ListaPedidosGuardiasDTS(
//                                       _listaPedidos, size, context),
//                                   rowsPerPage: _listaPedidos.length,
//                                 ))
//                             : const NoData(label: 'No hay Pedidos Realizados'),
//                         //***********************************************/
//                         SizedBox(
//                           height: size.iScreen(1.0),
//                         ),
//                         //*****************************************/
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             }
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
      
 Container(
                  // color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                  padding: EdgeInsets.only(
                    // top: size.iScreen(0.5),
                    left: size.iScreen(0.5),
                    right: size.iScreen(0.5),
                    // bottom: size.iScreen(0.5),
                  ),
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
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Estado: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              width: size.wScreen(60.0),
                              child:
                           
                              Text(
                                                              '${pedidoController.getinfoPedido['disEstado']}',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: (pedidoController.getinfoPedido[
                                                                                  'disEstado'] ==
                                                                              'ENVIADO')
                                                                          ? Colors
                                                                              .blue
                                                                          : (pedidoController.getinfoPedido['disEstado'] ==
                                                                                  'PENDIENTE')
                                                                              ? Colors
                                                                                  .orange
                                                                              : (pedidoController.getinfoPedido['disEstado'] ==
                                                                                      'RECIBIDO')
                                                                                  ? Colors
                                                                                      .green
                                                                                  : Colors
                                                                                      .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                            ),
                          ],
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            'Cliente: ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ), //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.1),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                         pedidoController.getinfoPedido['disNombreCliente'],
               
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Row(
                            children: [
                              Text(
                                'Guardias: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                               pedidoController.getinfoPedido['disPersonas'].isEmpty? Text(
                                      // pedidoController.getinfoPedido['disAdministracion'].isEmpty
                                           'No Designados',
                                          // : pedidoController.getinfoPedido['disAdministracion'][0]
                                          //     ['nombres'],
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ):Container()
                            ],
                          ),
                        ),
                        Column(
                          children: [
                        /***********************************************/
                        SizedBox(
                          height: size.iScreen(0.0),
                        ),
                        //*****************************************/
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  bottom: size.iScreen(0.0)),
                              width: size.wScreen(100.0),
                              child: pedidoController.getinfoPedido['disPersonas'].isEmpty
                                  ? Container()
                                  : Wrap(
                                      children: (pedidoController.getinfoPedido['disPersonas'] as List)
                                          .map((e) => Container(
                                                width: size.wScreen(100.0),
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.2)),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5),
                                                    horizontal: size.iScreen(0.5)),
                                                child: Text(
                                                  '${e['perApellidos']}  ${e['perNombres']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ))
                                          .toList()),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Row(
                            children: [
                              Text(
                                'Supervisores: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                                 pedidoController.getinfoPedido['disSupervisores'].isEmpty? Text(
                                      // pedidoController.getinfoPedido['disAdministracion'].isEmpty
                                           'No Designados',
                                          // : pedidoController.getinfoPedido['disAdministracion'][0]
                                          //     ['nombres'],
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ):Container()
                            ],
                          ),
                        ),
                        Column(
                          children: [
                        /***********************************************/
                        SizedBox(
                          height: size.iScreen(0.0),
                        ),
                        //*****************************************/
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  bottom: size.iScreen(0.0)),
                              width: size.wScreen(100.0),
                              child: pedidoController.getinfoPedido['disSupervisores'].isEmpty
                                  ? Container()
                                  : Wrap(
                                      children: (pedidoController.getinfoPedido['disSupervisores'] as List)
                                          .map((e) => Container(
                                                width: size.wScreen(100.0),
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.2)),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5),
                                                    horizontal: size.iScreen(0.5)),
                                                child: Text(
                                                  '${e['perApellidos']}  ${e['perNombres']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ))
                                          .toList()),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.0),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Row(
                            children: [
                              Text(
                                'Administradores: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                              
                             pedidoController.getinfoPedido['disAdministracion'].isEmpty? Text(
                                      // pedidoController.getinfoPedido['disAdministracion'].isEmpty
                                           'No Designados',
                                          // : pedidoController.getinfoPedido['disAdministracion'][0]
                                          //     ['nombres'],
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ):Container()
                            ],
                          ),
                        ),
                        Column(
                          children: [
                        /***********************************************/
                        SizedBox(
                          height: size.iScreen(0.0),
                        ),
                        //*****************************************/
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  bottom: size.iScreen(0.0)),
                              width: size.wScreen(100.0),
                              child: pedidoController.getinfoPedido['disAdministracion'].isEmpty
                                  ? Container()
                                  : Wrap(
                                      children: (pedidoController.getinfoPedido['disAdministracion'] as List)
                                          .map((e) => Container(
                                                width: size.wScreen(100.0),
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.2)),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.5),
                                                    horizontal: size.iScreen(0.5)),
                                                child: Text(
                                                  '${e['perApellidos']}  ${e['perNombres']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ))
                                          .toList()),
                            ),
                          ],
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Tipo de entrega: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.1),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                               pedidoController.getinfoPedido['disEntrega'],
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/

                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            'Observación: ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.1),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            pedidoController.getinfoPedido['disObservacion'],
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(1.0),
                            horizontal: size.iScreen(0.0)),
                        padding: EdgeInsets.only(
                           
                            right: size.iScreen(1.0)),
                        color: Colors.grey.shade200,
                        width: size.wScreen(100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Pedidos',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                                    Spacer(),
                            Text('Valor Total : \$ ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                            Consumer<LogisticaController>(
                              builder: (_, valueTotal, __) {
                                return Text('${valueTotal.getTotalPedido}',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.grey,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.0),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            'Implementos: ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                       _listaPedidosImplementos.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.1),
                                    bottom: size.iScreen(0.0)),
                                width: size.wScreen(100.0),
                                child: PaginatedDataTable(
                                  arrowHeadColor: primaryColor,
                                  columns: [
                                   
                                    DataColumn(
                                                  label: Row(
                                                children: [
                                                
                                                   Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Valor',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Serie',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Marca',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Modelo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Talla',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Bodega',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Tipo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                  ],
                                  source: PedidosImplementosDTS(
                                      _listaPedidosImplementos, size, context,'DETALLE'),
                                  rowsPerPage: _listaPedidosImplementos.length,
                                  
                                ))
                            : const NoData(label: 'No hay Pedidos Realizados'),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            'Municiones: ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                       _listaPedidosMuniciones.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.1),
                                    bottom: size.iScreen(0.0)),
                                width: size.wScreen(100.0),
                                child: PaginatedDataTable(
                                  arrowHeadColor: primaryColor,
                                  columns: [
                                   
                                    DataColumn(
                                                  label: Row(
                                                children: [
                                                
                                                   Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Valor',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Serie',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Marca',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Modelo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Talla',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Bodega',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Tipo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                  ],
                                  source: PedidosImplementosDTS(
                                      _listaPedidosMuniciones, size, context,'DETALLE'),
                                  rowsPerPage: _listaPedidosMuniciones.length,
                                  
                                ))
                            : const NoData(label: 'No hay Pedidos Realizados'),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                      ],
                    ),
                  ),
                )
             
    );
  }
}
