import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';

import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/detalle_actividades_page.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ActividadesPage extends StatefulWidget {
  final Session? usuario;
  final List<String?>? tipo;
  const ActividadesPage({Key? key, this.tipo, this.usuario}) : super(key: key);

  @override
  State<ActividadesPage> createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
 final loadInfo = Provider.of<ActivitiesController>(context, listen: false);
    loadInfo.getTodasLasActividades('');

 final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'actividad') {
        loadInfo.getTodasLasActividades('');
       
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'actividad') {
        loadInfo.getTodasLasActividades('');
        // serviceSocket.socket!.clearListeners();
       
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'actividad') {
        loadInfo.getTodasLasActividades('');
       
      }
    });
  
  }

  @override
  Widget build(BuildContext context) {
   
    int? diasCalculados;
    final Responsive size = Responsive.of(context);
    final controllerActividades = Provider.of<ActivitiesController>(context);
       final ctrlTheme = context.read<ThemeApp>();
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
            'Mis Actividades',
            // style:  Theme.of(context).textTheme.headline2,
           
          ),
         
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: 
          Container(
             
              width: size.wScreen(100.0),
              // height: size.hScreen(100.0),
              padding: EdgeInsets.only(
                top: size.iScreen(0.0),
                left: size.iScreen(0.5),
                right: size.iScreen(0.5),
              ),
              child: Consumer<ActivitiesController>(
                builder: (_, provider, __) {
                  if (provider.getErrorActividades == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          const Text('Cargando Actividades.... '),
                        ],
                      ),
                    );
                  } else if (provider.getListaTodasLasActividades.isEmpty) {
                    return const NoData(
                      label: 'No existen actividades para mostar',
                    );
                  } else if (provider.getListaTodasLasActividades.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }
                  return 
                  
                   //  //***********************************************/
                  Consumer<SocketService>(
                    builder: (_, valueEstadoInter, __) {
                      return valueEstadoInter.serverStatus == ServerStatus.Ofline
                          ?  
                    ListView.builder(
                    itemCount: provider.getListaTodasLasActividades.length,
                    itemBuilder: (BuildContext context, int index) {
//================= REVISAMOS NUMERO DE DIAS =======================//
               
                      List supervisoresDesignados = [];
                      final List guardiasDesignados = [];
                      for (var e in provider.getListaTodasLasActividades[index]
                          ['actAsignacion']) {
                        if (e['asignado'] == true) {
                          guardiasDesignados.add(e['nombres']);
                        }
                      }
                      for (var e in provider.getListaTodasLasActividades[index]
                          ['actSupervisores']) {
                        if (e['asignado'] == true) {
                          supervisoresDesignados.add(e['nombres']);
                        }
                      }

                      final totalDesignados = guardiasDesignados.length +
                          supervisoresDesignados.length;

                      // return Text('data');
                      final actividad =
                          provider.getListaTodasLasActividades[index];

                      // =====================CALCULAMOS LOS DIAS DE LA ACIVIDAD======//

                      if (provider.getListaTodasLasActividades[index]['actFechasActividadConsultaDB'].isNotEmpty) {
                        DateTime fechaInicio = (DateTime.parse(provider.getListaTodasLasActividades[index]['actFechasActividadConsultaDB'][0]));
                        DateTime fechaFin = DateTime.parse(provider.getListaTodasLasActividades[index]['actFechasActividadConsultaDB'][provider.getListaTodasLasActividades[index]
                                        ['actFechasActividadConsultaDB'].length -
                                1]);
                        // print('FECHA INICIO: ${fechaInicio}');
                        // print('FECHA FIN: ${fechaFin}');
                        Duration diasDiferencia =
                            fechaFin.difference(fechaInicio);
                        int diasDeTrabajo = diasDiferencia.inDays;

                        diasCalculados = (diasDeTrabajo == 0)
                            ? (diasDeTrabajo + 1)
                            : diasDeTrabajo;
                        // print(diasCalculados);
                      }

// ======================VERIFICA SI ESTA DESIGNADO ========================//
              
                      bool? _asignado;
                      String? _trabajoCumplido;
                      int? _progreso;

                      if (widget.tipo!.contains('SUPERVISOR')) {
                        for (var e
                            in provider.getListaTodasLasActividades[index]
                                ['actSupervisores']) {
                          if (e['docnumero'] == widget.usuario!.usuario &&
                              e['asignado'] == true) {
                            //        supervisoresDesignados.add(e);
                            _asignado = true;
                            _progreso = e['trabajos'].length;
                            if (diasCalculados! > _progreso!) {
                              _trabajoCumplido = 'EN PROGRESO';
                            } else if (diasCalculados == _progreso) {
                              _trabajoCumplido = 'REALIZADO';
                            } else if (diasCalculados! < _progreso) {
                              _trabajoCumplido = 'NO REALIZADO';
                            }
                           
                          } else {
                           
                          }
                        }
                      }
                      if (widget.tipo!.contains('GUARDIA')) {
                        for (var e
                            in provider.getListaTodasLasActividades[index]
                                ['actAsignacion']) {
                          if (e['docnumero'] == widget.usuario!.usuario &&
                              e['asignado'] == true) {
                            //        supervisoresDesignados.add(e);
                            _asignado = true;
                            _progreso = e['trabajos'].length;
                            if (diasCalculados! > _progreso!) {
                              _trabajoCumplido = 'EN PROGRESO';
                            } else if (diasCalculados == _progreso) {
                              _trabajoCumplido = 'REALIZADO';
                            } else if (diasCalculados! < _progreso) {
                              _trabajoCumplido = 'NO REALIZADO';
                            }
                            // print(' GUARDIA SI ESTA DESIGNADO: $e}');
                          } else {
                            // print('GUARDIA NOooooo ESTA DESIGNADO: $e');
                          }
                        }
                      }

                      return Slidable(
                        startActionPane: const ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: ScrollMotion(),

                          children: [
                            
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () async {
                      
                              controllerActividades.getActividad(actividad,widget.usuario);

                            final Session? usuario =
                                await Auth.instance.getSession();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => DetalleActividades(
                                          infoActividad: actividad,
                                          usuario: usuario,
                                        ))));
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
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 1.0,
                                        offset: Offset(0.0, 1.0))
                                  ],
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
                                                  'Asunto: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(55.0),
                                                  child: Text(
                                                    '${actividad['actAsunto']}',
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
                                                  'Prioridad: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
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
                                                  actividad['actPrioridad'],
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
                                                  'Ubicación: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(100.0),
                                                  child: Text(
                                                    actividad['actUbicacion'] !=
                                                            ''
                                                        ? actividad[
                                                            'actUbicacion']
                                                        : 'No Designada',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  'Puesto: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(5.0),
                                                  child: Text(
                                                    actividad['atcPuesto'] != ''
                                                        ? actividad['atcPuesto']
                                                        : 'No Asignado',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  'Personal Designado: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                               child: Text(
                                                  '$totalDesignados',
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
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: size.iScreen(1.0),
                                            // top: size.iScreen(0.5),
                                            // bottom: size.iScreen(0.0)
                                          ),
                                          child: Text(
                                            'Progreso',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.6),
                                                // color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: size.iScreen(1.0),
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child:
                                              // _trabajoCumplido==0?

                                              Text(
                                            // actividad['actProgreso'],
                                            // 'REALIZADO',
                                            _trabajoCumplido!,
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: _trabajoCumplido ==
                                                        'REALIZADO'
                                                    ? secondaryColor
                                                    : _trabajoCumplido ==
                                                            'EN PROGRESO'
                                                        ? tercearyColor
                                                        : _trabajoCumplido ==
                                                                'NO REALIZADO'
                                                            ? Colors.red
                                                            : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        
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
                  )
               
                          : const NoData(label: 'Sin conexión a internet');
                    },
                  );
                  //  //***********************************************/
                  
                  
                  
                 
               
                },
              )),
       
       
        ));
  }

  //======================= ACTUALIZA LA PANTALLA============================//
  Future<void> onRefresh() async {
    final controllerActividades =
        Provider.of<ActivitiesController>(context, listen: false);
    controllerActividades.getTodasLasActividades('');
  }
  //===================================================//

}
