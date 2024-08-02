import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/sugerencias_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/notifications_service.dart';

import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class CrearSugerencia extends StatefulWidget {
  final Session? usuario;
  final String? action;
  const CrearSugerencia({Key? key, this.usuario, this.action})
      : super(key: key);

  @override
  State<CrearSugerencia> createState() => _CrearSugerenciaState();
}

class _CrearSugerenciaState extends State<CrearSugerencia> {
  TextEditingController _fechaCreacionController = TextEditingController();
  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();

  @override
  void dispose() {
    _fechaCreacionController.clear();
    _fechaInicioController.clear();
    _fechaFinController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('la accion es: ${widget.action}');
    Responsive size = Responsive.of(context);
    final _controller = context.read<SugerenciasController>();
      final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
          title: widget.action == 'CREATE'
              ? Text(
                  'Crear Sugerencia',
                  // style: Theme.of(context).textTheme.headline2,
                )
              : Text(
                  'Editar Sugerencia',
                  // style: Theme.of(context).textTheme.headline2,
                ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    _onSubmit(context, _controller, widget.action.toString());
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
              key: _controller.sugerenciasFormKey,
              child: Column(
                children: [
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha:',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<SugerenciasController>(
                        builder: (_, valueFecha, __) {
                          return Row(
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
                                    _selectFechaCreacion(context, _controller);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        valueFecha.getInputfechaCreacion,
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.iScreen(1.0),
                                      ),
                                      Consumer<ThemeApp>(
                                          builder: (_, value, __) {
                                        return Icon(
                                          Icons.date_range_outlined,
                                          color: value.primaryColor,
                                          size: 30,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ]);
                        },
                      ),
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //*****************************************/

                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      'Remite: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //*****************************************/
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${widget.usuario!.nombre}',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Área :',
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
                          child: Consumer<SugerenciasController>(
                            builder: (_, persona, __) {
                              return (persona.getLabelArea == '' ||
                                      persona.getLabelArea == null)
                                  ? Text(
                                      'No hay área seleccionada',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )
                                  : Text(
                                      '${persona.getLabelArea} ',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      // _action == 'EXTRA' || _action == 'MULTA'||_action == 'CREATE'
                      //     ? Container()
                      //     :
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(onTap: () {
                          _modalSeleccionArea(size, _controller);
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
                      )
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //*****************************************/

                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Row(
                      children: [
                        Text(
                          'Recetor: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                        Consumer<SugerenciasController>(
                          builder: (_, value, __) {
                            return value.getListaDataArea.isEmpty
                                ? const SizedBox()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(onTap: () {
                                    
                                      _modalSeleccionAreaItems(
                                          size,
                                          _controller,
                                          _controller.getListaDataArea);

                                    
                                     
                                    }, child: Consumer<ThemeApp>(
                                      builder: (_, valueTheme, __) {
                                        return Container(
                                          alignment: Alignment.center,
                                          color: valueTheme.primaryColor,
                                          width: size.iScreen(3.0),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.3),
                                            bottom: size.iScreen(0.3),
                                            left: size.iScreen(0.3),
                                            right: size.iScreen(0.3),
                                          ),
                                          child: Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color:
                                                valueTheme.secondaryColor,
                                            size: size.iScreen(2.0),
                                          ),
                                        );
                                      },
                                    )),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //*****************************************/
                  Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                      width: size.wScreen(100.0),
                      child: Consumer<SugerenciasController>(
                        builder: (_, value, __) {
                          return Text(
                            value.getReceptor == null ||
                                    value.getReceptor!.isEmpty
                                ? '- - -   - - -  - - -   - - -   - - - - '
                                : '${value.getReceptor}',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(1.8),
                                color: value.getReceptor == null ||
                                        value.getReceptor!.isEmpty
                                    ? Colors.grey
                                    : Colors.black87,
                                fontWeight: value.getReceptor == null ||
                                        value.getReceptor!.isEmpty
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          );
                        },
                      )),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),
                    child: Text('Asunto:',
                        style: GoogleFonts.lexendDeca(
                            fontWeight: FontWeight.normal, color: Colors.grey)),
                  ),
                  TextFormField(
                    initialValue: widget.action == 'CREATE'
                        ? ''
                        : _controller.getAsunto,
                    decoration: const InputDecoration(),
                    textAlign: TextAlign.start,
                    minLines: 1,
                    maxLines: 3,
                    style: const TextStyle(),
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                    ],
                    onChanged: (text) {
                      _controller.onAsuntoChange(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese asunto';
                      }
                    },
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),
                    child: Text('Detalle:',
                        style: GoogleFonts.lexendDeca(
                            fontWeight: FontWeight.normal, color: Colors.grey)),
                  ),
                  TextFormField(
                    initialValue: widget.action == 'CREATE'
                        ? ''
                        : _controller.getInputDetalle,
                    decoration: const InputDecoration(),
                    textAlign: TextAlign.start,
                    minLines: 1,
                    maxLines: 3,
                    style: const TextStyle(),
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                    ],
                    onChanged: (text) {
                      _controller.onDetalleChange(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese detalle';
                      }
                    },
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
                          child: Consumer<SugerenciasController>(
                            builder: (_, persona, __) {
                              return (persona.labelMotivoSugerencia == '' ||
                                      persona.labelMotivoSugerencia == null)
                                  ? Text(
                                      'No hay motivo seleccionado',
                                      style: GoogleFonts.lexendDeca(
                                          // fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )
                                  : Text(
                                      '${persona.labelMotivoSugerencia} ',
                                      style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      // _action == 'EXTRA' || _action == 'MULTA'||_action == 'CREATE'
                      //     ? Container()
                      //     :
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(onTap: () {
                          _modalSeleccionaMotivo(size, _controller);
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
                      )
                    ],
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Tiempo de Atención:',
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
                          Consumer<SugerenciasController>(
                            builder: (_, valueFecha, __) {
                              return Row(
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
                                        _selectFechaInicio(
                                            context, _controller);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            valueFecha.getInputfechaInicio,
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.iScreen(1.0),
                                          ),
                                          Consumer<ThemeApp>(
                                              builder: (_, value, __) {
                                            return Icon(
                                              Icons.date_range_outlined,
                                              color: value.primaryColor,
                                              size: 30,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ]);
                            },
                          ),
                        ],
                      ),
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
                          Consumer<SugerenciasController>(
                            builder: (_, valueFecha, __) {
                              return Row(
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
                                        _selectFechaFin(context, _controller);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            valueFecha.getInputfechaFin,
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.iScreen(1.0),
                                          ),
                                          Consumer<ThemeApp>(
                                              builder: (_, value, __) {
                                            return Icon(
                                              Icons.date_range_outlined,
                                              color: value.primaryColor,
                                              size: 30,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ]);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  // //***********************************************/
                  // SizedBox(
                  //   height: size.iScreen(1.0),
                  // ),
                  // //*****************************************/
                  // Container(
                  //   width: size.wScreen(100.0),

                  //   // color: Colors.blue,
                  //   child: Text('Subir Documento:',
                  //       style: GoogleFonts.lexendDeca(
                  //           // fontSize: size.iScreen(2.0),
                  //           fontWeight: FontWeight.normal,
                  //           color: Colors.grey)),
                  // ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         // color: Colors.red,
                  //         padding: EdgeInsets.only(
                  //           top: size.iScreen(0.0),
                  //           right: size.iScreen(0.5),
                  //         ),
                  //         child: Consumer<SugerenciasController>(
                  //           builder: (_, _doc, __) {
                  //             return (_doc.getDocumento == '' ||
                  //                     _doc.getDocumento == null)
                  //                 ? Text(
                  //                     'No hay documeto seleccionado',
                  //                     style: GoogleFonts.lexendDeca(
                  //                         // fontSize: size.iScreen(1.8),
                  //                         fontWeight: FontWeight.bold,
                  //                         // color: Colors.grey,
                  //                         ),
                  //                   )
                  //                 : Row(
                  //                   children: [
                  //                      ClipRRect(
                  //       borderRadius: BorderRadius.circular(8),
                  //       child: GestureDetector(onTap: ()  {

                  //         OpenFile.open(  _controller.getDocumentoUrl.toString());
                  //       }, child: Consumer<AppTheme>(
                  //         builder: (_, valueTheme, __) {
                  //           return Container(
                  //             alignment: Alignment.center,
                  //             color: Colors.transparent,
                  //             width: size.iScreen(3.5),
                  //             padding: EdgeInsets.only(
                  //               top: size.iScreen(0.5),
                  //               bottom: size.iScreen(0.5),
                  //               left: size.iScreen(0.5),
                  //               right: size.iScreen(0.5),
                  //             ),
                  //             child: Icon(
                  //               Icons.remove_red_eye_outlined,
                  //               color: Colors.green,
                  //               size: size.iScreen(2.5),
                  //             ),
                  //           );
                  //         },
                  //       )),
                  //     ),
                  //                      ClipRRect(
                  //       borderRadius: BorderRadius.circular(8),
                  //       child: GestureDetector(onTap: ()  {

                  //         _controller.setDocumento('');

                  //         // OpenFile.open(file.path);
                  //       }, child: Consumer<AppTheme>(
                  //         builder: (_, valueTheme, __) {
                  //           return Container(
                  //             alignment: Alignment.center,
                  //             color: Colors.transparent,
                  //             width: size.iScreen(3.5),
                  //             padding: EdgeInsets.only(
                  //               top: size.iScreen(0.5),
                  //               bottom: size.iScreen(0.5),
                  //               left: size.iScreen(0.5),
                  //               right: size.iScreen(0.5),
                  //             ),
                  //             child: Icon(
                  //               Icons.delete_forever_rounded,
                  //               color: Colors.red,
                  //               size: size.iScreen(2.5),
                  //             ),
                  //           );
                  //         },
                  //       )),
                  //     ),
                  //     SizedBox(width: size.wScreen(1.0)),
                  //                     Text(
                  //                         '${_doc.getDocumento} ',
                  //                         style: GoogleFonts.lexendDeca(
                  //                           // fontSize: size.iScreen(1.8),
                  //                           fontWeight: FontWeight.normal,
                  //                           // color: Colors.grey
                  //                         ),
                  //                       ),
                  //                   ],
                  //                 );
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     // _action == 'EXTRA' || _action == 'MULTA'||_action == 'CREATE'
                  //     //     ? Container()
                  //     //     :

                  //             ClipRRect(
                  //       borderRadius: BorderRadius.circular(8),
                  //       child: GestureDetector(onTap: () async {
                  //         final _result = await FilePicker.platform.pickFiles(
                  //           type: FileType.custom,
                  //           allowedExtensions: ['pdf'],
                  //         );
                  //         if (_result == null) return;
                  //         final file = _result.files.first;

                  //         print('NAME: ${file.name}');
                  //         print('Bytes: ${file.bytes}');
                  //         print('SIZE: ${file..size}');
                  //         print('EXTENSION: ${file.extension}');
                  //         print('PATH: ${file.path}');

                  //         _controller.setDocumento(file.name);
                  //         _controller.setDocumentoUrl(file.path.toString());

                  //         // OpenFile.open(file.path);
                  //       }, child: Consumer<AppTheme>(
                  //         builder: (_, valueTheme, __) {
                  //           return Container(
                  //             alignment: Alignment.center,
                  //             color: valueTheme.getPrimaryTextColor,
                  //             width: size.iScreen(3.5),
                  //             padding: EdgeInsets.only(
                  //               top: size.iScreen(0.5),
                  //               bottom: size.iScreen(0.5),
                  //               left: size.iScreen(0.5),
                  //               right: size.iScreen(0.5),
                  //             ),
                  //             child: Icon(
                  //               Icons.note_add,
                  //               color: valueTheme.getSecondryTextColor,
                  //               size: size.iScreen(2.0),
                  //             ),
                  //           );
                  //         },
                  //       )),
                  //     )

                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

//******************************************************FECHA DE CREACION DE LA SUGERENCIA********************************************//

  _selectFechaCreacion(
      BuildContext context, SugerenciasController sugerenciaController) async {
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

      final _fechaCreacion =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaCreacionController.text = _fechaCreacion;
      sugerenciaController.onInputFechaCreacionChange(_fechaCreacion);
    }
  }

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaInicio(
      BuildContext context, SugerenciasController sugerenciaController) async {
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
      sugerenciaController.onInputFechaInicioChange(_fechaInicio);
    }
  }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  _selectFechaFin(
      BuildContext context, SugerenciasController sugerenciaController) async {
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

      final _fechaFin =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaFinController.text = _fechaFin;
      sugerenciaController.onInputFechaFinChange(_fechaFin);
    }
  }

  //====== MUESTRA MODAL DE PTOCESO =======//
  void _modalSeleccionArea(
      Responsive size, SugerenciasController sugerenciaController) {
    final _data = [
      "LOGISTICA",
      "ADMINISTRACION",
      "GERENTE",
      "ASISTENTE DE GERENCIA",
      "JEFE DE OPERACIONES",
      "COMPRAS PUBLICAS",
      "CONTADOR",
      "SECRETARIA",
      "SERVICIOS VARIOS",
      "OTROS",
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
                      Text('SELECCIONAR ÁREA',
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
                            sugerenciaController.setReceptor('');
                            sugerenciaController.setListataDataArea([]);
                            sugerenciaController.setLabelArea(_data[index]);
                            sugerenciaController.buscaListaDataArea('');

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

  //====== MUESTRA MODAL DE PTOCESO =======//
  void _modalSeleccionAreaItems(
      Responsive size, SugerenciasController sugerenciaController, List items) {
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
                      Text('SELECCIONAR RECEPTOR',
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
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            sugerenciaController.setIdReceptor(
                                items[index]['perId'].toString());
                            sugerenciaController.setCedReceptor(
                                items[index]['perDocNumero'].toString());
                            sugerenciaController.setReceptor(
                                '${items[index]['perNombres']} ${items[index]['perApellidos']}');

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
                              '${items[index]['perNombres']} ${items[index]['perApellidos']}',
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

  //====== MUESTRA MODAL DE PTOCESO =======//
  void _modalSeleccionaMotivo(
      Responsive size, SugerenciasController sugerenciaController) {
    final _data = [
      "SUGERENCIA",
      "QUEJA",
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
                            sugerenciaController
                                .setLabelMotivoSugerencia(_data[index]);
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

//********************************************************************************************************************//
  void _onSubmit(BuildContext context, SugerenciasController controller,
      String? _action) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getLabelArea == null || controller.getLabelArea == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Área');
      } else if (controller.labelMotivoSugerencia == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo');
      } else if (controller.getReceptor!.isEmpty ||
          controller.getReceptor == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Receptor');
      } else if (controller.getLabelArea!.isNotEmpty ||
          controller.getLabelArea != null &&
              controller.labelMotivoSugerencia!.isNotEmpty ||
          controller.labelMotivoSugerencia != null &&
              controller.getReceptor!.isNotEmpty ||
          controller.getReceptor != null) {
        if (_action == 'CREATE') {
          await controller.creaSugerencia(context);

          Navigator.pop(context);
        } else if (_action == 'EDIT') {
          await controller.editarSugerencia(context);
          Navigator.pop(context);
        }
      }
    }
  }
}
