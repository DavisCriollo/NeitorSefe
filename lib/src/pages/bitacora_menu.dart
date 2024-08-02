import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/novedades_controller.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/lista_bitacora.dart';
import 'package:nseguridad/src/pages/lista_cambio_puesto.dart';

import 'package:nseguridad/src/pages/lista_multas_supervisor_page.dart';
import 'package:nseguridad/src/pages/lista_residentes.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/item_menu_novedades.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class BitacoraPage extends StatefulWidget {
  final List<String?>? tipo;
  final Session? user;
  const BitacoraPage({Key? key, this.tipo, this.user}) : super(key: key);

  @override
  State<BitacoraPage> createState() => _BitacoraPageState();
}

class _BitacoraPageState extends State<BitacoraPage> {
  final socketService = SocketService();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    final controllerActividades = Provider.of<ActividadesController>(context);
    final controllerMultas = Provider.of<MultasGuardiasContrtoller>(context);
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
          'Bitácora',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Stack(
         alignment: Alignment.center,
        children: [
          Container(
              width: size.wScreen(100.0),
              padding: EdgeInsets.only(
                top: size.iScreen(0.0),
                left: size.iScreen(3.0),
                right: size.iScreen(3.0),
              ),
              child: 
              Center(
                child: SingleChildScrollView(
                  
                  child: Consumer<SocketService>(
                    builder: (_, valueMenu, __) {
                      return valueMenu.serverStatus == ServerStatus.Online
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              spacing: size.iScreen(1.0),
                              runSpacing: size.iScreen(2.0),
                              children: [
                               widget.user!.rol!.contains('RESIDENTE')
                               ?Container(): ItemsMenuNovedades(
                                  onTap: () {
                                    // if (widget.tipo!.contains('SUPERVISOR') 
                                    // || widget.tipo!.contains('GUARDIA')
                                    // || widget.tipo!.contains('ADMINISTRACION')
                                    // ) {
                                    //   controllerMultas.getTodasLasMultasGuardia(
                                    //       '', 'false');
                                    //   Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               ListaMultasSupervisor(
                                    //                   user: widget.user)));
                                    // } else {}

                                            final _controller =context.read<ResidentesController>();
                                                                              _controller.resetValuesResidentes();
                                                                           if(widget.user!.rol!.contains('CLIENTE')){
                                                                              _controller.getTodosLosResidentes('','false');

                                                                           } else  if(widget.user!.rol!.contains('GUARDIA')){
                                                                              _controller.getTodosLosResidentesGuardia('','false');
                                                                           }

                                                                          Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: (context) => ListaResidentes(
                                                                                    user: widget.user,
                                                                                  )));
                                  },
                                  label: 'Residentes',
                                  icon: Icons.group,
                                  color: Colors.green,
                                ),
                                ItemsMenuNovedades(
                                  onTap: () {
                              
                                                                              final _controller =
                                                                              context.read<BitacoraController>();
                                                                              _controller.resetValuesBitacora();
                                                                              
                                                                              _controller.getBitacoras('','false');

                                                                          Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: (context) => ListaBitacora(
                                                                                    user: widget.user,
                                                                                  )));
                                  },
                                  label:widget.user!.rol!.contains('RESIDENTE')?'Solicitud de Ingreso': 'Libro Diario',
                                  icon: Icons.auto_stories_outlined,
                                  color: Colors.orange,
                                ),

                                // (widget.tipo!.contains('SUPERVISOR'))
                                //     ? ItemsMenuNovedades(
                                //         onTap: () {
                                //           Provider.of<AvisoSalidaController>(
                                //                   context,
                                //                   listen: false)
                                //               .buscaAvisosSalida('');

                                //           Navigator.pushNamed(
                                //               context, 'listaAvisoSalidaGuardia');
                                //         },
                                //         label: 'Aviso de salida',
                                //         icon: Icons
                                //             .connect_without_contact_outlined,
                                //         color: Colors.brown,
                                //       )
                                //     : const SizedBox(),
                                // (widget.tipo!.contains('GUARDIA') 
                                // || widget.tipo!.contains('SUPERVISOR')
                            
                                //         )
                                //     ? ItemsMenuNovedades(
                                //         onTap: () {
                                //           Provider.of<CambioDePuestoController>(
                                //                   context,
                                //                   listen: false)
                                //               .buscaCambioPuesto('', 'false');
                                //           Navigator.of(context).push(
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       ListaCambioPuestoPage(
                                //                           user: widget.user)));
                                //         },
                                //         label: 'Cambio de puesto',
                                //         icon: Icons
                                //             .transfer_within_a_station_outlined,
                                //         color: Colors.blue)
                                //     : const SizedBox(),
                                // (widget.tipo!.contains('SUPERVISOR'))
                                //     ? ItemsMenuNovedades(
                                //         onTap: () {
                                //           Provider.of<TurnoExtraController>(
                                //                   context,
                                //                   listen: false)
                                //               .buscaTurnoExtra('');
                                //           Navigator.pushNamed(
                                //               context, 'listaTurnoExtra');
                                //         },
                                //         label: 'Turno Extra',
                                //         icon: Icons.card_membership_outlined,
                                //         color: Colors.purple,
                                //       )
                                //     : const SizedBox(),
                                // ItemsMenuNovedades(
                                //   onTap: () {
                                //     Provider.of<AusenciasController>(context,
                                //             listen: false)
                                //         .buscaAusencias('', 'false');
                                //     Navigator.pushNamed(context, 'listaAusencias',
                                //         arguments: widget.user);
                                //   },
                                //   label: 'Permisos',
                                //   icon: Icons.pending_actions_outlined,
                                //   color: Colors.green,
                                // ),
                              ],
                            )
                          : const NoData(label: 'Sin conexión a internet');
                    },
                  ),
                ),
              )
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
                                                      '${widget.user!.rucempresa!}  ',
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
                                                      '  ${widget.user!.usuario!} ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color:
                                                              Colors.grey.shade600,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )),
               )
        ],
      ),
    );
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalOpcionMulta(
      Responsive size, ActividadesController actividadesController) {
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
                  Text('OPCIONES',
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
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () async {
                          actividadesController.setOpcionMulta(1);
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  '#34CAF0', 'Cancelar', false, ScanMode.QR);

                          actividadesController.setInfoQR(barcodeScanRes);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
                        title: Text(
                          "Código Personal",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          actividadesController.setOpcionMulta(2);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'validaAccesoMultas');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading:
                            const Icon(Icons.list_alt, color: Colors.black),
                        title: Text(
                          "Nómina de Personal",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          actividadesController.setOpcionMulta(3);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'validaAccesoMultas');
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

  //===================================================//

}
