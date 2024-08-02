import 'dart:convert';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class VistaActividadRealizadasGuardias extends StatelessWidget {
  final int? codigoActicidad;
  final dynamic infoActividad;
  final Session? usuario;
  const VistaActividadRealizadasGuardias(
      {Key? key, this.infoActividad, this.codigoActicidad, this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String perfil = '';
  final ctrlTheme = context.read<ThemeApp>();
        
    final infoActividadRealizada = {};
    final actividadesController =
        Provider.of<ActivitiesController>(context, listen: false);
    final Responsive size = Responsive.of(context);
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
                      const Text('Cargando Actividades Realizadas... '),
                    ],
                  ),
                );
              }

              if (snapshot.hasData) {
                if (actividadesController.getListaTodasLasActividades.isEmpty) {
                  return const NoData(label: 'No Tiene Actividades Realizadas');
                }
                if (actividadesController
                    .getListaTodasLasActividades.isNotEmpty) {
                  for (var e
                      in actividadesController.getListaTodasLasActividades) {
                    if (e['actId'] == codigoActicidad) {
                      infoActividadRealizada.addAll(e);

                      final List guardiasDesignados = [];
                      final List trabajosGuardiasDesignados = [];
                      for (var e in infoActividadRealizada['actAsignacion']) {
                        if (e['asignado'] == true) {
                          guardiasDesignados.add(e['nombres']);
                          trabajosGuardiasDesignados.add(e['trabajos']);
                        }
                      }

                      final List supervisoresDesignados = [];
                      final List trabajosSupervisoresDesignados = [];
                      for (var e in infoActividadRealizada['actSupervisores']) {
                        if (e['asignado'] == true) {
                          supervisoresDesignados.add(e['nombres']);
                          trabajosSupervisoresDesignados.add(e['trabajos']);
                        }
                      }

                      return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                              // color:Colors.red,
                              margin: EdgeInsets.only(top: size.iScreen(0.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0)),
                              width: size.wScreen(100.0),
                              height: size.hScreen(100),
                              child:

                                  //====================SUPERVISORES=================//

                                  perfil == 'SUPERVISOR'
                                      ? trabajosSupervisoresDesignados
                                              .isNotEmpty
                                          ? ListView.builder(
                                              itemCount:
                                                  trabajosSupervisoresDesignados
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final List
                                                    _listaTrabajosRealizados =
                                                    infoActividadRealizada[
                                                            'actSupervisores']
                                                        [index]['trabajos'];

                                                return _listaTrabajosRealizados
                                                        .isNotEmpty
                                                    ? SizedBox(
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              _listaTrabajosRealizados
                                                                  .length,
                                                          // itemCount: _listaAsignacion[index]['trabajos'],
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            final trabajo =
                                                                _listaTrabajosRealizados[
                                                                    index];
                                                            final List
                                                                _listaFotos =
                                                                _listaTrabajosRealizados[
                                                                        index]
                                                                    ['fotos'];
                                                            return Column(
                                                              children: [
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //*****************************************/

                                                                SizedBox(
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                      'Fecha:',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          // fontSize: size.iScreen(2.0),
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey)),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            size.iScreen(
                                                                                0.5)),
                                                                    width: size
                                                                        .wScreen(
                                                                            100.0),
                                                                    child: Text(
                                                                      ' ${trabajo['fecha']}'
                                                                          .toString(),
                                                                      // .replaceAll(".000Z", "")
                                                                      // .replaceAll("T", " "),
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        // fontSize: size.iScreen(2.0),
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        // color: Colors.grey,
                                                                      ),
                                                                    )),
                                                                //***********************************************/
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //*****************************************/
                                                                SizedBox(
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                      'Detalle:',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          // fontSize: size.iScreen(2.0),
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey)),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              size.iScreen(0.5)),
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  child: Text(
                                                                    trabajo[
                                                                        'detalle'],
                                                                    style: GoogleFonts.lexendDeca(
                                                                        fontSize: size.iScreen(1.8),
                                                                        // color: Colors.white,
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),
                                                                trabajo['qr']
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            // color: Colors.blue,
                                                                            child: Text('Información QR :',
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    // fontSize: size.iScreen(2.0),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Colors.grey)),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            child:
                                                                                Text(
                                                                              ' ${trabajo['qr']}',
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
                                                                      .iScreen(
                                                                          1.0),
                                                                ),
                                                                //*****************************************/
                                                                _listaFotos
                                                                        .isNotEmpty
                                                                    ? SizedBox(
                                                                        width: size
                                                                            .wScreen(100.0),
                                                                        // color: Colors.blue,
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
                                                                            .wScreen(100.0),
                                                                        child: _listaFotos.isNotEmpty
                                                                            ? SingleChildScrollView(
                                                                                child: Wrap(
                                                                                    children: _listaFotos.map((e) {
                                                                                  return Container(
                                                                                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      child: Container(
                                                                                        decoration: const BoxDecoration(
                                                                                            // color: Colors.red,
                                                                                            // border: Border.all(color: Colors.grey),
                                                                                            // borderRadius: BorderRadius.circular(10),
                                                                                            ),
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
                                                                trabajo['video']!
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            // color: Colors.blue,
                                                                            margin:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: size.iScreen(1.0),
                                                                              horizontal: size.iScreen(0.0),
                                                                            ),
                                                                            child: Text('Video:',
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    // fontSize: size.iScreen(2.0),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Colors.grey)),
                                                                          ),
                                                                          AspectRatio(
                                                                            aspectRatio:
                                                                                16 / 16,
                                                                            child:
                                                                                BetterPlayer.network(
                                                                              // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',

                                                                              '${trabajo['video']}',
                                                                              betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                                                aspectRatio: 16 / 16,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Container(),

                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          2.0),
                                                                ),

                                                                //*****************************************/
                                                                Divider(
                                                                  color:
                                                                      primaryColor,
                                                                  height: size
                                                                      .iScreen(
                                                                          2.0),
                                                                ),

                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          3.0),
                                                                ),
                                                                //*****************************************/
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                        height:
                                                            size.hScreen(80),
                                                      )
                                                    : const SizedBox();
                                              },
                                            )
                                          : const NoData(
                                              label:
                                                  'No hay actividad realizada')

                                      //====================GUARDIAS=================//

                                      : trabajosGuardiasDesignados.isNotEmpty
                                          ? ListView.builder(
                                              itemCount:
                                                  trabajosGuardiasDesignados
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final List
                                                    _listaTrabajosRealizados =
                                                    infoActividadRealizada[
                                                            'actAsignacion']
                                                        [index]['trabajos'];

                                                return _listaTrabajosRealizados
                                                        .isNotEmpty
                                                    ? SizedBox(
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              _listaTrabajosRealizados
                                                                  .length,
                                                          // itemCount: _listaAsignacion[index]['trabajos'],
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            final trabajo =
                                                                _listaTrabajosRealizados[
                                                                    index];
                                                            final List
                                                                _listaFotos =
                                                                _listaTrabajosRealizados[
                                                                        index]
                                                                    ['fotos'];
                                                            return Column(
                                                              children: [
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //*****************************************/

                                                                SizedBox(
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                      'Fecha:',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          // fontSize: size.iScreen(2.0),
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey)),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            size.iScreen(
                                                                                0.5)),
                                                                    width: size
                                                                        .wScreen(
                                                                            100.0),
                                                                    child: Text(
                                                                      ' ${trabajo['fecha']}'
                                                                          .toString(),
                                                                      // .replaceAll(".000Z", "")
                                                                      // .replaceAll("T", " "),
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        // fontSize: size.iScreen(2.0),
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        // color: Colors.grey,
                                                                      ),
                                                                    )),
                                                                //***********************************************/

                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //*****************************************/
                                                                SizedBox(
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                      'Detalle:',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          // fontSize: size.iScreen(2.0),
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey)),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              size.iScreen(0.5)),
                                                                  width: size
                                                                      .wScreen(
                                                                          100.0),
                                                                  child: Text(
                                                                    trabajo[
                                                                        'detalle'],
                                                                    style: GoogleFonts.lexendDeca(
                                                                        fontSize: size.iScreen(1.8),
                                                                        // color: Colors.white,
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),

                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          1.0),
                                                                ),
                                                                trabajo['qr']
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            // color: Colors.blue,
                                                                            child: Text('Información QR :',
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    // fontSize: size.iScreen(2.0),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Colors.grey)),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            child:
                                                                                Text(
                                                                              ' ${trabajo['qr']}',
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
                                                                      .iScreen(
                                                                          1.0),
                                                                ),
                                                                //*****************************************/
                                                                _listaFotos
                                                                        .isNotEmpty
                                                                    ? SizedBox(
                                                                        width: size
                                                                            .wScreen(100.0),
                                                                        // color: Colors.blue,
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
                                                                            .wScreen(100.0),
                                                                        child: _listaFotos.isNotEmpty
                                                                            ? SingleChildScrollView(
                                                                                child: Wrap(
                                                                                    children: _listaFotos.map((e) {
                                                                                  return Container(
                                                                                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      child: Container(
                                                                                        decoration: const BoxDecoration(
                                                                                            // color: Colors.red,
                                                                                            // border: Border.all(color: Colors.grey),
                                                                                            // borderRadius: BorderRadius.circular(10),
                                                                                            ),
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
                                                                trabajo['video']!
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                size.wScreen(100.0),
                                                                            // color: Colors.blue,
                                                                            margin:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: size.iScreen(1.0),
                                                                              horizontal: size.iScreen(0.0),
                                                                            ),
                                                                            child: Text('Video:',
                                                                                style: GoogleFonts.lexendDeca(
                                                                                    // fontSize: size.iScreen(2.0),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Colors.grey)),
                                                                          ),
                                                                          AspectRatio(
                                                                            aspectRatio:
                                                                                16 / 16,
                                                                            child:
                                                                                BetterPlayer.network(
                                                                              // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',

                                                                              '${trabajo['video']}',
                                                                              betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                                                aspectRatio: 16 / 16,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Container(),

                                                                //*****************************************/
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          2.0),
                                                                ),
                                                                // // //==========================================//
                                                                //*****************************************/
                                                                Divider(
                                                                  color:
                                                                      primaryColor,
                                                                  height: size
                                                                      .iScreen(
                                                                          2.0),
                                                                ),
                                                                //*****************************************/
                                                                //***********************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          3.0),
                                                                ),
                                                                //*****************************************/
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                        // height: size.hScreen(_listaTrabajosRealizados.length.toDouble() ),
                                                        height:
                                                            size.hScreen(80),
                                                      )
                                                    : const SizedBox();
                                              },
                                            )
                                          : const NoData(
                                              label:
                                                  'No hay actividades realizadas')

                              //====================================================//
                              ));
                    }
                  }
                } else {
                  const NoData(label: 'No Tiene Actividades Realizadas');
                }
              }
              return Container();

              // ===============werwerwerwer=============

              // ===============ywieryuwyeiruywieurryiw=============
            },
          )),
    );
  }
}
