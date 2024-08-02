import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';

import 'package:nseguridad/src/pages/crear_turno_emergente.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class EditarMultaPage extends StatefulWidget {
  const EditarMultaPage({Key? key}) : super(key: key);

  @override
  State<EditarMultaPage> createState() => _EditarMultaPageState();
}

class _EditarMultaPageState extends State<EditarMultaPage> {
  TextEditingController _fechaMultaController = TextEditingController();
  TextEditingController _detalleMultaController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {}

  @override
  Widget build(BuildContext context) {
      final ctrlTheme = context.read<ThemeApp>();
        
    final Responsive size = Responsive.of(context);
    final tipoMultaController = Provider.of<MultasGuardiasContrtoller>(context);
    _fechaMultaController.text = tipoMultaController.getInputFechamulta;
    _detalleMultaController.text = tipoMultaController.getInputDetalleNovedad;

    if (tipoMultaController.getTextoTipoMulta == 'ABANDONO DE PUESTO' ||
        tipoMultaController.getTextoTipoMulta ==
            'ESTADO ETILICO O ALIENTO A LICOR' ||
        tipoMultaController.getTextoTipoMulta == 'FALTA INJUSTIFICADA') {
      tipoMultaController.setGuardiaReemplazo(true);
    } else {
      tipoMultaController.setGuardiaReemplazo(false);
    }

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              final controllerMulta = context.read<MultasGuardiasContrtoller>();
              return AlertDialog(
                title: const Text('Aviso'),
                content: const Text('¿Desea cancelar la cración de la multa?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        final providerTurno =
                            context.read<TurnoExtraController>();

                        await providerTurno.eliminaTurnoExtra(
                            controllerMulta.getDataTurnoEmergente['turId']);

                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                      )),
                ],
              );
            });
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
            title: Consumer<MultasGuardiasContrtoller>(
              builder: (_, valuePorcentage, __) {
                return Text(
                  'Editar Multa ${valuePorcentage.getPorcentajeTipoMulta}%',
                  // style: Theme.of(context).textTheme.headline2,
                );
              },
            ),

            actions: [
              //  //***********************************************/
              Consumer<SocketService>(
                builder: (_, valueEstadoInter, __) {
                  return valueEstadoInter.serverStatus == ServerStatus.Online
                      ? Container(
                          margin: EdgeInsets.only(right: size.iScreen(1.5)),
                          child: IconButton(
                              splashRadius: 28,
                              onPressed: () {
                                _onSubmit(context, tipoMultaController);
                              },
                              icon: Icon(
                                Icons.save_outlined,
                                size: size.iScreen(4.0),
                              )),
                        )
                      : Container();
                },
              ),
            ],
          ),
          body: Consumer<SocketService>(
            builder: (_, valueEstadoInter, __) {
              return valueEstadoInter.serverStatus == ServerStatus.Online
                  ? Container(
                      width: size.iScreen(100.0),
                      height: size.iScreen(100.0),
                      margin: EdgeInsets.only(
                          bottom: size.iScreen(0.0), top: size.iScreen(0.0)),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.iScreen(1.5),
                        vertical: size.iScreen(1.5),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: tipoMultaController.multasGuardiaFormKey,
                          child: Column(
                            children: [
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fecha de Registro:',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: size.wScreen(40),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.wScreen(3.5)),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      readOnly: true,
                                      controller: _fechaMultaController,
                                      decoration: InputDecoration(
                                        hintText: 'yyyy-mm-dd',
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                        suffixIcon: IconButton(
                                          color: Colors.red,
                                          splashRadius: 20,
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _selectFechaRegistro(
                                                context, tipoMultaController);
                                          },
                                          icon: const Icon(
                                            Icons.date_range_outlined,
                                            color: primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      onChanged: (value) {},
                                      onSaved: (value) {},
                                      validator: (text) {
                                        if (text!.trim().isNotEmpty) {
                                          return null;
                                        } else {
                                          return 'Ingrese fecha de registro';
                                        }
                                      },
                                      style: const TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/

                              Row(
                                children: [
                                  SizedBox(
                                    child: Text('Motivo:',
                                        style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  SizedBox(width: size.iScreen(1.0)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        // consignaController.buscaGuardiasConsigna('');
                                        Provider.of<MultasGuardiasContrtoller>(
                                                context,
                                                listen: false)
                                            .getTodoosLosTiposDeMultasGuardia();

                                        Navigator.pushNamed(context, 'multas',
                                            arguments: 'EDITAR');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: primaryColor,
                                        width: size.iScreen(3.05),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: size.iScreen(2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/
                              Container(
                                // width: size.wScreen(35),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.wScreen(3.5)),
                                child: Text(
                                  "${tipoMultaController.getTextoTipoMulta}",
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                  ),
                                ),
                              ),
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/

                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/

                              Row(
                                children: [
                                  SizedBox(
                                    // width: size.wScreen(100.0),
                                    // color: Colors.blue,
                                    child: Text('Persona:',
                                        style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  SizedBox(width: size.iScreen(1.0)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Provider.of<AvisoSalidaController>(
                                                context,
                                                listen: false)
                                            .buscaInfoGuardias('');
                                        Navigator.pushNamed(
                                            context, 'buscaGuardias',
                                            arguments:
                                                'editarMulta'); //     arguments: 'EDITAR');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: primaryColor,
                                        width: size.iScreen(3.05),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: size.iScreen(2.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //*****************************************/
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/
                              Container(
                                // width: size.wScreen(35),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.wScreen(1.0),
                                    vertical: size.iScreen(1.0)),
                                child: SizedBox(
                                  width: size.wScreen(100.0),
                                  child: Text(
                                    "${tipoMultaController.getNomPersonaMulta}",
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // ***************************************/
                              SizedBox(height: size.iScreen(1.0)),

                              //*****************************************/

                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/

                              Consumer(
                                builder: (_, valueTipoMulta, __) {
                                  return (tipoMultaController
                                              .getGuardiaReemplazo ==
                                          true)
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: size.wScreen(100.0),

                                              // color: Colors.blue,
                                              child: Text('Guardia Reemplazo:',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.red,
                                                    padding: EdgeInsets.only(
                                                      top: size.iScreen(1.0),
                                                      right: size.iScreen(0.5),
                                                    ),
                                                    child: Consumer<
                                                        TurnoExtraController>(
                                                      builder:
                                                          (_, persona, __) {
                                                        return (persona.nombreGuardia ==
                                                                    '' ||
                                                                persona.nombreGuardia ==
                                                                    null)
                                                            ? Text(
                                                                'No hay guardia designado',
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            : Text(
                                                                '${persona.nombreGuardia} ',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  // color: Colors.grey
                                                                ),
                                                              );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      //    final turnoExtraController = context.read<TurnoExtraController>();
                                                      // _modalSeleccionaGuardia(
                                                      //     size, turnoExtraController);

                                                      final turnoExtraController =
                                                          Provider.of<
                                                                  TurnoExtraController>(
                                                              context,
                                                              listen: false);
                                                      turnoExtraController
                                                          .resetValuesTurnoExtra();
                                                      // turnoExtraController.resetValuesTurnoExtra();
                                                      final controllerMulta =
                                                          context.read<
                                                              MultasGuardiasContrtoller>();
                                                      controllerMulta
                                                          .resetValuesTurnoEmergente();
                                                      controllerMulta
                                                          .getTodosLosPuestosDelCliente(
                                                              controllerMulta
                                                                  .getCedClienteMulta);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  const CreaTurnoEmergente())));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: primaryColor,
                                                      width: size.iScreen(3.5),
                                                      padding: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom:
                                                            size.iScreen(0.5),
                                                        left: size.iScreen(0.5),
                                                        right:
                                                            size.iScreen(0.5),
                                                      ),
                                                      child: Icon(
                                                        Icons.search_outlined,
                                                        color: Colors.white,
                                                        size: size.iScreen(2.8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container();
                                },
                              ),

                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //*****************************************/
                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Detalle de Novedad:',
                                    style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    )),
                              ),
                              TextFormField(
                                initialValue:
                                    tipoMultaController.getInputDetalleNovedad,
                                maxLines: 2,
                                decoration: const InputDecoration(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(),
                                onChanged: (text) {
                                  tipoMultaController
                                      .onInputDetalleNovedadChange(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Ingrese detalle de la multa';
                                  }
                                },
                                onSaved: (value) {
                                  // codigo = value;
                                  // tipoMultaController.onInputFDetalleNovedadChange(value);
                                },
                              ),
                              //==========================================//
                              Consumer<MultasGuardiasContrtoller>(
                                builder: (_, provFotos, __) {
                                  return provFotos.getListaFotosUrl!.isNotEmpty
                                      ? _CamaraOption(
                                          size: size,
                                        )
                                      : Container();
                                },
                              ),

                              //==========================================//
                              tipoMultaController.getPathVideo!.isNotEmpty
                                  ? _CamaraVideo(
                                      size: size,
                                      multasControler: tipoMultaController,
                                    )
                                  : Container(),
                              //==========================================//
                              tipoMultaController
                                      .getListaCorreosClienteMultas.isNotEmpty
                                  ? _CompartirClienta(
                                      size: size,
                                      multasController: tipoMultaController)
                                  : Container(),
                              //*****************************************/
                              SizedBox(
                                height: size.iScreen(2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const NoData(label: 'Sin conexión a internet');
            },
          ),
          floatingActionButton:
              //  //***********************************************/
              Consumer<SocketService>(
            builder: (_, valueEstadoInter, __) {
              return valueEstadoInter.serverStatus == ServerStatus.Online
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            bottomSheet(tipoMultaController, context, size);
                          },
                          backgroundColor: Colors.purpleAccent,
                          heroTag: "btnCamara",
                          child: const Icon(Icons.camera_alt_outlined),
                        ),
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        FloatingActionButton(
                          backgroundColor:
                              tipoMultaController.getUrlVideo!.isEmpty
                                  ? Colors.blue
                                  : Colors.grey,
                          heroTag: "btnVideo",
                          child: tipoMultaController.getUrlVideo!.isEmpty
                              ? const Icon(Icons.videocam_outlined,
                                  color: Colors.white)
                              : const Icon(
                                  Icons.videocam_outlined,
                                  color: Colors.black,
                                ),
                          onPressed: tipoMultaController.getUrlVideo!.isEmpty
                              ? () {
                                  bottomSheetVideo(
                                      tipoMultaController, context, size);
                                }
                              : null,
                        ),
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaRegistro(
      BuildContext context, MultasGuardiasContrtoller multasController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

      final _fechaMulta =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaMultaController.text = _fechaMulta;
      multasController.onInputFechaMultaChange(_fechaMulta);
    }
  }

  void bottomSheetVideo(
    MultasGuardiasContrtoller multasController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(ImageSource.camera, multasController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Video',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(ImageSource.gallery, multasController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            ));
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
        // tipoMultasController.buscaGuardiaMultas();
        Navigator.pushNamed(context, 'crearMultasGuardias');
      } else {
        NotificatiosnService.showSnackBarDanger('No existe registrto');
      }
    } on PlatformException {
      NotificatiosnService.showSnackBarError('No se pudo escanear ');
    }
  }

  //====== MUESTRA MODAL DE BUSCAR GUARDIA =======//
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
                          // homeController.setOpcionActividad(1);
                          tipoMultasController.resetValuesMulta();
                          _validaScanQRMulta(size, tipoMultasController);
                          Navigator.pop(context);
                          // _modalTerminosCondiciones(size, homeController);
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

                          Navigator.pushNamed(context, 'buscaGuardias',
                              arguments: 'editarMulta');
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

  void _funcionCamaraVideo(
      ImageSource source, MultasGuardiasContrtoller multasController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(
      source: source,
    );

    if (pickedFile == null) {
      return;
    }
    multasController.setPathVideoMultas(pickedFile.path);

    Navigator.pop(context);
  }

  void bottomSheet(
    MultasGuardiasContrtoller multasController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.camera, multasController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.gallery, multasController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            ));
  }

  void _downloadImage(String? image) async {
    try {
      var imageId = await ImageDownloader.downloadImage(image!);
      if (imageId == null) {
        return;
      }
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  void _funcionCamara(
    ImageSource source,
    MultasGuardiasContrtoller multasController,
  ) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    multasController.setNewPictureFile('${pickedFile.path}');

//===============================//
    _downloadImage(pickedFile.path);
//===============================//
    Navigator.pop(context);
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalCompartirUser(
      Responsive size, MultasGuardiasContrtoller multasController) {
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
                  Text('COMPARTIR',
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
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  '#34CAF0', 'Cancelar', false, ScanMode.QR);
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
                          _modalBuscaPersonaMultaCompartir(
                              size, multasController);
                          Navigator.pop(context);
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

//====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalBuscaPersonaMultaCompartir(
    Responsive size,
    MultasGuardiasContrtoller multasControler,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Buscar Cliente ',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
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

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Ingrese datos de búsqueda:',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {},
                        child: const Icon(
                          Icons.search,
                          color: Color(0XFF343A40),
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: const TextStyle(),
                    onChanged: (text) {
                      multasControler.onInputBuscaPersonaChange(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese dato para búsqueda';
                      }
                    },
                    onSaved: (value) {},
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/

                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Resultado búsqueda:',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                  ),
                  Container(
                    // width: size.wScreen(35),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.wScreen(1.0),
                        vertical: size.iScreen(1.0)),
                    child: SizedBox(
                      width: size.wScreen(100.0),
                      child: Text(
                        'No Hay Información',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                        ),
                      ),
                    ),
                  ),

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(1.0), bottom: size.iScreen(2.0)),
                    height: size.iScreen(3.5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF0A4280),
                        ),
                      ),
                      onPressed: () async {
                        ProgressDialog.show(context);
                        // await multasControler.actualizaEstadoMulta(
                        //     context, multa);

                        ProgressDialog.dissmiss(context);
                        Navigator.pop(context);
                      },
                      child: Text('Asignar',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //********************************************************************************************************************//
  void _onSubmit(
    BuildContext context,
    MultasGuardiasContrtoller controller,
  ) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getCedPersonaMulta == null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe asignar a una persona la multa');
      } else if (controller.getGuardiaReemplazo == true &&
          controller.getTurnoEmergenteGuardado == false) {
        NotificatiosnService.showSnackBarDanger('Debe asigna un Guardia ');
      } else {
        final conexion = await Connectivity().checkConnectivity();
        if (conexion == ConnectivityResult.none) {
          NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
        } else if (conexion == ConnectivityResult.wifi ||
            conexion == ConnectivityResult.mobile) {
          // ProgressDialog.show(context);
          await controller.editarMultaGuardia(context);
          Navigator.pop(context);
        }
      }
    }
  }
}

class _CamaraVideo extends StatelessWidget {
  const _CamaraVideo({
    Key? key,
    required this.size,
    required this.multasControler,
  }) : super(key: key);

  final Responsive size;
  final MultasGuardiasContrtoller multasControler;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.wScreen(100.0),
          // color: Colors.blue,
          margin: EdgeInsets.symmetric(
            vertical: size.iScreen(1.0),
            horizontal: size.iScreen(0.5),
          ),
          child: Text('Video:',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        ListTile(
          tileColor: Colors.grey.shade300,
          dense: true,
          title: Text(
            'Video seleccionado',
            style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.7),
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          leading: InkWell(
            onTap: () {
              multasControler.eliminaVideo();
            },
            child: Container(
              margin: EdgeInsets.only(right: size.iScreen(0.5)),
              child:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
          ),
          trailing: Icon(
            Icons.video_file_outlined,
            size: size.iScreen(5.0),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'videoSreen',
                arguments: '${multasControler.getUrlVideo}');
          },
        ),
      ],
    );
  }
}

class _CamaraOption extends StatefulWidget {
  // final MultasGuardiasContrtoller multasController;
  const _CamaraOption({
    Key? key,
    required this.size,
    // required this.multasController,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<MultasGuardiasContrtoller>(
        builder: (_, valueFotos, __) {
          return Column(
            children: [
              Container(
                width: widget.size.wScreen(100.0),
                // color: Colors.blue,
                margin: EdgeInsets.symmetric(
                  vertical: widget.size.iScreen(1.0),
                  horizontal: widget.size.iScreen(0.0),
                ),
                child:
                    Text('Fotografía: ${valueFotos.getListaFotosUrl!.length}',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
              SingleChildScrollView(
                child: Wrap(
                    children: valueFotos.getListaFotosUrl!
                        .map(
                          (e) => Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.size.iScreen(1.5)),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/imgs/loader.gif'),
                                  image: NetworkImage('${e['url']}'),
                                ),
                              ),
                              Positioned(
                                top: -3.0,
                                right: 4.0,
                                // bottom: -3.0,
                                child: IconButton(
                                  color: Colors.red.shade700,
                                  onPressed: () {
                                    setState(() {
                                      valueFotos.eliminaFotoUrl(e['url']);
                                    });
                                    // bottomSheetMaps(context, size);
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    size: widget.size.iScreen(3.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),

                //
              ),
            ],
          );
        },
      ),
      onTap: () {},
    );
  }
}

class _CompartirClienta extends StatelessWidget {
  final MultasGuardiasContrtoller multasController;
  const _CompartirClienta({
    Key? key,
    required this.size,
    required this.multasController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: size.wScreen(100.0),
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Compartir a:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          Consumer<MultasGuardiasContrtoller>(
            builder: (_, provider, __) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
                //color: Colors.red,
                width: size.wScreen(100.0),
                height: size.iScreen(
                    provider.getListaCorreosClienteMultas.length.toDouble() *
                        6.3),
                child: ListView.builder(
                  itemCount: provider.getListaCorreosClienteMultas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cliente =
                        provider.getListaCorreosClienteMultas[index];
                    return Card(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.eliminaClienteMulta(cliente['id']);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: size.iScreen(0.5)),
                              child: const Icon(Icons.delete_forever_outlined,
                                  color: Colors.red),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0),
                                  vertical: size.iScreen(1.0)),
                              child: Text(
                                '${cliente['nombres']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.7),
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      onTap: () {},
    );
  }
}
