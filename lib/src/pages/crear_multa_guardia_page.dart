import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';

import 'package:nseguridad/src/models/crea_foto_multas.dart';

import 'package:nseguridad/src/pages/view_photo_multas.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/utils/theme.dart';

class CrearMultaGuardia extends StatefulWidget {
  const CrearMultaGuardia({Key? key}) : super(key: key);

  @override
  State<CrearMultaGuardia> createState() => _CrearMultaGuardiaState();
}

class _CrearMultaGuardiaState extends State<CrearMultaGuardia> {
  TextEditingController _fechaMultaController = TextEditingController();

  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _horaInicioController = TextEditingController();
  TextEditingController _horaFinController = TextEditingController();

 late TimeOfDay timerInicio;
  late TimeOfDay timerFin;



  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final loadData = MultasGuardiasContrtoller();
    _fechaMultaController.text = loadData.getFechaActul;
       timerInicio = TimeOfDay.now();
    timerFin = TimeOfDay.now();
  }




  @override
  void dispose() {
    _fechaMultaController.clear();
    _fechaInicioController.clear();
    _fechaFinController.clear();
    _horaFinController.clear();
    _horaFinController.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final tipoMultaController = Provider.of<MultasGuardiasContrtoller>(context);
      final ctrlTheme = context.read<ThemeApp>();
        
  final _user=context.read<HomeController>();
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
                        // if (controllerMulta.getTurnoEmergenteGuardado == true &&
                        //         controllerMulta.nombreGuardia != '' ||
                        //     controllerMulta.nombreGuardia != null || controllerMulta.getIdTurnoEmergente=='') {
                              
                        //       print('idTurnoExtra: ${controllerMulta.getIdTurnoEmergente}');
                              
                        //   // await providerTurno.eliminaTurnoExtra(
                        //   //     controllerMulta.getDataTurnoEmergente['turId']);
                        //   // Navigator.of(context).pop(true);
                        // } else {
                        //   Navigator.of(context).pop(true);
                        // }
                        if ( controllerMulta.getIdTurnoEmergente!='') {
                              
                              // print('idTurnoExtra: ${controllerMulta.getIdTurnoEmergente}');
                              
                          await providerTurno.eliminaTurnoExtra(
                              int.parse(controllerMulta.getIdTurnoEmergente.toString()));
                            controllerMulta.setIdTurnoEmergente('');
                          Navigator.of(context).pop(true);
                        } else {
                          Navigator.of(context).pop(true);
                        }
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
            title: Text(
              'Crear Multa ${tipoMultaController.getPorcentajeTipoMulta}%',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Container(
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
              ),
            ],
          ),
          body: Container(
            width: size.iScreen(100.0),
            height: size.iScreen(100.0),
            margin: EdgeInsets.only(
                bottom: size.iScreen(0.0), top: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(
              horizontal: size.iScreen(1.5),
              vertical: size.iScreen(0.0),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: tipoMultaController.multasGuardiaFormKey,
                child: Column(
                  children: [

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



                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              hintStyle: const TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                color: Colors.red,
                                splashRadius: 20,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _selectFechaRegistro(
                                      context, tipoMultaController);
                                },
                                icon:
                                    Consumer<ThemeApp>(builder: (_, value, __) {
                                  return Icon(
                                    Icons.date_range_outlined,
                                    color: value.primaryColor,
                                    size: 30,
                                  );
                                }),
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

                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child: Text('Guardia Amonestado:',
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
                          "${tipoMultaController.getNomPersonaMulta}",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

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
                          child: Text('Novedad:',
                              style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(3.5)),
                            child: Text(
                              "${tipoMultaController.getTextoTipoMulta}",
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
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

                    //************************************************************************************************************/


 
                    //*****************************************/

                    Consumer<MultasGuardiasContrtoller>(
                      builder: (_, valueTipoMulta, __) {
                        return (valueTipoMulta.getGuardiaReemplazo)
                            ? Column(
                                children: [

//===================================================================//

//***********************************************/
                        SizedBox(
                          height: size.iScreen(.0),
                        ),
                        //*****************************************/
                          Container(
                        width: size.wScreen(100.0),
    
                        // color: Colors.blue,
                        child: Text('  Agregar turno extra:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.normal,
                                color: tercearyColor)),
                      ),
                      
                          //************************AGREGA FECHAS A LA LISTA ***********************/
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        Container(
                          color: Colors.grey.shade200,
                          padding:
                              EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Fecha : ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.black45,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Consumer<MultasGuardiasContrtoller>(
                                            builder: (_, valueFecha, __) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.iScreen(1.0),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // if (_action !=
                                                        //     'MULTA') {
                                                        //   FocusScope.of(context)
                                                        //       .requestFocus(
                                                        //           FocusNode());
                                                        //   FocusScope.of(context)
                                                        //       .requestFocus(
                                                        //           FocusNode());
                                                        //   _selectFechaInicio(
                                                        //       context,
                                                        //       valueFecha,
                                                        //     );
                                                        // // }
                                                        // _fecha(context, valueFecha);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                        valueFecha.getInputfechaInicio==''?  '-- -- --':  valueFecha
                                                              .getInputfechaInicio.toString().replaceAll('T', " "),
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors
                                                                  // .black45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: size
                                                                .iScreen(1.0),
                                                          ),
                                                          // Consumer<AppTheme>(
                                                          //   builder:
                                                          //       (_, value, __) {
                                                          //     return Icon(
                                                          //       Icons
                                                          //           .date_range_outlined,
                                                          //       color: value
                                                          //           .getPrimaryTextColor,
                                                          //       size: 30,
                                                          //     );
                                                          //   },
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]);
                                            },
                                          ),
                                        ],
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //       'Hora',
                                      //       style: GoogleFonts.lexendDeca(
                                      //         fontSize: size.iScreen(1.8),
                                      //         color: Colors.black45,
                                      //         // fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //     Consumer<MultasGuardiasContrtoller>(
                                      //       builder: (_, valueHoraIncio, __) {
                                      //         return Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.start,
                                      //             children: [
                                      //               SizedBox(
                                      //                 width: size.iScreen(1.0),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap: () {
                                      //                   FocusScope.of(context)
                                      //                       .requestFocus(
                                      //                           FocusNode());
                                      //                   _seleccionaHoraInicio(
                                      //                       context,
                                      //                       valueHoraIncio);
                                      //                 },
                                      //                 child: Row(
                                      //                   children: [
                                      //                     Text(
                                      //                       valueHoraIncio
                                      //                           .getInputHoraInicio ==''?'-- -- --':valueHoraIncio
                                      //                           .getInputHoraInicio,
                                      //                       style: GoogleFonts
                                      //                           .lexendDeca(
                                      //                         fontSize: size
                                      //                             .iScreen(1.8),
                                      //                         color: Colors
                                      //                             .black45,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                       ),
                                      //                     ),
                                      //                     SizedBox(
                                      //                       width: size
                                      //                           .iScreen(1.0),
                                      //                     ),
                                      //                     Consumer<AppTheme>(
                                      //                         builder: (_,
                                      //                             value, __) {
                                      //                       return Icon(
                                      //                         Icons
                                      //                             .access_time_outlined,
                                      //                         color: value
                                      //                             .getPrimaryTextColor,
                                      //                         size: 30,
                                      //                       );
                                      //                     }),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ]);
                                      //       },
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  //***********************************************/

                                  SizedBox(
                                    height: size.iScreen(0.0),
                                  ),

                                  // //*******************FECHA HORA HASTA **********************/
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         Text(
                                  //           'Hasta',
                                  //           style: GoogleFonts.lexendDeca(
                                  //             fontSize: size.iScreen(1.8),
                                  //             color: Colors.black45,
                                  //           ),
                                  //         ),
                                  //         Consumer<MultasGuardiasContrtoller>(
                                  //           builder: (_, valueFechaFin, __) {
                                  //             return Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                 children: [
                                  //                   SizedBox(
                                  //                     width: size.iScreen(1.0),
                                  //                   ),
                                  //                   GestureDetector(
                                  //                     onTap:null,
                                  //                     //  () 
                                  //                     // {
                                                       
                                  //                     //     FocusScope.of(context)
                                  //                     //         .requestFocus(
                                  //                     //             FocusNode());
                                  //                     //     FocusScope.of(context)
                                  //                     //         .requestFocus(
                                  //                     //             FocusNode());
                                  //                     //     _selectFechaFin(
                                  //                     //         context,
                                  //                     //         valueFechaFin,
                                  //                     //        );
                                                        
                                  //                     //   // _fecha(context, valueFecha);
                                  //                     // },
                                  //                     child: Row(
                                  //                       children: [
                                  //                         Text(
                                  //                           valueFechaFin
                                  //                               .getInputfechaFin ==''?'-- -- --': valueFechaFin
                                  //                               .getInputfechaFin,
                                  //                           style: GoogleFonts
                                  //                               .lexendDeca(
                                  //                             fontSize: size
                                  //                                 .iScreen(1.8),
                                  //                             color: Colors
                                  //                                 .black45,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .bold,
                                  //                           ),
                                  //                         ),
                                  //                         SizedBox(
                                  //                           width: size
                                  //                               .iScreen(1.0),
                                  //                         ),
                                  //                         Consumer<AppTheme>(
                                  //                             builder: (_,
                                  //                                 value, __) {
                                  //                           return Icon(
                                  //                             Icons
                                  //                                 .date_range_outlined,
                                  //                             color: Colors.grey,//value.getPrimaryTextColor,
                                  //                             size: 30,
                                  //                           );
                                  //                         }),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ]);
                                  //           },
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         Text(
                                  //           'Hora',
                                  //           style: GoogleFonts.lexendDeca(
                                  //             fontSize: size.iScreen(1.8),
                                  //             color: Colors.black45,
                                  //           ),
                                  //         ),
                                  //         Consumer<MultasGuardiasContrtoller>(
                                  //           builder: (_, valueHoraFin, __) {
                                  //             return Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                 children: [
                                  //                   SizedBox(
                                  //                     width: size.iScreen(1.0),
                                  //                   ),
                                  //                   GestureDetector(
                                  //                     onTap: () {
                                  //                       FocusScope.of(context)
                                  //                           .requestFocus(
                                  //                               FocusNode());
                                  //                       _seleccionaHoraFin(
                                  //                           context,
                                  //                           valueHoraFin);
                                  //                     },
                                  //                     child: Row(
                                  //                       children: [
                                  //                         Text(
                                  //                           valueHoraFin
                                  //                               .getInputHoraFin==''?'-- -- --':valueHoraFin
                                  //                               .getInputHoraFin,
                                  //                           style: GoogleFonts
                                  //                               .lexendDeca(
                                  //                             fontSize: size
                                  //                                 .iScreen(1.8),
                                  //                             color: Colors
                                  //                                 .black45,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .bold,
                                  //                           ),
                                  //                         ),
                                  //                         SizedBox(
                                  //                           width: size
                                  //                               .iScreen(1.0),
                                  //                         ),
                                  //                         Consumer<AppTheme>(
                                  //                             builder: (_,
                                  //                                 value, __) {
                                  //                           return Icon(
                                  //                             Icons
                                  //                                 .access_time_outlined,
                                  //                             color: value
                                  //                                 .getPrimaryTextColor,
                                  //                             size: 30,
                                  //                           );
                                  //                         }),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ]);
                                  //           },
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                             
                             Consumer  < MultasGuardiasContrtoller>(builder: (_, value, __) {  

                                  return  
                                  
                                    value.getFechaTurnoExtra.isEmpty 
                                    ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(onTap: value.getInputfechaInicio!='' 
                                ?() {
                                 
                                  // value.setListFechasAusencia({
                                  //   "desde": "${value.getInputfechaInicio}T${value.getInputHoraInicio}",
                                  //   "hasta": "${value.getInputfechaFin}T${value.getInputHoraFin}",
                                  //   "isSelect":false
                                  // });



//                                   final Map<String, dynamic> _fechaTurnoExtra={
//                                     "desde": "${value.getInputfechaInicio}T${value.getInputHoraInicio}",
//                                     "hasta": "${value.getInputfechaFin}T${value.getInputHoraFin}",
//                                                 };
// value.setFechaTurnoExtra(_fechaTurnoExtra);


                               
//                                   value.onInputFechaInicioChange('');
//                                   //  value.onInputHoraInicioChange('');
//                                     value.onInputFechaFinChange('');
//                                      value.onInputHoraFinChange('');
//                                       // value.onNumeroDiasChange(value.getListFechasTurnoExtra.length.toString());
//                                       final _controllerAusencia=context.read<AusenciasController>();
//                                         _controllerAusencia.setFechaValida( _fechaTurnoExtra); 

                                  //    //=============== AGREGAMOS VALIDACION  ===================//
                                          final _controller=context.read<MultasGuardiasContrtoller>();
                                                 String fechaBuscada = '${value.getInputfechaInicio.substring(0,10)}';
                                      if(_controller.getInfoGuardiaVerificaTurno['perTurno'].isNotEmpty){
                                      

                                                        bool encontrada = false;
                                                        bool _isFechaOk = false;
                                                         Map<String,dynamic>_fecha={};
                                                         Map<String,dynamic> _itemTurnoPuesto={};
                                            for (var item in _controller.getInfoGuardiaVerificaTurno['perTurno']) {

                                              if(item['fechasConsultaDB'].isNotEmpty){

                                                  for (var e in item['fechasConsultaDB']) {
                                                    // print('LA DATA ${e['desde']}'); 
                                                    // print('LA DATA ${item['id']}'); 
                                                     if (e["desde"].substring(0,10) == fechaBuscada) {
                                                            encontrada = true;
                                                            _isFechaOk = true;

                                                            value.onInputFechaInicioChange(e["desde"].toString().substring(0, e["desde"].toString().length - 3));
                                                            value.onInputFechaFinChange(e["hasta"].toString().substring(0, e["hasta"].toString().length - 3));
                                                            break;
                                                          }
                                                          

                                                }
                                                
                                                
                                              }
                                              
                                              
                                                                                                                                                                  

                                         if (encontrada) {
                                                        

                                // _fecha ={
                                //     "desde": "${value.getInputfechaInicio}T${value.getInputHoraInicio}",
                                //     "hasta": "${value.getInputfechaFin}T${value.getInputHoraFin}",
                                //     "id": "${item['id']}",
                                //     "isSelect":false
                                //   };
                           
                                _fecha ={
                                    "desde": "${value.getInputfechaInicio}",
                                    "hasta": "${value.getInputfechaFin}",
                                    "id": "${item['id']}",
                                    "isSelect":false
                                  };
                           
                               _itemTurnoPuesto={
                                    "id": item['id'],
                                    "ruccliente":item['docClienteIngreso'],
                                    "razonsocial": item['clienteIngreso'],
                                    "ubicacion": item['clienteUbicacionIngreso'],
                                    "puesto":item['puestoIngreso']
                                  
                                  };

                                         }
                                        
                                            }
                                            
                                        if(_isFechaOk==true){
                                          print('la fecha es : $_fecha');
                                          //  value.setListFechasAusencia(_fecha);
                                            value.setFechaTurnoExtra(_fecha);

                                            // final _dataTurnoExtra=context.read<TurnoExtraController>();
                                          value.setListMultaTurPuesto(_itemTurnoPuesto);
                                          // _dataTurnoExtra.setListTurPuesto(_itemTurnoPuesto);

                                           
                                        }else
                                        {
                                            NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                                        }



                                      }



                                  //    //=============== AGREGAMOS VALIDACION  ===================//
   





                                 
                                }:null, child: Consumer<ThemeApp>(
                                  builder: (_, valueTheme, __) {
                                    return Container(
                                        alignment: Alignment.center,
                                        color:value.getInputfechaInicio!='' 
                                         ?valueTheme.primaryColor : Colors.grey.shade500  ,
                                        width: size.iScreen(8.0),
                                        padding: EdgeInsets.only(
                                          top: size.iScreen(0.5),
                                          bottom: size.iScreen(0.5),
                                          left: size.iScreen(0.5),
                                          right: size.iScreen(0.5),
                                        ),
                                        child: Text('Agregar',
                                            style: GoogleFonts.lexendDeca(
                                                // fontSize: size.iScreen(2.0),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white))
                                        // Icon(
                                        //   Icons.add,
                                        //   color: valueTheme.getSecondryTextColor,
                                        //   size: size.iScreen(2.0),
                                        // ),
                                        );
                                  },
                                )),
                              ):Container()
                                  
                                  
                                  ;

                             }, )
                             
                             
                            ],
                          ),
                        ),




                    //************************************************************************************************************/

                    

                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/
                         SizedBox(
                                    width: size.wScreen(100.0),

                                    // color: Colors.blue,
                                    child: Text('Fecha Seleccionada:',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                            color: tercearyColor)),
                                  ),
                    //*****************************************/
Consumer<MultasGuardiasContrtoller>(builder: (_, valueMulta, __) { 

return Consumer<ThemeApp>(builder: (_, valueTheme,__) { 
return  Container( margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
  //                                            decoration: BoxDecoration(
  // borderRadius: const BorderRadius.all(
  //       Radius.circular(5.0) //                 <--- border radius here
  //   ),
  //    border: Border.all(
  //        color :  valueTheme.getPrimaryTextColor!, // Set border color
  //           width: 1.0)
  // ),
  child: 
  valueMulta.getFechaTurnoExtra.isEmpty 
  
  ?Container( alignment:Alignment.center,
    width:size.wScreen(100),


    child:   Text(
                                                      'Debe agregar fecha',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey),
                                                    )
  ):Container(

     decoration: BoxDecoration(
       color:valueTheme.primaryColor,
  borderRadius: const BorderRadius.all(
        Radius.circular(5.0) //                 <--- border radius here
    ),
    //  border: Border.all(
    //      color :  valueTheme.getPrimaryTextColor!, // Set border color
    //         width: 1.0)
  ),
    child: ListTile(
      onTap: (){

valueMulta.setFechaTurnoExtra({});


// final _controllerTurno=context.read<AusenciasController>();
// _controllerTurno.resetListaAusenciasTurno();



      },
      dense: true,

       title: Row(
                                                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                //  valueMulta.getFechaTurnoExtra.isNotEmpty 
                                                  //  tipoMultaController.nombreGuardia != ""  ? 
                                                    // tipoMultaController.getFechaTurnoExtra.isNotEmpty
                                                    tipoMultaController.nombreGuardia == "" 
                                                  ? const Icon(Icons.delete_forever,color:Colors.white,)
                                                   :Container(),
                                                    Text(
                                                                      valueMulta.getFechaTurnoExtra['desde'].toString().replaceAll("T", " "),
                                                                          // .toString().replaceAll('T',' '),
                                                                          // .substring(0, 10),
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        fontSize:
                                                                            size.iScreen(1.8),
                                                                        color: Colors.white,
                                                                        // fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                     Text(
                                                                       "/",
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        fontSize:
                                                                            size.iScreen(1.8),
                                                                        color: Colors.white,
                                                                        // fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                    Text(
                                                                       valueMulta.getFechaTurnoExtra['hasta'].toString().replaceAll("T", " "),
                                                                          // .toString().replaceAll('T',' '),
                                                                          // .substring(0, 10),
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        fontSize:
                                                                            size.iScreen(1.8),
                                                                        color: Colors.white,
                                                                        // fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                   
                                                  ],
                                                ),
    ),
  ));
 },);


      

 },),

             
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //*****************************************/












//===================================================================//









tipoMultaController.getFechaTurnoExtra.isNotEmpty?



                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: size.wScreen(100.0),

                                        // color: Colors.blue,
                                        child: Text('Seleccione Guardia Reemplazo:',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.normal,
                                                color: tercearyColor)),
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
                                              MultasGuardiasContrtoller>(
                                            builder: (_, persona, __) {
                                              return (valueTipoMulta
                                                              .nombreGuardia ==
                                                          '' ||
                                                      valueTipoMulta
                                                              .nombreGuardia ==
                                                          null)
                                                  ? Text(
                                                      'No hay guardia designado',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey),
                                                    )
                                                  :
                                                  Consumer<ThemeApp>(builder: (_, value, __) {  
                                                    return Container(
                                                    decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(
        Radius.circular(10.0) //                 <--- border radius here
    ),
                                                      color: Colors.white,
 border: Border.all(
         color :  value.primaryColor, // Set border color
            width: 1.0)
                                                    ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  size.iScreen(
                                                                      0.1)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                  .iScreen(0.3),
                                                              vertical:
                                                                  size.iScreen(
                                                                      0.0)),
                                                      width: size.wScreen(100),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                           IconButton(
                                                              onPressed:
                                                                  () async {
                                                                final _turExtra =
                                                                    context.read<
                                                                        TurnoExtraController>();
                                                                _turExtra.eliminaTurnoExtra(
                                                                    int.parse(
                                                                        persona
                                                                            .getIdTurnoEmergente)
                                                                            );

                                                                persona
                                                                    .setDocuGuardia(
                                                                        '');
                                                                persona
                                                                    .setNombreGuardia(
                                                                        '');
                                                                        persona.setIdTurnoEmergente('');
                                                              },
                                                              icon:  Icon(Icons
                                                                  .delete_forever,size: size.iScreen(3.0),),
                                                              color:Colors.red,),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                
                                                                Container(
                                                                  width: size
                                                                      .wScreen(
                                                                          100),
                                                                  child: Text(
                                                                    '${persona.nombreGuardia}',
                                                                    style: GoogleFonts
                                                                        .lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      // color: Colors.grey
                                                                    ),
                                                                  ),
                                                                ),
                                                                //*****************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          0.3),
                                                                ),
                                                                //*****************************************/

                                                                //*****************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          0.1),
                                                                ),
                                                                //*****************************************/

                                                                //*****************************************/
                                                                SizedBox(
                                                                  height: size
                                                                      .iScreen(
                                                                          0.5),
                                                                ),
                                                                //*****************************************/
                                                              ],
                                                            ),
                                                          ),
                                                         
                                                        ],
                                                      ));
                                                  });
                                                   
                                                      
                                                      
                                            },
                                          ),
                                        ),
                                      ),
                                    
                                    // tipoMultaController.getFechaTurnoExtra.isEmpty||valueTipoMulta
                                    //                           .nombreGuardia ==''
                                    //                        ||
                                    //                   valueTipoMulta.nombreGuardia == null
                                    //                   // || tipoMultaController.getFechaTurnoExtra.isNotEmpty&&valueTipoMulta
                                    //                   //         .nombreGuardia !=''
                                                           
                                                      
                                    // ?
                                    // Container()
                                    //  : 
                                    tipoMultaController.getFechaTurnoExtra.isEmpty
                                    || tipoMultaController.getFechaTurnoExtra.isNotEmpty&&tipoMultaController.nombreGuardia != ""                                                         ''
                                                      // || tipoMultaController.getFechaTurnoExtra.isNotEmpty&&valueTipoMulta
                                                      //         .nombreGuardia !=''
                                                           
                                                      
                                    ?
                                    Container()
                                     : 
                                     ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(onTap: () {
                                          

final _controllerTurno=context.read<AusenciasController>();
     _controllerTurno.resetListaAusenciasTurno();


// _controllerTurno.setListFechasAusenciaSeleccionadas(_controllerTurno.getFechaValida);
_controllerTurno.setListFechasAusenciaSeleccionadas({"desde":_controllerTurno.getFechaValida.toString()});
// _controllerTurno.setFechaValida(_controllerTurno.getFechaValida.toString());

final _dataTurnoExtra=context.read<TurnoExtraController>();
                    
                        // _dataTurnoExtra.setListFechasTurnoExtra(_controllerTurno.getFechaTurnoExtra);
                        _controllerTurno.setFechaValida(tipoMultaController.getFechaTurnoExtra);

 List _listaPuestos=[];
              _dataTurnoExtra.resetValuesTurnoExtra();






                                          final turnoExtraController =
                                              Provider.of<TurnoExtraController>(
                                                  context,
                                                  listen: false);
                                          turnoExtraController
                                              .resetValuesTurnoExtra();
                                          turnoExtraController
                                              .buscaLstaDataJefeOperaciones('');
                                          final controllerMulta = context.read<
                                              MultasGuardiasContrtoller>();

                                          turnoExtraController.setIdCliente(
                                              int.parse(controllerMulta
                                                  .getIdClienteMulta
                                                  .toString()));
                                          turnoExtraController.setCedulaCliente(
                                              controllerMulta
                                                  .getCedClienteMulta);

                                          turnoExtraController.setNombreCliente(
                                              controllerMulta
                                                  .getNomClienteMulta);

                                          turnoExtraController
                                              .setLabelINuevoPuesto(controllerMulta
                                                  .getlugarTrabajoPersonaMulta);

                                          turnoExtraController
                                              .setLabelMotivoTurnoExtra(
                                                  tipoMultaController
                                                      .getTextoTipoMulta);

                                          turnoExtraController
                                              .onInputFechaInicioChange(
                                                  tipoMultaController
                                                      .getInputFechamulta);

                                          turnoExtraController
                                              .onInputFechaFinChange(
                                                  tipoMultaController
                                                      .getInputFechamulta);

                                          turnoExtraController
                                              .onNumeroDiasChange('1');

                                               turnoExtraController.setListTurPuesto(controllerMulta.getListMultaTurPuesto[0]);

                                        // _controllerTurno.getFechaValida(turnoExtraController.getInputfechaInicio.toString().replaceAll('T', ' '));
                                        // _controllerTurno.getFechaValida('2023-07-22');

                                          Navigator.pushNamed(
                                              context, 'creaTurnoExtra',
                                              arguments: 'MULTA');

                                      



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
                                      ),
                                    ],
                                  ),



                                    ],
                                  ):Container(),
                                

                                ],
                              )
                            : Container();
                      },
                    ),

                    //***********************************************/
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
                      maxLines: 2,
                      decoration: const InputDecoration(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(),
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                      ],
                      onChanged: (text) {
                        tipoMultaController.onInputDetalleNovedadChange(text);
                      },
                      validator: (text) {
                        if (text!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese detalle de la multa';
                        }
                      },
                      onSaved: (value) {},
                    ),
                    //==========================================//
                    tipoMultaController.getListaFotosMultas.isNotEmpty
                        ? _CamaraOption(
                            size: size, multasController: tipoMultaController)
                        : Container(),
                    //*****************************************/
                    //==========================================//
                    tipoMultaController.getPathVideo!.isNotEmpty
                        ? _CamaraVideo(
                            size: size,
                            multasControler: tipoMultaController,
                          )
                        : Container(),
                    //*****************************************/
                    //==========================================//
                    tipoMultaController.getListaCorreosClienteMultas.isNotEmpty
                        ? _CompartirClienta(
                            size: size, multasController: tipoMultaController)
                        : Container(),
                    //*****************************************/
                    //*****************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
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
                backgroundColor: tipoMultaController.getUrlVideo!.isEmpty
                    ? Colors.blue
                    : Colors.grey,
                heroTag: "btnVideo",
                child: tipoMultaController.getUrlVideo!.isEmpty
                    ? const Icon(Icons.videocam_outlined, color: Colors.white)
                    : const Icon(
                        Icons.videocam_outlined,
                        color: Colors.black,
                      ),
                onPressed: tipoMultaController.getUrlVideo!.isEmpty
                    ? () {
                        bottomSheetVideo(tipoMultaController, context, size);
                      }
                    : null,
              ),
              SizedBox(
                height: size.iScreen(1.5),
              ),
            ],
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

    // Navigator.pop(context);
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
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(image!);
      if (imageId == null) {
        return;
      }
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {}
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
                        onTap: () async {
                          // _searchGuardia(multasControler);
                        },
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
    final contextTurno = context.read<TurnoExtraController>();

    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getCedPersonaMulta == null) {
        NotificatiosnService.showSnackBarDanger(
            'Debe asignar a una persona la multa');
      } else if (controller.getGuardiaReemplazo == true&& controller
                                                              .nombreGuardia ==
                                                          '' ||
                                                      controller
                                                              .nombreGuardia ==
                                                          null
      // &&
      //         controller.getIdTurnoEmergente.isEmpty||controller.nombreGuardia!.isEmpty
      //     ||controller.nombreGuardia =='' ||controller.nombreGuardia == null
          ) {
        NotificatiosnService.showSnackBarDanger(
            'Debe asignar guardia de reemplazo');
      } else {
        final conexion = await Connectivity().checkConnectivity();
        if (conexion == ConnectivityResult.none) {
          NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
        } else if (conexion == ConnectivityResult.wifi ||
            conexion == ConnectivityResult.mobile) {
          ProgressDialog.show(context);
          await controller.creaMultaGuardia(context);

          ProgressDialog.dissmiss(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    }
  }


  //****************************************************FECHAS TEMPORALES PARA TRABAJAR CON MULTAS Y TURNOS****************************************************************//



  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaInicio(
      BuildContext context, MultasGuardiasContrtoller multaController) async {
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
      multaController.onInputFechaInicioChange(_fechaInicio);
   
    }
  }

  //================================================= SELECCIONA FECHA FIN ==================================================//
  _selectFechaFin(
      BuildContext context, MultasGuardiasContrtoller multaController) async {
    DateTime? picked = await showDatePicker(
      context: context,
     
      initialDate:DateTime.parse(multaController.getInputfechaInicio),
      firstDate: DateTime.parse(multaController.getInputfechaInicio),
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


        multaController.onInputFechaFinChange(_fechaFin);

      });
    }
  }

  void _seleccionaHoraInicio(
      context, MultasGuardiasContrtoller multaController) async {
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
        multaController.onInputHoraInicioChange(horaInicio);
        //  print('si: $horaInicio');
      });
    }
  }

  void _seleccionaHoraFin(
      context, MultasGuardiasContrtoller multaController) async {
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
        multaController.onInputHoraFinChange(horaFin);
        //  print('si: $horaFin');
      });
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

