import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
// import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/utils/theme.dart';

class CreaAusencia extends StatefulWidget {
final Session? usuario;
final String? action;
 
  const CreaAusencia({Key? key, this.usuario, this.action,}) : super(key: key);

  @override
  State<CreaAusencia> createState() => _CreaAusenciaState();
}

class _CreaAusenciaState extends State<CreaAusencia> {
  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _horaInicioController = TextEditingController();
  TextEditingController _horaFinController = TextEditingController();


  late TimeOfDay timerInicio;
  late TimeOfDay timerFin;

// Session? usuario;

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
   final  _action = widget.action;
    Responsive size = Responsive.of(context);
    
            final _user=context.read<HomeController>();
    //  final _appTheme =context.read<AppTheme>().getPrimaryTextColor;

    //  final _colorTheme=_appTheme;

    final buscaGuardia = context.read<AvisoSalidaController>();

    final ausenciaController = Provider.of<AusenciasController>(context,listen:false);

      // ausenciaController.onInputFechaInicioChange('');
  final ctrlTheme = context.read<ThemeApp>();
       


    return WillPopScope(
            onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              // final controllerMulta = context.read<MultasGuardiasContrtoller>();
          
              return AlertDialog(
                title: const Text('Aviso'),
                content: const Text('¿Desea cancelar la creación del Permiso?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
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
             

                        if(ausenciaController.getlistaGuardiasSeleccionados.isNotEmpty){

                          for (var item in ausenciaController.getlistaGuardiasSeleccionados) {

                             providerTurno.eliminaTurnoExtra(int.parse(item['turId'].toString()));
                            print('EL ID:${item['turId']}');
                             
                          }
                             Navigator.of(context).pop(true);
                        }
                        else{
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
              title: _action == 'CREATE' || _action == 'EXTRA'
                  ? Text(
                      'Crear Permiso',
                      // style: Theme.of(context).textTheme.headline2,
                    )
                  : Text(
                      'Editar Permiso',
                      // style: Theme.of(context).textTheme.headline2,
                    ),
              actions: [

                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(
                            context, ausenciaController, _action.toString());
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
                  //*****************************************/
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

          _action == 'EDIT'?

                  Column(
                    children: [
                      Container(
                        width: size.wScreen(100.0),
    
                        // color: Colors.blue,
                        child: Text('Estado:',
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
                                child: Consumer<AusenciasController>(
                                  builder: (_, persona, __) {
                                    return (persona.getEstadoAusencia == '' ||
                                            persona.getEstadoAusencia == null)
                                        ? Text(
                                            'SELECCIONES ESTADO',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.getEstadoAusencia} ',
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
                      widget.usuario!.rol!.contains('SUPERVISOR')
                           ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  _modalSeleccionaEstado(
                                      size, ausenciaController);
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
                                          Icons.arrow_drop_down,
                                          color: valueTheme.secondaryColor,
                                          size: size.iScreen(2.0),
                                        ),
                                      );
                                    },
                                    )
                              ),
                            ):Container(),
                          ],
                        ),


                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //*****************************************/
                    ],
                  ):Container(),
                 

                  SizedBox(
                    width: size.wScreen(100.0),
    
                    // color: Colors.blue,
                    child: Text('Guardia :',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
    
                widget.usuario!.rol!.contains('GUARDIA')||
                widget.usuario!.rol!.contains('ADMINISTRACION')
                      ? FutureBuilder(
                          future: buscaGuardia.buscaInfoGuardias('${ widget.usuario!.usuario}'),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                            Provider.of<AusenciasController>(context,
                                      listen: false)
                                  .getInfomacionGuardia(snapshot.data['data'][0]);

                            }
                            return Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                top: size.iScreen(1.0),
                                right: size.iScreen(0.5),
                              ),
                              child: Consumer<AusenciasController>(
                                builder: (_, personaData, __) {
                                  return (personaData.nombreGuardia == '' ||
                                          personaData.nombreGuardia == null)
                                      ? Text(
                                          'No hay guardia designado',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      : Text(
                                          '${personaData.nombreGuardia} ',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                            // color: Colors.grey
                                          ),
                                        );
                                },
                              ),
                            );
                          },
                        )
                      : Row(
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  _modalSeleccionaGuardia(
                                      size, ausenciaController);
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
                  Row(
                    children: [
                      SizedBox(
                       child: Text('Cliente ',
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
                                    return (persona.labelMotivoAusencia == '' ||
                                            persona.labelMotivoAusencia == null)
                                        ? Text(
                                            'No hay motivo seleccionado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.labelMotivoAusencia} ',
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  _modalSeleccionaMotivo(
                                      size, ausenciaController);
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


                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
    
                
//                   Column(
//                     children: [
                         
//                          widget.usuario!.rol!.contains('GUARDIA')
//                         ?Container()
//                         :
//                          Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
                           
//                             child: 
                            
                           
//                               Consumer<AusenciasController>(builder: (_, value, __) { 
//                               return Text( 'Guardia Reemplazo: ${ausenciaController.getIdsTurnosEmergente.length}   ',
//                                style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.8),
//                                     fontWeight: FontWeight.normal,
//                                     color: tercearyColor));
//                              },)

//                           ),
//                           SizedBox(
                           
//                             child: 
                            
                          
//                               Consumer<AusenciasController>(builder: (_, value, __) { 
//                               // return Text( 'días: ${value.getSumaDiasPermiso.toString()} / ${value.getInputNumeroDias}',
//                               return Row(
                               
//                                 children: [
//                                   // Text( 'días: ${value.getSumaDiasPermiso.toString()} / ${value.getListFechasAusencia.length.toString()}',
//                                   Text( 'días: ${value.getDiasReemplazo.toString()} / ${value.getListFechasAusencia.length.toString()}',
//                                    style: GoogleFonts.lexendDeca(
//                                         fontSize: size.iScreen(2.0), 
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.grey)),
//                                   SizedBox(width:  size.iScreen(2.0),),


                                  
//                                             _action != 'EDIT'?
//                           Consumer<AusenciasController>(builder: (_, valueCliente, __) { 
//                             return 
                        
//                             // (valueCliente.getInputNumeroDias==null ||valueCliente.getInputNumeroDias=='- - -' 
//                             // ||valueCliente.getInputNumeroDias=='0'
//                             //                     && valueCliente.labelMotivoAusencia==null||valueCliente.labelMotivoAusencia==''
//                             //                     ||widget.usuario!.rol!.contains('GUARDIA')
//                             //                     || valueCliente.getSumaDiasPermiso == int.parse(valueCliente.getInputNumeroDias.toString())
//                             //                     // || valueCliente.getSumaDiasPermiso == value.getListFechasAusencia.length  
//                             //                     || value.getListFechasAusencia.isNotEmpty 
//                             //                     // )
//                             //                     )
//                             //       ?
//                                   // Container()
                            
//                             // :
//                             (value.getListFechasAusencia.isEmpty ||value.getDiasReemplazo ==value.getListFechasAusencia.length
                            
//                             // ||valueCliente.getSumaDiasPermiso!='0'
                            
                            
                            
//                             ?Container()
//                              :ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: GestureDetector(
//                               onTap:
//                               valueCliente.labelMotivoAusencia==null||valueCliente.labelMotivoAusencia==''?
//                                null: ()  async {
                          

// final _dataTurnoExtra=context.read<TurnoExtraController>();
//                         _dataTurnoExtra.buscaLstaDataJefeOperaciones('');

//  List _listaPuestos=[];
//               _dataTurnoExtra.resetValuesTurnoExtra();



//              _dataTurnoExtra.setIdCliente(int.parse(valueCliente.getIdCliente.toString()));
//              _dataTurnoExtra.setCedulaCliente(valueCliente.getListaTodosLosClientes[0]['cliDocNumero']);
//              _dataTurnoExtra.setNombreCliente(valueCliente.getListaTodosLosClientes[0]['cliRazonSocial']);


//              _dataTurnoExtra.setLabelINuevoPuesto(valueCliente.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
          

//              _dataTurnoExtra.setLabelMotivoTurnoExtra(valueCliente.labelMotivoAusencia!);
//             //  _dataTurnoExtra.onInputFechaInicioChange(valueCliente.getInputfechaInicio);
//             //  _dataTurnoExtra.onInputHoraInicioChange(valueCliente.getInputHoraInicio);
//             //  _dataTurnoExtra.onInputFechaFinChange(valueCliente.getInputfechaFin);
//             //  _dataTurnoExtra.onInputHoraFinChange(valueCliente.getInputHoraFin);

//             // _dataTurnoExtra.onNumeroDiasChange(1.toString());
//             _dataTurnoExtra.onNumeroDiasChange(valueCliente.getInputNumeroDias.toString());



//                                    Navigator.pushNamed(
//                                                                 context,
//                                                                 'creaTurnoExtra',
//                                                                 arguments:
//                                                                     'EXTRA');
                               
//                               },
//                               child: Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
//                                       return Container(
//                                         alignment: Alignment.center,
//                                         color: valueTheme.getPrimaryTextColor,
//                                         width: size.iScreen(3.5),
//                                         padding: EdgeInsets.only(
//                                           top: size.iScreen(0.5),
//                                           bottom: size.iScreen(0.5),
//                                           left: size.iScreen(0.5),
//                                           right: size.iScreen(0.5),
//                                         ),
//                                         child: Icon(
//                                           Icons.add,
//                                           color: valueTheme.getSecondryTextColor,
//                                           size: size.iScreen(2.0),
//                                         ),
//                                       );
//                                     },
//                                     )
//                             ),
//                           )
//                          );





//                            },)
//                            :Container(),
//                                 ],
//                               );
//                              },)

//                           ),
//                         ],
//                       ),


                      
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               // color: Colors.red,
//                               padding: EdgeInsets.only(
//                                 top: size.iScreen(1.0),
//                                 right: size.iScreen(0.5),
//                               ),
//                               child: Consumer<AusenciasController>(
//                                 builder: (_, persona, __) {
//                                   return (persona.nombreGuardia == '' ||
//                                           persona.nombreGuardia == null)
//                                       ? Text(
//                                           'No hay guardia designado',
//                                           style: GoogleFonts.lexendDeca(
//                                               fontSize: size.iScreen(1.8),
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.grey),
//                                         )
//                                       : 
                                     
//                                       Consumer<AusenciasController>(builder: (_, valuePuestos, __) { 
//                                           return 
                                          
//                                                  Wrap(children:valuePuestos.getIdsTurnosEmergente.map((e) => 

//                                        Consumer<ThemeApp>(builder: (_, valueItem, __) {  



//                                         return               Container(
//                                         margin: EdgeInsets.symmetric(vertical: size.iScreen(0.3)),
//                                         padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.3)),
//                                         width: size.wScreen(100),
//                                         // color: Colors.green[100],
//                                         color:valueItem.getPrimaryTextColor!,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                       width: size.wScreen(100),
//                                                     child: Text(
//                                                         '${e['turNomPersona']}',
//                                                         style: GoogleFonts.lexendDeca(
//                                                           fontSize: size.iScreen(1.8),
//                                                           fontWeight: FontWeight.normal,
//                                                           color: Colors.white
//                                                         ),
//                                                       ),
//                                                   ),
//                                                       //*****************************************/
//                                                   SizedBox(
//                                                     height: size.iScreen(0.3),
//                                                   ),
//                                               //*****************************************/
//                                                   Container(
                                                   
//                                                      width: size.wScreen(100),
//                                                     child: Text(
//                                                         'Días : ${e['numDias']}',
//                                                         style: GoogleFonts.lexendDeca(
//                                                           fontSize: size.iScreen(1.5),
//                                                           fontWeight: FontWeight.normal,
//                                                           color: Colors.white
//                                                         ),
//                                                       ),
//                                                   ),
//                                                       //*****************************************/
//                                                   SizedBox(
//                                                     height: size.iScreen(0.3),
//                                                   ),
//                                               //*****************************************/
//                                                   Container(
                                                   
//                                                      width: size.wScreen(100),
//                                                     child: Text(
//                                                         'Fechas:',
//                                                         style: GoogleFonts.lexendDeca(
//                                                           fontSize: size.iScreen(1.5),
//                                                           fontWeight: FontWeight.normal,
//                                                           color: Colors.white
//                                                         ),
//                                                       ),
//                                                   ),
//                                                       //*****************************************/
//                                                   SizedBox(
//                                                     height: size.iScreen(0.1),
//                                                   ),
//                                               //*****************************************/
//                                                   Container(
                                                   
//                                                      width: size.wScreen(100),
//                                                     child:      Wrap(
//                                       alignment: WrapAlignment.center,
//                                       children:( e['fechas'] as List)
//                                           .map(
//                                             (e) => Container(
//                                               margin: EdgeInsets.all(
//                                                   size.iScreen(0.6)),
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8.0),
//                                                 child: Container(
//                                                     alignment: Alignment.center,
//                                                     padding: EdgeInsets.all(
//                                                         size.iScreen(0.5)),
//                                                     decoration: BoxDecoration(
//                                                       // color: Colors.grey.shade200,
//                                                       color: Colors.grey.shade100,
//                                                     ),
//                                                     // width: size.iScreen(12.0),
//                                                     child: Row(
//                                                       mainAxisAlignment:MainAxisAlignment.spaceAround,
//                                                       children: [
                                                        
//                                                         Text(
//                                                           e['desde'],
//                                                               // .toString().replaceAll('T',' '),
//                                                               // .substring(0, 10),
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                             fontSize:
//                                                                 size.iScreen(1.8),
//                                                             // color: Colors.white,
//                                                             // fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           e['hasta'],
//                                                               // .toString().replaceAll('T',' '),
//                                                               // .substring(0, 10),
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                             fontSize:
//                                                                 size.iScreen(1.8),
//                                                             // color: Colors.white,
//                                                             // fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
                                                    
//                                                       ],
//                                                     )),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                     )
//                                                   ),
//                                                         //*****************************************/
//                                                   SizedBox(
//                                                     height: size.iScreen(0.5),
//                                                   ),
//                                               //*****************************************/
//                                                 ],
//                                               ),
//                                             ),
//                                               IconButton(onPressed: () async{
//                                               // print('es tipo:${e['turId']}');
//                                                final _turExtra=context.read<TurnoExtraController>();
//                                                final _ausencia=context.read<AusenciasController>();
//                                               _turExtra.eliminaTurnoExtra(e['turId']);
//                                                 persona.eliminaGuardiaTurnoExtra(int.parse(e['turIdPersona'].toString()));
//                                               //  persona.sumaDias(); 
//                                               _ausencia.setDiasReemplazo();
//                                               }, icon: const Icon(Icons.delete_forever),color:Colors.white)
//                                           ],
//                 ),
//                                       );
//                                        },)          
                        
                                      
                                      
                                      
//                                       ).toList());
                                      
                                      
                                      
                                      
//                                        },);
                               
                                      
//                                 },
//                               ),
//                             ),
//                           ),
// //           
                          
//                         ],
//                       ),
                    
                   
                   
                   
//                     ],
//                     //           )
//                     //         : Container();
//                     //   },
//                   ),
    
               
//                      //***********************************************/
                        SizedBox(
                          height: size.iScreen(.0),
                        ),
                        //*****************************************/
                          Container(
                        width: size.wScreen(100.0),
    
                        // color: Colors.blue,
                        child: Text('  Agregar fechas de Permiso:',
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
                          color: Colors.grey.shade50,
                          padding:
                              EdgeInsets.only(top: size.iScreen(0.1),bottom: size.iScreen(0.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Fecha: ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.black45,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Consumer<AusenciasController>(
                                            builder: (_, valueFecha, __) {
                                              return 
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.iScreen(1.0),
                                                    ),
                                                    GestureDetector(
                                                      onTap: valueFecha.nombreGuardia!=''? () {
                                                        // if (_action !=
                                                        //     'MULTA') {
                                                        //   FocusScope.of(context)
                                                        //       .requestFocus(
                                                        //           FocusNode());
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          _selectFechaInicio(
                                                              context,
                                                              valueFecha,
                                                            );
                                                        // }
                                                        // _fecha(context, valueFecha);
                                                      }:(){
                                                        NotificatiosnService.showSnackBarDanger('Debe seleccionar primero un Guardia');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                        valueFecha.getInputfechaInicio==''?  '-- -- --':  valueFecha.getInputfechaInicio.toString().substring(0, 10),
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              color: Colors
                                                                  .black45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: size
                                                                .iScreen(1.0),
                                                          ),
                                                          Consumer<ThemeApp>(
                                                            builder:
                                                                (_, value, __) {
                                                              return Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color: value
                                                                    .primaryColor,
                                                                size: 30,
                                                              );
                                                            },
                                                          ),
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
                                      //     Consumer<AusenciasController>(
                                      //       builder: (_, valueHoraIncio, __) {
                                      //         return Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.start,
                                      //             children: [
                                      //               SizedBox(
                                      //                 width: size.iScreen(1.0),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap:valueHoraIncio.nombreGuardia!=''? () {
                                      //                   FocusScope.of(context)
                                      //                       .requestFocus(
                                      //                           FocusNode());
                                      //                   _seleccionaHoraInicio(
                                      //                       context,
                                      //                       valueHoraIncio);
                                      //                 }:() {
                                      //                   NotificatiosnService.showSnackBarDanger('Debe seleccionar primero un Guardia'); 

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
                                      //                     Consumer<ThemeApp>(
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
                                  // //***********************************************/

                                  // SizedBox(
                                  //   height: size.iScreen(0.0),
                                  // ),

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
                                  //         Consumer<AusenciasController>(
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
                                  //                     // () {
                                                       
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
                                  //                         Consumer<ThemeApp>(
                                  //                             builder: (_,
                                  //                                 value, __) {
                                  //                           return Icon(
                                  //                             Icons
                                  //                                 .date_range_outlined,
                                  //                             color: Colors.grey ,//value.getPrimaryTextColor,
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
                                  //         Consumer<AusenciasController>(
                                  //           builder: (_, valueHoraFin, __) {
                                  //             return Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                 children: [
                                  //                   SizedBox(
                                  //                     width: size.iScreen(1.0),
                                  //                   ),
                                  //                   GestureDetector(
                                  //                     onTap: null,
                                  //                     // () {
                                  //                     //   FocusScope.of(context)
                                  //                     //       .requestFocus(
                                  //                     //           FocusNode());
                                  //                     //   _seleccionaHoraFin(
                                  //                     //       context,
                                  //                     //       valueHoraFin);
                                  //                     // },
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
                                  //                         Consumer<ThemeApp>(
                                  //                             builder: (_,
                                  //                                 value, __) {
                                  //                           return Icon(
                                  //                             Icons
                                  //                                 .access_time_outlined,
                                  //                             color: Colors.grey,
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
                             
                         Consumer  < AusenciasController>(builder: (_, value, __) {  

                                  return   ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap:
                                //    value.getInputfechaInicio!='' 
                                // && value.getInputHoraInicio!=''&& value.getInputfechaFin!=''
                                //  && value.getInputHoraFin!=''?() {
                                   value.getInputfechaInicio!=''
                                ?() {
                                 
                                         String _fechaSeleccionada= value.getInputfechaInicio;
                                          bool _isFecha=false;
                                          print('FECHA ELEGIDA: $_fechaSeleccionada');

                                value.findDate(_fechaSeleccionada);
                                 if (value.getContieneFecha.isNotEmpty) {
                                  _isFecha=true;
                                    Map<String,dynamic>_fecha={};
                                    Map<String, dynamic> _itemTurnoPuesto={}; 
                                     value.onInputFechaInicioChange(value.getContieneFecha['fecha']["desde"].toString().substring(0, value.getContieneFecha['fecha']["desde"].toString().length - 3));
                                    value.onInputFechaFinChange(value.getContieneFecha['fecha']["hasta"].toString().substring(0, value.getContieneFecha['fecha']["hasta"].toString().length - 3));
                                   
                                     
                                _fecha ={
                                    "desde": "${value.getInputfechaInicio}",
                                    "hasta": "${value.getInputfechaFin}",
                                    "id": "${value.getContieneFecha['id']}",
                                    "isSelect":false
                                  };

                             _itemTurnoPuesto={
                                    "idDelete": value.getContieneFecha['id'],
                                    "id": value.getContieneFecha['idDatoOptIngreso'],
                                    "ruccliente":value.getContieneFecha['ruccliente'],
                                    "razonsocial": value.getContieneFecha['razonsocial'],
                                    "ubicacion": value.getContieneFecha['ubicacion'],
                                    "puesto":value.getContieneFecha['puesto']
                                  
                                  };

                                    final _controlTurno=context.read<TurnoExtraController>();
                                  _controlTurno.setPuestoAlterno(value.getContieneFecha['puesto']);
                                   
                                    value.setListFechasAusencia(_fecha);
                                   value.setListTurPuesto(_itemTurnoPuesto);
                                   
                                   
                                    value.onInputFechaInicioChange('');
                                   
                                   
                                  
                                    




                                   
                                 } else {
                                  NotificatiosnService.showSnackBarError('No tiene turno el día  $_fechaSeleccionada');
                                 }




                                      //===========================================================//
                                  //  String _fecha= value.getInputfechaInicio;
                                             

                                              //      bool _isFecha=false;
                                              //      String _labelFecha='';
                                              //  for (var item in ausenciaController.getlistaGuardiasSeleccionados) {
                                              
                                              //                 if(item['fechas']['desde'].toString().substring(0,10)==_fecha){
                                                
                                              //                   _isFecha=true;
                                              //                   _labelFecha=_fecha;
                                              //                 break;
                                              //                 }
                                              //                 else{
                                              //                   _isFecha=false;
                                              //                 }

                                                 
                                              //  }
                            //                    if (_isFecha==true) {
                                                       
                            //                               NotificatiosnService.showSnackBarError('Turno asignado $_labelFecha');
                            //                               _isFecha==false;
                            //                           } else if (_isFecha==false) {
                            //                                 // NotificatiosnService.showSnackBarDanger('Fecha $_fecha eliminada');
                            //                                     //===========================================================//
                            //     //                                   if(value.getPersona=='GUARDIAS' || value.getPersona=='ADMINISTRACION' || value.getPersona=='SUPERVISOR'){
                              

                            //     //  for (var item in buscaGuardia.getListaInfoGuardia) {
                            //     //  ausenciaController.setInfoGuardiaVerificaTurno(item);



                                   
                            //     //  }
                            //     //  }


                            //           //=============== AGREGAMOS VALIDACION  ===================//
                            //               final _controlleravisoSalida=context.read<AusenciasController>();
                            //                      String fechaBuscada = '${value.getInputfechaInicio.substring(0,10)}';

                            //                     //  if(_controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno'] !=null) {

                                                 

                            //           if(_controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno'].isNotEmpty ){
                                      

                            //                             bool encontrada = false;
                            //                             bool _isFechaOk = false;
                            //                              Map<String,dynamic>_fecha={};
                            //                            Map<String, dynamic> _itemTurnoPuesto={};   
                            //                 for (var item in _controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno']) {

                                              // if(item['fechasConsultaDB'].isNotEmpty){

                                              //     for (var e in item['fechasConsultaDB']) {
                                              //       // print('LA DATA ${e['desde']}'); 
                                              //       // print('LA DATA ${item['id']}'); 
                                              //        if (e["desde"].substring(0,10) == fechaBuscada) {
                                              //               encontrada = true;
                                              //               _isFechaOk = true;

                                              //               value.onInputFechaInicioChange(e["desde"].toString().substring(0, e["desde"].toString().length - 3));
                                              //               value.onInputFechaFinChange(e["hasta"].toString().substring(0, e["hasta"].toString().length - 3));
                                              //               break;
                                              //             }
                                                          

                                              //   }
                                                
                                                
                                              // }
                                              
                                              
                                                                                                                                                                  

                            //              if (encontrada) {

                                                   

                           
                            //     _fecha ={
                            //         "desde": "${value.getInputfechaInicio}",
                            //         "hasta": "${value.getInputfechaFin}",
                            //         "id": "${item['id']}",
                            //         "isSelect":false
                            //       };

                            //  _itemTurnoPuesto={
                            //         "idDelete": item['id'],
                            //         "id": item['idDatoOptIngreso'],
                            //         "ruccliente":item['docClienteIngreso'],
                            //         "razonsocial": item['clienteIngreso'],
                            //         "ubicacion": item['clienteUbicacionIngreso'],
                            //         "puesto":item['puestoIngreso']
                                  
                            //       };

                            //         final _controlTurno=context.read<TurnoExtraController>();
                            //       _controlTurno.setPuestoAlterno(item['puestoIngreso']);
                                
                                 

                            //              }
                                        
                            //                 }
                                            
                            //             if(_isFechaOk==true){
                            //               print('la fecha es : $_fecha');
                            //                value.setListFechasAusencia(_fecha);
                            //                value.setListTurPuesto(_itemTurnoPuesto);

                                           
                            //             }else
                            //             {
                            //                 NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                            //             }



                            //           }

                                     


                            //                                     //===========================================================//
                                                            
                            //                           _isFecha==false;
                                                      
                            //                       }
                                                  
                               //===========================================================//



                                //  if(value.getPersona=='GUARDIAS'){
                              

                                //  for (var item in buscaGuardia.getListaInfoGuardia) {
                                //  ausenciaController.setInfoGuardiaVerificaTurno(item);



                                   
                                //  }
                                //  }


                                //   //    //=============== AGREGAMOS VALIDACION  ===================//
                                //           final _controlleravisoSalida=context.read<AusenciasController>();
                                //                  String fechaBuscada = '${value.getInputfechaInicio.substring(0,10)}';
                                //       if(_controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno'].isNotEmpty){
                                      

                                //                         bool encontrada = false;
                                //                         bool _isFechaOk = false;
                                //                          Map<String,dynamic>_fecha={};
                                //             for (var item in _controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno']) {

                                //               if(item['fechasConsultaDB'].isNotEmpty){

                                //                   for (var e in item['fechasConsultaDB']) {
                                //                     // print('LA DATA ${e['desde']}'); 
                                //                     // print('LA DATA ${item['id']}'); 
                                //                      if (e["desde"].substring(0,10) == fechaBuscada) {
                                //                             encontrada = true;
                                //                             _isFechaOk = true;

                                //                             value.onInputFechaInicioChange(e["desde"].toString().substring(0, e["desde"].toString().length - 3));
                                //                             value.onInputFechaFinChange(e["hasta"].toString().substring(0, e["hasta"].toString().length - 3));
                                //                             break;
                                //                           }
                                                          

                                //                 }
                                                
                                                
                                //               }
                                              
                                              
                                                                                                                                                                  

                                //          if (encontrada) {
                                                        

                           
                                // _fecha ={
                                //     "desde": "${value.getInputfechaInicio}",
                                //     "hasta": "${value.getInputfechaFin}",
                                //     "id": "${item['id']}",
                                //     "isSelect":false
                                //   };
                           
                                 

                                //          }
                                        
                                //             }
                                            
                                //         if(_isFechaOk==true){
                                //           print('la fecha es : $_fecha');
                                //            value.setListFechasAusencia(_fecha);
                                           
                                //         }else
                                //         {
                                //             NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                                //         }



                                //       }








                                 
                                }:null, child: Consumer<ThemeApp>(
                                  builder: (_, valueTheme, __) {
                                    return 
                                    value.nombreGuardia!=''
                                   ? Container(
                                        alignment: Alignment.center,
                                        // color:value.getInputfechaInicio!='' && value.getInputHoraInicio!=''
                                        // && value.getInputfechaFin!='' && value.getInputHoraFin!=''
                                        //  ?valueTheme.getPrimaryTextColor : Colors.grey.shade500  ,
                                        // width: size.iScreen(9.0),
                                        color:value.getInputfechaInicio!='' 
                                         ?valueTheme.primaryColor : Colors.grey.shade500  ,
                                        width: size.iScreen(9.0),
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
                                        ):Container();
                                  },
                                )),
                              );

                             }, )
                             
                             
                            ],
                          ),
                        ),

                 

                        Consumer<AusenciasController>(
                          builder: (_, itemFechas, __) {
                            return
                           Consumer <ThemeApp>(builder: ( _, value,  __) {  

                              if(itemFechas.getListFechasAusencia.isEmpty){


                                itemFechas.resetListaAusenciasTurno();
                              }


                            return  
                            itemFechas.getListFechasAusencia.isNotEmpty
                           ?  
                           
                           Container(
                              color: Colors.white,
                              // alignment: Alignment.,
                              width: size.wScreen(100.0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(0.0),
                                  vertical: size.iScreen(0.1)),
                              child: itemFechas.getListFechasAusencia!= []
                                  ?
                                   Wrap(
                                      alignment: WrapAlignment.center,
                                      children: itemFechas
                                          .getListFechasAusencia
                                          .map(
                                            (e) => 
                                            
    //                                                                             
                                       // =======================================//
                                                     Container(
                                                margin: EdgeInsets.all(
                                                    size.iScreen(0.2)),
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
                                                            .grey.shade200,
                                                      ),
                                                      // width: size.iScreen(12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                        
                                                        
                                                        
                                                        
                                                          Consumer<AusenciasController>(builder: (_, value, __) {  
                                                            return  
                                                            value.getIdsTurnosEmergente.isEmpty?
                                                            
                                                             GestureDetector(
                                                            onTap: (){
                                                            
                                                                
                                                                // if(ausenciaController.getIdsTurnosEmergente.isEmpty){
                                                                //    itemFechas.deleteItemFecha(e);
                                                                // }
                                                                  
                                                                
                                                                //===========================================================//
                                                                     String _fecha=e['desde'].toString().substring(0,10);


                                                   bool _isFecha=false;
                                                   String _labelFecha='';
                                               for (var item in ausenciaController.getlistaGuardiasSeleccionados) {
                                              
                                                              if(item['fechas']['desde'].toString().substring(0,10)==_fecha){
                                                
                                                                _isFecha=true;
                                                                _labelFecha=_fecha;
                                                              break;
                                                              }
                                                              else{
                                                                _isFecha=false;
                                                              }

                                                 
                                               }
                                               if (_isFecha==true) {
                                                       
                                                          NotificatiosnService.showSnackBarError('Turno asignado $_labelFecha');
                                                          _isFecha==false;
                                                      } else if (_isFecha==false) {
                                                             itemFechas.deleteItemFecha(e);
                                                             itemFechas.deleteItemTurPuesto(e);
                                                            NotificatiosnService.showSnackBarDanger('Fecha $_fecha eliminada, agregue otra fecha');
                                                      _isFecha==false;
                                                      
                                                  }
                                                                //===========================================================//






                                                            },
                                                            child: const Icon(Icons.remove_circle_outline,color: Colors.red,)):Container();
                                                          },),
                                                       
                                                          
                                                          Text(
                                                            e['desde'].toString().replaceAll("T", ' '),
                                                            // .toString().replaceAll('T',' '),
                                                            // .substring(0, 10),
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                           Text(
                                                                       "/",
                                                                      style: GoogleFonts
                                                                          .lexendDeca(
                                                                        fontSize:
                                                                            size.iScreen(1.8),
                                                                      
                                                                      ),
                                                                    ),
                                                          Text(
                                                            e['hasta'].toString().replaceAll("T", ' '),
                                                           
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),
                                                          ),

                                                      ausenciaController.getPersona!='GUARDIAS' || ausenciaController.getPersona!='ADMINISTRACION'?    ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: GestureDetector(onTap: itemFechas.getDiasReemplazo ==itemFechas.getListFechasAusencia.length ||widget.usuario!.rol!.contains('GUARDIA')
                                                  ?null: () {
                                          
                                           
                                              String _fecha=e['desde'].toString().substring(0,10);
                                              //  print('la fecha: ${e['desde'].toString().substring(0,10)}');

                                                   bool _isFecha=false;
                                                   String _labelFecha='';
                                               for (var item in ausenciaController.getlistaGuardiasSeleccionados) {
                                                //  print('ESTA FECHA: ${item['fechas'][0]['desde'].toString().substring(0,10)}');
                                                              if(item['fechas']['desde'].toString().substring(0,10)==_fecha){
                                                //  print('ESTA FECHA: ${item['fechas']['desde'].toString().substring(0,10)}');
                                                                _isFecha=true;
                                                                _labelFecha=_fecha;
                                                              break;
                                                              }
                                                              else{
                                                                _isFecha=false;
                                                              }

                                                 
                                               }
                                               if (_isFecha==true) {
                                                        // print("The date $targetDate exists in the list.");
                                                          NotificatiosnService.showSnackBarError('Turno asignado $_labelFecha');
                                                          _isFecha==false;
                                                      } else if (_isFecha==false) {
                                                            // NotificatiosnService.showSnackBarDanger('No tiene Turno asignado $_labelFecha');
                                                      _isFecha==false;
                                                       //=============================================//
                                                    if(itemFechas.labelMotivoAusencia!=''){
                                                   
                                                      itemFechas.setFechaValida(e);

                                              final _data={
                                                           "desde":"${e['desde']}",
                                                           "hasta":"${e['hasta']}",
                                                        };

                                                      // ausenciaController.setListFechasAusenciaSeleccionadas(_data);         

                                                            final _dataTurnoExtra=context.read<TurnoExtraController>();
                                                            _dataTurnoExtra.buscaLstaDataJefeOperaciones('');
                                                              _dataTurnoExtra.setListFechasTurnoExtra(e);

                                                    List _listaPuestos=[];
                                                    _dataTurnoExtra.resetValuesTurnoExtra();

                                                  _dataTurnoExtra.setIdCliente(int.parse(itemFechas.getIdCliente.toString()));
                                                  _dataTurnoExtra.setCedulaCliente(itemFechas.getListaTodosLosClientes[0]['cliDocNumero']);
                                                  _dataTurnoExtra.setNombreCliente(itemFechas.getListaTodosLosClientes[0]['cliRazonSocial']);
                                                  _dataTurnoExtra.setLabelINuevoPuesto(itemFechas.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
                                                
                                                  // _dataTurnoExtra.setLabelINuevoPuesto( _dataTurnoExtra.getPuestoAlterno);

                                                  // _dataTurnoExtra.setIdCliente(int.parse(itemFechas.getIdCliente.toString()));
                                                  // _dataTurnoExtra.setCedulaCliente(itemFechas.getListTurPuesto[0]['ruccliente']);
                                                  // _dataTurnoExtra.setNombreCliente(itemFechas.getListTurPuesto[0]['razonsocial']);
                                                  _dataTurnoExtra.setLabelINuevoPuesto( itemFechas.getListTurPuesto[0]['puesto']);


                                                  _dataTurnoExtra.setLabelMotivoTurnoExtra(itemFechas.labelMotivoAusencia!);


                                                  _dataTurnoExtra.setListTurPuesto(itemFechas.getListTurPuesto[0]);

                                              




                                                
                                                  _dataTurnoExtra.onNumeroDiasChange('1');
                                                  Navigator.pushNamed( context, 'creaTurnoExtra',arguments: 'EXTRA');
                                                    }
                                                    else{
                                                       NotificatiosnService.showSnackBarDanger('Seleccione motivo de permiso ');
                                                    }
                                                   //=============================================//
                                                      }


                                                    // _verificaFehaAgregada(_fecha,ausenciaController.getlistaGuardiasSeleccionados,context);

                                                       
                                              

                                                   //=============================================//
                                              //       if(itemFechas.labelMotivoAusencia!=''){
                                                   
                                              //         itemFechas.setFechaValida(e);

                                              // final _data={
                                              //              "desde":"${e['desde']}",
                                              //              "hasta":"${e['hasta']}",
                                              //           };

                                              //         // ausenciaController.setListFechasAusenciaSeleccionadas(_data);         

                                              //               final _dataTurnoExtra=context.read<TurnoExtraController>();
                                              //               _dataTurnoExtra.buscaLstaDataJefeOperaciones('');
                                              //                 _dataTurnoExtra.setListFechasTurnoExtra(e);

                                              //       List _listaPuestos=[];
                                              //       _dataTurnoExtra.resetValuesTurnoExtra();

                                              //     _dataTurnoExtra.setIdCliente(int.parse(itemFechas.getIdCliente.toString()));
                                              //     _dataTurnoExtra.setCedulaCliente(itemFechas.getListaTodosLosClientes[0]['cliDocNumero']);
                                              //     _dataTurnoExtra.setNombreCliente(itemFechas.getListaTodosLosClientes[0]['cliRazonSocial']);
                                              //     _dataTurnoExtra.setLabelINuevoPuesto(itemFechas.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
                                              //     _dataTurnoExtra.setLabelMotivoTurnoExtra(itemFechas.labelMotivoAusencia!);
                                                
                                              //     _dataTurnoExtra.onNumeroDiasChange('1');
                                              //     Navigator.pushNamed( context, 'creaTurnoExtra',arguments: 'EXTRA');
                                              //       }
                                              //       else{
                                              //          NotificatiosnService.showSnackBarDanger('Seleccione motivo de permiso ');
                                              //       }
                                                   //=============================================//

                                                  
                              }, child: 
                              
                              ausenciaController.getPersona=='GUARDIAS' || ausenciaController.getPersona=='ADMINISTRACION'?
                             Container(): Consumer<ThemeApp>(
                                builder: (_, valueTheme, __) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color:valueTheme.primaryColor,
                                    width: size.iScreen(3.5),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: valueTheme.secondaryColor,
                                      size: size.iScreen(2.0),
                                    ),
                                  );
                                },
                              )),
                            ):Container(),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                       // =======================================//

                                        
                                        
                                        
                                          )
                                          .toList(),
                                    )
                                  : Text('Seleccione fecha de permiso',style: GoogleFonts
                                                                .lexendDeca(
                                                              fontSize:
                                                                  size.iScreen(1.8),
                                                              // color: Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                            ),),

                             
                            ) : Container(
                        width: size.wScreen(100.0),
                        color:Colors.grey.shade200,
                        padding: EdgeInsets.all(size.iScreen(0.5)),
                         child: Text('No tiene fechas agregadas',style: GoogleFonts
                                                                  .lexendDeca(
                                                                fontSize:
                                                                    size.iScreen(1.8),
                                                                color: Colors.black38,
                                                                // fontWeight: FontWeight.bold,
                                                              ),),
                       );
                            
                            
                           });
                               
                            
                            
                            //*****************************************/
                          },
                        ), 


  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
  //*****************************************/
    
                
                  Column(
                    children: [
                         
                         widget.usuario!.rol!.contains('GUARDIA')||
                         widget.usuario!.rol!.contains('ADMINISTRACION')
                        ?Container()
                        :
                         Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                           
                            child: 
                            
                           
                              Consumer<AusenciasController>(builder: (_, value, __) { 
                              return Text( 'Guardia Reemplazo: ${ausenciaController.getlistaGuardiasSeleccionados.length}   ',
                               style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    fontWeight: FontWeight.normal,
                                    color: tercearyColor));
                             },)

                          ),
                          SizedBox(
                           
                            child: 
                            
                          
                              Consumer<AusenciasController>(builder: (_, value, __) { 
                            
                              return Row(
                               
                                children: [
                                 
                                  Text( 'días: ${value.getlistaGuardiasSeleccionados.length.toString()} / ${value.getListFechasAusencia.length.toString()}',
                                   style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(2.0), 
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                                  SizedBox(width:  size.iScreen(2.0),),


                                  
//                                             _action != 'EDIT'?
//                           Consumer<AusenciasController>(builder: (_, valueCliente, __) { 
//                             return 
                        
//                             // (valueCliente.getInputNumeroDias==null ||valueCliente.getInputNumeroDias=='- - -' 
//                             // ||valueCliente.getInputNumeroDias=='0'
//                             //                     && valueCliente.labelMotivoAusencia==null||valueCliente.labelMotivoAusencia==''
//                             //                     ||widget.usuario!.rol!.contains('GUARDIA')
//                             //                     || valueCliente.getSumaDiasPermiso == int.parse(valueCliente.getInputNumeroDias.toString())
//                             //                     // || valueCliente.getSumaDiasPermiso == value.getListFechasAusencia.length  
//                             //                     || value.getListFechasAusencia.isNotEmpty 
//                             //                     // )
//                             //                     )
//                             //       ?
//                                   // Container()
                            
//                             // :
//                             (value.getListFechasAusencia.isEmpty 
//                             ||value.getDiasReemplazo ==value.getListFechasAusencia.length 
//                             ||value.getListFechasAusenciaSeleccionadas.isEmpty
//                             ||valueCliente.labelMotivoAusencia==null||valueCliente.labelMotivoAusencia==''|| widget.usuario!.rol!.contains('GUARDIA')
                            
//                             // ||valueCliente.getSumaDiasPermiso!='0'
                            
                            
                            
//                             ?Container()
//                              :
//                              ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: GestureDetector(
//                               onTap:
//                               valueCliente.labelMotivoAusencia==null||valueCliente.labelMotivoAusencia==''?
//                                null
                           
                               
//                                : ()  async {
                          

// final _dataTurnoExtra=context.read<TurnoExtraController>();
//                         _dataTurnoExtra.buscaLstaDataJefeOperaciones('');

//  List _listaPuestos=[];
//               _dataTurnoExtra.resetValuesTurnoExtra();



//              _dataTurnoExtra.setIdCliente(int.parse(valueCliente.getIdCliente.toString()));
//              _dataTurnoExtra.setCedulaCliente(valueCliente.getListaTodosLosClientes[0]['cliDocNumero']);
//              _dataTurnoExtra.setNombreCliente(valueCliente.getListaTodosLosClientes[0]['cliRazonSocial']);


//              _dataTurnoExtra.setLabelINuevoPuesto(valueCliente.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
          

//              _dataTurnoExtra.setLabelMotivoTurnoExtra(valueCliente.labelMotivoAusencia!);
//             //  _dataTurnoExtra.onInputFechaInicioChange(valueCliente.getInputfechaInicio);
//             //  _dataTurnoExtra.onInputHoraInicioChange(valueCliente.getInputHoraInicio);
//             //  _dataTurnoExtra.onInputFechaFinChange(valueCliente.getInputfechaFin);
//             //  _dataTurnoExtra.onInputHoraFinChange(valueCliente.getInputHoraFin);

//             // _dataTurnoExtra.onNumeroDiasChange(1.toString());
//             _dataTurnoExtra.onNumeroDiasChange(valueCliente.getInputNumeroDias.toString());



//                                    Navigator.pushNamed(
//                                                                 context,
//                                                                 'creaTurnoExtra',
//                                                                 arguments:
//                                                                     'EXTRA');
                               
//                               },
//                               child: Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
//                                       return Container(
//                                         alignment: Alignment.center,
//                                         color: valueTheme.getPrimaryTextColor,
//                                         width: size.iScreen(5.5),
//                                         padding: EdgeInsets.only(
//                                           top: size.iScreen(0.5),
//                                           bottom: size.iScreen(0.5),
//                                           left: size.iScreen(0.5),
//                                           right: size.iScreen(0.5),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             SizedBox(width: size.iScreen(0.2),),
//                                             Text('${value.getListFechasAusenciaSeleccionadas.length}', style: GoogleFonts.lexendDeca(
//                                     fontSize: size.iScreen(1.8),
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white)),
//                                             Icon(
//                                               Icons.add,
//                                               color: valueTheme.getSecondryTextColor,
//                                               size: size.iScreen(2.0),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                     )
//                             ),
//                           )
//                          );





//                            },)
//                            :Container(),
                                ],
                              );
                             },)

                          ),
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
                                  return (persona.nombreGuardia == '' ||
                                          persona.nombreGuardia == null)
                                      ? Text(
                                          'No hay guardia designado',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      :  Wrap(children:persona.getlistaGuardiasSeleccionados.map((e) => 

                                       Consumer<ThemeApp>(builder: (_, valueItem, __) {  



                                        return               Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                        color:valueItem.primaryColor,
                                          ),
                                        margin: EdgeInsets.symmetric(vertical: size.iScreen(0.3)),
                                        padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.3)),
                                        width: size.wScreen(100),
                                        // color: Colors.green[100],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      width: size.wScreen(100),
                                                    child: Text(
                                                        '${e['turNomPersona']}',
                                                        style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.8),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.white
                                                        ),
                                                      ),
                                                  ),
                                                      //*****************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.3),
                                                  ),
                                              //*****************************************/
                                                  Container(
                                                   
                                                     width: size.wScreen(100),
                                                    child: Text(
                                                        'Días : ${e['numDias']}',
                                                        style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.5),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.white
                                                        ),
                                                      ),
                                                  ),
                                                      //*****************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.3),
                                                  ),
                                              //*****************************************/
                                                  Container(
                                                   
                                                     width: size.wScreen(100),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                           width: size.iScreen(6.0),
                                                          child: Text(
                                                              'Fecha: ',
                                                              style: GoogleFonts.lexendDeca(
                                                                fontSize: size.iScreen(1.5),
                                                                fontWeight: FontWeight.normal,
                                                                color: Colors.white
                                                              ),
                                                            ),
                                                        ),
                                                        Container(
                                                         
                                                          width: size.iScreen(30.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                  '${e['fechas']['desde'].toString().replaceAll("T", " ")}',
                                                                  style: GoogleFonts.lexendDeca(
                                                                    fontSize: size.iScreen(1.6),
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white
                                                                  ),
                                                                ),
                                                          
                                                          Text(
                                                              '/',
                                                              style: GoogleFonts.lexendDeca(
                                                                fontSize: size.iScreen(1.6),
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                              ),
                                                            ),
                                                          Text(
                                                              '${e['fechas']['hasta'].toString().replaceAll("T", " ")}',
                                                              style: GoogleFonts.lexendDeca(
                                                                fontSize: size.iScreen(1.6),
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                              ),
                                                            ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                      //*****************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.1),
                                                  ),
                                              //*****************************************/
                                    //               Container(
                                                   
                                    //                  width: size.wScreen(100),
                                    //                 child:      Wrap(
                                    //   alignment: WrapAlignment.center,
                                    //   children:( e['fechas'] as List)
                                    //       .map(
                                    //         (e) => Container(
                                    //           margin: EdgeInsets.all(
                                    //               size.iScreen(0.6)),
                                    //           child: ClipRRect(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(8.0),
                                    //             child: Container(
                                    //                 alignment: Alignment.center,
                                    //                 padding: EdgeInsets.all(
                                    //                     size.iScreen(0.5)),
                                    //                 decoration: BoxDecoration(
                                    //                   // color: Colors.grey.shade200,
                                    //                   color: Colors.grey.shade100,
                                    //                 ),
                                    //                 // width: size.iScreen(12.0),
                                    //                 child: Row(
                                    //                   mainAxisAlignment:MainAxisAlignment.spaceAround,
                                    //                   children: [
                                                        
                                    //                     Text(
                                    //                       e['desde'],
                                    //                           // .toString().replaceAll('T',' '),
                                    //                           // .substring(0, 10),
                                    //                       style: GoogleFonts
                                    //                           .lexendDeca(
                                    //                         fontSize:
                                    //                             size.iScreen(1.8),
                                    //                         // color: Colors.white,
                                    //                         // fontWeight: FontWeight.bold,
                                    //                       ),
                                    //                     ),
                                    //                      Text(
                                    //                                    "/",
                                    //                                   style: GoogleFonts
                                    //                                       .lexendDeca(
                                    //                                     fontSize:
                                    //                                         size.iScreen(1.8),
                                    //                                     // color: Colors.white,
                                    //                                     // fontWeight: FontWeight.bold,
                                    //                                   ),
                                    //                                 ),
                                    //                     Text(
                                    //                       e['hasta'],
                                    //                           // .toString().replaceAll('T',' '),
                                    //                           // .substring(0, 10),
                                    //                       style: GoogleFonts
                                    //                           .lexendDeca(
                                    //                         fontSize:
                                    //                             size.iScreen(1.8),
                                    //                         // color: Colors.white,
                                    //                         // fontWeight: FontWeight.bold,
                                    //                       ),
                                    //                     ),
                                                    
                                    //                   ],
                                    //                 )),
                                    //           ),
                                    //         ),
                                    //       )
                                    //       .toList(),
                                    // )
                                                 
                                                        //*****************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.5),
                                                  ),
                                              //*****************************************/
                                                ],
                                              ),
                                            ),
                                          IconButton(onPressed: () async{
                                              // print('es tipo:${e['turId']}');
                                               final _turExtra=context.read<TurnoExtraController>();
                                               final _ausencia=context.read<AusenciasController>();
                                              // _turExtra.eliminaTurnoExtra(e['turId']);
                                                // persona.eliminaGuardiaTurnoExtra(int.parse(e['turId'].toString()));
                                              _turExtra.eliminaTurnoExtra(int.parse(e['turId'].toString()));
                                                persona.eliminalistaGuardiasSeleccionados(int.parse(e['turId'].toString()));
                                              //  persona.sumaDias(); 
                                              _ausencia.setDiasReemplazo();
                                              }, icon: const Icon(Icons.delete_forever),color:Colors.white)
                                          ],
                ),
                                      );
                                       },)          
                        
                                      
                                      
                                      
                                      ).toList());
                                      // Consumer<AusenciasController>(builder: (_, valuePuestos, __) { 
                                      //     return 
                                          
                                                
                                      
                                      
                                      
                                      
                                      //  },);
                               
                                      
                                },
                              ),
                            ),
                          ),
