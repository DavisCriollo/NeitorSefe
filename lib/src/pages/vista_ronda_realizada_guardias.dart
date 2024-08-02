import 'dart:convert';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class VistaRondaRealizadasGuardias extends StatelessWidget {
  final int? codigoActicidad;
  final dynamic infoActividad;
  final Session? usuario;
  const VistaRondaRealizadasGuardias(
      {Key? key, this.infoActividad, this.codigoActicidad, this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String perfil = '';

    final infoActividadRealizada = {};
    final trabajosRonda = [];
    final listaRonda = [];

    final actividadesController =
        Provider.of<ActivitiesController>(context, listen: false);
    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
         
    if (usuario!.rol!.contains('SUPERVISOR')) {
      perfil = 'SUPERVISOR';
    } else if (usuario!.rol!.contains('GUARDIA')) {
      perfil = 'GUARDIA';
    }

    return SafeArea(
      bottom: true,
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
              'Actividad Realizada',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: FutureBuilder(
            future: actividadesController.getTodasLasActividades(''),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      const Text('Cargando Rondas Realizadas... '),
                    ],
                  ),
                );
              }

              if (snapshot.hasData) {
                if (actividadesController.getListaTodasLasActividades.isEmpty)
                  return const NoData(label: 'No Tiene Actividades Realizadas');
                if (actividadesController
                    .getListaTodasLasActividades.isNotEmpty) {
                  for (var e
                      in actividadesController.getListaTodasLasActividades) {
                    if (e['actId'] == codigoActicidad) {
                      infoActividadRealizada.addAll(e);

                      final List guardiasDesignados = [];
                      for (var e in infoActividadRealizada['actAsignacion']) {
                        if (e['asignado'] == true) {
                          guardiasDesignados.add(e['nombres']);
                        }
                      }

                      final List supervisoresDesignados = [];
                      for (var e in infoActividadRealizada['actSupervisores']) {
                        if (e['asignado'] == true) {
                          supervisoresDesignados.add(e['nombres']);
                        }
                      }

                      if (infoActividadRealizada['actSupervisores']
                          .isNotEmpty) {
                        if (perfil == 'SUPERVISOR') {
                          for (var item
                              in infoActividadRealizada['actSupervisores']) {
                            if (item['docnumero'] == usuario!.usuario) {
                              if (item['trabajos'].isNotEmpty) {
                                for (var entry in item['trabajos'].entries) {
                                  trabajosRonda.add(entry.value);
                                }
                                trabajosRonda[0].forEach((e) {
                                  listaRonda.add(e);
                                });
                              }
                            }
                          }
                        } else if (perfil == 'GUARDIA') {
                          for (var item
                              in infoActividadRealizada['actAsignacion']) {
                            if (item['docnumero'] == usuario!.usuario) {
                              if (item['trabajos'].isNotEmpty) {
                                for (var entry in item['trabajos'].entries) {
                                  trabajosRonda.add(entry.value);
                                }
                                trabajosRonda[0].forEach((e) {
                                  listaRonda.add(e);
                                });
                              }
                            }
                          }
                        }
                      }
                      return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            margin: EdgeInsets.only(top: size.iScreen(0.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0)),
                            width: size.wScreen(100.0),
                            height: size.hScreen(93),
                            child: Column(
                              children: [
                                ///***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),

                                //*****************************************/
                                Container(
                                  width: size.wScreen(100),
                                  child: Text('Actividad:',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ),
                                Text('"${infoActividadRealizada['actAsunto']}"',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      color: Colors.black,
                                    )),

                                ///***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),

                                //*****************************************/
                                trabajosRonda.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                          itemCount: trabajosRonda.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ExpansionTile(
                                                title: Text(
                                                    'Ronda: ${index + 1}',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                                children: [
                                                  Container(
                                                    height: size.iScreen(40.0),
                                                    child: ListView.builder(
                                                      itemCount:
                                                          trabajosRonda[index]
                                                              .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        final _listaTrabajosRealizadosRonda =
                                                            trabajosRonda[index]
                                                                [i];
                                                        final List _listaFotos =
                                                            _listaTrabajosRealizadosRonda[
                                                                'fotos'];

                                                        return Column(
                                                          children: [
                                                            //*****************************************/
                                                            SizedBox(
                                                              width:
                                                                  size.wScreen(
                                                                      100.0),
                                                              child: Text(
                                                                  'Fecha:',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .grey)),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets.symmetric(
                                                                    vertical: size
                                                                        .iScreen(
                                                                            0.5)),
                                                                width: size
                                                                    .wScreen(
                                                                        100.0),
                                                                child: Text(
                                                                  ' ${_listaTrabajosRealizadosRonda['fecha']}'
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "T",
                                                                          " "),
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    // color: Colors.grey,
                                                                  ),
                                                                )),
//
                                                            //*****************************************/
                                                            SizedBox(
                                                              width:
                                                                  size.wScreen(
                                                                      100.0),
                                                              child: Text(
                                                                  'Lugar:',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .grey)),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                              width:
                                                                  size.wScreen(
                                                                      100.0),
                                                              child: Text(
                                                                '${_listaTrabajosRealizadosRonda['nombre']}',
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                            //***********************************************/
                                                            SizedBox(
                                                              height: size
                                                                  .iScreen(1.0),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.wScreen(
                                                                      100.0),
                                                              child: Text(
                                                                  'Detalle:',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .grey)),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                              width:
                                                                  size.wScreen(
                                                                      100.0),
                                                              child: Text(
                                                                '${_listaTrabajosRealizadosRonda['detalle']}',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize:
                                                                            size.iScreen(
                                                                                1.8),
                                                                        // color: Colors.white,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                            ),
                                                            //***********************************************/
                                                            SizedBox(
                                                              height: size
                                                                  .iScreen(1.0),
                                                            ),
                                                            '${_listaTrabajosRealizadosRonda['qr']}'
                                                                    .isNotEmpty
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: size
                                                                            .wScreen(100.0),
                                                                        // color: Colors.blue,
                                                                        child: Text(
                                                                            'Información QR :',
                                                                            style: GoogleFonts.lexendDeca(
                                                                                // fontSize: size.iScreen(2.0),
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.grey)),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                size.iScreen(1.0)),
                                                                        width: size
                                                                            .wScreen(100.0),
                                                                        child:
                                                                            Text(
                                                                          '${_listaTrabajosRealizadosRonda['qr']}',
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(1.8),
                                                                              // color: Colors.white,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              height: size
                                                                  .iScreen(1.0),
                                                            ),

                                                            //***********************************************/
                                                            SizedBox(
                                                              height: size
                                                                  .iScreen(1.0),
                                                            ),
                                                            //*****************************************/
                                                            _listaFotos
                                                                    .isNotEmpty
                                                                ? SizedBox(
                                                                    width: size
                                                                        .wScreen(
                                                                            100.0),
                                                                    child: Text(
                                                                        'Fotos: ${_listaFotos.length}',
                                                                        style: GoogleFonts.lexendDeca(
                                                                            // fontSize: size.iScreen(2.0),
                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                  )
                                                                : const SizedBox(),
                                                            _listaFotos
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            size.iScreen(0.5)),
                                                                    width: size
                                                                        .wScreen(
                                                                            100.0),
                                                                    child: _listaFotos
                                                                            .isNotEmpty
                                                                        ? SingleChildScrollView(
                                                                            child: Wrap(
                                                                                children: _listaFotos.map((e) {
                                                                              return Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  child: Container(
                                                                                    decoration: const BoxDecoration(),
                                                                                    width: size.wScreen(100.0),
                                                                                    // height: size.hScreen(20.0),
                                                                                    padding: EdgeInsets.symmetric(
                                                                                      vertical: size.iScreen(0.0),
                                                                                      horizontal: size.iScreen(0.0),
                                                                                    ),
                                                                                    child: FadeInImage(
                                                                                      placeholder: const AssetImage('assets/imgs/loader.gif'),
                                                                                      image: NetworkImage(e['url']),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }).toList()),
                                                                          )
                                                                        : Center(
                                                                            child: Text('No exiten fotos para mostrar:',
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    // fontSize: size.iScreen(2.0),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Colors.grey)),
                                                                          ),
                                                                  )
                                                                : const SizedBox(),
                                                            //***********************************************/

                                                            '${_listaTrabajosRealizadosRonda['video']}'
                                                                    .isNotEmpty
                                                                ? Column(
                                                                    children: [
                                                                      Container(
                                                                        width: size
                                                                            .wScreen(100.0),
                                                                        // color: Colors.blue,
                                                                        margin:
                                                                            EdgeInsets.symmetric(
                                                                          vertical:
                                                                              size.iScreen(1.0),
                                                                          horizontal:
                                                                              size.iScreen(0.0),
                                                                        ),
                                                                        child: Text(
                                                                            'Video:',
                                                                            style:
                                                                                GoogleFonts.lexendDeca(fontWeight: FontWeight.normal, color: Colors.grey)),
                                                                      ),
                                                                      AspectRatio(
                                                                        aspectRatio:
                                                                            16 /
                                                                                16,
                                                                        child: BetterPlayer
                                                                            .network(
                                                                          '${_listaTrabajosRealizadosRonda['video']}',
                                                                          betterPlayerConfiguration:
                                                                              const BetterPlayerConfiguration(
                                                                            aspectRatio:
                                                                                16 / 16,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                : Container(),

//
//                                               //*****************************************/
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ]);
                                          },
                                        ),
                                      )
                                    : const NoData(
                                        label:
                                            'No tiene Actividades Realizadas'),
                              ],
                            ),
                          ));
                    }
                  }
                } else {
                  const NoData(label: 'No Tiene Actividades Realizadas');
                }
              }
              return Container();
            },
          )),
    );
  }
}
