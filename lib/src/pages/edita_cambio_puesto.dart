import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/dropdown_estado_cambio_puesto.dart';

import 'package:provider/provider.dart';

class EditaCambioDePuesto extends StatefulWidget {
  final String? fecha;
  const EditaCambioDePuesto({Key? key, this.fecha}) : super(key: key);

  @override
  State<EditaCambioDePuesto> createState() => _EditaCambioDePuestoState();
}

class _EditaCambioDePuestoState extends State<EditaCambioDePuesto> {
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _horaInicioController = TextEditingController();
  late TimeOfDay timeInicio;
  List<String> data = ['ANULADO', 'PENDIENTE'];

  @override
  void initState() {
    timeInicio = TimeOfDay.now();

    List<String>? dataFecha = widget.fecha!.split('T');

    _fechaInicioController.text = dataFecha[0];
    // _horaInicioController.text = dataFecha[1];
    super.initState();
  }

  @override
  void dispose() {
    _fechaInicioController.clear();
    _horaInicioController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avisoSalidaController =
        Provider.of<AvisoSalidaController>(context, listen: false);
    final cambioPuestoController =
        Provider.of<CambioDePuestoController>(context, listen: false);
    Responsive size = Responsive.of(context);
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
            'Edita Cambio de Puesto',
            // style: Theme.of(context).textTheme.headline2,
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
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      // width: size.wScreen(100.0),
                      child: Text(
                        'Estado: ',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      width: size.wScreen(60.0),
                      child: DropMenuEstadoCambioPuesto(
                        // title: 'Tipo de documento:',
                        data: data,
                        hinText: 'Seleccione',
                      ),
                    ),
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
                  child: Text('Guardia :',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                Container(
                  // color: Colors.red,
                  width: size.iScreen(100),
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
                              '${persona.nombreGuardia}',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.7),
                                fontWeight: FontWeight.normal,
                                // color: Colors.grey
                              ),
                            );
                    },
                  ),
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
                                  : SizedBox(),
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
                SizedBox(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child: Text('Cliente:',
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
                  child: Text('Puesto:',
                      style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.normal, color: Colors.grey)),
                ),
                Container(
                  width: size.wScreen(100.0),
                  child: Text(
                    '{persona.nombreCliente} ',
                    style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(1.7),
                      fontWeight: FontWeight.normal,
                      // color: Colors.grey
                    ),
                  ),
                ),

                //*****************************************/
                SizedBox(
                  height: size.iScreen(2.0),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Fecha de cambio de puesto:',
                      style: GoogleFonts.lexendDeca(
                        // fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: size.wScreen(35),
                      margin:
                          EdgeInsets.symmetric(horizontal: size.wScreen(3.5)),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        controller: _fechaInicioController,
                        decoration: const InputDecoration(
                          hintText: 'yyyy-mm-dd',
                          hintStyle: TextStyle(color: Colors.black38),
                          suffixIcon: IconButton(
                            color: Colors.red,
                            splashRadius: 20,
                            onPressed: null,
                            icon: Icon(
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
                            return 'Ingrese fecha del cambio';
                          }
                        },
                        style: const TextStyle(),
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
                  child: Text('Motivo:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: cambioPuestoController.getInputDetalle,
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
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

      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaInicioController.text = _fechaInicio;
      cambioDePuestoController.onInputFechaChange(_fechaInicio);
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
      Responsive size, AvisoSalidaController avisontroller) {
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
                        onTap: () async {},
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
                        onTap: () async {},
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
        await controller.editarCambioTurno(context);
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
                child: Wrap(
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
      onTap: () {},
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