//           
                          
                        ],
                      ),
                    
                   
                   
                   
                    ],
                    //           )
                    //         : Container();
                    //   },
                  ),
    
                      // Container(
                      //   width: size.wScreen(30.0),
    
                      //   // color: Colors.blue,
                      //   child: Text('Días Permiso:',
                      //       style: GoogleFonts.lexendDeca(
                      //           // fontSize: size.iScreen(2.0),
                      //           fontWeight: FontWeight.normal,
                      //           color: Colors.grey)),
                      // ),
               
                      // Container(
                      //   width: size.wScreen(30.0),
    
                      //   // color: Colors.blue,
                      //   child: Consumer<AusenciasController>(builder: (BuildContext context, value, Widget? child) { 
                      //     return Text('${value.getListFechasAusenciaSeleccionadas}',
                      //       style: GoogleFonts.lexendDeca(
                      //           // fontSize: size.iScreen(2.0),
                      //           fontWeight: FontWeight.normal,
                      //           color: Colors.grey));
                      //    },),
               
                      // ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
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
                        child: Consumer<AusenciasController>(builder: (_, value, __) { 
                          value.onNumeroDiasChange(value.getListFechasAusencia.length.toString());
                          // return Text( value.getInputNumeroDias!,
                          return Text( value.getListFechasAusencia.length.toString(),
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54));
                         },)
                      ),
                    ],
                  ),
                  

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),
    
                  
                    child: Text('Detalle:',
                        style: GoogleFonts.lexendDeca(
                         
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  TextFormField(
                    initialValue: _action == 'CREATE'
                              ? ''
                              : ausenciaController.getInputDetalle,
                    decoration: const InputDecoration(
                       
                        ),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
    
                        ),
                      textInputAction: TextInputAction.done,
                         inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@#-+.,{""}\\s]")),],
                    onChanged: (text) {

                        


          ausenciaController.onDetalleChange(text);


                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese detalle del Permiso';
                      }
                    },
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                
                  //==========================================//
                  ausenciaController.getListaFotosInforme.isNotEmpty
                      ? _CamaraOption(
                          size: size, ausenciasController: ausenciaController)
                      : Container(),
                 
               
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
           
            SizedBox(
              height: size.iScreen(1.5),
            ),
    
            SizedBox(
              height: size.iScreen(1.5),
            ),
          ],
        ),
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
                    // urls.launchWaze(lat, lng);s
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
  void _onSubmit(BuildContext context, AusenciasController controller,String? _action) async {

final controllerMultas=context.read<MultasGuardiasContrtoller>();
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {

//       if (controller.nombreGuardia == '' || controller.nombreGuardia == null) {
//         NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
//       } else if (controller.nombreCliente == null ||
//           controller.nombreCliente == '') {
//         NotificatiosnService.showSnackBarDanger('Debe seleccionar Cliente');
//       } else if (controller.labelMotivoAusencia == null) {
//         NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo');
//       }  
     
//       else 
//       if (controller.getDiasReemplazo!<controller.getListFechasAusencia.length&& widget.usuario!.rol!.contains('SUPERVISOR')) {
//         NotificatiosnService.showSnackBarDanger('Falta completar días de reemplazo ');
//         }
//       else 
//       if (controller.getListFechasAusencia.isEmpty&& widget.usuario!.rol!.contains('GUARDIA')||controller.getListFechasAusencia.isEmpty&& widget.usuario!.rol!.contains('ADMINISTRACION')) {
//         NotificatiosnService.showSnackBarDanger('Debe agregar fecha de permiso ');
//         }
      
//       else if (controller.getIdsTurnosEmergente.isEmpty&& widget.action!='EDIT' && widget.usuario!.rol!.contains('SUPERVISOR')) {
//         NotificatiosnService.showSnackBarDanger('Debe asignar Guardia de reemplazo');
//         }
//       else if (controller.getDiasReemplazo!=controller.getListFechasAusencia.length&& widget.usuario!.rol!.contains('SUPERVISOR')) {
//         NotificatiosnService.showSnackBarDanger('El número de días de permiso no coincide con los días de los Guardias');
//         }
     
      
//  else  if (controller.nombreGuardia!.isNotEmpty ||
//             controller.nombreGuardia != null &&
//                 controller.nombreCliente!.isNotEmpty ||
//             controller.nombreCliente != null &&
//                 controller.labelMotivoAusencia!.isNotEmpty ||
//             controller.labelMotivoAusencia != null  &&controller.getDiasReemplazo ==controller.getListFechasAusencia.length
//           ) {
//           if (_action == 'CREATE') {
//             await controller.crearAusencia(context);

//             Navigator.pop(context);
//           }else
//           if (_action == 'EDIT') {
//             await controller.editaAusencia(context);
//             Navigator.pop(context);
           
            


//           }
        

//         }
      if (controller.nombreGuardia == '' || controller.nombreGuardia == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
      } else if (controller.nombreCliente == null ||
          controller.nombreCliente == '') {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar Cliente'); 
      } else if (controller.labelMotivoAusencia == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo');
      }  
     
      else 
      if (controller.getListFechasAusencia.isEmpty& widget.usuario!.rol!.contains('SUPERVISOR')) {
        NotificatiosnService.showSnackBarDanger('Falta completar días de reemplazo ');
        }
      else 
      if (controller.getListFechasAusencia.isEmpty&& widget.usuario!.rol!.contains('GUARDIA')||controller.getListFechasAusencia.isEmpty&& widget.usuario!.rol!.contains('ADMINISTRACION')) {
        NotificatiosnService.showSnackBarDanger('Debe agregar fecha de permiso ');
        }
           
      else if (controller.getlistaGuardiasSeleccionados.length!=controller.getListFechasAusencia.length&& widget.usuario!.rol!.contains('SUPERVISOR')) {
        NotificatiosnService.showSnackBarDanger('El número de días de permiso no coincide con los días de los Guardias');
        }
     
      
 else  if (controller.nombreGuardia!.isNotEmpty ||
            controller.nombreGuardia != null &&
                controller.nombreCliente!.isNotEmpty ||
            controller.nombreCliente != null &&
                controller.labelMotivoAusencia!.isNotEmpty ||
            controller.labelMotivoAusencia != null  &&controller.getlistaGuardiasSeleccionados.length ==controller.getListFechasAusencia.length
          ) {
          if (_action == 'CREATE') {
            await controller.crearAusencia(context);

            Navigator.pop(context);
          }else
          if (_action == 'EDIT') {
            await controller.editaAusencia(context);
            Navigator.pop(context);
           
            


          }
        

        }
    }
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaGuardia(
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
                          _validaScanQRGuardia(ausenciasController);
                        
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
  //====== MUESTRA MODAL DE MOTIVO =======//
  void _modalSeleccionaMotivo(
      Responsive size, AusenciasController ausenciasController) {

final  _data=[
                      'ENFERMEDAD IESS',
                      'PERMISO PERSONAL',
                      'PATERNIDAD',
                      'DEFUNCION FAMILIAR',
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
          onTap: (){
            ausenciasController.setLabelMotivoAusencia( _data[index]);
             Navigator.pop(context);
          },
          child: Container(color: Colors.grey[100],
          margin: EdgeInsets.symmetric(vertical: size.iScreen(0.3)),
          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(1.0)),
            child:Text(
                        _data[index],
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),),
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
  //====== MUESTRA MODAL DE ESTADO =======//
  void _modalSeleccionaEstado(
      Responsive size, AusenciasController ausenciasController) {

final  _data=[
                      'EN PROCESO',
                      'APROBADO',
                      'ANULADA',
                      
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
                      Text('SELECCIONAR ESTADO',
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
                    height: size.hScreen(15),
                    child: ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            ausenciasController.setEstadoAusencia( _data[index]);
             Navigator.pop(context);
          },
          child: Container(color: Colors.grey[100],
          margin: EdgeInsets.symmetric(vertical: size.iScreen(0.3)),
          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(1.0)),
            child:Text(
                        _data[index],
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),),
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

  //================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFechaInicio(
      BuildContext context, AusenciasController ausenciasController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime.now(),
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
     
      initialDate:DateTime.parse(ausenciasController.getInputfechaInicio),
      firstDate: DateTime.parse(ausenciasController.getInputfechaInicio),
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
        //  print('si: $horaInicio');
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
        //  print('si: $horaFin');
      });
    }
  }

  //======================== VALIDA SCANQRgUARDIA =======================//
  void _validaScanQRGuardia(AusenciasController ausenciasController) async {
    ausenciasController.setInfoQRGuardia(
        await FlutterBarcodeScanner.scanBarcode(
            '#34CAF0', '', false, ScanMode.QR));
    if (!mounted) return;
    Navigator.pop(context);
  }

  //====== MUESTRA AGREGAR PEDIDO =======//
  void _modalAgregarDias(
      Responsive size,AusenciasController ausenciasController) {
    
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(2.0), vertical: size.wScreen(1.0)),
              content: Form(
               
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AGREGAR DIAS',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
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
                    //*****************************************/
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                //  color: Colors.red,
                                width: size.wScreen(29.0),
                                child: Text(
                                  '# de Días:',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.black45,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                               Expanded(
                                 child: TextFormField(
                                               // controller: textSearchGuardias,
                                               autofocus: true,
                                               textAlign: TextAlign.center,
                                               onChanged: (value){
                                                  ausenciasController.onNumeroDiasChange(value);
                                               },),
                               )

                            ],
                          ),
                           SizedBox(
                        height: size.iScreen(0.5),
                      ),
                       TextButton(onPressed: (){
                      //  ausenciasController.onNumeroDiasChange(text)


                       }, child: 
                            
                   Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        )
                        ],
                      ),
                    ),
                 
                  ],
                ),
              ),
 
            ),
          );
        });
  }

  void _blockChech( AusenciasController ausenciaController) {


  //   for (var i = 0; i < ausenciaController.getListFechasAusencia.length; i++) {
      
  //                               ausenciaController.getListFechasAusencia.removeWhere((e) => e['desde'] ==  ausenciaController.getListFechasAusencia[i]['desde'] && e['hasta'] ==  ausenciaController.getListFechasAusencia[i]['hasta']);
     
  // ausenciaController.setListFechasAusencia({"desde":ausenciaController.getListFechasAusencia[i]['desde'],"hasta":ausenciaController.getListFechasAusencia[i]['hasta'],ausenciaController.getListFechasAusencia[i]['isSelect']:true,});


  //   }
     for (var item in ausenciaController.getListFechasAusencia) {

                                ausenciaController.getListFechasAusencia.removeWhere((e) => e['desde'] ==  item['desde'] && e['hasta'] ==  item['hasta']);

                            ausenciaController.setListFechasAusencia({"desde":item['desde'],"hasta":item['hasta'],"isSelect":false,});


                            // print('object: ${item}');
                            // ausenciaController.setListFechasAusencia({"desde":"","hasta":"","isSelect":true,
                            // }
                            // );
                            
                          }
                          setState(() {
  
});

  }

  _verificaFehaAgregada(String _fecha,List<Map<String, dynamic>> _lista,BuildContext context) async {
    final _control=context.read<AusenciasController>();



      bool _isFecha=false;
      String _labelFecha='';

    for (var item in _lista) {

       for (var _itemfecha in item['fechas']) {
                                                                
          print('fecha: ${_itemfecha['desde'].toString().substring(0,10)}');

            if(_itemfecha['desde'].toString().substring(0,10)==_fecha){

                _isFecha=true;
               _labelFecha=_fecha;   
               break;

            }else if(_itemfecha['desde'].toString().substring(0,10)!=_fecha){

               _isFecha=false;
               _labelFecha=_fecha;   
              //  break;
            }



         }
                
  }
                                                              
                                                              // print('fecha: ${item['fecha']}');
                                                              // print('fecha: ${item['fechas']}');
if (_isFecha==true) {
    // print("The date $targetDate exists in the list.");
      NotificatiosnService.showSnackBarError('Turno asignado $_labelFecha');
  } else if (_isFecha==false) {
        NotificatiosnService.showSnackBarDanger('No tiene Turno asignado $_labelFecha');
  }





  // if (_control.getDateExists==true) {
  //   // print("The date $targetDate exists in the list.");
  //     NotificatiosnService.showSnackBarError('Turno asignado ${_control.getTargetDate}');
  // } else if (_control.getDateExists==false) {
  
  //     NotificatiosnService.showSnackBarDanger('No tiene Turno asignado ${_control.getTargetDate}');
  // }







      // print('ITEM: ${_control.getIdsTurnosEmergente}');

  //   for (var item in _control.getIdsTurnosEmergente) {
  //     // print('ITEM: ${item['fechas']['desde']}');
  //     for (var _fechas in item['fechas']) {
  //     // print('ITEM: ${_fecha['desde']}');
  //           if(_fechas['desde'].toString().substring(0,10)==e['desde'].toString().substring(0,10)){
  //             // print('ITEM: ${_fecha['desde'].toString().substring(0,10)}==${e['desde'].toString().substring(0,10)}');
             
  //              _isFecha=true;
  //           _fecha=_fechas['desde'].toString().substring(0,10);
  //           //  NotificatiosnService.showSnackBarDanger('No tiene Turno asignado $_fecha');
  // break;
  //           }
  //           else{
  //              _fecha='';
  //                 _isFecha=false;
  //                  _fecha=_fechas['desde'].toString().substring(0,10);
  //             //  NotificatiosnService.showSnackBarDanger('Ya tiene turno asignado $_fecha');
  //              break;
  //           }
        
  //     }
      
  //   }
  //   if(_isFecha){
  //      print('ITEM: $_fecha}');
  //           NotificatiosnService.showSnackBarDanger('No tiene Turno asignado $_fecha');
  //        }else{
  //          NotificatiosnService.showSnackBarError('Ya tiene turno asignado $_fecha');

  //        }

    
    


    
      // for (var i = 0; i < _control.getIdsTurnosEmergente.length; i++) {
      //   //  print('ITEM: ${ _control.getIdsTurnosEmergente[i]['fechas']}');
      //    for (var item in  _control.getIdsTurnosEmergente[i]['fechas']) {

      //         if(e['desde'].toString().substring(0,10)==item['desde'].toString().substring(0,10)){
      //               print('ITEM: ${item['desde']} = = ${e['desde']}');
      //                   _isFecha=true;
      //               _fecha=item['desde'];
      //         }
      //          if(e['desde'].toString().substring(0,10)!=item['desde'].toString().substring(0,10)){
      //               print('ITEM: ${item['desde']} = = ${e['desde']}');
      //                   _isFecha=false;
      //               _fecha=item['desde'];
      //         }
              
              
      //   //  print('ITEM: ${_control.getIdsTurnosEmergente[i]['turNomPersona']}');
      //   //  print('ITEM: ${item['desde']}');
      //    }
        
   




                                              //       if(_control.labelMotivoAusencia!=''){
                                                   
                                              //         _control.setFechaValida(e);

                                              // final _data={
                                              //              "desde":"${e['desde']}",
                                              //              "hasta":"${e['hasta']}",
                                              //           };

                                              //         _control.setListFechasAusenciaSeleccionadas(_data);         

                                              //               final _dataTurnoExtra=context.read<TurnoExtraController>();
                                              //               _dataTurnoExtra.buscaLstaDataJefeOperaciones('');
                                              //                 _dataTurnoExtra.setListFechasTurnoExtra(_data);

                                              //       List _listaPuestos=[];
                                              //       _dataTurnoExtra.resetValuesTurnoExtra();

                                              //     _dataTurnoExtra.setIdCliente(int.parse(_control.getIdCliente.toString()));
                                              //     _dataTurnoExtra.setCedulaCliente(_control.getListaTodosLosClientes[0]['cliDocNumero']);
                                              //     _dataTurnoExtra.setNombreCliente(_control.getListaTodosLosClientes[0]['cliRazonSocial']);
                                              //     _dataTurnoExtra.setLabelINuevoPuesto(_control.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
                                              //     _dataTurnoExtra.setLabelMotivoTurnoExtra(_control.labelMotivoAusencia!);
                                                
                                              //     _dataTurnoExtra.onNumeroDiasChange('1');
                                              //     Navigator.pushNamed( context, 'creaTurnoExtra',arguments: 'EXTRA');
                                              //       }
                                              //       else{
                                              //          NotificatiosnService.showSnackBarDanger('Seleccione motivo de permiso ');
                                              //       }



      }

      //  if(_isFecha==true){
      //      NotificatiosnService.showSnackBarDanger('No tiene Turno asignado $_fecha');
      //    }else{
      //      NotificatiosnService.showSnackBarDanger('Ya tiene turno asignado $_fecha');

      //    }

                                  // if(_control.labelMotivoAusencia!=''){
                                                   
                                  //                     _control.setFechaValida(e);

                                  //             final _data={
                                  //                          "desde":"${e['desde']}",
                                  //                          "hasta":"${e['hasta']}",
                                  //                       };

                                  //                     _control.setListFechasAusenciaSeleccionadas(_data);         

                                  //                           final _dataTurnoExtra=context.read<TurnoExtraController>();
                                  //                           _dataTurnoExtra.buscaLstaDataJefeOperaciones('');
                                  //                             _dataTurnoExtra.setListFechasTurnoExtra(_data);

                                  //                   List _listaPuestos=[];
                                  //                   _dataTurnoExtra.resetValuesTurnoExtra();

                                  //                 _dataTurnoExtra.setIdCliente(int.parse(_control.getIdCliente.toString()));
                                  //                 _dataTurnoExtra.setCedulaCliente(_control.getListaTodosLosClientes[0]['cliDocNumero']);
                                  //                 _dataTurnoExtra.setNombreCliente(_control.getListaTodosLosClientes[0]['cliRazonSocial']);
                                  //                 _dataTurnoExtra.setLabelINuevoPuesto(_control.getListaTodosLosClientes[0]['cliDatosOperativos'][0]['puesto']);
                                  //                 _dataTurnoExtra.setLabelMotivoTurnoExtra(_control.labelMotivoAusencia!);
                                                
                                  //                 _dataTurnoExtra.onNumeroDiasChange('1');
                                  //                 Navigator.pushNamed( context, 'creaTurnoExtra',arguments: 'EXTRA');
                                  //                   }
                                  //                   else{
                                  //                      NotificatiosnService.showSnackBarDanger('Seleccione motivo de permiso ');
                                  //                   }





    // return  _isFecha;
  // }

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
