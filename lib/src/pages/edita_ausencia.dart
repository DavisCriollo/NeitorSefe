import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/dropdown_motivo_ausencia.dart';
import 'package:provider/provider.dart';

class EditarAusencia extends StatefulWidget {
  final String? fechaInicio;
  final String? fechaFin;
  const EditarAusencia({Key? key, this.fechaInicio, this.fechaFin})
      : super(key: key);

  @override
  State<EditarAusencia> createState() => _EditarAusenciaState();
}

class _EditarAusenciaState extends State<EditarAusencia> {
  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _horaInicioController = TextEditingController();
  TextEditingController _horaFinController = TextEditingController();

  late TimeOfDay timerInicio;
  late TimeOfDay timerFin;

  @override
  void initState() {
    initload();
    super.initState();
  }

  void initload() async {
    timerInicio = TimeOfDay.now();
    timerFin = TimeOfDay.now();

    List<String>? dataFechaInicio = widget.fechaInicio!.split('T');

    _fechaInicioController.text = dataFechaInicio[0];
    _horaInicioController.text = dataFechaInicio[1];
    List<String>? dataFechaFin = widget.fechaFin!.split('T');

    _fechaFinController.text = dataFechaFin[0];
    _horaFinController.text = dataFechaFin[1];
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
    Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    final ausenciaController = Provider.of<AusenciasController>(context);
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
        title: Text(
          'Editar Permiso',
          // style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: size.iScreen(1.5)),
            child: IconButton(
                splashRadius: 28,
                onPressed: () {
                  _onSubmit(context, ausenciaController);
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
            key: ausenciaController.ausenciasFormKey,
            child: Column(
              children: [
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
                  width: size.wScreen(100),
                  // color: Colors.red,
                  padding: EdgeInsets.only(
                    top: size.iScreen(1.0),
                    right: size.iScreen(0.5),
                  ),
                  child: Consumer<AusenciasController>(
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

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    SizedBox(
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

                    Consumer<AusenciasController>(
                      builder: (_, value, __) {
                        return (value.nombreGuardia != '' ||
                                value.nombreGuardia != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CambioDePuestoController>()
                                        .getTodosLosClientes('');
                                    Navigator.pushNamed(
                                        context, 'buscaClientes',
                                        arguments: 'crearPermiso');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: primaryColor,
                                    width: size.iScreen(3.5),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.search_outlined,
                                      color: Colors.white,
                                      size: size.iScreen(2.8),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    )
                  ],
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
                        child: Consumer<AusenciasController>(
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
                  child: Text('Motivo:',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                const DropMenuMotivoAusencia(
                  data: [
                    'ENFERMEDAD IESS',
                    'PERMISO PERSONAL',
                    'PATERNIDAD',
                    'DEFUNCIÓN FAMILIAR',
                    'INJUSTIFICADA',
                  ],
                  hinText: 'seleccione Motivo',
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Desde:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: size.wScreen(35),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.wScreen(3.5)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: _fechaInicioController,
                            decoration: InputDecoration(
                              hintText: 'yyyy-mm-dd',
                              hintStyle: const TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _selectFechaInicio(
                                      context, ausenciaController);
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
                                return 'Ingrese fecha de inicio';
                              }
                            },
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hora:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: size.wScreen(35),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.wScreen(3.5)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: _horaInicioController,
                            decoration: InputDecoration(
                              hintText: '00:00',
                              hintStyle: const TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _seleccionaHoraInicio(
                                      context, ausenciaController);
                                  // _selectFechaFin(
                                  //     context, consignaController);
                                },
                                icon: const Icon(
                                  Icons.access_time_outlined,
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
                                return 'Ingrese hora de inicio';
                              }
                            },
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //***********************************************/

                SizedBox(
                  height: size.iScreen(2.0),
                ),

                //*******************FECHA HORA HASTA **********************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Hasta:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: size.wScreen(35),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.wScreen(3.5)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: _fechaFinController,
                            decoration: InputDecoration(
                              hintText: 'yyyy-mm-dd',
                              hintStyle: const TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _selectFechaFin(context, ausenciaController);
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
                                return 'Ingrese fecha de límite';
                              }
                            },
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Hora:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: size.wScreen(35),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.wScreen(3.5)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            readOnly: true,
                            controller: _horaFinController,
                            decoration: InputDecoration(
                              hintText: '00:00',
                              hintStyle: const TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _seleccionaHoraFin(
                                      context, ausenciaController);
                                  // _selectFechaFin(
                                  //     context, consignaController);
                                },
                                icon: const Icon(
                                  Icons.access_time_outlined,
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
                                return 'Ingrese hora Límite';
                              }
                            },
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                      child: TextFormField(
                        initialValue: ausenciaController.getInputNumeroDias,
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(),
                        onChanged: (text) {
                          ausenciaController.onNumeroDiasChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese días';
                          }
                        },
                      ),
                    ),
                  ],
                ),
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
                  initialValue: ausenciaController.getInputDetalle,
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                  onChanged: (text) {
                    ausenciaController.onDetalleChange(text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Ingrese detalle del aviso';
                    }
                  },
                ),

                Consumer<AusenciasController>(
                  builder: (_, fotos, __) {
                    return fotos.getListaFotosUrl!.isNotEmpty
                        ? _CamaraOption(size: size, ausenciasController: fotos)
                        : Container();
                  },
                ),

                //*****************************************/
                //***********************************************/
                SizedBox(
                  width: size.iScreen(1.0),
                ),
                //*****************************************/
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              bottomSheet(ausenciaController, context, size);
            },
            backgroundColor: Colors.purpleAccent,
            heroTag: "btnCamara",
            child: const Icon(Icons.camera_alt_outlined),
          ),
          SizedBox(
            height: size.iScreen(1.5),
          ),
          //********************VIDEO***************************//

          SizedBox(
            height: size.iScreen(1.5),
          ),

          SizedBox(
            height: size.iScreen(1.5),
          ),
        ],
      ),
    );
  }

  void bottomSheet(
    AusenciasController informeController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.camera, informeController);
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
                    _funcionCamara(ImageSource.gallery, informeController);
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

  void _funcionCamara(
      ImageSource source, AusenciasController informeController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    informeController.setNewPictureFile('${pickedFile.path}');

    Navigator.pop(context);
  }

