import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class CreaCambioDePuesto extends StatefulWidget {
  const CreaCambioDePuesto({Key? key}) : super(key: key);

  @override
  State<CreaCambioDePuesto> createState() => _CreaCambioDePuestoState();
}

class _CreaCambioDePuestoState extends State<CreaCambioDePuesto> {
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _horaInicioController = TextEditingController();
  late TimeOfDay timeInicio;

  @override
  void initState() {
    timeInicio = TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    _fechaInicioController.clear();
    _horaInicioController.clear();
    // _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avisoSalidaController =
        Provider.of<AvisoSalidaController>(context, listen: false);
    final cambioPuestoController =
        Provider.of<CambioDePuestoController>(context, listen: false);
    Responsive size = Responsive.of(context);

  final _user=context.read<HomeController>();

  final ctrlTheme = context.read<ThemeApp>();
        

    return SafeArea(
      child: Scaffold(
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
            'Nuevo Puesto',
            // style:  Theme.of(context).textTheme.headline2,
           
          ),
         
          actions: [
          Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    _onSubmit(context, cambioPuestoController);
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    size: size.iScreen(4.0),
                  )),
            )
            
          ],
        ),
        body: Container(
          // color: Colors.red,
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
              key: cambioPuestoController.cambioPuestoFormKey,
              child: Column(children: [
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
                  height: size.iScreen(1.0),
                ),
                //*****************************************/

                SizedBox(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child: Text('Guardia :',
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
                        child: Consumer<CambioDePuestoController>(
                          builder: (_, persona, __) {
                            return (persona.nombreGuardia == '' ||
                                    persona.nombreGuardia == null)
                                ? Text(
                                    'No hay guardia designado',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    '${persona.nombreGuardia} ',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.grey
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          _modalSeleccionaGuardia(size, avisoSalidaController,
                              cambioPuestoController);
                        },
                        child:  Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
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
                                    )
                      ),
                    ),
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                (cambioPuestoController.puestosServicioGuardia != null)
                    ? Consumer<CambioDePuestoController>(
                        builder: (_, valuePuestos, __) {
                          return Column(
                            children: [
                              SizedBox(
                                width: size.wScreen(100.0),

                                // color: Colors.blue,
                                child: Text('Puesto de Servicio :',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              (valuePuestos.puestosServicioGuardia!.isNotEmpty)
                                  ? Container(
                                      height: size.iScreen(valuePuestos
                                              .puestosServicioGuardia!.length *
                                          5.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: valuePuestos
                                            .puestosServicioGuardia!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final servicio = valuePuestos
                                              .puestosServicioGuardia![index];
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.iScreen(0.1)),
                                            color: Colors.grey.shade300,
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.iScreen(0.5)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Puesto: ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                    Expanded(
                                                      child: Text(
                                                          '${servicio['puesto']}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Cliente: ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .grey)),
                                                    Expanded(
                                                      child: Text(
                                                          '${servicio['razonsocial']}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                            // fontSize: size.iScreen(2.0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                    // color: Colors.green,
                                    margin: EdgeInsets.only(
                                                top: size.iScreen(1.0)),
                                    width: size.wScreen(100.0),
                                    child: Text(
                                      'No hay puesto designado',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.7),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                            ],
                          );
                        },
                      )
                    : Container(
                        width: size.wScreen(100.0),
                        child: Text('Puesto de Servicio :',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    SizedBox(
                      // width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Buscar Cliente ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    //***********************************************/
                    SizedBox(
                      width: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Consumer<CambioDePuestoController>(
                      builder: (_, value, __) {
                        return (value.nombreGuardia != '' ||
                                value.nombreGuardia != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    value.resetDropDown();
                                    _modalSeleccionaCliente(size, value);
                                  },
                                  child:  Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
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
                                    )
                                ),
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                SizedBox(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child: Text('Nuevo Cliente:',
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
                        child: Consumer<CambioDePuestoController>(
                          builder: (_, persona, __) {
                            return (persona.nombreCliente == '' ||
                                    persona.nombreCliente == null)
                                ? Text(
                                    'No hay cliente designado',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    '${persona.nombreCliente} ',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.grey
                                    ),
                                  );
                          },
                        ),
                      ),
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
                  child: Text('Nuevo Puesto:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.iScreen(2.0), vertical: size.iScreen(0)),
                  width: size.wScreen(100),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Consumer<CambioDePuestoController>(
                      builder: (_, puesto, __) {
                        return DropdownButton(
                          isExpanded: true,
                          hint: Text('Seleccione Puesto',
                              // estadoCompra.tipoDoc.toString(),
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              )),
                          items: (puesto.getListaPuestosNuevoCliente.isNotEmpty)
                              ? puesto.getListaPuestosNuevoCliente
                                  .map((e) => DropdownMenuItem(
                                        child: Center(
                                            child: Text(e['puesto'],
                                                textAlign: TextAlign.center)),
                                        value: e['puesto'],
                                      ))
                                  .toList()
                              : null,
                          value: puesto.labelNuevoPuesto,
                          onChanged: (value) {
                            // puesto.setPuestoNuevoCliente(value.toString());
                            puesto.setLabelINuevoPuesto(value.toString());
                          },
                        );
                      },
                    ),
                  ),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Fecha cambio de puesto:',
                      style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                     
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      
                                      SizedBox(
                                        width: size.iScreen(1.0),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                               FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                     _selectFecha(context, cambioPuestoController);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              cambioPuestoController.getInputfecha, 
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.iScreen(1.0),
                                            ),
                                           
                                              Consumer<ThemeApp>(builder: (_, value, __) { 
                                                  return  Icon(
                                                  Icons.date_range_outlined,
                                                  color:value.primaryColor,
                                                  size: 30,
                                                );
                                                 }),
                                          ],
                                        ),
                                      ),
                                    ])
                           
                  
                  ],
                ),
               
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Container(
                  width: size.wScreen(100.0),

                  child: Text('Motivo:',
                      style: GoogleFonts.lexendDeca(
                         fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                     ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(

                      ),
                  textInputAction: TextInputAction.done,
                         inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@#-+.,{""}\\s]")),],
                      
                  onChanged: (text) {
                    cambioPuestoController.onDetalleChange(text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Ingrese detalle del cambio';
                    }
                  },
                ),
                SizedBox(
                  height: size.iScreen(3.0),
                ),
              ]),
            ),
          ),
        ),
       
      ),
    );
  }