class _CamaraOption extends StatelessWidget {
  final MultasGuardiasContrtoller multasController;
  const _CamaraOption({
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
            child: Text('Fotografía:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
            child: Wrap(
                children: multasController.getListaFotosMultas
                    .map((e) => _ItemFoto(
                        size: size,
                        multasController: multasController,
                        image: e))
                    .toList()),
          ),
        ],
      ),
      onTap: () {
        print('activa FOTOGRAFIA');
      },
    );
  }
}

class _ItemFoto extends StatelessWidget {
  final CreaNuevaFotoMultas? image;
  final MultasGuardiasContrtoller multasController;

  const _ItemFoto({
    Key? key,
    required this.size,
    required this.multasController,
    required this.image,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Hero(
            tag: image!.id,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.wScreen(90.0),
                  // height: size.hScreen(100.0),
                  padding: EdgeInsets.symmetric(
                    vertical: size.iScreen(0.0),
                    horizontal: size.iScreen(0.0),
                  ),
                  child: getImage(image!.path),
                ),
              ),
            ),
          ),
          onTap: () {
            // Navigator.pushNamed(context, 'viewPhoto');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PreviewScreenMultas(image: image)));
          },
        ),
        Positioned(
          top: -3.0,
          right: 4.0,
          // bottom: -3.0,
          child: IconButton(
            color: Colors.red.shade700,
            onPressed: () {
              multasController.eliminaFoto(image!.id);
              // bottomSheetMaps(context, size);
            },
            icon: Icon(
              Icons.delete_forever,
              size: size.iScreen(3.5),
            ),
          ),
        ),
      ],
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return const FadeInImage(
      placeholder: AssetImage('assets/imgs/loader.gif'),
      image: NetworkImage('url'),
    );
  }

  return Image.file(
    File(picture),
    fit: BoxFit.cover,
  );
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
