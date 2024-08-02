import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/pages/crea_aviso_salida_guardia.dart';

import 'package:nseguridad/src/pages/detalle_aviso_salida.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaAvisoSalidaGuardiasPage extends StatefulWidget {
  const ListaAvisoSalidaGuardiasPage({Key? key}) : super(key: key);

  @override
  State<ListaAvisoSalidaGuardiasPage> createState() =>
      _ListaAvisoSalidaGuardiasPageState();
}

class _ListaAvisoSalidaGuardiasPageState
    extends State<ListaAvisoSalidaGuardiasPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<AvisoSalidaController>(context, listen: false);
    loadInfo.buscaAvisosSalida('');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'avisosalida') {
        loadInfo.buscaAvisosSalida('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'avisosalida') {
        loadInfo.buscaAvisosSalida('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'avisosalida') {
        loadInfo.buscaAvisosSalida('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
  final _user=context.read<HomeController>();
       final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                'Avisos de Salida',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: Stack(
                children: [
                  Container(
                    
                     padding: EdgeInsets.only(
                top: size.iScreen(2.0),
                left: size.iScreen(0.0),
                right: size.iScreen(0.0),
              ),
                      width: size.wScreen(100.0),
                      height: size.hScreen(100.0),
                      child: Consumer<AvisoSalidaController>(
                          builder: (_, provider, __) {
                        if (provider.getErrorInformesGuardia == null) {
                          return const NoData(
                            label: 'Cargando datos...',
                          );
                        } else if (provider.getErrorInformesGuardia == false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (provider.getListaAvisosSalida.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        }
                        return ListView.builder(
                          itemCount: provider.getListaAvisosSalida.length,
                          itemBuilder: (BuildContext context, int index) {
                            final aviso = provider.getListaAvisosSalida[index];
                            return Slidable(
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    // label: 'Editar',
                                    onPressed: (context) {
                                      // loadData;
                                      // provider.resetValuesInformes();
                                      provider.getDataAvisoSalida(aviso);

                                      final avisoSalida =
                                          Provider.of<AvisoSalidaController>(
                                              context,
                                              listen: false);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const CreaAvisoSalida(
                                                    action: 'EDIT',
                                                  ))));
                                    },
                                  ),
                                  SlidableAction(
                                    onPressed: (context) async {
                                      // ProgressDialog.show(context);
                                      await provider
                                          .eliminaAvisoSalida(aviso['nomId']);
                                      // ProgressDialog.dissmiss(context);
                                    },
                                    backgroundColor: Colors.red.shade700,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_forever_outlined,
                                    // label: 'Eliminar',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, 'detalleInformeGuardia');
                                  provider.getDataAvisoSalida(aviso);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const DetalleAvisoSalida())));
                                },
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(8),
                                  child: Card(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: size.iScreen(0.5)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(1.0),
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
                                                      margin: EdgeInsets.only(
                                                          top: size.iScreen(0.5),
                                                          bottom:
                                                              size.iScreen(0.0)),
                                                      // width: size.wScreen(100.0),
                                                      child: Text(
                                                        'Guardia: ',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.iScreen(23.0),
                                                      // color: Colors.red,
                                                      margin: EdgeInsets.only(
                                                          top: size.iScreen(0.5),
                                                          bottom:
                                                              size.iScreen(0.0)),

                                                      child: Text(
                                                        ' ${aviso['nomNomPersona']}',
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
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
                                                        'Motivo: ',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.iScreen(23.0),
                                                      // color: Colors.red,
                                                      margin: EdgeInsets.only(
                                                          top: size.iScreen(0.5),
                                                          bottom:
                                                              size.iScreen(0.0)),

                                                      child: Text(
                                                        ' ${aviso['nomMotivo']}',
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
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
                                                        'Fecha de Registro: ',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
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
                                                        aviso['nomFecha']
                                                            .toString()
                                                            .replaceAll("T", " "),
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                color:
                                                                    Colors.black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'ESTADO',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.3),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Text(
                                                  '${aviso['nomEstado']}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.4),
                                                      // color: Colors.orange,
                                                      color: aviso!['nomEstado'] ==
                                                              'APELACION'
                                                          ? secondaryColor
                                                          : aviso!['nomEstado'] ==
                                                                  'EN PROCESO'
                                                              ? tercearyColor
                                                              : aviso!['nomEstado'] ==
                                                                      'APROBADO'
                                                                  ? secondaryColor
                                                                  : aviso!['nomEstado'] ==
                                                                          'ANULADA'
                                                                      ? Colors.red
                                                                      : aviso!['nomEstado'] ==
                                                                              'ASIGNADA'
                                                                          ? primaryColor
                                                                          : Colors
                                                                              .grey,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      })),

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
            floatingActionButton: FloatingActionButton(
              backgroundColor:      ctrlTheme.primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                final avisoSalida =
                    Provider.of<AvisoSalidaController>(context, listen: false);
                avisoSalida.resetValuesAvisoSalida();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const CreaAvisoSalida(
                              action: 'CREATE',
                            ))));

              },
            )),
      ),
    );
  }

  Future<void> onRefresh() async {
    final informeController =
        Provider.of<InformeController>(context, listen: false);
    // informeController.buscaInformeGuardias('');
  }
}
