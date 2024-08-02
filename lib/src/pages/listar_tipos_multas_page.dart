import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class TipoMultasPage extends StatefulWidget {
    final Session? user;
  const TipoMultasPage({Key? key, this.user}) : super(key: key);
  @override
  State<TipoMultasPage> createState() => _TipoMultasPageState();
}

class _TipoMultasPageState extends State<TipoMultasPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    // await MultasGuardiasContrtoller().buscaGuardiaMultas();
  }

  int val = -1;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    final Responsive size = Responsive.of(context);
    final tipoMultasController =
        Provider.of<MultasGuardiasContrtoller>(context);

        final _user=context.read<HomeController>();
  final ctrlTheme = context.read<ThemeApp>();
        
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
            'Tipos de Multas',
            // style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: Stack(
          children: [
             
            Container(
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              padding: EdgeInsets.only(
                top: size.iScreen(2.0),
                left: size.iScreen(1.0),
                right: size.iScreen(1.0),
              ),
              child: Consumer<MultasGuardiasContrtoller>(
                builder: (_, providers, __) {
                  if (providers.getErrorTiposMultas == null) {
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
                  } else if (providers.getErrorTiposMultas == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                  } else if (providers.getListaTodosLosTiposDeMultas.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                  }

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: providers.getListaTodosLosTiposDeMultas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tipoMulta =
                            providers.getListaTodosLosTiposDeMultas[index];
                        return ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          title: Text(
                            '${tipoMulta.novTipo}  ${tipoMulta.novPorcentaje} % ',
                            style: TextStyle(
                                fontSize: size.iScreen(1.9),
                                fontWeight: FontWeight.w500),
                          ),
                          children: <Widget>[
                            SizedBox(
                              height: size.iScreen(providers
                                      .getListaTodosLosTiposDeMultas.length
                                      .toDouble() *
                                  13.0),
                              child: ListView.builder(
                                itemCount: tipoMulta.novlista!.length,
                                itemBuilder: (BuildContext context, int i) {
                                  final nombreTipo = tipoMulta.novlista![i];
                                  return RadioListTile(
                                    title: Text(
                                      ' ${nombreTipo.nombre} ',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.9),
                                          // color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    value:
                                        '$index${tipoMulta.novlista!.indexOf(tipoMulta.novlista![i], i)}',
                                    groupValue:
                                        tipoMultasController.getItemTipoMulta,
                                    onChanged: (value) {
                                      var data =
                                          '$index${tipoMulta.novlista!.indexOf(tipoMulta.novlista![i], i)}';
                                      val = int.parse(data);
                                      tipoMultasController.setItenTipoMulta(
                                          value,
                                          tipoMulta.novId,
                                          tipoMulta.novOrigen,
                                          tipoMulta.novTipo,
                                          tipoMulta.novPorcentaje,
                                          tipoMulta.novlista![i].nombre.toString());
                                      // print(data);
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(1.0),
                                  bottom: size.iScreen(2.0)),
                              height: size.iScreen(3.5),
                              child: Consumer<ThemeApp>(
                                builder: (_, valueThem, __) {
                                  return ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          valueThem.primaryColor),
                                    ),
                                    onPressed: () {
                                      if (args == 'EDITAR') {
                                        Navigator.pop(context);
                                      } else {
                                        tipoMultasController.setCoords = '';
                                        if (tipoMultasController
                                            .getTextoTipoMulta.isNotEmpty) {
                                          _modalRegistraMulta(
                                              size,
                                              tipoMultasController,
                                              args.toString());
                                        } else {
                                          NotificatiosnService.showSnackBarDanger(
                                              'Debe seleccionar una multa');
                                        }
                                      }
                                    },
                                    child: Text('Asignar',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      });
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
      ),
    );
  }

//======================== VAALIDA SCANQR =======================//
  void _validaScanQRMulta(
      Responsive size, MultasGuardiasContrtoller tipoMultasController) async {
    try {
      await tipoMultasController.setInfoQRMultaGuardia(
          await FlutterBarcodeScanner.scanBarcode(
              '#34CAF0', '', false, ScanMode.QR));
      if (!mounted) return;
      ProgressDialog.show(context);

      ProgressDialog.dissmiss(context);
      final response = tipoMultasController.getErrorInfoMultaGuardia;
      if (response == true) {
        Navigator.pushNamed(context, 'crearMultasGuardias');
      } else {
        NotificatiosnService.showSnackBarDanger('No existe registrto');
      }
    } on PlatformException {
      NotificatiosnService.showSnackBarError('No se pudo escanear ');
    }
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalRegistraMulta(Responsive size,
      MultasGuardiasContrtoller tipoMultasController, String? accion) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SELECCIONAR PERSONA',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      )),
                  IconButton(
                      splashRadius: size.iScreen(3.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: size.iScreen(3.5),
                      )),
                ],
              ),
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading:
                            const Icon(Icons.qr_code_2, color: Colors.black),
                        title: Text(
                          "Código QR",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () async {
                          tipoMultasController.resetValuesMulta();
                          _validaScanQRMulta(size, tipoMultasController);
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
                        title: Text(
                          "Nómina de Guardias",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          tipoMultasController.resetValuesMulta();
                          Navigator.pop(context);

                          Provider.of<AvisoSalidaController>(context,
                                  listen: false)
                              .buscaInfoGuardias('');
                          if (accion == 'EDITAR') {
                            Navigator.pushNamed(context, 'buscaGuardias',
                                arguments: 'editarMulta');
                          } else if (accion == 'NUEVO') {
                            Navigator.pushNamed(context, 'buscaGuardias',
                                arguments: 'crearMulta');
                          }
                        },
                      ),
                      SizedBox(
                        height: size.iScreen(2.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
