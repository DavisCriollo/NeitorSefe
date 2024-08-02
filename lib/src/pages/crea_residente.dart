import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/correos.dart';
import 'package:nseguridad/src/utils/letras_mayusculas_minusculas.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/dropdown_estado_residente.dart';

class CrearResidente extends StatefulWidget {
  final String? action;
     final Session? user;
  const CrearResidente({Key? key, this.action, this.user}) : super(key: key);

  @override
  State<CrearResidente> createState() => _CrearResidenteState();
}

class _CrearResidenteState extends State<CrearResidente> {
  final _controlCorreo = TextEditingController();
  final _controlTelefono = TextEditingController();
  final _controlPersona = TextEditingController();
  @override
  void dispose() {
    _controlCorreo.dispose();
    _controlTelefono.dispose();
    _controlPersona.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
    final residenteController = context.read<ResidentesController>();
      final ctrlTheme = context.read<ThemeApp>();
        

    final _action = widget.action;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                    'Crear Residente',
                    // style: Theme.of(context).textTheme.headline2,
                  )
                : Text(
                    'Editar Residente',
                    // style: Theme.of(context).textTheme.headline2,
                  ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, residenteController, _action!);
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              ),
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
                key: residenteController.residentesFormKey,
                child: Column(
                  children: [
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
                      _action == 'EDIT' ?  Column(children: [
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
                      child: const DropMenuEstadoResidente(
                        // title: 'Tipo de documento:',
                        data: [
                         'ACTIVA', 'INACTIVA'
                        ],
                        hinText: 'Seleccione',
                      ),
                    ),
                  ],
                ),

                    ],):Container(),
                   
                    //***********************************************/
                  widget.user!.rol!.contains('GUARDIA')?Container(): Column(mainAxisSize:MainAxisSize.min,
                      children: [
                         //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Cliente:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),

                        SizedBox(
                          height: size.iScreen(0.0),
                        ),
                          //***********************************************/
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.red,
                            padding: EdgeInsets.only(
                              top: size.iScreen(1.0),
                              right: size.iScreen(0.5),
                            ),
                            child: Consumer<ResidentesController>(
                              builder: (_, personal, __) {
                                return (personal.getNombreCliente == '' ||
                                        personal.getNombreCliente == null)
                                    ? Container(
                                        width: size.wScreen(3.0),
                                        height: size.hScreen(3.0),
                                        child: CupertinoActivityIndicator(
                                          radius: 10,
                                        ),
                                      )
                                    : Text(
                                        '${personal.getNombreCliente}',
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
                      child: Text('Puesto:',
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
                            child: Consumer<ResidentesController>(
                              builder: (_, puesto, __) {
                                return (puesto.getNombrePuesto==''||
                                        puesto.getNombrePuesto == null)
                                    ? Text(
                                        'No hay puesto seleccionado',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    : Container(
                                            width: size.wScreen(100.0),
                                            color: Colors.grey.shade200,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.0)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.5)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Ubicación : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.7),
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${puesto.getNombreUbicacion} ',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
                                                                  // color: Colors.black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Puesto : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.7),
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${puesto.getNombrePuesto} ',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
                                                                  // color: Colors.black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                    
                                    
                                    
                                   
                              },
                            ),
                          ),
                        ),
                        Consumer<ResidentesController>(builder: (_, valueBoton, __) { 
                                 return  valueBoton.getNombreCliente == '' ||
                                        valueBoton.getNombreCliente == null
                                        ? Container()
                                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(onTap: () {
                            // _modalSeleccionaMotivo(
                            //     size, turnoExtraController);
     _modalSeleccionaPuesto( context, size,valueBoton, valueBoton.getDatosOperativos);
    

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
                        );
                         },)
                     
                      ],
                    ),
                      ],
                    ),
                  
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Row(
                      children: [
                        Container(
                          width: size.wScreen(15.0),

                          // color: Colors.blue,
                          child: Text('Cédula:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.iScreen(1.0)),
                          width: size.wScreen(70.0),
                          // color: Colors.blue,12
                          child: TextFormField(
                            initialValue:  widget.action == 'CREATE'
                        ? ''
                        : residenteController.getItemCedula,
                            textAlign: TextAlign.center,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: const InputDecoration(
                                // suffixIcon: Icon(Icons.beenhere_outlined)
                                ),
                            style: TextStyle(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                            ),
                            onChanged: (text) {
                              residenteController.setItemCedulaResidente(text);
                            },
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese Cédula';
                              }
                            },
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
                      child: Text('Apellidos y Nombres: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                           initialValue:  widget.action == 'CREATE'
                        ? ''
                        : residenteController.getItemNombresResidentes,
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
                        residenteController.setItemNombresResidentes(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Nombres Completos';
                        }
                      },
                    ),
                    //***********************************************/
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        children: [
                          Container(
                            // width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Text('Correos:   ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            width: size.wScreen(50.0),
                            child: Form(
                              key: residenteController.correoFormKey,
                              child: TextFormField(
                                controller: _controlCorreo,
                                decoration: const InputDecoration(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(),
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                      RegExp(r'^[^\n"]*$')),
                                  // UpperCaseText(),
                                ],
                                onChanged: (text) {
                                  residenteController.setEmail(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Ingrese Correo';
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.iScreen(1.0),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(onTap: () {
                              final isValid =
                                  residenteController.validateFormCorreo();
                              if (!isValid) return;
                              if (isValid) {
                                final _correo;
                                _correo = isValidEmail(
                                    '${residenteController.getEmail}');

                                if (_correo == false) {
                                  NotificatiosnService.showSnackBarDanger(
                                      'Correo inválido');
                                } else {
                                  _controlCorreo.text = '';
                                  residenteController.setListaCorreoResidente(
                                      residenteController.getEmail);
                                }
                              }
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
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Consumer<ResidentesController>(
                        builder: (_, correos, __) {
                          return (correos.getListaCorreoResidente.isEmpty)
                              ? Text(
                                  'No hay correos agregados',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              : Container(
                                  width: size.wScreen(100),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: correos.getListaCorreoResidente
                                        .map((e) => Stack(
                                              children: [
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0)),
                                                    child: Chip(
                                                        label: SelectableText(
                                                      '$e',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                        fontSize:
                                                            size.iScreen(1.8),
                                                        // color: Colors.black45,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))),
                                                Positioned(
                                                  right: size.iScreen(0.6),
                                                  top: size.iScreen(0.5),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      correos
                                                          .deleteCorreoResidente(
                                                              e);
                                                    },
                                                    child: Icon(
                                                      Icons.do_disturb_on,
                                                      color:
                                                          Colors.red.shade600,
                                                      size: size.wScreen(4.0),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ))
                                        .toList(),
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
                    Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        children: [
                          Container(
                            // width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Text('Teléfono:   ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          Container(
                            width: size.wScreen(50.0),
                            child: Form(
                              key: residenteController.telefonoFormKey,
                              child: TextFormField(
                                controller: _controlTelefono,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: const InputDecoration(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(),
                                onChanged: (text) {
                                  residenteController.setTelefono(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Debe ingresar teléfono';
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.iScreen(1.0),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(onTap: () {
                              final isValid =
                                  residenteController.validateFormTelefono();
                              if (!isValid) return;
                              if (isValid) {
                                if (residenteController.getTelefono == '') {
                                  NotificatiosnService.showSnackBarDanger(
                                      'Agregue Teléfono');
                                } else {
                                  _controlTelefono.text = '';
                                  residenteController
                                      .setListaTelefonosResidente(
                                          residenteController.getTelefono);
                                }
                              }
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
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Consumer<ResidentesController>(
                        builder: (_, correos, __) {
                          return (correos.getListaTelefonosResidente.isEmpty)
                              ? Text(
                                  'No hay teléfonos agregados',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              : Wrap(
                                  alignment: WrapAlignment.center,
                                  children: correos.getListaTelefonosResidente
                                      .map((e) => Stack(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.iScreen(1.0)),
                                                  child: Chip(
                                                      label: SelectableText(
                                                    '$e',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.8),
                                                      // color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ))),
                                              Positioned(
                                                right: size.iScreen(0.6),
                                                top: size.iScreen(0.5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    correos
                                                        .deleteTelefonosResidente(
                                                            e);
                                                  },
                                                  child: Icon(
                                                    Icons.do_disturb_on,
                                                    color: Colors.red.shade600,
                                                    size: size.wScreen(4.0),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                      .toList(),
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
                      child: Text('Casa o Departamento #: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                           initialValue:  widget.action == 'CREATE'
                        ? ''
                        : residenteController.getItemCasaDepartamentoResidente,
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
                        residenteController
                            .setItemCasaDepartamentoResidente(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Casa o Departamento #';
                        }
                      },
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
                      child: Text('Ubicación: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    TextFormField(
                           initialValue:  widget.action == 'CREATE'
                        ? ''
                        : residenteController.getItemUbicacionResidente,
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
                        residenteController.setItemUbicacionResidente(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese Ubicación';
                        }
                      },
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
                      child: Text('Personas Autorizadas:   ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        children: [
                          Container(
                            width: size.wScreen(80.0),
                            child: Form(
                              key: residenteController.personaFormKey,
                              child: TextFormField(
                                controller: _controlPersona,
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
                                  residenteController.setPersona(text);
                                },
                                validator: (text) {
                                  if (text!.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Ingrese persona autorizada';
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.iScreen(1.0),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(onTap: () {
                              final isValid =
                                  residenteController.validateFormPersona();
                              if (!isValid) return;
                              if (isValid) {
                                if (residenteController.getPersona == '') {
                                  NotificatiosnService.showSnackBarDanger(
                                      'Agregue Persona');
                                } else {
                                  _controlPersona.text = '';
                                  residenteController
                                      .setListaPersonasAutorizadasResidente(
                                          residenteController.getPersona);
                                }
                              }
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
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    //*****************************************/
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Consumer<ResidentesController>(
                        builder: (_, persona, __) {
                          return (persona
                                  .getListaPersonasAutorizadasResidente.isEmpty)
                              ? Text(
                                  'No hay personas agregadas',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              : Wrap(
                                  alignment: WrapAlignment.center,
                                  children: persona
                                      .getListaPersonasAutorizadasResidente
                                      .map((e) => Stack(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.iScreen(1.0)),
                                                  child: Chip(
                                                      label: SelectableText(
                                                    '$e',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.8),
                                                      // color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ))),
                                              Positioned(
                                                right: size.iScreen(0.6),
                                                top: size.iScreen(0.5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    persona
                                                        .deletePersonasAutorizadasResidente(
                                                            e);
                                                  },
                                                  child: Icon(
                                                    Icons.do_disturb_on,
                                                    color: Colors.red.shade600,
                                                    size: size.wScreen(4.0),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                      .toList(),
                                );
                        },
                      ),
                    ),
                  //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, ResidentesController _controller,
      String _action) async {
    final isValid = _controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (widget.user!.rol!.contains('RESIDENTE')&& _controller.getNombrePuesto!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Seleccione pesto de cliente');
      }
     else if (_controller.getItemCedula=='' ||
          _controller.getItemCedula==null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe agregar Cédula');
      }
     else if (_controller.getListaCorreoResidente.isEmpty ) {
        NotificatiosnService.showSnackBarDanger(
            'Debe agregar correo');
      }

        else if (_controller.getListaTelefonosResidente.isEmpty ) {
        NotificatiosnService.showSnackBarDanger(
            'Debe agregar teléfono');
      }
        else if (_controller.getListaPersonasAutorizadasResidente.isEmpty ) {
        NotificatiosnService.showSnackBarDanger(
            'Debe agregar persona autorizada');
      }

      else
        if (_action == 'CREATE') {


             if(widget.user!.rol!.contains('GUARDIA')){

            _controller.creaResidenteGuardia(context);

          }else  if(widget.user!.rol!.contains('CLIENTE')){
              _controller.creaResidente(context);
          }

            // _controller.creaResidente(context);

          Navigator.pop(context);
        }
        else if (_action == 'EDIT') {
           


             if(widget.user!.rol!.contains('GUARDIA')){

            _controller.editaResidente(context);

          }else  if(widget.user!.rol!.contains('CLIENTE')){
              _controller.editaResidente(context);
          }
        _controller.editaResidente(context);
          Navigator.pop(context);
        

    }
    }}

  void _modalSeleccionaPuesto(BuildContext context, Responsive size,
      ResidentesController _controller, List _data) {
    // final _data = [
    //   'RENUNCIA',
    //   'RENUNCIA ART 190 CT',
    // ];
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
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _controller.setNombreUbicacion(_data[index]['ubicacion']);
                            _controller.setNombrePuesto(_data[index]['puesto']);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Ubicación: ',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      width: size.wScreen(50.0),
                                      child: Text(
                                        '${_data[index]['ubicacion']} ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Puesto: ',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Container(
                                      
                                       width: size.wScreen(50.0),
                                      child: Text(
                                        '${_data[index]['puesto']} ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              
                              ],
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
}
