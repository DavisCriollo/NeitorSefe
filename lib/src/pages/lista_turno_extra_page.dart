// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';

import 'package:nseguridad/src/pages/detalle_turno_extra.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
// import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaTurnoExtraPage extends StatefulWidget {
  const ListaTurnoExtraPage({Key? key}) : super(key: key);

  @override
  State<ListaTurnoExtraPage> createState() => _ListaTurnoExtraPageState();
}

class _ListaTurnoExtraPageState extends State<ListaTurnoExtraPage> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void dispose() {
    _textSearchController.clear();
    super.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<TurnoExtraController>(context, listen: false);
    loadInfo.buscaTurnoExtra('');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'turnoextra') {
        loadInfo.buscaTurnoExtra('');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'turnoextra') {
        loadInfo.buscaTurnoExtra('');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'turnoextra') {
        loadInfo.buscaTurnoExtra('');
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
            title: Consumer<TurnoExtraController>(
              builder: (_, providerSearch, __) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        child: (providerSearch.btnSearch)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.5)),
                                        color: Colors.white,
                                        height: size.iScreen(4.0),
                                        child: TextField(
                                          controller: _textSearchController,
                                          autofocus: true,
                                          onChanged: (text) {
                                            providerSearch.onSearchText(text);
                                            // setState(() {});
                                          },
                                          decoration: const InputDecoration(
                                            // icon: Icon(Icons.search),
                                            border: InputBorder.none,
                                            hintText: 'Buscar...',
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          border:
                                              // Border.all(
                                              //     color: Colors.white)
                                              Border(
                                            left: BorderSide(
                                                width: 0.0, color: Colors.grey),
                                          ),
                                        ),
                                        height: size.iScreen(4.0),
                                        width: size.iScreen(3.0),
                                        child: const Icon(Icons.search,
                                            color: Colors.white),
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: size.wScreen(90.0),
                                child: Text(
                                  'Turno Extra',
                                  // style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                      ),
                    ),
                    IconButton(
                        splashRadius: 2.0,
                        icon: (!providerSearch.btnSearch)
                            ? Icon(
                                Icons.search,
                                size: size.iScreen(3.5),
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.clear,
                                size: size.iScreen(3.5),
                                color: Colors.white,
                              ),
                        onPressed: () {
                          providerSearch
                              .setBtnSearch(!providerSearch.btnSearch);
                          _textSearchController.text = "";
                          providerSearch.buscaTurnoExtra('');
                        }),
                  ],
                );
              },
            ),
          ),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                     padding: EdgeInsets.only(
                top: size.iScreen(2.0),
                left: size.iScreen(0.0),
                right: size.iScreen(0.0),
              ),
                    // color: Colors.red,
                    width: size.wScreen(100.0),
                    height: size.hScreen(100.0),
                    child:
                        Consumer<TurnoExtraController>(builder: (_, provider, __) {
                      if (provider.getErrorTurnoExtra == null) {
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
                      } else if (provider.getErrorTurnoExtra == false) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("Error al cargar los datos");
                      } else if (provider.getListaTurnoExtra.isEmpty) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("sin datos");
                      }
                      return ListView.builder(
                        itemCount: provider.getListaTurnoExtra.length,
                        itemBuilder: (BuildContext context, int index) {
                          final turno = provider.getListaTurnoExtra[index];
                          return Slidable(
                            startActionPane: const ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: ScrollMotion(),

                              children: [],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                provider.getDataTurnoExtra(turno);
                                 provider.buscaIdTurnoAsignado(turno['turIdMulta'].toString());//idTurno
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const DetalleTurnoExtra())));
                              },
                              child: ClipRRect(
                                // borderRadius: BorderRadius.circular(8),
                                child: Card(
                                  child: Container(
                                    margin: EdgeInsets.only(top: size.iScreen(0.5)),
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
                                                        bottom: size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      'Motivo: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.red,
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),
                                                    width: size.wScreen(60.0),
                                                    child: Text(
                                                      '${turno['turMotivo']}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                      'Guardia: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.iScreen(30.0),
                                                    // color: Colors.red,
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),

                                                    child: Text(
                                                      ' ${turno['turNomPersona']}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.iScreen(33.0),
                                                    // color: Colors.red,
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),

                                                    child: Text(
                                                      ' ${turno['turNomCliente']}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Row(
                                              //       children: [
                                              //         Container(
                                              //           margin: EdgeInsets.only(
                                              //               top: size.iScreen(0.5),
                                              //               bottom:
                                              //                   size.iScreen(0.0)),
                                              //           // width: size.wScreen(100.0),
                                              //           child: Text(
                                              //             'Desde: ',
                                              //             style: GoogleFonts
                                              //                 .lexendDeca(
                                              //                     fontSize: size
                                              //                         .iScreen(1.5),
                                              //                     color: Colors
                                              //                         .black87,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .normal),
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           margin: EdgeInsets.only(
                                              //               top: size.iScreen(0.5),
                                              //               bottom:
                                              //                   size.iScreen(0.0)),
                                              //           // width: size.wScreen(100.0),
                                              //           child: Text(
                                              //             turno['turFechaDesde']
                                              //                 .toString()
                                              //                 .replaceAll("T", " "),
                                              //             style: GoogleFonts
                                              //                 .lexendDeca(
                                              //                     fontSize: size
                                              //                         .iScreen(1.5),
                                              //                     color: Colors
                                              //                         .black87,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .bold),
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Row(
                                              //       children: [
                                              //         Container(
                                              //           margin: EdgeInsets.only(
                                              //               top: size.iScreen(0.5),
                                              //               bottom:
                                              //                   size.iScreen(0.0)),
                                              //           // width: size.wScreen(100.0),
                                              //           child: Text(
                                              //             'Hasta: ',
                                              //             style: GoogleFonts
                                              //                 .lexendDeca(
                                              //                     fontSize: size
                                              //                         .iScreen(1.5),
                                              //                     color: Colors
                                              //                         .black87,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .normal),
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           margin: EdgeInsets.only(
                                              //               top: size.iScreen(0.5),
                                              //               bottom:
                                              //                   size.iScreen(0.0)),
                                              //           // width: size.wScreen(100.0),
                                              //           child: Text(
                                              //             turno['turFechaHasta']
                                              //                 .toString()
                                              //                 .replaceAll("T", " "),
                                              //             style: GoogleFonts
                                              //                 .lexendDeca(
                                              //                     fontSize: size
                                              //                         .iScreen(1.5),
                                              //                     color: Colors
                                              //                         .black87,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .bold),
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  Container(
                                                    // width: size.iScreen(10.0),
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      'Días: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.iScreen(10.0),
                                                    // color: Colors.red,
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),

                                                    child: Text(
                                                      ' ${turno['turDiasTurno']}',
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
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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

          // floatingActionButton: FloatingActionButton(
          //   // backgroundColor: primaryColor,
          //   child: const Icon(Icons.add),
          //   onPressed: () {
          //     final turnoExtraController =
          //         Provider.of<TurnoExtraController>(context, listen: false);
          //     turnoExtraController.resetValuesTurnoExtra();
          //     turnoExtraController.buscaLstaDataJefeOperaciones('');
          //     // turnoExtraController.resetValuesTurnoExtra();
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: ((context) => CreaTurnoExtra())));
          //         turnoExtraController.setLabelMotivoTurnoExtra('EVENTO ESPECIAL');
          //     Navigator.pushNamed(context, 'creaTurnoExtra',
          //         arguments: 'CREATE');
          //   },
          // )
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    final informeController =
        Provider.of<InformeController>(context, listen: false);
    // informeController.buscaInformeGuardias('');
  }
}
