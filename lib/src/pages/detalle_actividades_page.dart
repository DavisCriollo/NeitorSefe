import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';

import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/realizar_actividad_guardia.dart';
import 'package:nseguridad/src/pages/rondas_guardias.dart';
import 'package:nseguridad/src/pages/vista_actividad_realizada.dart';
import 'package:nseguridad/src/pages/vista_ronda_realizada_guardias.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleActividades extends StatefulWidget {
  final dynamic infoActividad;
  final Session? usuario;
  const DetalleActividades({Key? key, this.infoActividad, this.usuario})
      : super(key: key);

  @override
  State<DetalleActividades> createState() => _DetalleActividadesState();
}

class _DetalleActividadesState extends State<DetalleActividades> {
  @override
  void initState() {
    // initData();
    super.initState();
  }

  initData() async {}

  @override
  Widget build(BuildContext context) {
    final actividadesController =
        Provider.of<ActivitiesController>(context, listen: false);
          final ctrlTheme = context.read<ThemeApp>();
        

    final fechaActual = DateTime.now();
    bool _guardiaDesignado = false;
    bool _supervisorDesignado = false;

    final List _guardiasDesignados = [];
    final List _nombresGuardiasDesignados = [];
    for (var e in widget.infoActividad['actAsignacion']) {
      if (e['asignado'] == true) {
        _guardiasDesignados.add(
          e['docnumero'],
        );
        _nombresGuardiasDesignados.add(
          e['nombres'],
        );
      }
    }
    if (_guardiasDesignados.isNotEmpty) {
      for (var e in _guardiasDesignados) {
        if (e == widget.usuario!.usuario) {
          _guardiaDesignado = true;
        } else {}
      }
    } else {
      _guardiaDesignado = false;
    }

    final List _supervisoresDesignados = [];
    final List _nombresSupervisoresDesignados = [];
    for (var e in widget.infoActividad['actSupervisores']) {
      if (e['asignado'] == true) {
        _supervisoresDesignados.add(
          e['docnumero'],
        );
        _nombresSupervisoresDesignados.add(
          e['nombres'],
        );
      }
    }
    if (_supervisoresDesignados.isNotEmpty) {
      for (var e in _supervisoresDesignados) {
        if (e == widget.usuario!.usuario) {
          _supervisorDesignado = true;
        } else {}
      }
    } else {
      _supervisorDesignado = false;
    }

    final Responsive size = Responsive.of(context);

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
          'Detalle de Actividad',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: size.iScreen(1.0),
            left: size.iScreen(1.0),
            right: size.iScreen(1.0)),
        padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
        width: size.wScreen(100.0),
        height: size.hScreen(100),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                child: Row(
                  children: [
                    Text('Asunto:',
                        style: GoogleFonts.lexendDeca(
                            fontWeight: FontWeight.normal, color: Colors.grey)),
                    const Spacer(),
                    Text(
                        ' ${widget.infoActividad['actFecReg']}'
                            .toString()
                            .replaceAll(".000Z", "")
                            .replaceAll("T", " "),
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.1)),
                width: size.wScreen(100.0),
                child: Text(
                  '"${widget.infoActividad['actAsunto']}"',
                  textAlign: TextAlign.center,
                  //
                  style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(2.0),
                      // color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),

              //*****************************************/
              SizedBox(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                child: Text('Cliente:',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                width: size.wScreen(100.0),
                child: Text(
                  '${widget.infoActividad['actNombreCliente']}',
                  style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(1.8),
                      // color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(0.5),
              ),

              // //*****************************************/
              SizedBox(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                child: Text('Observaciones:',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                width: size.wScreen(100.0),
                child: Text(
                  '${widget.infoActividad['actObservacion']}',
                  style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(1.8),
                      // color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),

              //***********************************************/
              Row(
                children: [
                  Text(
                    'Prioridad:',
                    style: GoogleFonts.lexendDeca(
                      // fontSize: size.iScreen(1.8),
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    // width: size.wScreen(35),
                    margin: EdgeInsets.symmetric(horizontal: size.wScreen(0.5)),
                    child: Text(
                      '  ${widget.infoActividad['actPrioridad']}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                      ),
                    ),
                  ),
                ],
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),

              //***********************************************/
              SizedBox(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                child: Text('Fecha de actividad:',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),

              //***********************************************/
              Consumer<ActivitiesController>(
                builder: (_, valueFechas, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Desde:',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // width: size.wScreen(35),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(0.5)),
                            child: Text(
                              '  ${valueFechas.getFechaInicio}',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Hasta:',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // width: size.wScreen(35),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(0.5)),
                            child: Text(
                              '  ${valueFechas.getFechaFin}',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              //***********************************************/
              _nombresGuardiasDesignados.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                          child: Text(
                            'Guardias: ${_nombresGuardiasDesignados.length}',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                      ],
                    )
                  : const SizedBox(),
              _nombresGuardiasDesignados.isNotEmpty
                  ? SizedBox(
                      width: size.wScreen(100.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _nombresGuardiasDesignados.length,
                        itemBuilder: (BuildContext context, int index) {
                          final guardia = _nombresGuardiasDesignados[index];

                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.2)),
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5),
                                  horizontal: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2)),
                              width: size.wScreen(98.0),
                              child: Text(
                                // '${widget.infoActividad['actAsignacion'][index]['nombres']}',
                                '$guardia',
                                style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ));
                        },
                      ),
                      height: widget.infoActividad['actAsignacion'].length *
                          size.iScreen(3.8),
                    )
                  : const SizedBox(),

              //***********************************************/
              _supervisoresDesignados.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                          child: Text(
                            'Supervisores: ${_supervisoresDesignados.length}',
                            style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                      ],
                    )
                  : const SizedBox(),

              _supervisoresDesignados.isNotEmpty
                  ? SizedBox(
                      width: size.wScreen(100.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _nombresSupervisoresDesignados.length,
                        itemBuilder: (BuildContext context, int index) {
                          final supervisores =
                              _nombresSupervisoresDesignados[index];

                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.2)),
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5),
                                  horizontal: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2)),
                              width: size.wScreen(98.0),
                              child: Text(
                                '$supervisores',
                                style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ));
                        },
                      ),
                      height: widget.infoActividad['actSupervisores'].length *
                          size.iScreen(3.5),
                    )
                  : Text(
                      'No hay supervisores designados',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

              //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
              //==========================================//

              SizedBox(
                height: size.iScreen(1.0),
              ),

              //*****************************************/
              widget.infoActividad['actFotosActividad'].isNotEmpty
                  ? SizedBox(
                      width: size.wScreen(100.0),
                      child: Text(
                        'Fotos: ${widget.infoActividad!['actFotosActividad']!.length}',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),

              // //==========================================//
              widget.infoActividad['actFotosActividad'].isNotEmpty
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.iScreen(0.5),
                          horizontal: size.iScreen(0.5)),
                      child: ListView.builder(
                        itemCount:
                            widget.infoActividad!['actFotosActividad']!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                // color: Colors.red,
                                margin: EdgeInsets.symmetric(
                                    vertical: size.iScreen(0.5),
                                    horizontal: size.iScreen(0.0)),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/imgs/loader.gif'),
                                  image: NetworkImage(
                                    '${widget.infoActividad!['actFotosActividad']![index]['url']}',
                                  ),
                                ),
                              ),
                              //*****************************************/

                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/
                            ],
                          );
                        },
                      ),
                      height: size.iScreen(widget
                              .infoActividad!['actFotosActividad']!.length
                              .toDouble() *
                          40.0),
                    )
                  : Container(),
              // // //*****************************************/

              //*****************************************/
              //*****************************************/
              SizedBox(
                height: size.iScreen(0.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              if (widget.infoActividad['actAsunto'] == 'RONDAS') {
                actividadesController.getTodasLasActividades('');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VistaRondaRealizadasGuardias(
                        codigoActicidad: widget.infoActividad['actId'],
                        usuario: widget.usuario,
                        infoActividad: widget.infoActividad)));
              } else {
                actividadesController.getTodasLasActividades('');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VistaActividadRealizadasGuardias(
                        codigoActicidad: widget.infoActividad['actId'],
                        usuario: widget.usuario,
                        infoActividad: widget.infoActividad)));
              }
            },
            heroTag: "btnVisualizar",
            child: const Icon(Icons.content_paste_search_outlined),
          ),
          SizedBox(
            height: size.iScreen(1.5),
          ),

          actividadesController.getTrabajoCumplido != 'REALIZADO'
              ? FloatingActionButton(
                  backgroundColor: primaryColor,
                  heroTag: "btnRealizar",
                  onPressed: () {
                    if (widget.infoActividad['actAsunto'] == 'RONDAS') {
                      actividadesController.resetValuesActividades();
                      actividadesController.getTodosLosPuntosDeRonda('');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PuntosDeRondaPage(
                                infoActividad: widget.infoActividad,
                              )));
                    } else {
                      actividadesController.resetValuesActividades();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RealizarActividadGuardia(
                                infoActividad: widget.infoActividad,
                              )));
                    }
                  },
                  child: const Icon(Icons.rate_review_outlined),
                )
              : const SizedBox(),

          // : const SizedBox(),

          //***********************************************/
          SizedBox(
            height: size.iScreen(2.0),
          ),
        ],
      ),
    );
  }
}
