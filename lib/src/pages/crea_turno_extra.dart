//=================================================================================================================//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/utils/theme.dart';

class CreaTurnoExtra extends StatefulWidget {
  const CreaTurnoExtra({Key? key}) : super(key: key);

  @override
  State<CreaTurnoExtra> createState() => _CreaTurnoExtraState();
}

class _CreaTurnoExtraState extends State<CreaTurnoExtra> {
  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _horaInicioController = TextEditingController();
  TextEditingController _horaFinController = TextEditingController();

  late TimeOfDay timerInicio;
  late TimeOfDay timerFin;
  DateTime? _fechaini = DateTime.now();
  DateTime? _fechafin = DateTime.now();
  @override
  void initState() {
    initload();
    super.initState();
  }

  void initload() async {
    timerInicio = TimeOfDay.now();
    timerFin = TimeOfDay.now();
  }

  @override
  void dispose() {
    _fechaInicioController.clear();
    _fechaFinController.clear();
    _horaFinController.clear();
    _horaFinController.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _action = ModalRoute.of(context)!.settings.arguments;
    Responsive size = Responsive.of(context);
    final turnoExtraController = Provider.of<TurnoExtraController>(context);
    final _controllerFecha= context.read<AusenciasController>();

    //  print('resultado del ${_controllerFecha.getFechaValida}');
    //  print('resultado tipo ${_controllerFecha.getFechaValida.runtimeType}');

  final ctrlTheme = context.read<ThemeApp>();
         

    final _user = context.read<HomeController>();

    // print('_fechaVerificacion : ${_fechaVerificacion.getInputfechaInicio}');
    // _fechaini = DateTime.parse(turnoExtraController.getInputfechaInicio);
    // _fechafin = DateTime.parse(turnoExtraController.getInputfechaFin);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            // backgroundColor: const Color(0xFFEEEEEE),
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
              title: _action == 'CREATE' ||
                      _action == 'EXTRA' ||
                      _action == 'FALTAS' ||
                      _action == 'TURNO' ||
                      _action == 'MULTA'
                  ? Text(
                      'Crear Turno Extra',
                      // style: Theme.of(context).textTheme.headline2,
                    )
                  : Text(
                      'Editar Turno Extra',
                      // style: Theme.of(context).textTheme.headline2,
                    ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(
                            context, turnoExtraController, _action.toString());
                      },
                      icon: Icon(
                        Icons.save_outlined,
                        size: size.iScreen(4.0),
                      )),
                )
              ],
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
                  child: Form(
                    key: turnoExtraController.turnoExtraFormKey,
                    child: Column(
                      children: [
                        //==========================================//
                        Container(
                            width: size.wScreen(100.0),
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                                Text('-',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                                Text('  ${_user.getUsuarioInfo!.usuario!} ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/

                        SizedBox(
                          width: size.wScreen(100.0),
                          child: Text('Seleccionar Guardia :',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
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
                                child: Consumer<TurnoExtraController>(
                                  builder: (_, persona, __) {
                                    return (persona.nombreGuardia == '' ||
                                            persona.nombreGuardia == null)
                                        ? Text(
                                            'No hay guardia designado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.nombreGuardia} ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                          // _action!='FALTAS'?  
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(onTap: () {
                                final _fechaVerificacion =
                                    context.read<AusenciasController>();
                                //=========OBTENEMOS LA FECHA PAR VALIDAR EN LA BUSQUEDA ==========//
                                // String fecha = _fechaVerificacion.getListFechasAusenciaSeleccionadas[0]['desde'] .toString();
                                // int indexT = fecha.indexOf("T"); // Obtenemos el índice de la letra "T"

                                // if (indexT != -1) {
                                //   String fechaSinLetras = fecha.substring(0, indexT); // Obtenemos la parte antes de la "T"
                               
                                //       _fechaVerificacion.setFechaValida(fechaSinLetras);
                                // }
                                _modalSeleccionaGuardia(size, turnoExtraController);

                              }, child: Consumer<ThemeApp>(
                                builder: (_, valueTheme, __) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: valueTheme.primaryColor,
                                    width: size.iScreen(3.5),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: valueTheme.secondaryColor,
                                      size: size.iScreen(2.0),
                                    ),
                                  );
                                },
                              )),
                            ),
                            // :Container(),
                          ],
                        ),
                        //***********************************************/
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/

                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              _action == 'EXTRA' || _action == 'MULTA'
                                  ? 'Cliente :'
                                  : 'Nuevo Cliente :',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
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
                                child: Consumer<TurnoExtraController>(
                                  builder: (_, persona, __) {
                                    return (persona.nombreCliente == '' ||
                                            persona.nombreCliente == null)
                                        ? Text(
                                            'No hay cliente seleccionado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.nombreCliente} ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                            _action == 'EXTRA' || _action == 'MULTA'
                            || _action=='FALTAS'
                                ? Container()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(onTap: () {
                                      turnoExtraController.resetDropDown();
                                      _modalSeleccionaCliente(
                                          size, turnoExtraController);
                                    }, child: Consumer<ThemeApp>(
                                      builder: (_, valueTheme, __) {
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color:
                                                valueTheme.secondaryColor,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                    )),
                                  ),
                          ],
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text(
                              _action == 'EXTRA' || _action == 'MULTA'
                                  ? "Puesto :"
                                  : 'Nuevo Puesto:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
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
                                child: Consumer<TurnoExtraController>(
                                  builder: (_, persona, __) {
                                    return (persona.labelNuevoPuesto == '' ||
                                            persona.labelNuevoPuesto == null)
                                        ? Text(
                                            'No hay puesto seleccionado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.labelNuevoPuesto} ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                            _action != 'EXTRA' || _action != 'MULTA'
                                ? Consumer<TurnoExtraController>(
                                    builder: (_, value, __) {
                                      return value.getListaPuestosCliente
                                                  .isNotEmpty &&
                                              value.labelNuevoPuesto != ''
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: GestureDetector(onTap: () {
                                                _modalSeleccionaNuevoPuesto(
                                                    size,
                                                    turnoExtraController,
                                                    _action.toString());
                                              }, child: Consumer<ThemeApp>(
                                                builder: (_, valueTheme, __) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    color: valueTheme
                                                        .primaryColor,
                                                    width: size.iScreen(3.5),
                                                    padding: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom: size.iScreen(0.5),
                                                      left: size.iScreen(0.5),
                                                      right: size.iScreen(0.5),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: valueTheme
                                                          .secondaryColor,
                                                      size: size.iScreen(2.0),
                                                    ),
                                                  );
                                                },
                                              )),
                                            )
                                          : Container();
                                    },
                                  )
                                : Container(),
                          ],
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Fecha Seleccionada:',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: tercearyColor)),
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.3),
                        ),
                        //*****************************************/

                        Consumer<AusenciasController>(
                          builder: (_, itemFechas, __) {

               


                            return Container(
                              color: Colors.white,
                              // alignment: Alignment.,
                              width: size.wScreen(100.0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(0.0),
                                  vertical: size.iScreen(0.1)),
                              child: itemFechas
                                          .getFechaValida !=
                                      ''
                                  ? 
                                    Container(
                                                margin: EdgeInsets.all(
                                                    size.iScreen(0.6)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.all(
                                                          size.iScreen(0.5)),
                                                      decoration: BoxDecoration(
                                                        // color: Colors.grey.shade200,
                                                        color: Colors
                                                            .grey.shade100,
                                                      ),
                                                      // width: size.iScreen(12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          // const Icon(Icons.remove_circle_outline,color: Colors.red,),
                                                          Text(
                                                            itemFechas.getFechaValida['desde'].toString().replaceAll('T', " ") ,
                                                          style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            "/" ,
                                                          style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            itemFechas.getFechaValida['hasta'].toString().replaceAll('T', " ") ,
                                                          style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                         
                                                        ],
                                                      )),
                                                ),
                                              )
                                  : Container(
                                      child: Text(
                                        'Seleccione fecha de turno',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                              // height: size.iScreen(consignaController.getLitaSeleccionada!.length.toDouble()*3),
                            );

                            //*****************************************/
                          },
                        ),
                      

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/

                        Row(
                          children: [
                            Container(
                              width: size.wScreen(30.0),

                              // color: Colors.blue,
                              child: Text('Días Permiso:',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Container(
                                width: size.wScreen(20.0),
                                child: Consumer<TurnoExtraController>(
                                  builder: (_, value, __) {
                                   
                                    // for (var item in value
                                    //     .getListFechasAusenciaSeleccionadas) {
                                    //   turnoExtraController
                                    //       .setListFechasTurnoExtra(item);
                                    // }

                                    // turnoExtraController.onNumeroDiasChange(
                                    //     turnoExtraController.getListFechasTurnoExtra
                                    //         .length
                                    //         .toString());
                                    return Text(
                                        turnoExtraController.getInputNumeroDias
                                      //  1
                                            .toString(),
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54));
                                  },
                                )),
                          ],
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Motivo:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
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
                                child: Consumer<TurnoExtraController>(
                                  builder: (_, persona, __) {
                                    return (persona.labelMotivoTurnoExtra ==
                                                '' ||
                                            persona.labelMotivoTurnoExtra ==
                                                null)
                                        ? Text(
                                            'No hay motivo seleccionado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.labelMotivoTurnoExtra} ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                            _action == 'FALTAS' ||
                            _action == 'EXTRA' ||
                                    _action == 'MULTA' ||
                                    _action == 'CREATE'
                                ? Container()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(onTap: () {
                                      _modalSeleccionaMotivo(
                                          size, turnoExtraController);
                                    }, child: Consumer<ThemeApp>(
                                      builder: (_, valueTheme, __) {
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.primaryColor,
                                          width: size.iScreen(3.5),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color:
                                                valueTheme.secondaryColor,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                    )),
                                  )
                          ],
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Autorizado por:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),

                        Container(
                          // color: Colors.red,
                          width: size.wScreen(100.0),
                          padding: EdgeInsets.only(
                            top: size.iScreen(1.0),
                            right: size.iScreen(0.5),
                          ),
                          child: Consumer<TurnoExtraController>(
                            builder: (_, persona, __) {
                              return (persona.getInputAutorizadoPor == '' ||
                                      persona.getInputAutorizadoPor == null)
                                  ? Text(
                                      '- - - - - - - - - - - ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )
                                  : Text(
                                      '${persona.getInputAutorizadoPor} ',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey
                                      ),
                                    );
                            },
                          ),
                        ),

                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Detalle:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        TextFormField(
                          initialValue: _action == 'CREATE' ||
                                  // _action == 'FALTAS' ||
                                  _action == 'EXTRA' ||
                                  _action == 'TURNO' ||
                                  _action == 'MULTA'
                              ? ''
                              : turnoExtraController.getInputDetalle,
                          decoration: const InputDecoration(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(),
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                          ],
                          onChanged: (text) {
                            turnoExtraController.onDetalleChange(text);
                          },
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese detalle del turno ';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaMotivo(
      Responsive size, TurnoExtraController turnoController) {
    final _data = [
      'ENFERMEDAD IESS',
      'PERMISO PERSONAL',
      'PATERNIDAD',
      'DEFUNCIÓN FAMILIAR',
      'INJUSTIFICADA',
    ];

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
                      Text('SELECCIONAR MOTIVO',
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
                  Container(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            turnoController
                                .setLabelMotivoTurnoExtra(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE NUEVO PUESTO =======//
  void _modalSeleccionaNuevoPuesto(
      Responsive size, TurnoExtraController turnoController, String? _action) {
    List? _puesto = [];

    for (var item in turnoController.getListaPuestosCliente) {
      _puesto.add('${item['puesto']} - ${item['ubicacion']}');
    }

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
                      Text('SELECCIONAR PUESTO',
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
                  Container(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _puesto.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (_action == 'EXTRA') {
                              turnoController.setPuestos([
                                {
                                  "ruccliente":turnoController.getCedulaCliente,
                                  "razonsocial": turnoController.nombreCliente,
                                  "ubicacion": turnoController.getListaPuestosCliente[index]['ubicacion'],
                                  "puesto": turnoController .getListaPuestosCliente[index]['puesto'],
                                }
                              ]);
                            }

                            turnoController
                                .setLabelINuevoPuesto(_puesto[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _puesto[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, TurnoExtraController controller,
      String? _action) async {
    final _controlAusencia = context.read<AusenciasController>();
    final controllerMulta = context.read<MultasGuardiasContrtoller>();

    bool _diasTotales = false;
    if (_action == 'EXTRA') {
      int _totalDias = _controlAusencia.getSumaDiasPermiso +
          int.parse(controller.getInputNumeroDias.toString());

      if (_totalDias <=
          int.parse(_controlAusencia.getInputNumeroDias.toString())) {
        _diasTotales = true;
      } else {
        _diasTotales = false;
      }
    }

    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.nombreGuardia!.isEmpty ||
          controller.nombreGuardia == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Guardia');
      } else if (controller.nombreCliente!.isEmpty ||
          controller.nombreCliente == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Cliente');
      } else if (controller.labelMotivoTurnoExtra == '' ||
          controller.labelMotivoTurnoExtra == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Motivo');
      } else if (controller.labelNuevoPuesto == '' ||
          controller.labelNuevoPuesto == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Puesto');
      } else if (controller.getInputAutorizadoPor == '' ||
          controller.getInputAutorizadoPor == null) {
        NotificatiosnService.showSnackBarDanger('No hay persona que autoriza');
        // } else if (_action == 'EXTRA' && controller.getInputNumeroDias == '0' ||
      } 
      // else if (_action == 'EXTRA' &&
      //         controller.getListFechasTurnoExtra.isEmpty ||
      //     _action == 'EXTRA' && controller.getListFechasTurnoExtra == []) {
      //   NotificatiosnService.showSnackBarDanger(
      //       'Debe seleccionar fechas de turno');
      // }
      // else if (_action == 'EXTRA' && _diasTotales == false) {
      //   NotificatiosnService.showSnackBarDanger(
      //       'El número de días es mayor al permiso');
      // }
      else if (controller.nombreGuardia!.isNotEmpty ||
          controller.nombreGuardia != null &&
              controller.nombreCliente!.isNotEmpty ||
          controller.nombreCliente != null &&
              controller.labelMotivoTurnoExtra!.isNotEmpty ||
          controller.getInputAutorizadoPor == '' ||
          controller.getInputAutorizadoPor == null &&
              controller.labelMotivoTurnoExtra != null &&
              controller.labelNuevoPuesto!.isNotEmpty &&
              controller.getInputNumeroDias != 0 ||
          controller.getInputNumeroDias != null) {
        if (_action == 'CREATE' || _action == 'EXTRA' || _action == 'MULTA'|| _action == 'TURNO'|| _action == 'FALTAS' ) {
          final _controllerPermiso = context.read<AusenciasController>();
          await controller.crearTurnoExtra(context,_controllerPermiso.getFechaValida,);
          final serviceSocket = SocketService();
          serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
            if (data['tabla'] == 'turnoextra') {
              if (_action == 'EXTRA') {
             
                // _controllerPermiso.setIdsTurnoEmergente({
                //   "turId": data['turId'],
                //   "turIdPersona": data['turIdPersona'],
                //   "turDocuPersona": data['turDocuPersona'],
                //   "turNomPersona": data['turNomPersona'],
                //   "fechas":controller.getListFechasTurnoExtra,
                //   "numDias":controller.getListFechasTurnoExtra.length.toString()
// getFechaValida

                // });

                  // final _fecha=[
                  //   {
                  //     "desde": _controllerPermiso.getFechaValida['desde'], 
                  //     "hasta": _controllerPermiso.getFechaValida['hasta'], 
                  //     "id": _controllerPermiso.getFechaValida['id'],
                  //     "isSelect": false,}
                  // ];


                _controllerPermiso.setGuardiasSeleccionados({
                  "turId": data['turId'],
                  "turIdPersona": data['turIdPersona'],
                  "turDocuPersona": data['turDocuPersona'],
                  "turNomPersona": data['turNomPersona'],
                  "fechas":  {
                      "desde": _controllerPermiso.getFechaValida['desde'], 
                      "hasta": _controllerPermiso.getFechaValida['hasta'], 
                      "id": _controllerPermiso.getFechaValida['id'],
                      "isSelect": false,} ,//controller.getListFechasTurnoExtra,
                  "numDias":'1'//controller.getListFechasTurnoExtra.length.toString()
                });
              //   _controllerPermiso.setGuardiasSelect({  "turId": data['turId'],
              //     "turIdPersona": data['turIdPersona'],
              //     "turDocuPersona": data['turDocuPersona'],
              //     "turNomPersona": data['turNomPersona'],
              //     "fechas":  _fecha  ,//controller.getListFechasTurnoExtra,
              //     "numDias":'1'//controller.getListFechasTurnoExtra.length.toString()



              // });
              }
              if (_action == 'MULTA') {
                controllerMulta.setDataTurnoEmergente(data);
                controllerMulta.setIdTurnoEmergente(data['turId'].toString());
                controllerMulta
                    .setIdGuardia(int.parse(data['turIdPersona'].toString()));
                controllerMulta
                    .setDocuGuardia(data['turDocuPersona'].toString());
                controllerMulta
                    .setNombreGuardia(data['turNomPersona'].toString());
              }
              if (_action == 'TURNO') {
                // controllerMulta.setDataTurnoEmergente(data);
                // controllerMulta.setIdTurnoEmergente(data['turId'].toString());
                // controllerMulta
                //     .setIdGuardia(int.parse(data['turIdPersona'].toString()));
                // controllerMulta
                //     .setDocuGuardia(data['turDocuPersona'].toString());
                // controllerMulta
                //     .setNombreGuardia(data['turNomPersona'].toString());
                  controllerMulta.getTodasLasMultasGuardia('', 'false');
                        // controller.resetValuesTurnoExtra();
              }
              if (_action == 'FALTAS') {
               
                  controllerMulta.getTodasLasFaltasInjustificadas('');
                        // controller.resetValuesTurnoExtra();
              }
            }
          });
          Navigator.pop(context);
        }
        if (_action == 'EDIT') {
          await controller.editarTurnoExtra(context);
          Navigator.pop(context);
        }
      }
    }
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaGuardia(
      Responsive size, TurnoExtraController turnoExtraController) {
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
                  Text('SELECCIONAR GUARDIA',
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
                          _validaScanQRGuardia(turnoExtraController);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
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
                          Navigator.pop(context);
                          Provider.of<AvisoSalidaController>(context,
                                  listen: false)
                              .buscaInfoGuardias('');
                          Navigator.pushNamed(context, 'buscaGuardias',
                              arguments: 'turnoExtra');
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

  //====== MUESTRA MODAL  =======//
  void _modalSeleccionaCliente(
      Responsive size, TurnoExtraController turnoExtraController) {
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
                  Text('SELECCIONAR CLIENTE',
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
                          _validaScanQRCliente(turnoExtraController);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
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
                          Provider.of<CambioDePuestoController>(context,
                                  listen: false)
                              .getTodosLosClientes('');
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'buscaClientes',
                              arguments: 'turnoExtra');
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

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaInicio(BuildContext context,
      TurnoExtraController turnoExtraController, String? _action) async {
    DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: _action == 'EXTRA' ? _fechaini! : DateTime.now(),
      // firstDate: _action == 'EXTRA' ? _fechaini! : DateTime.now(),

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

      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      // _fechaInicioController.text = _fechaInicio;
      turnoExtraController.onInputFechaInicioChange(_fechaInicio);
    }
  }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  _selectFechaFin(BuildContext context,
      TurnoExtraController turnoExtraController, String? _action) async {
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

      setState(() {
        final _fechaFin =
            '${anio.toString()}-${mes.toString()}-${dia.toString()}';
        _fechaFinController.text = _fechaFin;
        turnoExtraController.onInputFechaFinChange(_fechaFin);
      });
    }
  }

  void _seleccionaHoraInicio(
      context, TurnoExtraController turnoExtraController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timerInicio);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timerInicio = _hora;
        String horaInicio = '${dateHora}:${dateMinutos}';
        _horaInicioController.text = horaInicio;
        turnoExtraController.onInputHoraInicioChange(horaInicio);
      });
    }
  }

  void _seleccionaHoraFin(
      context, TurnoExtraController turnoExtraController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timerFin);
    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timerFin = _hora;
        print(timerFin.format(context));
        String horaFin = '${dateHora}:${dateMinutos}';
        _horaFinController.text = horaFin;
        turnoExtraController.onInputHoraFinChange(horaFin);
        //  print('si: $horaFin');
      });
    }
  }

  //======================== VALIDA SCANQRgUARDIA =======================//
  void _validaScanQRGuardia(TurnoExtraController turnoExtraController) async {
    turnoExtraController.setInfoQRGuardia(
        await FlutterBarcodeScanner.scanBarcode(
            '#34CAF0', '', false, ScanMode.QR));
    if (!mounted) return;
    Navigator.pop(context);
  }

  //======================== VALIDA SCANQRgUARDIA =======================//
  void _validaScanQRCliente(TurnoExtraController turnoExtraController) async {
    turnoExtraController.setInfoQRCliente(
        await FlutterBarcodeScanner.scanBarcode(
            '#34CAF0', '', false, ScanMode.QR));
    if (!mounted) return;
    Navigator.pop(context);
  }
}
