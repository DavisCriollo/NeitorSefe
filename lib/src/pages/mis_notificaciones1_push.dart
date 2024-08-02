import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';

import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';
import 'package:nseguridad/src/controllers/evaluaciones_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/lista_actividades_asignadas.dart';

import 'package:nseguridad/src/pages/lista_consignas_guardias_page.dart';
import 'package:nseguridad/src/pages/lista_encuestas_page.dart';
import 'package:nseguridad/src/pages/lista_evaluaciones_page.dart';
import 'package:nseguridad/src/pages/lista_de_actividades.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaNotificacionesPush extends StatefulWidget {
  final Session? session;
  // final informacion;
  const ListaNotificacionesPush({Key? key, this.session}) : super(key: key);

  @override
  State<ListaNotificacionesPush> createState() =>
      _ListaNotificacionesPushState();
}

class _ListaNotificacionesPushState extends State<ListaNotificacionesPush> {
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
        loadInfo.buscaNotificacionesPush('');
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
                if (providers.getErrorNotificacionesPush == null) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                } else if (providers.getErrorNotificacionesPush == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                } else if (providers.getListaNotificacionesPush.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }

                return ListView.builder(
                  itemCount: providers.getListaNotificacionesPush.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notificacion =
                        providers.getListaNotificacionesPush[index];
                    final fechaNotificacion1 =
                        DateTime.parse(notificacion['notFecReg']).toLocal();
                    return Slidable(
                      key: ValueKey(index),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: const ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: ScrollMotion(),

                        children: [],
                      ),
                      child: InkWell(
                        onTap: () {
                          if (notificacion['notTipo'] == 'CONSIGNA') {
                            providers.leerNotificacionPush(notificacion);
                            Provider.of<ConsignasController>(context, listen: false)
                                .getTodasLasConsignasClientes(
                                    '${notificacion['notInformacion']['idregistro']}',
                                    'true');

                                    providers.buscaNotificacionesPush('');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaConsignasGuardiasPage()));
                          } else if (notificacion['notTipo'] == 'ENCUESTAS') {
                            providers.leerNotificacionPush(notificacion);
                            context
                                .read<EncuestasController>()
                                .buscaEncuestas('', 'true');
                                providers.buscaNotificacionesPush('');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EncuastasPage(
                                          usuario: widget.session,
                                        ))));
                          } else if (notificacion['notTipo'] == 'EVALUACIONES') {
                            providers.leerNotificacionPush(notificacion);
                            context
                                .read<EvaluacionesController>()
                                .buscaEvaluaciones('', 'true');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EvaluacionPage(
                                          usuario: widget.session,
                                        ))));
                          }
                           else if (notificacion['notTipo'] == 'ACTIVIDAD') {
                            
                              final _controller=context.read<ActividadesAsignadasController>();
                           providers.leerNotificacionPush(notificacion);
                           

                                // print('LA DATA   ${notificacion}');

                          
                                _controller.getActividadesAsignadas(notificacion['notInformacion']['idregistro'].toString(), 'true');


                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ListaDeActividades())).then((value) {

                                         providers.buscaNotificacionesPush('');

                                    });
                                    
                                      //  context.read<HomeController>().buscaNotificacionesPush('');
                                      
                          }
                          //========= ACTUALIZAOS LA LISTA DE NOTIFICACIONES =========//
                          // context.read<HomeController>().buscaNotificacionesPush('');
                          providers.buscaNotificacionesPush('');
                          
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
                                            width: size.wScreen(100.0),
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
                                        fechaNotificacion1
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
