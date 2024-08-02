import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/dataTable/detalle_pedidos_activos_datasource.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetallePedidoActivo extends StatefulWidget {
  final int? codigoPedido;
  const DetallePedidoActivo({Key? key, this.codigoPedido}) : super(key: key);

  @override
  State<DetallePedidoActivo> createState() => _DetallePedidoActivoState();
}

class _DetallePedidoActivoState extends State<DetallePedidoActivo> {
  @override
  Widget build(BuildContext context) {
    final _infoPedido = {};
    final List<dynamic> _listaPedidos = [];

    final pedidoController =
        Provider.of<LogisticaController>(context, listen: false);
    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
         
     final _user=context.read<HomeController>();
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
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
      body: FutureBuilder(
        future: pedidoController.getTodosLosPedidosActivos(''),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            for (var e in pedidoController.getListaTodosLosPedidosActivos) {
              if (e['disId'] == widget.codigoPedido) {
                _infoPedido.addAll(e);
                _listaPedidos.addAll(e['disPedidos']);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                  padding: EdgeInsets.only(
                    left: size.iScreen(0.5),
                    right: size.iScreen(0.5),
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
                              child: Text(
                                '${_infoPedido['disEstado']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    color:
                                        (_infoPedido['disEstado'] == 'ENVIADO')
                                            ? Colors.blue
                                            : (_infoPedido['disEstado'] ==
                                                    'PENDIENTE')
                                                ? Colors.orange
                                                : (_infoPedido['disEstado'] ==
                                                        'RECIBIDO')
                                                    ? Colors.green
                                                    : Colors.red,
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
                            // 'pedidodisEntrega dadas asdasd asda ad asdasd asdasd asdasd asdasd ' ,
                            _infoPedido['disNombreCliente'],
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
                          child: Text(
                            'Guardia: ',
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
                            _infoPedido['disPersonas'][0]['nombres'],
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
                                _infoPedido['disEntrega'],
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
                            _infoPedido['disObservacion'],
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
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5),
                              bottom: size.iScreen(0.0)),
                          width: size.wScreen(100.0),
                          child: Text(
                            'Pedidos: ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
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
                            child: PaginatedDataTable(
                              arrowHeadColor: primaryColor,
                              columns: [
                                DataColumn(
                                    label: Text('Nombre',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    numeric: true,
                                    label: Text('Cantidad',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                                DataColumn(
                                    label: Text('Serie',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey))),
                              ],
                              source: ListaDetallepedidosActivosDTS(
                                  _listaPedidos, size, context),
                              rowsPerPage: _listaPedidos.length,
                            )),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                      ],
                    ),
                  ),
                );
              }
            }
          }
          return Container();
        },
      ),
    );
  }
}