//********************************************************************************************************************//
  void _onSubmit(BuildContext context, AusenciasController controller) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.labelMotivoAusencia == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo');
      } else {
        await controller.editaAusencia(context);
        Navigator.pop(context);
      }
    }
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaPersona(
      Responsive size, AusenciasController ausenciasController) {
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
                  Text('SELECCIONAR ',
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
                          Navigator.pop(context);
                          Provider.of<AvisoSalidaController>(context,
                                  listen: false)
                              .buscaInfoGuardias('');
                          Navigator.pushNamed(context, 'buscaGuardias',
                              arguments: 'ausencia');
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
  _selectFechaInicio(
      BuildContext context, AusenciasController ausenciasController) async {
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
      ausenciasController.onInputFechaInicioChange(_fechaInicio);
    }
  }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  _selectFechaFin(
      BuildContext context, AusenciasController ausenciasController) async {
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
        ausenciasController.onInputFechaFinChange(_fechaFin);
      });
    }
  }

  void _seleccionaHoraInicio(
      context, AusenciasController ausenciasController) async {
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
        ausenciasController.onInputHoraInicioChange(horaInicio);
      });
    }
  }

  void _seleccionaHoraFin(
      context, AusenciasController ausenciasController) async {
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
        ausenciasController.onInputHoraFinChange(horaFin);
      });
    }
  }
}

class _CamaraOption extends StatefulWidget {
  final AusenciasController ausenciasController;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.ausenciasController,
  }) : super(key: key);

  final Responsive size;

  @override
  State<_CamaraOption> createState() => _CamaraOptionState();
}

class _CamaraOptionState extends State<_CamaraOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<AusenciasController>(
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
