import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/new_permisos_controller.dart';
import 'package:nseguridad/src/controllers/new_turno_extra_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crea_nuevo_turno_extra.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme_app.dart';
import 'package:nseguridad/src/utils/verifica_fecha_actual.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class CreaNuevoPermiso extends StatefulWidget {
  final Session? usuario;
  final String? action;
  CreaNuevoPermiso({Key? key, this.usuario, this.action}) : super(key: key);

  @override
  State<CreaNuevoPermiso> createState() => _CreaNuevoPermisoState();
}

class _CreaNuevoPermisoState extends State<CreaNuevoPermiso> {
    ColorManager colorManager = ColorManager();
  // List<bool> isCheckedList = List.generate(
  //     100,
  //     (index) =>
  //         false); // Ajusta el tamaño según la cantidad de elementos en tu lista

  @override
  Widget build(BuildContext context) {

//  Color appBarColor = colorManager.savedColors[0] ?? Colors.red;



    final _action = widget.action;
    final _user = context.read<HomeController>();
    Responsive size = Responsive.of(context);
    final ctrlHome = context.read<NuevoPermisoController>();
      final ctrlTheme = context.read<ThemeApp>();
        
    return WillPopScope(
     
              onWillPop: () async {
        return await showDialog(
          // barrierDismissible :false,
            context: context,
            builder: (context) {
              // final controllerMulta = context.read<MultasGuardiasContrtoller>();
          
              return AlertDialog(
                
                title: const Text('Aviso'),
                content: const Text('¿Desea cancelar la creación del Permiso?'),
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
                      onPressed: ()  {
                        final providerTurno = context.read<NuevoTurnoExtraController>();
                         final providerPermiso = context.read<NuevoPermisoController>();



                         final List _idTurnos=[];



                        if(providerPermiso.getListaPersonasReemplazo.isNotEmpty){

                          for (var item in providerPermiso.getListaPersonasReemplazo) {

                             _idTurnos.add(item['turnId']);
                             

                            // print('EL ID:${item['turnId']}');
                             
                          }
                          providerTurno.eliminaTurnoExtra(_idTurnos);
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      
          child: Scaffold(
              // backgroundColor: const Color(0xffF2F2F2),
              appBar: AppBar(
                // backgroundColor: appBarColor,
                
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
                          _onSubmit(context, ctrlHome, _action.toString());
                        },
                        icon: Icon(
                          Icons.save_outlined,
                          size: size.iScreen(4.0),
                        )),
                  )
                ],
              ),
              body: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                  padding: EdgeInsets.only(
                    top: size.iScreen(0.5),
                    left: size.iScreen(1.0),
                    right: size.iScreen(1.0),
                    bottom: size.iScreen(0.5),
                  ),
                  width: size.wScreen(100.0),
                  height: size.hScreen(100),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: ctrlHome.permisoFormKey,
                      child: Column(
                        children: [
                          //*****************************************/
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
                                child: Consumer<NuevoPermisoController>(
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
                                      size, ctrlHome);
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
                 

                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(0.5),
                          ),
                          //*****************************************/
                          SizedBox(
                            width: size.wScreen(100.0),
        
                            // color: Colors.blue,
                            child: Text('Guardia ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          ),
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(0.0),
                          ),
                          //*****************************************/
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // color: Colors.red,
                                  padding: EdgeInsets.only(
                                    top: size.iScreen(0.0),
                                    right: size.iScreen(0.5),
                                  ),
                                  child: Consumer<NuevoPermisoController>(
                                    builder: (_, persona, __) {
                                      return (persona.getInfoPersona.isEmpty)
                                          ? Text(
                                              'No hay guardia designado',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            )
                                          : Text(
                                              '${persona.getInfoPersona['perApellidos']} ${persona.getInfoPersona['perNombres']}',
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
                              Consumer<NuevoPermisoController>(builder: (_, value, __) { 
                                return   
                                 value.getListaPersonasReemplazo.isEmpty?
                                
                                ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(onTap: () {
                                  // _modalSeleccionaGuardia(
                                  //     size, ausenciaController);
                                  Provider.of<NuevoPermisoController>(context,
                                          listen: false)
                                      .buscaInfoGuardias('');
        
                                  Navigator.pushNamed(context, 'nuevoBuscaPersona',
                                      arguments: 'permiso');
                                }, child: Consumer<ThemeApp>(
                                  builder: (_, valueTheme, __) {
                                    return Container(
                                      alignment: Alignment.center,
                                      color: valueTheme.primaryColor,
                                      width: size.iScreen(3.5),
                                      padding: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.2),
                                        left: size.iScreen(0.2),
                                        right: size.iScreen(0.2),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: valueTheme.secondaryColor,
                                        size: size.iScreen(2.0),
                                      ),
                                    );
                                  },
                                )),
                              ):Container();
                               },),
                             
                            
                            ],
                          ),
        
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(0.5),
                          ),
                          //*****************************************/
        
                          Consumer<NuevoPermisoController>(
                              builder: (_, valueListaFechas, __) {
                            return valueListaFechas
                                    .getIdDiasLaborablesValidados.isNotEmpty
                                ? Column(
                                    children: [
                                      valueListaFechas.getIdDiasLaborablesValidados
                                              .isNotEmpty
                                          ? Container(
                                              width: size.wScreen(100),
                                              child: Text(
                                                'Días de permiso',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey),
                                              ),
                                            )
                                          : Container(),
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(0.5),
                                      ),
                                      //*****************************************/
                                      Container(
                                        // color: Colors.green,
                                        child: Wrap(
                                          spacing: 5.0,
                                          children: valueListaFechas
                                              .getIdDiasLaborablesValidados
                                              .map((e) {
                                                return 
                                                Chip(
                                                  backgroundColor: Colors.grey.shade300,
                                                    onDeleted: valueListaFechas
                                                                .getListaPersonasReemplazo
                                                                .isEmpty  
                                                          
                                                        ?  () {
                                                            valueListaFechas
                                                                .deleteFechaDePermiso(
                                                                    e);
                                                          }
                                                        : null,
                                                    deleteIconColor: Colors.red,
                                                    label: Text(
                                                      e['fecha_inicio'],
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        // color: Colors.grey
                                                      ),
                                                    ),
                                                  );
                                              })
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container();
                          }),
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(0.5),
                          ),
                          //*****************************************/
        
                          Consumer<NuevoPermisoController>(
                              builder: (_, valueListaFechas, __) {
                            return valueListaFechas
                                    .getIdDiasLaborablesValidados.isNotEmpty
                                ? Column(children: [
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
                                            child: Consumer<NuevoPermisoController>(
                                              builder: (_, persona, __) {
                                                return (persona.labelMotivoAusencia ==
                                                            '' ||
                                                        persona.labelMotivoAusencia ==
                                                            null)
                                                    ? Text(
                                                        'No hay motivo seleccionado',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(1.8),
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color: Colors.grey),
                                                      )
                                                    : Text(
                                                        '${persona.labelMotivoAusencia} ',
                                                        style:
                                                            GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.8),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          // color: Colors.grey
                                                        ),
                                                      );
                                              },
                                            ),
                                          ),
                                        ),
                                       
                                      
                                       valueListaFechas
                                                                .getListaPersonasReemplazo
                                                                .isEmpty?
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: GestureDetector(onTap: () {
                                            _modalSeleccionaMotivo(size, ctrlHome);
                                          }, child: Consumer<ThemeApp>(
                                            builder: (_, valueTheme, __) {
                                              return Container(
                                                alignment: Alignment.center,
                                                color:
                                                    valueTheme.primaryColor,
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
                                        ):Container(),
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
                                          : ctrlHome.getInputDetalle,
                                      decoration: const InputDecoration(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(),
                                      textInputAction: TextInputAction.done,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                      ],
                                      onChanged: (text) {
                                        ctrlHome.onDetalleChange(text);
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
                                  ])
                                : Container();
                          }),
        
                          //***********************************************/
                          Consumer<NuevoPermisoController>(
                              builder: (_, valueListaFechas, __) {
                            return valueListaFechas
                                    .getIdDiasLaborablesValidados.isNotEmpty
                                ? Column(
                                    children: [
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(0.5),
                                      ),
                                      //*****************************************/
                                      SizedBox(
                                        width: size.wScreen(100.0),
        
                                        // color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Guardias Reemplazo ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: GestureDetector(
                                                
                                                
                                                onTap: () {
                                                if (valueListaFechas
                                                    .labelMotivoAusencia!
                                                    .isNotEmpty) {
                                                      
                                                  // valueListaFechas
                                                  //     .resetListaSelectedFecha();
                                                  // _modalSeleccionaFechasReemplazo(
                                                  //     size,
                                                  //     context,
                                                  //     valueListaFechas
                                                  //         .getIdDiasLaborablesValidados
                                                  //         .length,
                                                  //     valueListaFechas
                                                  //         .getIdDiasLaborablesValidados);
        
                                                      //******************************//
          //                                                 if (valueListaFechas.verificaTurnosCompletos()) {
          //   print('Todas las fechas están en la lista de turnos.');
          //   //  NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo de permiso');
        
          // } else {
            
          //   print('Al menos una de las fechas no está en la lista de turnos.');
          // }
                                                       if (valueListaFechas.verificaTurnosCompletos()) {
            print('Las dos listas tienen la misma información.');
        NotificatiosnService .showSnackBarDanger('No tiene mas turnos que asignar');
        
          } else {
          valueListaFechas
                                                      .resetListaSelectedFecha();
                                                  _modalSeleccionaFechasReemplazo(
                                                      size,
                                                      context,
                                                      valueListaFechas
                                                          .getIdDiasLaborablesValidados
                                                          .length,
                                                      valueListaFechas
                                                          .getIdDiasLaborablesValidados);
            // print('Las dos listas NO tienen la misma información.');
            // NotificatiosnService .showSnackBarDanger('Tiene Turnos por asignar');
          }
        
        
        
                                                } else {
                                                  NotificatiosnService
                                                      .showSnackBarDanger(
                                                          'Debe seleccionar motivo de permiso');
                                                }
        
        
        
                                                  //   if (valueListaFechas.getListaPersonasReemplazo.isNotEmpty) {
        
                                                  //     for (var x in valueListaFechas.getListaPersonasReemplazo) {
                                                  //             for (var item in x['dias']) {
                                                  //                                         print('${item['fecha_inicio']}');
                                                  //                                       }
                                                  // }
                                                  //   } else {
                                                  //   }
        
          // Set<Map<String, dynamic>> setList1 = Set.from(valueListaFechas.getIdDiasLaborablesValidados);
          // Set<Map<String, dynamic>> setList2 = Set.from(valueListaFechas.getListaPersonasReemplazo);
        
          // // Obtener mapas repetidos
          // Set<Map<String, dynamic>> mapasRepetidos = setList1.intersection(setList2);
        
          // // Obtener mapas que no se han repetido
          // Set<Map<String, dynamic>> mapasNoRepetidos = setList1.union(setList2).difference(mapasRepetidos);
        
          // List<Map<String, dynamic>> listaMapasNoRepetidos = mapasNoRepetidos.toList();
        
          // print("Mapas repetidos: ${valueListaFechas.getIdDiasLaborablesValidados}");
          // print("Mapas no repetidos: ${valueListaFechas.getListaPersonasReemplazo}");
                                                     
          //                                                List<Map<String, dynamic>> _list2 = [
          //   {"turnId": 17, "turnIdPersona": 1133, "turnIdPersonaReemplazada": 1418, "turnIdDOperativo": 133, "turnIdPermiso": 0, "turnIdMulta": 0, "turnIdHorario": 0, "turnMotivo": "ENFERMEDAD IESS", "turnEstado": "EN PROCESO", "turnAutorizado": "OPERACIONES NACIONAL", "turnDetalle": "qqqqq", "turnStatusDescripcion": "", "turnUser": "0604591768", "turnEmpresa": "PRUEBA", "turnFecReg": "2024-02-22T01:10:07.000Z", "turnFecUpd": "2024-02-22T01:10:07.000Z", "cedula": "2350206658", "nombres": "CHEME SANCHEZ ANDY ANTONIO", "idCliente": 1538, "ruc": "0302626290001", "razonSocial": "NUEVO PROVEEDOR", "ubicacion": "CUENCAaaa", "puesto": "Mall del RIO", "turnIdsJornadaLaboral": [532, 533], "dias": [{"id": 532, "fecha_inicio": "2024-02-23 02:00:00", "fecha_final": "2024-02-23 16:00:00", "id_horario": 2, "tipo": "DIA", "estado": "ACTIVA", "estatus_proceso": "APROBADO", "id_relacion": 51}, {"id": 533, "fecha_inicio": "2024-02-24 02:00:00", "fecha_final": "2024-02-24 16:00:00", "id_horario": 2, "tipo": "DIA", "estado": "ACTIVA", "estatus_proceso": "APROBADO", "id_relacion": 52}]}
          //   // Agrega más elementos según sea necesario
          // ];
        
          // Set<String> fechasList1 = Set.from(valueListaFechas.getIdDiasLaborablesValidados.map((map) => map["fecha_inicio"] as String));
          // Set<String> fechasList2 = Set.from(valueListaFechas.getListaPersonasReemplazo.expand((map) => (map["dias"] as List<Map<String, dynamic>>).map((dia) => (dia["fecha_inicio"] as dynamic).toString())));
        
          // // Obtener fechas repetidas
          // Set<String> fechasRepetidas = fechasList1.intersection(fechasList2);
        
          // // Obtener fechas que no se han repetido
          // Set<String> fechasNoRepetidas = fechasList1.union(fechasList2).difference(fechasRepetidas);
        
          // List<String> listaFechasNoRepetidas = fechasNoRepetidas.toList();
        
          // print("Fechas repetidas: $fechasRepetidas");
          // print("Fechas no repetidas: $listaFechasNoRepetidas");
        
        
        
        
                                              }, child: Consumer<ThemeApp>(
                                                builder: (_, valueTheme, __) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    color: valueTheme
                                                        .primaryColor,
                                                    width: size.iScreen(4.0),
                                                    padding: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom: size.iScreen(0.2),
                                                      left: size.iScreen(0.2),
                                                      right: size.iScreen(0.2),
                                                    ),
                                                    child: Icon(
                                                      Icons.person_add,
                                                      color: valueTheme
                                                          .secondaryColor,
                                                      size: size.iScreen(2.5),
                                                    ),
                                                  );
                                                },
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // color: Colors.red,
                                              padding: EdgeInsets.only(
                                                top: size.iScreen(0.0),
                                                right: size.iScreen(0.5),
                                              ),
                                              child:
                                                  Consumer<NuevoPermisoController>(
                                                builder: (_, persona, __) {
                                                  return Wrap(
                                                  
                                                    children:persona.getListaPersonasReemplazo.map((e) {
                                                    return  Container(
                                                      margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                                                       padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(1)),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200,),
                                                     
                                                      width: size.wScreen(100.0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: size.wScreen(100.0),
                                                            child: Text(
                                                                  '${e['nombres']}',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    fontSize:
                                                                        size.iScreen(1.8),
                                                                    fontWeight:
                                                                        FontWeight.normal,
                                                                    // color: Colors.grey
                                                                  ),
                                                                  textAlign:TextAlign.left,
                                                                ),
                                                          ),
                                                              Wrap(
                                                                spacing: 5.0,
                                                                children:(e['dias'] as List).map((e) {
        
        
         String fechaOriginal = DateUtility.fechaLocalConvert( e['fecha_inicio']!.toString());
        DateTime fecha = DateTime.parse(fechaOriginal);
        
          String fechaLocal = DateFormat('yyyy-MM-dd').format(fecha);
                                                                return Chip( 
                                                                   label: Text(
                                                      fechaLocal,
                                                      style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.8),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        // color: Colors.grey
                                                      ),
                                                    ),);
                                                              }).toList(),)
                                                        ],
                                                      ),
                                                    );
                                                  }).toList());
                                                  // ListView.builder(
                                                  //   itemCount: persona.getListaPersonasReemplazo.length,
                                                  //   itemBuilder: (BuildContext context, int index) { 
                                                  //   return 
                                                  //   (persona.getListaPersonasReemplazo.isEmpty)
                                                  //     ? Text(
                                                  //         'No hay guardia designado',
                                                  //         style: GoogleFonts
                                                  //             .lexendDeca(
                                                  //                 fontSize: size
                                                  //                     .iScreen(1.8),
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold,
                                                  //                 color:
                                                  //                     Colors.grey),
                                                  //       )
                                                  //     : Text(
                                                  //         '${persona.getInfoPersona['perApellidos']} ${persona.getInfoPersona['perNombres']}',
                                                  //         style: GoogleFonts
                                                  //             .lexendDeca(
                                                  //           fontSize:
                                                  //               size.iScreen(1.8),
                                                  //           fontWeight:
                                                  //               FontWeight.normal,
                                                  //           // color: Colors.grey
                                                  //         ),
                                                  //       );
                                                  //  },);
                                                  // 
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
        
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(0.5),
                                      ),
                                      //*****************************************/
                                    ],
                                  )
                                : Container();
                          }),
        
                          //***********************************************/
                          // SizedBox(
                          //   height: size.iScreen(2.0),
                          // ),
        
                          //==========================================//
                          // ctrlHome.getListaFotosInforme.isNotEmpty
                          //     ?
                          _CamaraOption(size: size, ausenciasController: ctrlHome),
        
                          // : Container(),
        
                          //***********************************************/
                          SizedBox(
                            width: size.iScreen(1.0),
                          ),
                          //*****************************************/
        
                          Consumer<NuevoPermisoController>(
                            builder: (_, valueDias, __) {
                              return valueDias.getListaDiasPermiso.isNotEmpty
                                  ? Container(
                                      // color: Colors.green,
                                      width: size.wScreen(90),
                                      height: size.hScreen(35),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            valueDias.getListaDiasPermiso.length,
                                        //  itemCount: 50,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (valueDias
                                              .getListaDiasPermiso.isEmpty) {
                                            return Center(
                                              // child: CircularProgressIndicator(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Cargando Datos...',
                                                    style: GoogleFonts.lexendDeca(
                                                        fontSize: size.iScreen(1.5),
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  //***********************************************/
                                                  SizedBox(
                                                    height: size.iScreen(1.0),
                                                  ),
                                                  //*****************************************/
                                                  const CircularProgressIndicator(),
                                                ],
                                              ),
                                            );
                                          } else if (valueDias
                                                  .getErrorDiasPermiso ==
                                              false) {
                                            return const NoData(
                                              label: 'No existen datos para mostar',
                                            );
                                          } else if (valueDias
                                              .getListaDiasPermiso.isEmpty) {
                                            return const NoData(
                                              label: 'No existen datos para mostar',
                                            );
                                          }
        
                                          var e =
                                              valueDias.getListaDiasPermiso[index];
        
                                          return Card(
                                              child: ListTile(
                                            title: Text(
                                              'Puesto: ${e['puesto']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              ' Ubicación: ${e['ubicacion']}',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.grey
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.calendar_month_rounded,
                                              size: size.iScreen(3.0),
                                              color: Colors.black,
                                            ),
                                            onTap:
                                            valueDias.getListaPersonasReemplazo.isEmpty ?
                                            
                                            () {
                                              
        
        
        
                                              valueDias.listaCountHoras(
                                                  '${e['horarios'].length}');
                                              valueDias.resetListFechas();
                                              _showDialog(size, context, e);
                                            }:null,
                                          ));
                                        },
                                      ),
                                    )
                                  : const NoData(label: 'No tiene información');
                            },
                          )
                        ],
                      ),
                    ),
                  )),
              floatingActionButton: Consumer<NuevoPermisoController>(
                  builder: (_, valueListaFechas, __) {
                return valueListaFechas.getIdDiasLaborablesValidados.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              bottomSheet(ctrlHome, context, size);
                            },
                            backgroundColor: Colors.purpleAccent,
                            heroTag: "btnCamara",
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                          // SizedBox(
                          //   height: size.iScreen(1.5),
                          // ),
                        ],
                      )
                    : Container();
              })),
        ),
    
    );
  }

  void bottomSheet(
    NuevoPermisoController informeController,
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
      ImageSource source, NuevoPermisoController informeController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedFile == null) {
      return;
    }
    informeController.setNewPictureFile('${pickedFile.path}');

    Navigator.pop(context);
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, NuevoPermisoController controller,
      String? _action) async {
// final controllerMultas=context.read<MultasGuardiasContrtoller>();
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getInfoPersona.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar persona');
      } else if (controller.labelMotivoAusencia!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar motivo de permiso');
      } 
      else if (controller.getIdDiasLaborablesValidados.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionardias de permiso');
      } 
      else if (controller.getListaPersonasReemplazo.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionardias persona de Reemplazo');
      } 
      else if (controller.getInfoPersona.isNotEmpty &&
          controller.labelMotivoAusencia!.isNotEmpty &&
          controller.getIdDiasLaborablesValidados.isNotEmpty &&
           controller.getListaPersonasReemplazo.isNotEmpty) {
        if (_action == 'CREATE') {
          await controller.crearPermiso(context);
          Navigator.pop(context);
        } else if (_action == 'EDIT') {
          // await controller.editaAusencia(context);
          Navigator.pop(context);
        }
      }
    }
  }

  //====== MUESTRA MODAL DE MOTIVO =======//
  void _modalSeleccionaMotivo(Responsive size, NuevoPermisoController permiso) {
    final _data = [
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
                          onTap: () {
                            permiso.setLabelMotivoAusencia(_data[index]);
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

//====== MUESTRA MODAL DE MOTIVO =======//
  Future<void> _modalSeleccionaFechasReemplazo(
      Responsive size, BuildContext context, int index, List _data) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Seleccione días',
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
          content: Container(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
// String fecha = _data[index]['fecha_inicio'];

                return 
                Consumer<NuevoPermisoController>(
  builder: (_, crtlPermiso, __) {
    // String fechaId = _data[index]['id'];
    return CheckboxListTile(
      activeColor: Colors.green,
      selectedTileColor: Colors.grey,
      dense: false,
      title: Text(_data[index]['fecha_inicio']),
      value: crtlPermiso.selectedFechas.contains(_data[index]),
      onChanged: (bool? value) {
        // crtlPermiso.toggleSelectedFecha(_data[index]);

if (crtlPermiso.getListaPersonasReemplazo.isNotEmpty) {
   String fechaBuscada = _data[index]['fecha_inicio'];
  if (crtlPermiso.verificarFechaEnLista(fechaBuscada)) {
    print('La fecha $fechaBuscada está en la lista.');
  } else {
    print('La fecha $fechaBuscada no está en la lista.');
     crtlPermiso.toggleSelectedFecha(_data[index]);
  }
  
} else {
   crtlPermiso.toggleSelectedFecha(_data[index]);
}
                            





      },
    );
  },
);
              },
            ),
          ),
          actions: <Widget>[
            Consumer<NuevoPermisoController>(
              builder: (_, value, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Seleccionados: ${value.selectedFechas.length}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    value.selectedFechas.isNotEmpty
                        ? TextButton(
                            child: Text('Crear Turno',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                              final crtlPermiso =
                                  context.read<NuevoPermisoController>();
                              final crtlTurno =
                                  context.read<NuevoTurnoExtraController>();
                                  crtlTurno.resetVariablesTurno();
                              crtlTurno.setLabelMotivoPermidos(
                                  crtlPermiso.labelMotivoAusencia!);
                              crtlTurno.buscaLstaDataJefeOperaciones('');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => CrearNuevoTurno(
                                            action: 'CREATE',
                                            tipo: 'PERMISO',
                                            // infoPermiso: {
                                            //   "persona":
                                            //       crtlPermiso.getInfoPersona,
                                            // },
                                          ))));
                            },
                          )
                        : Container(),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialog(Responsive size, BuildContext context, var e) async {
    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<NuevoPermisoController>(
          builder: (_, crtlPermiso, __) {
            return AlertDialog(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECCIONAR FECHA ',
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
                    // color:  Colors.red,
                    width: size.wScreen(100),
                    child: Text(
                      'Puesto: ${e['puesto']}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              content: Container(
                height: size.hScreen(40),
                width: size.wScreen(100),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        3, // Ajusta este valor según tus necesidades
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: (e['horarios'] as List).length,
                  itemBuilder: (BuildContext context, int subIndex) {
                    var x = (e['horarios'] as List)[subIndex];
                    DateTime fecha = DateTime.parse(x['fecha_inicio']);
                    String fechaFormateada =
                        DateFormat('E dd', 'es').format(fecha);
                     final fechaVerificada=   validarFechaActual(x['fecha_inicio']);

                    return InkWell(
                      onTap: 
                      fechaVerificada==true
                          ?
                      //*********VALIDA POR ALDUN CODIGO *********// 
                          () {
                              crtlPermiso.toggleChecked(subIndex, x);
                            }
                          : null,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: crtlPermiso.isCheckedList[subIndex]
                          //     ? Colors.grey.shade500
                          //     : Colors.grey.shade300,
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: crtlPermiso.isCheckedList[subIndex]
                                ? Colors.green
                                : Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(0.1), vertical: size.iScreen(0.1)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$fechaFormateada',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                fontWeight: crtlPermiso.isCheckedList[subIndex]
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Text(
                              x['codigo'],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                fontWeight: crtlPermiso.isCheckedList[subIndex]
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            //********VALIDA SI LA FECHA ESTA CON ALGUN CODIGO*******//
                            fechaVerificada==true
                                ? 
                                Icon(
                                    crtlPermiso.isCheckedList[subIndex]
                                        ? Icons.check
                                        : Icons.close,
                                    color: crtlPermiso.isCheckedList[subIndex]
                                        ? Colors.green
                                        : Colors.red,
                                    size: size.iScreen(3.0),
                                  )
                                : Icon(
                                    Icons.do_not_disturb_alt,
                                    color: Colors.grey,
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Seleccionados: ${crtlPermiso.selectedItemsFechas.length}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(onTap: () async {
                        // _modalSeleccionaGuardia(
                        //     size, ausenciaController);
                        //  Provider.of<NuevoPermisoController>(context,
                        //           listen: false)
                        //       .buscaInfoGuardias('');

                        //           Navigator.pushNamed(context, 'nuevoBuscaPersona',arguments: 'permiso');

// Navigator.pop(context);

//  ProgressDialog.show(context);
//             final response = await  crtlPermiso.validaDiasHabiles(context);
//             ProgressDialog.dissmiss(context);

//             if (response==true) {
//               crtlPermiso.setInfoPuestoSeleccionado(e);
//            Navigator.pop(context);

//             }
//             else{
//               Dialogs.alert(context, title: 'sdfsd', description: 'description');
//             }

                        ProgressDialog.show(context);
                        final response =
                            await crtlPermiso.validaDiasHabiles(context);
                        ProgressDialog.dissmiss(context);

                        if (response.statusCode == 200) {
                          crtlPermiso.setInfoPuestoSeleccionado(e);
                          Navigator.pop(context);
                        }
                        if (response.statusCode == 404 ||
                            response.statusCode == 500) {
                          Map<String, dynamic> message =
                              jsonDecode(response.body);
                          Navigator.pop(context);
                          Dialogs.alert(context,
                              title: 'Atención',
                              description: '${message['msg']}');
                        }

//             }

//  Dialogs.alert(context, title: 'sdfsd', description: 'description');
                      }, child: Consumer<ThemeApp>(
                        builder: (_, valueTheme, __) {
                          return Container(
                              alignment: Alignment.center,
                              color: valueTheme.primaryColor,
                              width: size.iScreen(10),
                              padding: EdgeInsets.only(
                                top: size.iScreen(0.8),
                                bottom: size.iScreen(0.8),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              child: Text(
                                'Agregar',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.5),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ));
                        },
                      )),
                    ),
                  ],
                ),

                // TextButton(
                //  style: ButtonStyle(),
                //   child: Text('Guardar'),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
              ],
            );
          },
        );
      },
    );
  }


 //====== MUESTRA MODAL DE ESTADO =======//
  void _modalSeleccionaEstado(
      Responsive size, NuevoPermisoController ausenciasController) {

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




}

class _CamaraOption extends StatefulWidget {
  final NuevoPermisoController ausenciasController;
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
      child: Consumer<NuevoPermisoController>(
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
                child: fotoUrl.getListaFotosUrl!.isNotEmpty
                    ? Text(
                        'Fotografía:  ${fotoUrl.getListaFotosUrl!.length}   ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey))
                    : Container(),
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
