import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';
import 'package:nseguridad/src/pages/realizar_ronda_guardia.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class PuntosDeRondaPage extends StatefulWidget {
  final dynamic infoActividad;
  const PuntosDeRondaPage({Key? key, this.infoActividad}) : super(key: key);

  @override
  State<PuntosDeRondaPage> createState() => _PuntosDeRondaPageState();
}

class _PuntosDeRondaPageState extends State<PuntosDeRondaPage> {
  @override
  Widget build(BuildContext context) {
    final activitiesController =
        Provider.of<ActivitiesController>(context, listen: false);

    List listaPuestos = [];

    for (var item in widget.infoActividad['actDatosRondas']) {
      listaPuestos.add(item);
    }
    activitiesController.setNumLugares(
        widget.infoActividad['actId'], listaPuestos.length);

    activitiesController.validaDataDispositivo();

    final Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
         
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: primaryColor,
            
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
              'Mis Rondas',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Consumer<ActivitiesController>(
                builder: (_, valueRondas, __) {
                  return valueRondas.getRondaCompleta == true
                      ? Container(
                          margin: EdgeInsets.only(right: size.iScreen(1.5)),
                          child: IconButton(
                              splashRadius: 28,
                              onPressed: () {
                                _onSubmit(context, activitiesController);
                              },
                              icon: Icon(
                                Icons.save_outlined,
                                size: size.iScreen(4.0),
                              )),
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
            width: size.wScreen(100),
            height: size.hScreen(100),
            child: Column(
              children: [
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                SizedBox(
                  width: size.wScreen(100.0),
                  // color: Colors.blue,
                  child: Row(
                    children: [
                      Text('Puesto:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                      Spacer(),
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
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  width: size.wScreen(100.0),
                  child: Text(
                    // 'item Novedad: ${controllerActividades.getItemMulta}',
                    ' "${widget.infoActividad['atcPuesto']}"',

                    textAlign: TextAlign.center,
                    //
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.3),
                        // color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //***********************************************/
                Container(
                  width: size.wScreen(100.0),
                  child: Text('Ubicación:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                  width: size.wScreen(100.0),
                  child: Text(
                    "${widget.infoActividad['actUbicacion']}",
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
                //***********************************************/
                Container(
                  width: size.wScreen(100.0),
                  child: Text('Lugares:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listaPuestos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer<ActivitiesController>(
                        builder: (_, valueRonda, Widget? child) {
                          return Container(
                            color: (valueRonda.getRondaCompleta == true)
                                ? Colors.grey.shade400
                                : Color(0XFFF7F7F7),
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: ListTile(
                              dense: true,
                              title: Text(
                                '${listaPuestos[index]}',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal),
                              ),
                              onTap: () {
                                // activitiesController.getNombrePuntoPuesto=activitiesController.getListaTodosLosPuntosDeRonda[index]['actDatosRondas'][index];
                                activitiesController.resetValuesActividades();
                                activitiesController.getNombrePuntoPuesto =
                                    listaPuestos[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RealizaPuntoRonda(
                                      // codigoActicidad: widget.infoActividad['actId'],
                                      idRonda: widget.infoActividad['actId'],
                                      nombrePuesto: listaPuestos[index]),
                                ));
                              },
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                // size: size.iScreen(3.0)
                              ),
                            ),
                          );
                        },
                      );

                      //
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(
    BuildContext context,
    ActivitiesController activitiesController,
  ) async {
    final conexion = await Connectivity().checkConnectivity();
    if (conexion == ConnectivityResult.none) {
      NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
    } else if (conexion == ConnectivityResult.wifi ||
        conexion == ConnectivityResult.mobile) {
      await activitiesController.guardarRonda(
          widget.infoActividad['actId'], context);
      Navigator.pop(context);
    }
  }
}
