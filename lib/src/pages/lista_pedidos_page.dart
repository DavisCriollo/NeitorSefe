import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/pages/detalle_pedido_activo.dart';
import 'package:nseguridad/src/pages/realiza_devolucion.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaPedidosPage extends StatefulWidget {
  const ListaPedidosPage({Key? key}) : super(key: key);

  @override
  State<ListaPedidosPage> createState() => _ListaPedidosPageState();
}

class _ListaPedidosPageState extends State<ListaPedidosPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<LogisticaController>(context, listen: false);
    loadInfo.getTodosLosPedidosActivos('');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'devolucion') {
        loadInfo.getTodosLosPedidosActivos('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'devolucion') {
        loadInfo.getTodosLosPedidosActivos('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'devolucion') {
        loadInfo.getTodosLosPedidosActivos('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final logisticaController =
        Provider.of<LogisticaController>(context, listen: false);

          final _user=context.read<HomeController>();
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
        title: Text(
          'Lista de Pedidos',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: // =============================================//
          Stack(
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
                if (providers.getErrorAllPedidosActivos == null) {
                  return Center(
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
                } else if (providers.getErrorAllPedidosActivos == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                } else if (providers.getListaTodosLosPedidosActivos.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("sin datos");
                }

                return ListView.builder(
                  itemCount: providers.getListaTodosLosPedidosActivos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pedido = providers.getListaTodosLosPedidosActivos[index];
                    return Slidable(
                      key: ValueKey(index),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: ScrollMotion(),

                        children: [
                          SlidableAction(
                            backgroundColor: secondaryColor,
                            foregroundColor: Colors.white,
                            icon: Icons.assignment_return_outlined,
                            label: 'Devolver',
                            onPressed: (context) {
                              providers.resetValuesPedidos();
                              providers.getPedidoParaDevoluciones(pedido);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const RealizaDevolucion(
                                              // pedido: pedido,
                                              ))));
                            },
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          providers.resetValuesPedidos();
                          providers.getPedidoParaDevoluciones(pedido);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetallePedidoActivo(
                                        codigoPedido: pedido['disId'],
                                      ))));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: size.iScreen(0.5)),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Tipo: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            '${pedido['disTipo']}  ${pedido['disId']}', //- ${pedido['disId']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Cliente: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          width: size.wScreen(70.0),
                                          child: Text(
                                            '${pedido['disNombreCliente']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Entrega: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            '${pedido['disEntrega']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          width: size.wScreen(60.0),
                                          child: Text(
                                            '${pedido['disEstado']}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: (pedido['disEstado'] ==
                                                        'ENVIADO')
                                                    ? Colors.blue
                                                    : (pedido['disEstado'] ==
                                                            'PENDIENTE')
                                                        ? Colors.orange
                                                        : (pedido['disEstado'] ==
                                                                'RECIBIDO')
                                                            ? Colors.green
                                                            : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Fecha de registro: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            pedido['disFecReg']
                                                .toString()
                                                .replaceAll(".000Z", "")
                                                .replaceAll("T", "   "),
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
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
                );
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

      // =============================================//,
    );
  }
}
