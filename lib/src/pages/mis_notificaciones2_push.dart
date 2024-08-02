import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';

import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';

import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/alerta_page.dart';
import 'package:nseguridad/src/pages/lista_actividades_asignadas.dart';

import 'package:nseguridad/src/pages/lista_cambio_puesto.dart';
import 'package:nseguridad/src/pages/lista_comunicados_guardias.dart';
import 'package:nseguridad/src/pages/lista_informes_guardias_page.dart';

import 'package:nseguridad/src/pages/lista_multas_supervisor_page.dart';
import 'package:nseguridad/src/pages/lista_todas_las_devoluciones.dart';
import 'package:nseguridad/src/pages/lista_todos_los_pedidos.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaNotificaciones2Push extends StatefulWidget {
  final Session? user;
  final informacion;
  const ListaNotificaciones2Push({Key? key, this.informacion, this.user})
      : super(key: key);

  @override
  State<ListaNotificaciones2Push> createState() =>
      _ListaNotificaciones2PushState();
}

class _ListaNotificaciones2PushState extends State<ListaNotificaciones2Push> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<HomeController>(context, listen: false);
    final serviceSocket = Provider.of<SocketService>(context, listen: false);

    serviceSocket.socket?.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'notificacionleido') {
        loadInfo.buscaNotificacionesPush2('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
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
          'Mis Notificaciones',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Stack(
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
            child: Consumer<HomeController>(
              builder: (_, providers, __) {
                if (providers.getErrorNotificacionesPush2 == null) {
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
                } else if (providers.getErrorNotificacionesPush2 == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                } else if (providers.getListaNotificacionesPush2.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }

                return ListView.builder(
                  itemCount: providers.getListaNotificacionesPush2.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notificacion =
                        providers.getListaNotificacionesPush2[index];
                    providers.setInfoNotificacionAlerta(
                        providers.getListaNotificacionesPush2[index]);
                    final fechaRegistro = DateTime.parse(notificacion["notFecReg"]);
                    return Slidable(
                      key: ValueKey(index),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: const ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: ScrollMotion(),

                        children: [],
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (notificacion['notTipo'] == 'ALERTA') {
                            final Map<String, dynamic> infoAlert = {};

                            infoAlert.addAll({
                              "notNombrePersona": notificacion['notNombrePersona'],
                              "notEmpresa": notificacion[
                                  'notEmpresa'], //dataAlerta[' notEmpresa'],
                              "perLugarTrabajo": notificacion['notInformacion']
                                      ['datos'][
                                  'perLugarTrabajo'], //notificacion['notInformacion']['datos'][' perLugarTrabajo'],
                              "perCiudad": notificacion['notInformacion']['datos']
                                  ['perCiudad'], //dataAlerta[' perCiudad'],
                              "alerAsunto": notificacion['notInformacion']['datos']
                                  ['alerAsunto'], //dataAlerta[' alerAsunto'],
                              "coordenadas": notificacion['notInformacion']['datos']
                                  ['coordenadas'], //dataAlerta[' coordenadas'],
                              "perEmail": notificacion['notInformacion']['datos']
                                  ['perEmail'], //dataAlerta[' perEmail'],
                              "perCelular": notificacion['notInformacion']['datos']
                                  ['perTelefono'], //dataAlerta[' perTelefono'],
                            });

                            providers.leerNotificacionPushGeneric(notificacion);
                            providers.buscaNotificacionesPush2('');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    AlertaPage(notificacion: infoAlert)),
                              ),
                            );
                            // .then((value) {
                                
                            // providers.buscaNotificacionesPush2('');
                            //    providers.leerNotificacionPushGeneric(notificacion);
                            // });
                          } else if (notificacion['notTipo'] == 'PEDIDO') {
                            providers.leerNotificacionPush(notificacion);
                            Provider.of<LogisticaController>(context, listen: false)
                                .getTodosLosPedidosGuardias(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ListaTodosLosPedidos(
                                    // usuario:
                                    //     widget.user,
                                    )));
                          } else if (notificacion['notTipo'] == 'COMUNICADO') {
                            providers.leerNotificacionPush(notificacion);
                            Provider.of<AvisosController>(context, listen: false)
                                .getTodosLosAvisos(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaComunicadosGuardiasPage()));
                          } else if (notificacion['notTipo'] == 'DEVOLUCION') {
                            providers.leerNotificacionPushGeneric(notificacion);
                            Provider.of<LogisticaController>(context, listen: false)
                                .getTodasLasDevoluciones(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaTodasLasDevoluciones()));
                          } else if (notificacion['notTipo'] == 'MULTA') {
                            Provider.of<MultasGuardiasContrtoller>(context,
                                    listen: false)
                                .getTodasLasMultasGuardia(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');
                            if (widget.user!.rol!.contains('SUPERVISOR') 
                            ||widget.user!.rol!.contains('GUARDIA')
                            ||widget.user!.rol!.contains('ADMINISTRACION')
                                ) {
                              providers.leerNotificacionPushGeneric(notificacion);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListaMultasSupervisor(
                                        user: widget.user,
                                      )));
                            }
                          } else if (notificacion['notTipo'] == 'INFORME') {
                            providers.leerNotificacionPushGeneric(notificacion);
                            Provider.of<InformeController>(context, listen: false)
                                .buscaInformeGuardias(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ListaInformesGuardiasPage(
                                      usuario: widget.user,
                                    )));
                          } else if (notificacion['notTipo'] == 'CAMBIO PUESTO') {
                            providers.leerNotificacionPush(notificacion);

                            Provider.of<CambioDePuestoController>(context,
                                    listen: false)
                                .buscaCambioPuesto('', 'true');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ListaCambioPuestoPage(user: widget.user)));
                          }
                          // else if (notificacion['notTipo'] == 'ACTIVIDAD ASIGNADA') {
                          //   providers.leerNotificacionPush(notificacion);

                          //       // print('LA DATA  $notificacion');

                          //     final _controller=context.read<ActividadesAsignadasController>();
                          //     _controller.setIsActividad(true);
                          //   // Provider.of<ActividadesAsignadasController>(context,
                          //   //         listen: false)
                          //   //     .getActividadesAsignadas('', 'true');
                          //       _controller.getActividadesAsignadas('', 'true');


                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) =>
                          //           const ListActividadesAsignadas()));
                          // }
                          context.read<HomeController>().buscaNotificacionesPush2('');
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: size.iScreen(0.5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(1.5),
                              vertical: size.iScreen(0.5)),
                          decoration: BoxDecoration(
                            color: notificacion['notVisto'] == 'NO'
                                ? const Color.fromARGB(255, 206, 229, 246)
                                : Colors.white,
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.0)),
                                      width: size.wScreen(100.0),
                                      child: Text(
                                        '${notificacion['notTipo']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.6),
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
                                            'Empresa: ',
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
                                            '${notificacion['notEmpresa']}',
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
                                            'Contenido: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: size.iScreen(0.5),
                                                bottom: size.iScreen(0.0)),
                                            // width: size.wScreen(100.0),
                                            child: Text(
                                              '${notificacion['notContenido']}',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.0)),
                                      width: size.wScreen(100.0),
                                      child: Text(
                                        // notificacion['notFecReg']
                                        fechaRegistro
                                            .toLocal()
                                            .toString()
                                            .substring(0, 16)
                                            .replaceAll(".000Z", "")
                                            .replaceAll("T", " "),
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.5),
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      ),
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
    );
  }
}
