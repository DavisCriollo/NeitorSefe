import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/pages/detalle_pedido_guardia.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaTodosLosPedidos extends StatefulWidget {
  const ListaTodosLosPedidos({Key? key}) : super(key: key);

  @override
  State<ListaTodosLosPedidos> createState() => _ListaTodosLosPedidosState();
}

class _ListaTodosLosPedidosState extends State<ListaTodosLosPedidos> {
  final logisticaController = LogisticaController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    logisticaController.getTodosLosPedidosGuardias('', 'false');
    final socketService = context.read<SocketService>();
    socketService.socket?.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'pedido') {
        logisticaController.getTodosLosPedidosGuardias('', 'false');
      }
    });

    socketService.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'pedido') {
        logisticaController.getTodosLosPedidosGuardias('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    socketService.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'pedido') {
        logisticaController.getTodosLosPedidosGuardias('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

     final _user=context.read<HomeController>();

  final ctrlTheme = context.read<ThemeApp>();
        

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                'Pedidos',
                // style: Theme.of(context).textTheme.headline2,
              ),
              actions: const [],
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.iScreen(1.0),
                    ),
                      padding: EdgeInsets.only(
                      top: size.iScreen(2.0),
                      left: size.iScreen(0.0),
                      right: size.iScreen(0.0),
                    ),
                    width: size.wScreen(100.0),
                    height: size.hScreen(100.0),
                    child: Consumer<LogisticaController>(
                      builder: (_, providers, __) {
                        // print('redibujo0');
                        if (providers.getErrorAllPedidos == null) {
                          return Center(
                            // child: CircularProgressIndicator(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Cargando Datos...',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.5),
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                const CircularProgressIndicator(),
                              ],
                            ),
                          );
                        } else if (providers.getErrorAllPedidos == false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (providers
                            .getListaTodosLosPedidosGuardias.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }
            
                        return
            
                            //  //***********************************************/
                            Consumer<SocketService>(
                          builder: (_, valueEstadoInter, __) {
                            return valueEstadoInter.serverStatus ==
                                    ServerStatus.Online
                                ? ListView.builder(
                                    itemCount: providers
                                        .getListaTodosLosPedidosGuardias.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final pedido = providers
                                          .getListaTodosLosPedidosGuardias[index];
                                
                                      String fechaLocal = pedido['disFecReg']==''?'--- --- ':DateUtility.fechaLocalConvert( pedido['disFecReg']!.toString());
                                
                                      return Slidable(
                                        key: ValueKey(index),
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            (providers.getListaTodosLosPedidosGuardias[
                                                            index]['disEstado'] ==
                                                        'RECIBIDO' ||
                                                    providers.getListaTodosLosPedidosGuardias[
                                                            index]['disEstado'] ==
                                                        'ANULADO')
                                                ? Container()
                                                : SlidableAction(
                                                    backgroundColor: tercearyColor,
                                                    foregroundColor: Colors.white,
                                                    // icon: Icons.edit,
                                                    label: 'Editar',
                                                    onPressed: (context) {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible: true,
                                                          builder:
                                                              (BuildContext context) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              child: Container(
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxHeight: size
                                                                            .wScreen(
                                                                                60.0)),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .all(size
                                                                          .iScreen(
                                                                              3.0)),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Estado del Pedido',
                                                                          style: GoogleFonts
                                                                              .lexendDeca(
                                                                            fontSize:
                                                                                size.iScreen(
                                                                                    2.0),
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                            // color: Colors.white,
                                                                          )),
                                                                      SizedBox(
                                                                        height: size
                                                                            .iScreen(
                                                                                2.0),
                                                                      ),
                                                                      providers.getListaTodosLosPedidosGuardias[index]
                                                                                  [
                                                                                  'disEstado'] ==
                                                                              'ENVIADO'
                                                                          ? ListTile(
                                                                              tileColor:
                                                                                  Colors.grey[200],
                                                                              leading: const Icon(
                                                                                  Icons
                                                                                      .receipt_long_outlined,
                                                                                  color:
                                                                                      Colors.green),
                                                                              title:
                                                                                  Text(
                                                                                "RECIBIDO",
                                                                                style:
                                                                                    GoogleFonts.lexendDeca(
                                                                                  fontSize:
                                                                                      size.iScreen(2.0),
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  // color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              onTap:
                                                                                  () async {
                                                                                providers.infoPedidoEdicion(
                                                                                    pedido,
                                                                                    "RECIBIDO",
                                                                                    context);
                                                                                Navigator.pop(
                                                                                    context);
                                                                              },
                                                                            )
                                                                          : Container(),
                                                                      const Divider(),
                                                                      providers.getListaTodosLosPedidosGuardias[index]['disEstado'] ==
                                                                                  'ENVIADO' ||
                                                                              providers.getListaTodosLosPedidosGuardias[index]['disEstado'] ==
                                                                                  'PENDIENTE'
                                                                          ? ListTile(
                                                                              tileColor:
                                                                                  Colors.grey[200],
                                                                              leading: const Icon(
                                                                                  Icons
                                                                                      .do_disturb_alt_outlined,
                                                                                  color:
                                                                                      Colors.red),
                                                                              title:
                                                                                  Text(
                                                                                "ANULADO",
                                                                                style:
                                                                                    GoogleFonts.lexendDeca(
                                                                                  fontSize:
                                                                                      size.iScreen(2.0),
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  // color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              // trailing: const Icon(Icons.chevron_right_outlined),
                                                                              onTap:
                                                                                  () async {
                                                                                providers.infoPedidoEdicion(
                                                                                    pedido,
                                                                                    "ANULADO",
                                                                                    context);
                                
                                                                                Navigator.pop(
                                                                                    context);
                                                                              },
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                  ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                              final _controller=context.read<LogisticaController>();
                                            _controller.resetItemDevolucion();
                                            _controller.resetListaInventario();
                                            _controller.resetModalAgregarItems();
                                            _controller.resetValuesPedidos();
                                            _controller.setInfoPedido(pedido);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetallePedidoGuardia(
                                                            ))));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: size.iScreen(0.5)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.5),
                                                vertical: size.iScreen(0.5)),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            //  color: Colors.red,
                                                            width: size.wScreen(15.0),
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              'Cliente: ',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                          ),
                                                          Container(
                                                            // color: Colors.red,
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            width: size.wScreen(70.0),
                                                            child: Text(
                                                              '${pedido['disNombreCliente']}',
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            //  color: Colors.red,
                                                            width: size.wScreen(15.0),
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              'Entrega: ',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              '${pedido['disEntrega']}',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            //  color: Colors.red,
                                                            width: size.wScreen(15.0),
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              'Estado: ',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            width: size.wScreen(60.0),
                                                            child: Text(
                                                              '${pedido['disEstado']}',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: (pedido[
                                                                                  'disEstado'] ==
                                                                              'ENVIADO')
                                                                          ? Colors
                                                                              .blue
                                                                          : (pedido['disEstado'] ==
                                                                                  'PENDIENTE')
                                                                              ? Colors
                                                                                  .orange
                                                                              : (pedido['disEstado'] ==
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
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              'Fecha de registro: ',
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top:
                                                                    size.iScreen(0.5),
                                                                bottom: size
                                                                    .iScreen(0.0)),
                                                            // width: size.wScreen(100.0),
                                                            child: Text(
                                                              fechaLocal,
                                                              // // pedido['disFecReg']!=''?
                                                              // _fechaLocal
                                                              //   //  pedido['disFecReg'] .toLocal()
                                                              //     .toString()
                                                              //     .substring(0, 16)
                                                              //     // .toString()
                                                              //     .replaceAll(
                                                              //         ".000Z", "")
                                                              //     .replaceAll(
                                                              //         "T", "   "),
                                                              //         // :"--- ---",
                                                              style: GoogleFonts
                                                                  .lexendDeca(
                                                                      fontSize: size
                                                                          .iScreen(
                                                                              1.5),
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const NoData(label: 'Sin conexión a internet');
                          },
                        );
                        //  //***********************************************/
                      },
                    ),
                  ),
                                          Positioned(
                    top: 0,
                    child:   Container(
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
                 ),
                ],
              ),
            ),
            floatingActionButton:
                //  //***********************************************/
                Consumer<SocketService>(
              builder: (_, valueEstadoInter, __) {
                return valueEstadoInter.serverStatus == ServerStatus.Online
                    ? FloatingActionButton(
                        // backgroundColor: primaryColor,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          Provider.of<LogisticaController>(context,
                                  listen: false)
                              .resetValuesPedidos();

                          Navigator.pushNamed(context, 'creaPedido');
                        },
                      )
                    : Container();
              },
            )
            //  //***********************************************/

            ),
      ),
    );
  }

//========ALERTA ESTADO  CAMBIO DE PUESTO========//
  void _showAlertEstado(Responsive size, LogisticaController controller) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: const Text("Estado del Pedido"),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //==========================================//
                  GestureDetector(
                    child: Container(
                      width: size.wScreen(100.0),
                      padding:
                          EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                      color: Colors.grey.shade400,
                      child: Text(
                        "ANULAR",
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      controller
                          .setLabelNombreEstadoDevolucionPedido('ANULADO');
                      await controller.editarDevolucionPedido(context);
                      Navigator.pop(context);
                    },
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //==========================================//

                  SizedBox(
                    height: size.iScreen(2.0),
                  )
                ],
              ),
            ),
          );
        });
  }


  Future<void> onRefresh() async {
    final _control =
        Provider.of<LogisticaController>(context, listen: false);
    _control.getTodosLosPedidosGuardias('','false');
  }

}