//================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFecha(BuildContext context,
      CambioDePuestoController cambioDePuestoController) async {
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

      // setState(() {
      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaInicioController.text = _fechaInicio;
      cambioDePuestoController.onInputFechaChange(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

  void _seleccionaHora(
      context, CambioDePuestoController cambioDePuestoController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeInicio);

    if (_hora != null) {
      String? dateHora = (_hora.hour < 10) ? '0${_hora.hour}' : '${_hora.hour}';
      String? dateMinutos =
          (_hora.minute < 10) ? '0${_hora.minute}' : '${_hora.minute}';

      setState(() {
        timeInicio = _hora;
        String horaInicio = '${dateHora}:${dateMinutos}';
        _horaInicioController.text = horaInicio;
        cambioDePuestoController.onInputHoraChange(horaInicio);
        //  print('si: $horaInicio');
      });
    }
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaGuardia(
      Responsive size,
      AvisoSalidaController avisontroller,
      CambioDePuestoController cambioDePuestoController) {
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
                  Text('SELECCIONAR  GUARDIA',
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
                          _validaScanQRGuardia(cambioDePuestoController);
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
                          avisontroller.buscaInfoGuardias('');
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'buscaGuardias',
                              arguments: 'cambioPuesto');
                          // Navigator.pop(context);
                        }
                        // Navigator.pop(context);
                        ,
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
  void _modalSeleccionaCliente(
      Responsive size, CambioDePuestoController cambioDePuestoController) {
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
                  Text('SELECCIONAR  CLIENTE',
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
                          //  _validaScanQRCliente(cambioDePuestoController);
                         
                        },
                      ),
                      const Divider(),
                      ListTile(
                          tileColor: Colors.grey[200],
                          leading: const Icon(Icons.badge_outlined,
                              color: Colors.black),
                          title: Text(
                            "Nómina de Clientes",
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right_outlined),
                          onTap: () {
                            cambioDePuestoController.getTodosLosClientes('');
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'buscaClientes',
                                arguments: 'cambioPuesto');
                          }),
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

  //********************************************************************************************************************//
  void _onSubmit(
      BuildContext context, CambioDePuestoController controller) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.labelNuevoPuesto == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Puesto');
      } else {
        await controller.crearCambioPuesto(context);
        Navigator.pop(context);
      }
     
    }
  }

  void bottomSheet(
    AvisoSalidaController avisoSalidaController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
            
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    // urls.launchWaze(lat, lng);s
                    _funcionCamara(ImageSource.camera, avisoSalidaController);
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
                    _funcionCamara(ImageSource.gallery, avisoSalidaController);
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

  void bottomSheetVideo(
    AvisoSalidaController avisoSalidaController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
            

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamaraVideo(
                        ImageSource.camera, avisoSalidaController);
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
                    _funcionCamaraVideo(
                        ImageSource.gallery, avisoSalidaController);
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

  void _funcionCamara(
      ImageSource source, AvisoSalidaController avisoSalidaController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    avisoSalidaController.setNewPictureFile('${pickedFile.path}');

    Navigator.pop(context);

  }

  void _funcionCamaraVideo(
      ImageSource source, AvisoSalidaController avisoSalidaController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(
      source: source,
    );

    if (pickedFile == null) {
      return;
    }
   avisoSalidaController.setPathVideo(pickedFile.path);
 Navigator.pop(context);

  }

  //======================== VALIDA SCANQRgUARDIA =======================//
  void _validaScanQRGuardia(
      CambioDePuestoController cambioPuestoController) async {
    cambioPuestoController.setInfoQRGuardia(
        await FlutterBarcodeScanner.scanBarcode(
            '#34CAF0', '', false, ScanMode.QR));
    if (!mounted) return;
    Navigator.pop(context);
  }



}

class _CamaraOption extends StatefulWidget {
  final AvisoSalidaController avisoSalidaController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.avisoSalidaController,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<AvisoSalidaController>(
        builder: (_, fotoUrl, __) {
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
                    Text('Fotografía:  ${fotoUrl.getListaFotosUrl!.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
              ),
              SingleChildScrollView(
                child:
                  
                    Wrap(
                        children: fotoUrl.getListaFotosUrl!
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
                                          fotoUrl.eliminaFotoUrl(e['url']);
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
              ),
            ],
          );
        },
      ),
      onTap: () {
      },
    );
  }
}

class _CamaraVideo extends StatelessWidget {
  const _CamaraVideo({
    Key? key,
    required this.size,
    required this.avisoSalidaController,
  }) : super(key: key);

  final Responsive size;
  final AvisoSalidaController avisoSalidaController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AvisoSalidaController>(
      builder: (_, valueVideo, __) {
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
            Card(
              child: Row(
                children: [
                  //***********************************************/
                  SizedBox(
                    width: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  GestureDetector(
                    onTap: () {
                      valueVideo.eliminaVideo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: size.iScreen(0.5)),
                      child: const Icon(Icons.delete_forever_outlined,
                          color: Colors.red),
                    ),
                  ),
                  Icon(
                    Icons.video_file_outlined,
                    size: size.iScreen(5.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'videoSreen',
                          arguments: '${valueVideo.getUrlVideo}');
                    },
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(1.0),
                            vertical: size.iScreen(1.0)),
                        child: Text(
                          'Video seleccionado',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.7),
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
