import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/capacitaciones_controller.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';
import 'package:nseguridad/src/controllers/evaluaciones_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crea_encuesta.dart';
import 'package:nseguridad/src/pages/crea_evaluacion.dart';

import 'package:nseguridad/src/service/notifications_service.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:nseguridad/src/utils/theme.dart';

class CrearCapacitacion extends StatefulWidget {
  final Session? usuario;
  final String? action;
  const CrearCapacitacion({Key? key, this.usuario, this.action})
      : super(key: key);

  @override
  State<CrearCapacitacion> createState() => _CrearCapacitacionState();
}

class _CrearCapacitacionState extends State<CrearCapacitacion> {
  @override
  Widget build(BuildContext context) {
    final _action = widget.action;
    Responsive size = Responsive.of(context);
    final _data = ModalRoute.of(context)!.settings.arguments;
         final _user=context.read<HomeController>();
  final ctrlTheme = context.read<ThemeApp>();
        
    final List _datos = _data as List;
    final _controller = context.read<CapacitacionesController>();
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
        title: _datos[0]!['action'] == 'CREATE'
            ? Text(
                'Realizar Capacitación',
                // style: Theme.of(context).textTheme.headline2,
              )
            : Text(
                'Editar Capacitación',
                // style: Theme.of(context).textTheme.headline2,
              ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
        padding: EdgeInsets.only(
          top: size.iScreen(0.5),
          left: size.iScreen(0.5),
          right: size.iScreen(0.5),
          bottom: size.iScreen(0.5),
        ),
        width: size.wScreen(100.0),
        height: size.hScreen(100),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
               //*****************************************/
                                 Container(
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
              //***********************************************/
              SizedBox(
                height: size.iScreen(0.0),
              ),
              //***********************************************/
              Container(
                width: size.wScreen(100),

                // color: Colors.blue,
                child: Text('Título:',
                    style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                width: size.wScreen(100.0),
                child: Text(
                  '"${_controller.getDataCapacitacion['capaTitulo']}"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(2.3),
                      // color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(0.5),
              ),
              //***********************************************/
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    // width: size.wScreen(100.0),
                    child: Text(
                      'Fecha Emisión:  ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.5),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    child: Text(
                      _controller.getDataCapacitacion['capaFecDesde']
                          .toString()
                          .replaceAll("T", " "),
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.7),
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
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    child: Text(
                      'Fecha Finalización: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.5),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    child: Text(
                      _controller.getDataCapacitacion['capaFecHasta']
                          .toString()
                          .replaceAll("T", " "),
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.7),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //***********************************************/
              Consumer<CapacitacionesController>(
                builder: (_, valueCap, __) {
                  return valueCap.getDataCapacitacion.isNotEmpty
                      ? Container(
                          width: size.wScreen(100),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.wScreen(20.0)),
                          // color: Colors.blue,
                          child: Center(
                            child: TextButton(
                              child: Row(
                                children: [
                                  Text(
                                    int.parse(_datos[0]!['usuario']!
                                                .id
                                                .toString()) ==
                                            int.parse(
                                                valueCap.getDataCapacitacion[
                                                    'capaIdCapacitador'])
                                        ? 'Tomar Asistencia: '
                                        : 'Registrar Asistencia: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.5),
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Icon(
                                    Icons.qr_code_2_outlined,
                                    size: size.iScreen(4.5),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                if (int.parse(
                                        _datos[0]!['usuario'].id.toString()) ==
                                    int.parse(valueCap.getDataCapacitacion[
                                        'capaIdCapacitador'])) {
                                  _controller.setDataQR(valueCap
                                      .getDataCapacitacion['capaId']
                                      .toString());

                                  showModalBottomSheet<void>(
                                    context: context,
                                    isDismissible: false,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: size.hScreen(100.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.5),
                                            ),
                                            //***********************************************/

                                            Consumer<CapacitacionesController>(
                                              builder: (_, value, __) {
                                                return value.getDataQR.isEmpty
                                                    ? Container()
                                                    : QrImage(
                                                        data: value.getDataQR,
                                                        version:
                                                            QrVersions.auto,
                                                        size: size.wScreen(80),
                                                        gapless: false,
                                                        embeddedImage:
                                                            const AssetImage(
                                                                'assets/images/my_embedded_image.png'),
                                                        embeddedImageStyle:
                                                            QrEmbeddedImageStyle(
                                                          size: Size(
                                                              size.wScreen(2),
                                                              size.wScreen(2)),
                                                        ),
                                                      );
                                              },
                                            ),
                                            //***********************************************/
                                            SizedBox(
                                              height: size.iScreen(1.5),
                                            ),
                                            ElevatedButton(
                                              child: const Text('Cerrar'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  _scanAsistenciaQR(size, valueCap, context,
                                      _datos[0]['usuario']!);
                                }
                              },
                            ),
                          ))
                      : Container();
                },
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //***********************************************/
              Consumer<CapacitacionesController>(
                builder: (_, value, __) {
                  return _controller.getMessageAsistencia.isNotEmpty
                      ? Container(
                          width: size.wScreen(100.0),
                          height: size.hScreen(20.0),
                          alignment: Alignment.center,
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment_turned_in_outlined,
                                size: size.iScreen(7.0),
                                color: secondaryColor,
                              ),
                              //***********************************************/
                              SizedBox(
                                height: size.iScreen(1.5),
                              ),
                              //***********************************************/
                              Column(
                                children: [
                                  Text('${value.getMessageAsistencia['msg']}',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(2.2),
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.grey,
                                      )),
                                ],
                              ),
                            ],
                          ))
                      : Container();
                },
              ),

              //***********************************************/
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //***********************************************/
              Consumer<CapacitacionesController>(
                builder: (_, value, __) {
                  return value.getPreguntas.isNotEmpty &&
                          value.getPreguntas['docPreguntas'].isNotEmpty
                      ? TextButton(
                          onPressed: () {
                            if (value.getPreguntas['encOption'] ==
                                'EVALUACIONES') {
                              final _providerEvaluaciones =
                                  context.read<EvaluacionesController>();
                              _providerEvaluaciones.resetValuesEvaluaciones();
                              _providerEvaluaciones
                                  .getDataEvaluacion(_controller.getPreguntas);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => CreaEvaluacion(
                                            usuario: _datos[0]!['usuario']!,
                                            action: 'CREATE',
                                            menu: 'NO',
                                          ))));
                            } else if (value.getPreguntas['encOption'] ==
                                'ENCUESTAS') {
                              final _providerEncuestasa =
                                  context.read<EncuestasController>();
                              _providerEncuestasa.resetValuesEncuestas();
                              _providerEncuestasa
                                  .getDataEncuesta(_controller.getPreguntas);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => CreaEncuesta(
                                            usuario: _datos[0]!['usuario']!,
                                            action: 'CREATE',
                                              menu: 'NO',
                                          ))));
                            }
                          },
                          child: Text(
                              value.getPreguntas['encOption'] == 'EVALUACIONES'
                                  ? 'Realizar EVALUACIÓN'
                                  : 'Realizar ENCUESTA',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                // color: Colors.grey,
                              )))
                      : Container();
                },
              ),
              //***********************************************/
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //***********************************************/
            ],
          ),
        ),
      ),
    );
  }

//======================== VAALIDA SCANQR =======================//
  void _scanAsistenciaQR(Responsive size, CapacitacionesController _controllers,
      BuildContext context, Session? _usuario) async {
    bool _isMounted = false;

    _controllers.setScanData("", context);
    try {
      _controllers.setScanData(
          await FlutterBarcodeScanner.scanBarcode(
              '#34CAF0', '', false, ScanMode.QR),
          context);
      if (!mounted) {
        _isMounted = false;
      }
      _isMounted = true;
    } on PlatformException {
      NotificatiosnService.showSnackBarError('No se pudo escanear ');
    }
  }
}
