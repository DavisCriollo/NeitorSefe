import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';
import 'package:nseguridad/src/controllers/gestion_documental_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/busca_persona_pedido.dart';
import 'package:nseguridad/src/pages/busca_personal_gestion_documental.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class CreaGestionDocumental extends StatefulWidget {
  final Session? usuario;
  final String? action;

  const CreaGestionDocumental({
    Key? key,
    this.usuario,
    this.action,
  }) : super(key: key);

  @override
  State<CreaGestionDocumental> createState() => _CreaGestionDocumentalState();
}

class _CreaGestionDocumentalState extends State<CreaGestionDocumental> {
  final _controlAsunto = TextEditingController();
  final _controlLugar = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  late TimeOfDay timeFecha;

  @override
  void initState() {
    timeFecha = TimeOfDay.now();

    super.initState();
  }

  late TimeOfDay timeInicio;

  // final _controlPersona = TextEditingController();
  @override
  void dispose() {
    _controlAsunto.dispose();
    _controlLugar.dispose();
    _fechaController.dispose();
    // _controlPersona.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
       

    final _action = widget.action;
    final _controller = context.read<GestionDocumentalController>();
    return WillPopScope(
       onWillPop: () async {
      return await showDialog(
            context: context,
            builder: (context) {
              final _crtl = context.read<GestionDocumentalController>();
              return AlertDialog(
                title: const Text('Aviso'),
                content: const Text('¿Desea cancelar la cración del Acta?'),
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
                      onPressed:_action == 'CREATE'? () async {
                       
                      
                        if ( _crtl.getListaDeContenidos.isNotEmpty) {
                              
                                                        
                                     ProgressDialog.show(context);
                              for (var item in _crtl.getListaDeContenidos) {

                                // print('URLS ${item['foto']}');
                               
                          await  _controller.eliminaUrlServer(item['foto']);
                          
                              }
                            ProgressDialog.dissmiss(context); 


                          Navigator.of(context).pop(true);






                          // await providerTurno.eliminaTurnoExtra(
                          //     int.parse(controllerMulta.getIdTurnoEmergente.toString()));
                          //   controllerMulta.setIdTurnoEmergente('');
                        } else {
                          Navigator.of(context).pop(true);
                        }
                      }:null,
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                      )),
                ],
              );
            }
            );
            },

      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            //  appBar: AppBar(
            //       title: Text(
            //         'Crear Acta de Gestión',
            //         style: Theme.of(context).textTheme.headline2,
            //       ),
            //       actions: [
            //         Container(
            //           margin: EdgeInsets.only(right: size.iScreen(1.5)),
            //           child: IconButton(
            //               splashRadius: 28,
            //               onPressed: () {
            //                 // _onSubmit(size, context, _controller, _action.toString());
            //               },
            //               icon: Icon(
            //                 Icons.save_outlined,
            //                 size: size.iScreen(4.0),
            //               )),
            //         )
            //       ],
            //     ),
            appBar: AppBar(
              // backgroundColor: primaryColor,
              // title:  Text('Registrar Bitácora',style:  Theme.of(context).textTheme.headline2,),
                
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
              title: _action == 'CREATE'
                  ? Text(
                      'Crear Acta de Gestión',
                      // style: Theme.of(context).textTheme.headline2,
                    )
                  : Text(
                      'Editar Acta de Gestión',
                      // style: Theme.of(context).textTheme.headline2,
                    ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(context, _controller, _action!);
                      },
                      icon: Icon(
                        Icons.save_outlined,
                        size: size.iScreen(4.0),
                      )),
                ),
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
                  child: Form(
                    key: _controller.gestionDocFormKey,
                    child: Column(
                      children: [
                        Container(
                            width: size.wScreen(100.0),
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${widget.usuario!.rucempresa!}  ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                                Text('-',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                                Text('  ${widget.usuario!.usuario!} ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                        // Container(
                        //           width: size.wScreen(80.0),
                        //           child: Form(
                        //             key: _controller.gestionDocFormKey,
                        //             child: TextFormField(
                        //               controller: _controlAsunto,
                        //               decoration: const InputDecoration(),
                        //               textAlign: TextAlign.start,
                        //               style: const TextStyle(),
                        //               textInputAction: TextInputAction.done,
                        //               inputFormatters: <TextInputFormatter>[
                        //                 FilteringTextInputFormatter.allow(
                        //                     // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                        //                     RegExp(r'^[^\n"]*$')),
                        //                 UpperCaseText(),
                        //               ],
                        //               onChanged: (text) {
                        //                 _controller.onInputAsuntoChange(text);
                        //               },
                        //               validator: (text) {
                        //                 if (text!.trim().isNotEmpty) {
                        //                   return null;
                        //                 } else {
                        //                   return 'Ingrese persona autorizada';
                        //                 }
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        Consumer<GestionDocumentalController>(
                          builder: (_, valueFecha, __) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tipo: ',
                                    style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(1.8),
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.only(
                                        top: size.iScreen(0.0),
                                        right: size.iScreen(0.5),
                                      ),
                                      child: Consumer<GestionDocumentalController>(
                                        builder: (_, persona, __) {
                                          return (persona.getLabelTipo == '' ||
                                                  persona.getLabelTipo == null)
                                              ? Text(
                                                  '--- --- --- --- --- ---',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.grey),
                                                )
                                              : Text(
                                                  '${persona.getLabelTipo} ',
                                                  style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(2.0),
                                                    fontWeight: FontWeight.normal,
                                                    // color: Colors.grey
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                     
                          //*****************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                  
                        Consumer<GestionDocumentalController>(
                          builder: (_, valueFecha, __) {
                            return Row(
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
                                  SizedBox(
                                    width: size.iScreen(1.0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _fecha(context, valueFecha);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          valueFecha.getInputfecha,
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            // color: Colors.black45,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.iScreen(1.0),
                                        ),
                                        Consumer<ThemeApp>(builder: (_, value, __) {
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
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          width: size.wScreen(100.0),
                  
                          // color: Colors.blue,
                          child: Text('Asunto: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        TextFormField(
                          initialValue: widget.action == 'CREATE'
                              ? ''
                              : _controller.getInputAsunto,
                          decoration: const InputDecoration(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(),
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                RegExp(r'^[^\n"]*$')),
                            UpperCaseText(),
                          ],
                          onChanged: (text) {
                            _controller.onInputAsuntoChange(text);
                          },
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese Asunto';
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
                          child: Text('Lugar: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        TextFormField(
                          initialValue: widget.action == 'CREATE'
                              ? ''
                              : _controller.getInputLugar,
                          decoration: const InputDecoration(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(),
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                RegExp(r'^[^\n"]*$')),
                            UpperCaseText(),
                          ],
                          onChanged: (text) {
                            _controller.onLugarChange(text);
                          },
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese Lugar';
                            }
                          },
                        ),
                  
                        // //*****************************************/
                        // SizedBox(
                        //   height: size.iScreen(2.0),
                        // ),
                  
                        // Consumer<GestionDocumentalController>(
                        //   builder: (_, valueFecha, __) {
                        //     return Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             'Fecha:',
                        //             style: GoogleFonts.lexendDeca(
                        //               // fontSize: size.iScreen(1.8),
                        //               color: Colors.black45,
                        //               // fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: size.iScreen(1.0),
                        //           ),
                        //           GestureDetector(
                        //             onTap: () {
                        //               FocusScope.of(context)
                        //                   .requestFocus(FocusNode());
                        //               _fecha(context, valueFecha);
                        //             },
                        //             child: Row(
                        //               children: [
                        //                 Text(
                        //                   valueFecha.getInputfecha,
                        //                   style: GoogleFonts.lexendDeca(
                        //                     fontSize: size.iScreen(1.8),
                        //                     // color: Colors.black45,
                        //                     fontWeight: FontWeight.normal,
                        //                   ),
                        //                 ),
                        //                 SizedBox(
                        //                   width: size.iScreen(1.0),
                        //                 ),
                        //                 Consumer<ThemeApp>(builder: (_, value, __) {
                        //                   return Icon(
                        //                     Icons.date_range_outlined,
                        //                     color: value.getPrimaryTextColor,
                        //                     size: 30,
                        //                   );
                        //                 }),
                        //               ],
                        //             ),
                        //           ),
                        //         ]);
                        //   },
                        // ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                  
                        Row(
                          children: [
                            Container(
                              width: size.wScreen(25.0),
                  
                              // color: Colors.blue,
                              child: Text('Para el Perfil :',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                            ),
                            Expanded(
                              child: Container(
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.0),
                                  right: size.iScreen(0.5),
                                ),
                                child: Consumer<GestionDocumentalController>(
                                  builder: (_, persona, __) {
                                    return (persona.getLabelPerfil == '' ||
                                            persona.getLabelPerfil == null)
                                        ? Text(
                                            'No hay perfil seleccionada',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.getLabelPerfil} ',
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
                           
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(8),
                            //   child: GestureDetector(onTap: () {
                            //     _modalSeleccioPerfil(size, _controller);
                            //   }, child: Consumer<ThemeApp>(
                            //     builder: (_, valueTheme, __) {
                            //       return Container(
                            //         alignment: Alignment.center,
                            //         color: valueTheme.getPrimaryTextColor,
                            //         width: size.iScreen(3.5),
                            //         padding: EdgeInsets.only(
                            //           top: size.iScreen(0.5),
                            //           bottom: size.iScreen(0.5),
                            //           left: size.iScreen(0.5),
                            //           right: size.iScreen(0.5),
                            //         ),
                            //         child: Icon(
                            //           Icons.add,
                            //           color: valueTheme.getSecondryTextColor,
                            //           size: size.iScreen(2.0),
                            //         ),
                            //       );
                            //     },
                            //   )),
                            // )
                          ],
                        ),
                  
                        Consumer<GestionDocumentalController>(
                          builder: (_, value, __) {
                            return value.getLabelPerfil == '' ||
                                    value.getLabelPerfil == null
                                ? Container()
                                : Column(
                                    children: [
                                      //*****************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Row(
                                        children: [
                                          Container(
                                            // width: size.wScreen(100.0),
                  
                                            // color: Colors.blue,
                                            child: Row(
                                              children: [
                                                Text('Para: ',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey)),
                                                Consumer<
                                                    GestionDocumentalController>(
                                                  builder: (_, value, __) {
                                                    return value.getListaDePersonal
                                                            .isNotEmpty
                                                        ? Text(
                                                            ' ${value.getListaDePersonal.length}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.7),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey))
                                                        : Container();
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: size.iScreen(1.0)),
                                          Consumer<GestionDocumentalController>(
                                            builder: (_, btnprovider, __) {
                                              return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: GestureDetector(onTap: () {
                                                    //   if (btnprovider.getInfoClientePedido[
                                                    //           'cliRazonSocial'] !=
                                                    //       '') {
                                                    //     _modalSeleccionaPersona(
                                                    //         size, btnprovider, 'GUARDIA');
                                                    //   } else {
                                                    //     NotificatiosnService.showSnackBarDanger(
                                                    //         'Debe seleccionar un cliente  primero');
                                                    //   }
                                                    final _ctrl = context.read<
                                                        LogisticaController>();
                                                    _modalSeleccionaPersona(
                                                        size,
                                                        _ctrl,
                                                        '${btnprovider.getLabelPerfil}');
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
                                                  )));
                                              //
                                              // )
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          },
                        ),
                        Consumer<GestionDocumentalController>(
                          builder: (_, valueListaPersonas, __) {
                            return valueListaPersonas.getLabelPerfil!.isNotEmpty &&
                                    valueListaPersonas.getListaDePersonal.isEmpty
                                ? Column(
                                    children: [
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Text('No hay personal seleccionado',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Wrap(
                                        children: valueListaPersonas
                                            .getListaDePersonal
                                            .map((e) => Card(
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          valueListaPersonas
                                                              .eliminarItemListaDePersonal(
                                                                  e['perId']);
                                                          // Provider.of<AvisoSalidaController>(context,
                                                          //         listen: false)
                                                          //     .eliminaGuardiaInformacion(guardia['id']);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              right: size
                                                                  .iScreen(0.5)),
                                                          padding: EdgeInsets.only(
                                                              left: size
                                                                  .iScreen(0.5)),
                                                          child: const Icon(
                                                              Icons
                                                                  .delete_forever_outlined,
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: size
                                                                      .iScreen(1.0),
                                                                  vertical:
                                                                      size.iScreen(
                                                                          1.0)),
                                                          child: Text(
                                                            '${e['perApellidos']} ${e['perNombres']}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.7),
                                                                    // color: Colors.black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  );
                          },
                        ),
                        Consumer<GestionDocumentalController>(
                          builder: (_, value, __) {
                            return value.getLabelPerfil == '' ||
                                    value.getLabelPerfil == null
                                ? Container()
                                : Column(
                                    children: [
                                      //*****************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Row(
                                        children: [
                                          Container(
                                            // width: size.wScreen(100.0),
                  
                                            // color: Colors.blue,
                                            child: Row(
                                              children: [
                                                Text('Agregar Contenido: ',
                                                    style: GoogleFonts.lexendDeca(
                                                        // fontSize: size.iScreen(2.0),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey)),
                                                Consumer<
                                                    GestionDocumentalController>(
                                                  builder: (_, value, __) {
                                                    return value
                                                            .getListaDeContenidos
                                                            .isNotEmpty
                                                        ? Text(
                                                            ' ${value.getListaDeContenidos.length}',
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.7),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey))
                                                        : Container();
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: size.iScreen(1.0)),
                                          Consumer<GestionDocumentalController>(
                                            builder: (_, btnprovider, __) {
                                              return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: GestureDetector(onTap: () {
                                                       _modalAgregaContenido(
                                                        size, btnprovider);
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
                                                  )));
                                              //
                                              // )
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          },
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        //***********************************************/
    
                        Consumer<GestionDocumentalController>(builder: (_, valueListaContenidos, __) { 
                  
                          return  Wrap(children: valueListaContenidos.getListaDeContenidos.map((e) {
                          
                            return Card(
                          child:
                              ExpansionTile( leading: IconButton(
                                splashRadius: 0.1,
                              icon: const Icon(Icons.delete_forever_outlined,color: Colors.red,),
                              onPressed: () async {
                              
    
                         ProgressDialog.show(context);
                           final  response = await  _controller.eliminaUrlServer(e['foto']);
                          
                            ProgressDialog.dissmiss(context); 
                            if (response=='true') {
                              _controller.eliminarItemListaDeContenidos(e['id']);
                            }
                     
                              },
                            ),
                           
                            title: Text('${e['cabecera']}'), children: [
                            Padding(
                              padding: EdgeInsets.only(left:size.iScreen(3.0),right: size.iScreen(3.0),bottom: size.iScreen(3.0)),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.wScreen(100.0),
                  
                                      // color: Colors.blue,
                                      child: Text('Título: ',
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
                                    Container(
                                      width: size.wScreen(100.0),
                  
                                      // color: Colors.blue,
                                      child: Text('${e['titulo']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              
                                              )),
                                    ),
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                  
                                    Container(
                                      width: size.wScreen(100.0),
                  
                                      // color: Colors.blue,
                                      child: Text('Contenido: ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey
                                              ),
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
                                      child: Text('${e['contenido']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey,
                                              )),
                                    ),
                  
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                  
                                    Container(
                                      // width: size.wScreen(40),
                                      child: Container(
                                        alignment: Alignment.center,
                                        // width: size.wScreen(40),
                                        // height: size.hScreen(30),
                                        child: 
                                        Center(
                                          child:
                                              // Image.network(
                                              //   'https://via.placeholder.com/150',
                                              //   width: size.wScreen(100),
                                              //   height: size.hScreen(100),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              //*****************************************/
                  
                                              Consumer<GestionDocumentalController>(
                                            builder: (_, valueUrl, __) {
                                              return 
                                             e['foto'].isNotEmpty?  Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: size.wScreen(100.0),
                  
                                                    // color: Colors.blue,
                                                    child: Text('Foto:',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                // fontSize: size.iScreen(2.0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color:
                                                                    Colors.grey)),
                                                  ),
                                                  SizedBox(
                                                    height: size.iScreen(1.0),
                                                  ),
                                                  Consumer<
                                                      GestionDocumentalController>(
                                                    builder: (context,
                                                        imageProvider, child) {
                                                      return
                                                      //  Container(
                                                      //     width: size.wScreen(50.0),
                  
                                                      //   child: Image.file(File(e['foto'])),
                                                      // );
                                                       Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.iScreen(1.5)),
                                      child: 
                                      // FadeInImage(
                                      //   placeholder: const AssetImage(
                                      //       'assets/imgs/loader.gif'),
                                      //   image: 
                                        
                                      //   NetworkImage('${e['foto']}'),
                                      // ),
                                      Center(
            child: Image.network(
              '${e['foto']}',
              errorBuilder: (context, error, stackTrace) {
                // print('Error al cargar la imagen: $error');
                return 
                Icon(
                  Icons.error_outline,
                  size: size.iScreen(4.0),
                  color: Colors.red,
                );
              },
            ),
          ),
                                    );
                                                    },
                                                  )
                                                ],
                                              ):Container();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //***********************************************/
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        );
                          },
                      ).toList());
                         },),
                   
                        
                      
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(1.5),
                        ),
                        //***********************************************/
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
  File stringToFile(String data, String filePath) {
  File file = File(filePath);
  file.writeAsStringSync(data);
  return file;
}

  Card _contenidoAdd(Responsive size, GestionDocumentalController _controller) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(size.iScreen(2.0)),
        child: SingleChildScrollView(
          child: Form(
            key: _controller.contenidoDocFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.wScreen(100.0),

                  // color: Colors.blue,
                  child: Text('Título: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
                TextFormField(
                  initialValue: widget.action == 'CREATE'
                      ? ''
                      : _controller.getInputTitulo,
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                        RegExp(r'^[^\n"]*$')),
                    UpperCaseText(),
                  ],
                  onChanged: (text) {
                    _controller.onTituloChange(text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Ingrese Título';
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
                  child: Text('Contenido: ',
                      style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),

                TextFormField(
                  initialValue: widget.action == 'CREATE'
                      ? ''
                      : _controller.getInputContenido,
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                        RegExp(r'^[^\n"]*$')),
                    UpperCaseText(),
                  ],
                  onChanged: (text) {
                    _controller.onContenidoChange(text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Ingrese Contenido';
                    }
                  },
                ),

                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //***********************************************/

                Container(
                  width: size.wScreen(100),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.wScreen(30),
                    height: size.hScreen(50),
                    child: Center(
                      child:
                          // Image.network(
                          //   'https://via.placeholder.com/150',
                          //   width: size.wScreen(100),
                          //   height: size.hScreen(100),
                          //   fit: BoxFit.cover,
                          // ),
                          //*****************************************/

                          Consumer<GestionDocumentalController>(
                        builder: (_, valueUrl, __) {
                          return Column(
                            children: [
                              SizedBox(
                                width: size.wScreen(100.0),

                                // color: Colors.blue,
                                child: Text('Foto:',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              Stack(
                                children: [
                                  // Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //         vertical: size.iScreen(1.5)),
                                  //     child: FadeInImage.assetNetwork(
                                  //       // fit: BoxFit.fitHeight,
                                  //       placeholder:
                                  //           'assets/imgs/loading.gif',
                                  //       image: valueUrl
                                  //           .getFotUrlTemp!, //'https://picsum.photos/id/237/500/300',
                                  //     )),

                                  Consumer<GestionDocumentalController>(
                                    builder: (context, imageProvider, child) {
                                      if (valueUrl.selectedImage == null && widget.action == 'CREATE') {
                                        return Column(
                                          children: [
                                          

                                            ElevatedButton(
                                              onPressed: () {
                                                bottomSheet(
                                                    _controller, context, size);
                                              },
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: size.iScreen(3.5),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Stack(
                                           
                                          children: [

                                                widget.action == 'CREATE'
                                           ? Image.file(valueUrl.selectedImage!)

                                             : Container(
                                              width: size.wScreen(100),
                                              height: size.hScreen(45),
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.iScreen(1.5)),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),
                                      image: NetworkImage('${valueUrl.getFotoContenido}'),
                                    ),
                                  ),

                                            Positioned(
                                              top: 5.0,
                                              left: 3.0,
                                              // bottom: -3.0,
                                              child: IconButton(
                                                color:
                                                    tercearyColor, // Colors.red.shade700,
                                                onPressed: () {
                                          //          widget.action == 'CREATE'
                                          //  ? 
                                                  valueUrl.deleteImage();
                                          
                                            //  :
                                            //  valueUrl.eliminaUrlServer(e['foto']);
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever,
                                                  size: size.iScreen(3.5),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //***********************************************/
              ],
            ),
          ),
        ),
      ),
    );
  }

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _fecha(BuildContext context, GestionDocumentalController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      // locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

      // setState(() {
      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      // _fechaController.text = _fechaInicio;
      controller.onInputFechaChange(_fechaInicio);
      // print('FechaInicio: $_fechaInicio');
      // });
    }
  }

//====== MUESTRA MODAL DE PTOCESO =======//
  void _modalSeleccioPerfil(
      Responsive size, GestionDocumentalController _controller) {
    final _data = ["GUARDIAS", "SUPERVISORES", "ADMINISTRACION"];

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
                      Text('SELECCIONAR PERFIL',
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
                            _controller.setLabelPerfil('');
                            _controller.setLabelPerfil(_data[index]);
                            // sugerenciaController.setListataDataArea([]);
                            // sugerenciaController.setLabelArea(_data[index]);
                            // sugerenciaController.buscaListaDataArea('');

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

  Future<File?> _getImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }

//====== MUESTRA MODAL DE PTOCESO =======//
  void _modalAgregaContenido(
      Responsive size, GestionDocumentalController _controller) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       widget.action == 'CREATE'
                      ?  Text(
                            'CONTENIDO',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ))
                      : 
                        Text(
                            '${_controller.getInputCabecera}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            )),
                        GestureDetector(
                          onTap: () {
                            _onSubmitAgregaContenido(context, _controller);
                          },
                          child: Consumer<ThemeApp>(
                            builder: (_, valueTheme, __) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: valueTheme.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(size.iScreen(0.5)),
                                ),
                                width: size.iScreen(3.5),
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.5),
                                  left: size.iScreen(0.5),
                                  right: size.iScreen(0.5),
                                ),
                                child: Icon(
                                  Icons.save,
                                  color: valueTheme.secondaryColor,
                                  size: size.iScreen(2.5),
                                ),
                              );
                            },
                          ),
                        ),
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
                        height: size.hScreen(50),
                        child: _contenidoAdd(size, _controller)),
                  ],
                ),
              ),
            ),
          );
        });
  }

//====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaPersona(
      Responsive size, LogisticaController logisticaController, String tipo) {
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
                  Expanded(
                    child: Text('SELECCIONAR $tipo',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        )),
                  ),
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
                      // ListTile(
                      //   tileColor: Colors.grey[200],
                      //   leading:
                      //       const Icon(Icons.qr_code_2, color: Colors.black),
                      //   title: Text(
                      //     "Código QR",
                      //     style: GoogleFonts.lexendDeca(
                      //       fontSize: size.iScreen(1.5),
                      //       fontWeight: FontWeight.bold,
                      //       // color: Colors.white,
                      //     ),
                      //   ),
                      //   trailing: const Icon(Icons.chevron_right_outlined),
                      //   onTap: () async {},
                      // ),
                      // const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
                        title: Text(
                          "Nómina de $tipo",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          // Navigator.pop(context);
                          // if (tipo == 'GUARDIAS') {
                          //   Navigator.pop(context);
                          //   final _controller = context.read<GestionDocumentalController>();
                          //    logisticaController.resetListaPersonas();
                          //   logisticaController.setPersona('GUARDIAS');

                          //   logisticaController.buscaListaPersonas('');
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const BuscarPersonaPedido(
                          //             persona: 'Guardias',
                          //             lugar: 'gestionDocumental',
                          //             // persona: 'Supervisores',
                          //             // persona: 'Administradores',
                          //           )));
                          // }

                          Navigator.pop(context);
                          String _persona = '';
                          final _controller =
                              context.read<GestionDocumentalController>();
                          logisticaController.resetListaPersonas();
                          logisticaController
                              .setPersona('${_controller.getLabelPerfil}');

                          _controller.buscaPersonaGestion('');
                          if (_controller.getLabelPerfil == "GUARDIAS") {
                            _persona = 'Guardias';
                          } else if (_controller.getLabelPerfil ==
                              "SUPERVISORES") {
                            _persona = 'Supervisores';
                          }
                          if (_controller.getLabelPerfil == "ADMINISTRACION") {
                            _persona = 'Administradores';
                          }

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuscarPersonaGestionDocumental(
                                    persona: _persona,
                                    lugar: 'gestionDocumental',
                                    // persona: 'Supervisores',
                                    // persona: 'Administradores',
                                  )));

                          // else if (tipo == 'SUPERVISOR') {
                          //   Navigator.pop(context);
                          //   final _control = Provider.of<LogisticaController>(
                          //       context,
                          //       listen: false);
                          //   _control.resetListaPersonas();
                          //   _control.setPersona('ADMINISTRACION');
                          //   _control.buscaListaPersonas('');
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const BuscarPersonaPedido(
                          //             persona: 'Supervisores',
                          //           )));
                          // } else if (tipo == 'ADMINISTRADORES') {
                          //   Navigator.pop(context);
                          //   final _control = Provider.of<LogisticaController>(
                          //       context,
                          //       listen: false);
                          //   _control.resetListaPersonas();
                          //   _control.setPersona('ADMINISTRACION');
                          //   _control.buscaListaPersonas('');
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const BuscarPersonaPedido(
                          //             persona: 'Administradores',
                          //           )));
                          // }
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

  void _onSubmitAgregaContenido(BuildContext context,
      GestionDocumentalController _controller) async {
    final isValid = _controller.validateFormAddContenido();
    if (!isValid) return;
    if (isValid) {
        // ProgressDialog.show(context);
        //     _controller.getUrlsServer( );
        //     ProgressDialog.dissmiss(context);
        //     // if (_controller.getUrlImage.isNotEmpty) {
        //     //              }
        //     // else{
        //     //   NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
        //     // }
        //          Navigator.pop(context);


        // ProgressDialog.show(context);
        //     final response = await  _controller.getUrlsServer( );
        //     ProgressDialog.dissmiss(context);
        //     if (response != null && _controller.getUrlImage.isNotEmpty) {
        //         Navigator.pop(context);
        //     }
        //     else{
        //       NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
        //     }
        if (_controller.selectedImage != null) {
           ProgressDialog.show(context);
            final response = await  _controller.getUrlsServer( );
            ProgressDialog.dissmiss(context);
            if (response != null && _controller.getUrlImage.isNotEmpty) {
                Navigator.pop(context);
            }
            else{
              // NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
            }
          
        } else {
          _controller.setUrlImge('');
      
           Navigator.pop(context);
        }
      



          }
    }
  

  void _onSubmit(
      BuildContext context, GestionDocumentalController _controller,String _action) async {

        final _ctrl = context.read<HomeController>();
    final isValid = _controller.validateForm();
    if (!isValid) return;
    if (isValid) {




      
        if (_controller.getLabelPerfil == '' ||
            _controller.getLabelPerfil== null) {
          NotificatiosnService.showSnackBarDanger('Debe seleccionar perfil');
        } 
        else if (_controller.getListaDePersonal.isEmpty) {
          NotificatiosnService.showSnackBarDanger('Debe seleccionar personal');
        }
        else if (_controller.getListaDeContenidos.isEmpty) {
          NotificatiosnService.showSnackBarDanger('Debe agregar contenido');
        } else    if (
                    _controller.getLabelPerfil!.isNotEmpty
                    && _controller.getListaDePersonal.isNotEmpty
                    && _controller.getListaDeContenidos.isNotEmpty
                   
               ) {
          _controller.crearActaDegestion(context);
            _ctrl.buscaGestionDocumental('','ENVIADO');
            
          Navigator.pop(context);

         
        } 
      }
    }
  

  void bottomSheet(
    GestionDocumentalController controller,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              // title: Text(title, style: GoogleFonts.lexendDeca(
              //               fontSize: size.dp(1.8),
              //               fontWeight: FontWeight.w500,
              //               // color: Colors.white,
              //             )),

              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                    // // urls.launchWaze(lat, lng);s
                    // // _funcionCamara(ImageSource.camera, controller);
                    // pickImageCamera(controller);
                    final image = await _getImage(context, ImageSource.camera);
                    if (image != null) {
                      controller.setImage(image);
                    }
                    Navigator.pop(context);
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
                  onPressed: () async {
                    // _funcionCamara(ImageSource.gallery, controller);
                    // pickImageGalery(controller);
                    final image = await _getImage(context, ImageSource.gallery);
                    if (image != null) {
                      controller.setImage(image);
                    }
                    Navigator.pop(context);
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
              // cancelButton: CupertinoActionSheetAction(
              //   onPressed: () => Navigator.of(context).pop(),
              //   child: Text('Close'),
              // ),
            ));
  }

// ===========================================//

//   File? image;

//   Future pickImageGalery(
//     GestionDocumentalController controller,
//   ) async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final imageTemp = File(image.path);
//       // print('imageTemp: $imageTemp');
//       controller.setNewPictureFile(this.image);
// // controlerMascota.setNewPictureFile(this.image);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       NotificatiosnService.showSnackBarError(e.message.toString());
//       // print('Failed to pick image: $e');
//     }
//   }

//   Future pickImageCamera(
//     GestionDocumentalController controller,
//   ) async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);

//       if (image == null) return;

//       final imageTemp = File(image.path);
// // print('imageTemp: $imageTemp');
// // controlerMascota.setNewPictureFile(image);
//       controller.setNewPictureFile(this.image);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       NotificatiosnService.showSnackBarError(e.message.toString());
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sincop_app/src/controllers/home_controller.dart';

// class QuizScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Quiz con Preguntas y Respuestas')),
//       body: QuizQuestions(),
//     );
//   }
// }

// class QuizQuestions extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeController>(
//       builder: (context, quizProvider, child) {
//         return SingleChildScrollView(
//           child: Column(
//             children: List.generate(quizProvider.questions.length, (index) {
//               return QuestionWidget(questionIndex: index);
//             }),
//           ),
//         );
//       },
//     );
//   }
// }

// class QuestionWidget extends StatelessWidget {
//   final int questionIndex;

//   QuestionWidget({required this.questionIndex});

//   @override
//   Widget build(BuildContext context) {
//     final quizProvider = context.read<HomeController>();
//     final question = quizProvider.questions[questionIndex];
//     final List<String> options = question['options'];

//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(question['question']),
//             SizedBox(height: 10),
//             Column(
//               children: List.generate(options.length, (optionIndex) {
//                 return AnswerWidget(
//                   questionIndex: questionIndex,
//                   optionIndex: optionIndex,
//                   label: options[optionIndex],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnswerWidget extends StatelessWidget {
//   final int questionIndex;
//   final int optionIndex;
//   final String label;

//   AnswerWidget({
//     required this.questionIndex,
//     required this.optionIndex,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final quizProvider = context.read<HomeController>();
//     final isSelected = quizProvider.questions[questionIndex]['selectedAnswerIndex'] == optionIndex;

//     return Row(
//       children: [
//         Radio<bool>(
//           value: isSelected,
//           groupValue: true, // Puedes usar cualquier valor ya que solo hay una opción seleccionada
//           onChanged: (bool? value) {
//             quizProvider.setSelectedAnswer(questionIndex, optionIndex);
//           },
//         ),
//         Text(label),
//       ],
//     );
//   }
}
