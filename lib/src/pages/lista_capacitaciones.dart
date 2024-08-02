import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/capacitaciones_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';

import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/detalle_capacitacion.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaCapacitaciones extends StatefulWidget {
  final Session? usuario;
  const ListaCapacitaciones({Key? key, this.usuario}) : super(key: key);

  @override
  State<ListaCapacitaciones> createState() => _ListaCapacitacionesState();
}

class _ListaCapacitacionesState extends State<ListaCapacitaciones> {
  final TextEditingController _textSearchController = TextEditingController();

  // Session? usuario;
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
    final loadInfo =
        Provider.of<CapacitacionesController>(context, listen: false);
    // loadInfo.buscaAusencias('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'capacitacion') {
        loadInfo.buscaListaCapacitaciones('');
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'capacitacion') {
        loadInfo.buscaListaCapacitaciones('');
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'capacitacion') {
        loadInfo.buscaListaCapacitaciones('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);

    final _controller = context.read<CapacitacionesController>();
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
            title: Container(
              alignment: Alignment.center,
               
       
              child: Text(
                'Capacitaciones',
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(2.45),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          body: Stack(
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
                child:
                    Consumer<CapacitacionesController>(builder: (_, provider, __) {
                  if (provider.getErrorListaCapacitaciones == null) {
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
                  } else if (provider.getErrorListaCapacitaciones == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("Error al cargar los datos");
                  } else if (provider.getListaCapacitaciones.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }
                  return ListView.builder(
                    itemCount: provider.getListaCapacitaciones.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _capacitacion = provider.getListaCapacitaciones[index];

                      // final _asistencia= [];

                      // for (var item in _capacitacion['capaGuardias']) {

                      //   print('object: ${item['perApellidos']} -${item['asistencia']}');

                      // }

                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            int.parse(widget.usuario!.id.toString()) ==
                                        int.parse(_capacitacion['capaIdCapacitador']
                                            .toString()) &&
                                    _capacitacion['capaEstado'] != 'FINALIZADA'
                                ? SlidableAction(
                                    backgroundColor: secondaryColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    // label: 'Ver',
                                    onPressed: (context) {
                                      provider.resetValuesCapacitaciones();
                                      _showAlertEstado(
                                          size, provider, _capacitacion);
                                    },
                                  )
                                : Container(),

                            // int.parse(widget.usuario!.id.toString()) ==
                            //         int.parse(_capacitacion['capaIdCapacitador'])
                            //     //         &&
                            //     // _capacitacion['capaEstado'] != 'FINALIZADA'
                            //     ?
                                 SlidableAction(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    // icon: Icons.edit,
                                    label: 'Ver',
                                    onPressed: (context) {
                                      provider.resetValuesCapacitaciones();
                                      provider.setDataCapacitacion(_capacitacion);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                   DetalleDeCapacitacion(usuario:widget.usuario))));
                                    },
                                  )
                                // : Container(),

                            // : Container(),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: _capacitacion['capaEstado'] == 'FINALIZADA'
                              ? null
                              : () {
                                  //===========================//

                                  bool _asistencia = false;
                                  if (widget.usuario!.rol!.contains('GUARDIA')) {
                                    for (var item
                                        in _capacitacion['capaGuardias']) {
                                      if (widget.usuario!.usuario ==
                                              item['perDocNumero'] &&
                                          item['asistencia'] == true) {
                                        _asistencia = true;
                                      } else {
                                        _asistencia = false;
                                      }
                                    }
                                  } else if (widget.usuario!.rol!
                                      .contains('SUPERVISOR')) {
                                    for (var item
                                        in _capacitacion['capaSupervisores']) {
                                      if (widget.usuario!.usuario ==
                                              item['perDocNumero'] &&
                                          item['asistencia'] == true) {
                                        _asistencia = true;
                                      } else {
                                        _asistencia = false;
                                      }
                                    }
                                  } else if (widget.usuario!.rol!
                                      .contains('ADMINISTRACION')) {
                                    for (var item
                                        in _capacitacion['capaAdministracion']) {
                                      if (widget.usuario!.usuario ==
                                              item['perDocNumero'] &&
                                          item['asistencia'] == true) {
                                        _asistencia = true;
                                      } else {
                                        _asistencia = false;
                                      }
                                    }
                                  }

                                  if (_asistencia == false) {
                                 
                                    provider.resetValuesCapacitaciones();
                                    provider.setDataCapacitacion(_capacitacion);

                                    final _data = [
                                      {
                                        "usuario": widget.usuario,
                                        "action": 'CREATE'
                                      }
                                    ];

                                    Navigator.pushNamed(
                                        context, 'crearCapacitaciones',
                                        arguments: _data);
                                  }
                                  //===========================//
                                },
                          child: ClipRRect(
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
                                                  'Título: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
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
                                                width: size.wScreen(55.0),
                                                child: Text(
                                                  '${_capacitacion['capaTitulo']}',
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
                                                  'Fecha Emisión: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  _capacitacion['capaFecDesde']
                                                      .toString()
                                                      .replaceAll("T", " "),
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
                                                  'Fecha Finalización: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  _capacitacion['capaFecHasta']
                                                      .toString()
                                                      .replaceAll("T", " "),
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
                                                // width: size.iScreen(10.0),
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  'Capacitador: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: size.iScreen(100.0),
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom: size.iScreen(0.0)),

                                                  child: Text(
                                                    ' ${_capacitacion['capaNombreCapacitador']}',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.6),
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
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
                                          '${_capacitacion['capaEstado']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              color:
                                                  // tercearyColor, //_colorEstado,

                                                  _capacitacion['capaEstado'] ==
                                                          'FINALIZADA'
                                                      ? secondaryColor
                                                      : _capacitacion[
                                                                  'capaEstado'] ==
                                                              'ACTIVA'
                                                          ? tercearyColor
                                                          : Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
                }),
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
      ),
    );
  }

//========ALERTA ESTADO  CAMBIO ESTADO DE CAPACITACION========//
  void _showAlertEstado(Responsive size, CapacitacionesController controller,
      dynamic _capacitacion) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: const Text("¿ Finalizar Capacitación ?"),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //==========================================//
                  GestureDetector(
                    child: Container(
                      width: size.wScreen(100.0),
                      padding:
                          EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                      color: Colors.grey.shade400,
                      child: Text(
                        "FINALIZAR",
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await controller.cambiaEstadoCapacitacion(
                          context, _capacitacion);
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
}
