import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/consignas_controller.dart';

import 'package:nseguridad/src/pages/detalle_consigna_clientes.dart';
import 'package:nseguridad/src/pages/edita_consigna_cliente_page.dart';
import 'package:nseguridad/src/pages/crea_consigna_cliente_page.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaConsignasClientesPage extends StatefulWidget {
  const ListaConsignasClientesPage({Key? key}) : super(key: key);

  @override
  State<ListaConsignasClientesPage> createState() =>
      _ListaConsignasClientesPageState();
}

class _ListaConsignasClientesPageState
    extends State<ListaConsignasClientesPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<ConsignasController>(context, listen: false);
    loadInfo.getTodasLasConsignasClientes('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket?.on('server:error', (data) {
      NotificatiosnService.showSnackBarError(data['msg']);
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final consignasControler = Provider.of<ConsignasController>(context);
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
            'Mis Consignas',
            // style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.iScreen(1.0),
            ),
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: Consumer<SocketService>(
              builder: (_, valuesSocket, __) {
                return valuesSocket.serverStatus == ServerStatus.Online
                    ? Consumer<ConsignasController>(
                        builder: (_, providers, __) {
                          if (providers.getErrorAllConsignas == null) {
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
                          } else if (providers.getErrorAllConsignas == false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (providers
                              .getListaTodasLasConsignasCliente.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }

                          return ListView.builder(
                            itemCount: providers
                                .getListaTodasLasConsignasCliente.length,
                            itemBuilder: (BuildContext context, int index) {
                              final consigna = providers
                                  .getListaTodasLasConsignasCliente[index];
                              return Slidable(
                                key: ValueKey(index),
                                // The start action pane is the one at the left or the top side.
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.purple,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      // label: 'Editar',
                                      onPressed: (context) async {
                                        await providers
                                            .getInfoConsigna(consigna);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const EditarConsignaClientePage())));
                                      },
                                    ),
                                    SlidableAction(
                                      onPressed: (context) async {
                                        consignasControler
                                            .eliminaConsignaCliente(
                                                context, consigna);
                                      },
                                      backgroundColor: Colors.red.shade700,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_forever_outlined,
                                      // label: 'Eliminar',
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    await providers.getInfoConsigna(consigna);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const DetalleConsignasClientes())));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: size.iScreen(0.5)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(0.5),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                width: size.wScreen(100.0),
                                                child: Text(
                                                  '${consigna['conAsunto']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.6),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom:
                                                            size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      'Prioridad: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom:
                                                            size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      '${consigna['conPrioridad']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
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
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom:
                                                            size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      'Fecha de registro: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom:
                                                            size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      consigna['conFecReg']
                                                          .toString()
                                                          .replaceAll(
                                                              ".000Z", "")
                                                          .replaceAll(
                                                              "T", "   "),
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.5),
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
                                        Column(
                                          children: [
//
                                            //*****************************************/
                                            Text(
                                              'Estado',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.6),
                                                  color: Colors.black87,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(0.5),
                                            ),

                                            //*****************************************/
                                            Text(
                                              '${consigna['conProgreso']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.4),
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Container();
              },
            )),
        floatingActionButton: Consumer<SocketService>(
          builder: (_, valuesSave, __) {
            return valuesSave.serverStatus == ServerStatus.Online
                ? FloatingActionButton(
                    backgroundColor: primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      consignasControler.resetValues();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ConsignaClientePage()));
                    },
                  )
                : const NoData(label: 'Sin conexión a internet');
          },
        ));
  }

//====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalEstadoConsigna(
      Responsive size, ConsignasController consignasControler) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aviso',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  Text('Seguro de cambiar el estado de la consigna?',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        // color: Colors.white,
                      )),
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(1.0), bottom: size.iScreen(2.0)),
                    height: size.iScreen(3.5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF0A4280),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Si',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
