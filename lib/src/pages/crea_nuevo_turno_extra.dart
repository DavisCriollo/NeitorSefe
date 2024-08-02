import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/new_permisos_controller.dart';
import 'package:nseguridad/src/controllers/new_turno_extra_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class CrearNuevoTurno extends StatefulWidget {
   final String? tipo;
  final String? action;
  // final Map<String, dynamic>? infoPermiso;
  CrearNuevoTurno({Key? key, this.action, this.tipo,}) : super(key: key);

  @override
  State<CrearNuevoTurno> createState() => _CrearNuevoTurnoState();
}

class _CrearNuevoTurnoState extends State<CrearNuevoTurno> {
  @override
  Widget build(BuildContext context) {
    final _action = widget.action;
 
    final _user = context.read<HomeController>();
    final ctrlTurno = context.read<NuevoTurnoExtraController>();
     final ctrlPermiso= context.read<NuevoPermisoController>();
       final ctrlTheme = context.read<ThemeApp>();
      
    Responsive size = Responsive.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: const Color(0xFFEEEEEE),
            appBar: AppBar(
              // backgroundColor: primaryColor,
               
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
                'Crear Turno Extra',
                // style: Theme.of(context).textTheme.headline2,
              ),

              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.iScreen(1.5)),
                  child: IconButton(
                      splashRadius: 28,
                      onPressed: () {
                        _onSubmit(context, ctrlTurno,_action!);
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
                    key: ctrlTurno.turnoFormKey,
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
                  
                              //*****************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                  
                          // color: Colors.blue,
                          child: Text('Persona a reemplazar : ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
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
                                    return (persona
                                            .getInfoPersona.isEmpty)
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
                          
                          ],
                        ),
                  
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                  
                          // color: Colors.blue,
                          child: Text('Fechas Seleccionadas: ',
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
                       Consumer<NuevoPermisoController>(
                    builder: (_, valuesFecha, __) {
                      return Wrap(
                        spacing: 2.0,
                        children: valuesFecha.selectedFechas
                            .map(
                              (e) => Chip(
                                onDeleted: valuesFecha.selectedFechas.length>1?() {
                                  valuesFecha.deleteFechaDeReemplazo(e);
                                }:null,
                                deleteIconColor: Colors.red,
                                label: Text(
                                  e['fecha_inicio'],
                                  style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.7),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                        //*****************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                        SizedBox(
                          width: size.wScreen(100.0),
                  
                          // color: Colors.blue,
                          child: Text('Seleccione Guardia ',
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
                                child: Consumer<NuevoTurnoExtraController>(
                                  builder: (_, persona, __) {
                                    return (persona
                                            .getInfoPersonaReemplazo.isEmpty)
                                        ? Text(
                                            'No hay guardia designado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${persona.getInfoPersonaReemplazo['perApellidos']} ${persona.getInfoPersonaReemplazo['perNombres']}',
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
                              child: GestureDetector(onTap: () {
                                // _modalSeleccionaGuardia(
                                //     size, ausenciaController);
                                Provider.of<NuevoPermisoController>(context,
                                        listen: false)
                                    .buscaInfoGuardias('');
                  
                                Navigator.pushNamed(context, 'nuevoBuscaPersona',
                                    arguments: 'turnoExtra');
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
                            ),
                          ],
                        ),
                  
                        //***********************************************/
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        //*****************************************/
                  
                        Column(children: [
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
                                  child: Consumer<NuevoTurnoExtraController>(
                                    builder: (_, persona, __) {
                                      return (persona.labelMotivoPermidos == '' ||
                                              persona.labelMotivoPermidos == null)
                                          ? Text(
                                              'No hay motivo seleccionado',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            )
                                          : Text(
                                              '${persona.labelMotivoPermidos} ',
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
                            child: Consumer<NuevoTurnoExtraController>(
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
                            height: size.iScreen(1.0),
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
                                : ctrlTurno.getInputDetalle,
                            decoration: const InputDecoration(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(),
                            textInputAction: TextInputAction.done,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                            ],
                            onChanged: (text) {
                              ctrlTurno.onDetalleChange(text);
                            },
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese detalle del Turno';
                              }
                            },
                          ),
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                        ])
                      ],
                    ),
                  )),
            )),
      ),
    );
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, NuevoTurnoExtraController controller,
      String _action) async {

  final ctrlPermiso=context.read<NuevoPermisoController>();

// final controllerMultas=context.read<MultasGuardiasContrtoller>();
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getInfoPersonaReemplazo.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar persona');
      } else if (controller.labelMotivoPermidos!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar motivo de permiso');
      } else if (controller.getInputAutorizadoPor!.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'No hay persona que Autoriza');
      }else if (ctrlPermiso.selectedFechas.isEmpty) {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar dias de permiso');
      }
      
       else if (controller.getInfoPersonaReemplazo.isNotEmpty &&
          controller.labelMotivoPermidos!.isNotEmpty &&
          controller.getInputAutorizadoPor!.isNotEmpty &&
          ctrlPermiso.selectedFechas.isNotEmpty) {
        if (_action == 'CREATE') {
          await controller.crearTurno(context);
             final serviceSocket = context.read<SocketService>() ;
               final crtlPermiso = context.read<NuevoPermisoController>() ;
          serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
            if (data['tabla'] == 'turno_extra') {
              if (widget.tipo == 'PERMISO') {
             
                  crtlPermiso.setListaPersonasReemplazo(data);
                    crtlPermiso.buscaNuevosPermisos('', 'false');
                   serviceSocket.socket!.off('server:guardadoExitoso');

                // _controllerPermiso.setGuardiasSeleccionados({
                //   "turId": data['turId'],
                //   "turIdPersona": data['turIdPersona'],
                //   "turDocuPersona": data['turDocuPersona'],
                //   "turNomPersona": data['turNomPersona'],
                //   "fechas":  {
                //       "desde": _controllerPermiso.getFechaValida['desde'], 
                //       "hasta": _controllerPermiso.getFechaValida['hasta'], 
                //       "id": _controllerPermiso.getFechaValida['id'],
                //       "isSelect": false,} ,//controller.getListFechasTurnoExtra,
                //   "numDias":'1'//controller.getListFechasTurnoExtra.length.toString()
                // });
             



              // });
              }
              if (_action == 'MULTA') {
                // controllerMulta.setDataTurnoEmergente(data);
                // controllerMulta.setIdTurnoEmergente(data['turId'].toString());
                // controllerMulta
                //     .setIdGuardia(int.parse(data['turIdPersona'].toString()));
                // controllerMulta
                //     .setDocuGuardia(data['turDocuPersona'].toString());
                // controllerMulta
                //     .setNombreGuardia(data['turNomPersona'].toString());
              }
              if (_action == 'TURNO') {
             
                  // controllerMulta.getTodasLasMultasGuardia('', 'false');
                        // controller.resetValuesTurnoExtra();
              }
              if (_action == 'FALTAS') {
               
                  // controllerMulta.getTodasLasFaltasInjustificadas('');
                        // controller.resetValuesTurnoExtra();
              }
            }
          });

          Navigator.pop(context);
        } else if (_action == 'EDIT') {
          // await controller.editaAusencia(context);
          Navigator.pop(context);
        }
      }
    }
  }










}
