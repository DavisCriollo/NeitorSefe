import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/crear_cambio_puesto.dart';

import 'package:nseguridad/src/pages/detalle_cambio_puesto.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaCambioPuestoPage extends StatefulWidget {
  final Session? user;

  const ListaCambioPuestoPage({Key? key, this.user}) : super(key: key);

  @override
  State<ListaCambioPuestoPage> createState() => _ListaCambioPuestoPageState();
}

class _ListaCambioPuestoPageState extends State<ListaCambioPuestoPage> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.clear();
    super.dispose();
  }

  void initData() async {
//  usuario= await Auth.instance.getSession();

    final loadInfo =
        Provider.of<CambioDePuestoController>(context, listen: false);
    loadInfo.buscaCambioPuesto('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'cambiopuesto') {
        loadInfo.buscaCambioPuesto('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'cambiopuesto') {
        loadInfo.buscaCambioPuesto('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'cambiopuesto') {
        loadInfo.buscaCambioPuesto('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
       final ctrlTheme = context.read<ThemeApp>();
      final _user=context.read<HomeController>();



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
              title: Consumer<CambioDePuestoController>(
                builder: (_, providerSearch, __) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.iScreen(0.1)),
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
                                            },
                                            decoration: const InputDecoration(
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
                                            border: Border(
                                              left: BorderSide(
                                                  width: 0.0,
                                                  color: Colors.grey),
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
                                    'Cambio de Puesto',
                                    // style:Theme.of(context).textTheme.headline2,
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
                            providerSearch.buscaCambioPuesto('', 'false');
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
                      width: size.wScreen(100.0),
                      height: size.hScreen(100.0),
                      child: Consumer<CambioDePuestoController>(
                          builder: (_, provider, __) {
                        if (provider.getErrorCambioPuesto == null) {
                          return const NoData(
                            label: 'Cargando datos...',
                          );
                        } else if (provider.getErrorCambioPuesto == false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("Error al cargar los datos");
                        } else if (provider.getListaCambioPuesto.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }
                        return ListView.builder(
                          itemCount: provider.getListaCambioPuesto.length,
                          itemBuilder: (BuildContext context, int index) {
                            final puesto = provider.getListaCambioPuesto[index];
                            // Color _colorEstado = Colors.grey;
                            Color _colorEstado = Colors.grey;

                            if (puesto['camEstado'] == 'PENDIENTE') {
                              // _colorEstado = tercearyColor;
                              _colorEstado = tercearyColor;
                            } else if (puesto['camEstado'] == 'ANULADO') {
                              // _colorEstado = Colors.red;
                              _colorEstado = Colors.red;
                            }

                            return Slidable(
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                children: [
                                  widget.user!.rol!.contains('GUARDIA')
                                      ? Container()
                                      : SlidableAction(
                                          backgroundColor: Colors.purple,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          // label: 'Editar',
                                          onPressed: (context) {
                                            provider.resetDropDown();
                                            provider.getDataCambioPuesto(puesto);

                                            _showAlertDialog(size, provider);
                                          },
                                        ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  provider.getInformacionPuesto(puesto);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const DetalleCambioPuesto())));
                                },
                                child: ClipRRect(
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
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: size.iScreen(0.5),
                                                            bottom:
                                                                size.iScreen(0.0)),
                                                        child: Text(
                                                          ' ${puesto['camNomPersona']}',
                                                          overflow:
                                                              TextOverflow.ellipsis,
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
                                                        'Cliente : ',
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
                                                    Expanded(
                                                      child: Container(
                                                        // width: size.iScreen(28.0),
                                                        // color: Colors.red,
                                                        margin: EdgeInsets.only(
                                                            top: size.iScreen(0.5),
                                                            bottom:
                                                                size.iScreen(0.0)),

                                                        child: Text(
                                                          ' ${puesto['camNomCliente']}',
                                                          overflow:
                                                              TextOverflow.ellipsis,
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
                                                        'Nuevo Puesto: ',
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
                                                      // width: size.iScreen(28.0),
                                                      // color: Colors.red,
                                                      margin: EdgeInsets.only(
                                                          top: size.iScreen(0.5),
                                                          bottom:
                                                              size.iScreen(0.0)),

                                                      child: Text(
                                                        ' ${puesto['camNuevoPuesto'][0]['puesto']}',
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
                                                        'Fecha de cambio:  ${puesto['camId']} --',
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
                                                        puesto['camFecha']
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
                                          Column(
                                            children: [
                                              Text(
                                                'Estado',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.6),
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                              Text(
                                                '${puesto['camEstado']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.6),
                                                    // color: _colorEstado,
                                                    color: puesto!['camEstado'] ==
                                                            'APELACION'
                                                        ? secondaryColor
                                                        : puesto!['camEstado'] ==
                                                                'EN PROCESO'
                                                            ? tercearyColor
                                                            : puesto!['camEstado'] ==
                                                                    'APROBADO'
                                                                ? secondaryColor
                                                                : puesto!['camEstado'] ==
                                                                        'ANULADA'
                                                                    ? Colors.red
                                                                    : puesto!['camEstado'] ==
                                                                            'ASIGNADA'
                                                                        ? primaryColor
                                                                        : Colors
                                                                            .grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
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
            floatingActionButton: widget.user!.rol!.contains('GUARDIA')
                ? Container()
                : FloatingActionButton(
                     backgroundColor:  ctrlTheme.primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      final cambioPuesto =
                          Provider.of<CambioDePuestoController>(context,
                              listen: false);
                      cambioPuesto.resetValuesCambioPuesto();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const CreaCambioDePuesto())));
                    },
                  )),
      ),
    );
  }

  Future<void> onRefresh() async {
    final informeController =
        Provider.of<InformeController>(context, listen: false);
  }

//========ALERTA ESTADO  CAMBIO DE PUESTO========//
  void _showAlertDialog(Responsive size, CambioDePuestoController controller) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: const Text("Estado del Puesto"),
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
                        "ANULADO",
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      controller.setLabelNombreEstadoCambioPuesto('ANULADO');
                      await controller.editarCambioTurno(context);
                      Navigator.pop(context);
                    },
                  ),
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
                        "PENDIENTE",
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      controller.setLabelNombreEstadoCambioPuesto('PENDIENTE');
                      await controller.editarCambioTurno(context);
                      Navigator.pop(context);
                    },
                  ),

                  SizedBox(
                    height: size.iScreen(2.0),
                  )
                ],
              ),
            ),
          );
        });
  }
}
