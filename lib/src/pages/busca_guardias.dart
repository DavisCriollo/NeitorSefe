// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardias extends StatefulWidget {
  // final String? modulo;

  const BuscarGuardias({Key? key}) : super(key: key);

  @override
  State<BuscarGuardias> createState() => _BuscarGuardiasState();
}

class _BuscarGuardiasState extends State<BuscarGuardias> {
  TextEditingController textSearchGuardias = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchGuardias.text = '';

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final informeController = Provider.of<AvisoSalidaController>(context);
    final modulo = ModalRoute.of(context)!.settings.arguments;
     final ctrlTheme = context.read<ThemeApp>();

            final _user=context.read<HomeController>();

 String _persona='';
  if(_user.getUsuarioInfo!.rol!.contains('GUARDIA')){
     _persona="GUARDIA";

  }else if(_user.getUsuarioInfo!.rol!.contains('ADMINISTRACION')){
     _persona="ADMINISTRACION";

  }





    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBar(
          // backgroundColor: const Color(0XFF343A40), // primaryColor,
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
            ' Personal',
            // style:  Theme.of(context).textTheme.headline2,
           
          ),
         
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,









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
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //*****************************************/
    
              TextFormField(
                controller: textSearchGuardias,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'búsqueda Personal',
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      // _searchGuardia(tipoMultaController);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color(0XFF343A40),
                    ),
                  ),
                ),
                textAlign: TextAlign.start,
                style: const TextStyle(
    
                   
                    ),
                onChanged: (text) {
                  informeController.onInputBuscaGuardiaChange(text);
                },
                validator: (text) {
                  if (text!.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Ingrese dato para búsqueda';
                  }
                },
                onSaved: (value) {
                 
                },
              ),
              //*****************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),
              Expanded(
                  child: SizedBox(
                      // color: Colors.red,
                      width: size.iScreen(100),
                      child: Consumer<AvisoSalidaController>(
                        builder: (_, provider, __) {
                          if (provider.getErrorInfoGuardia == null) {
                            return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          const Text('Cargando lista de Guardias.... '),
                        ],
                      ),
                    );
                          } else if (provider.getErrorInfoGuardia == false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (provider.getListaInfoGuardia.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }
    
                          return ListView.builder(
                            itemCount: provider.getListaInfoGuardia.length,
                            itemBuilder: (BuildContext context, int index) {
                              final guardia = provider.getListaInfoGuardia[index];
                              return Card(
                                child: ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${guardia['perApellidos']} ${guardia['perNombres']}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        
                                        fontWeight: FontWeight.normal),
                                  ),
                                  subtitle: Text(
                                    '${guardia['perDocNumero']}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                     
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    if (modulo == 'cambioPuesto') {
                                      final controllerCambioPuesto =
                                          Provider.of<CambioDePuestoController>(
                                              context,
                                              listen: false);
                                      controllerCambioPuesto
                                          .getInfoGuardia(guardia);
                                      Navigator.pop(context);
                                    } else if (modulo == 'avisoSalida') {
                                      provider.getInfomacionGuardia(
                                          guardia['perId'],
                                          guardia['perDocNumero'],
                                          guardia['perNombres'],
                                          guardia['perApellidos']);
                                      Navigator.pop(context);
                                    } else if (modulo == 'ausencia') {


                                      //=========AGREGAR ESTA PARTE PARA Q FUNCIONE========//
                                        final _controlAsusencia=context.read<AusenciasController>();
                                         _controlAsusencia.resetListaFechas();
                                  _controlAsusencia.setInfoGuardiaVerificaTurno(guardia);





                                         if(
                                          guardia['perIdCliente']==""||guardia['perIdCliente']==null&&
                                          guardia['perDocuCliente']==""||guardia['perDocuCliente']==null&&
                                          guardia['perNombreCliente']==""||guardia['perNombreCliente']==null&& guardia['perTurno'].isEmpty
                                        ){
                                            NotificatiosnService.showSnackBarDanger('El guardia no tiene cliente o turno  asignado');

                                        }else{

                                      Provider.of<AusenciasController>(context,
                                          listen: false).getInfomacionGuardia(guardia);
                                      Navigator.pop(context);
                                        }
                                    }
                                    else if (modulo == 'turnoExtra') {

                                         if(
                                          guardia['perIdCliente']==""||guardia['perIdCliente']==null&&
                                          guardia['perDocuCliente']==""||guardia['perDocuCliente']==null&&
                                          guardia['perNombreCliente']==""||guardia['perNombreCliente']==null
                                        ){
                                            NotificatiosnService.showSnackBarDanger('El guardia no tiene Cliente  asignado');

                                        }else{
                                      //  final _controlTurno= context.read<TurnoExtraController>();

                                            final _controlAsusencia=context.read<AusenciasController>();
                                    
                                  _controlAsusencia.setInfoGuardiaVerificaTurno(guardia);
                                  // _controlTurno.setListTurPuesto(guardia);
                                  



                                      //  print('_fecha : ${_fecha.getFechaValida}');


                                             //=============== AGREGAMOS VALIDACION  ===================//
                                   
                                    //    if(guardia['perTurno'].isNotEmpty){

                                    //               String fechaBuscada = '${_controlAusencia.getFechaValida}';











                                    //                     bool encontrada = false;
                                    //   for (var item in guardia['perTurno']) {

                                               

                                    //                     for (var fecha in item['fechasConsultaDB']) {
                                    //                       if (fecha["desde"].substring(0,10) == fechaBuscada) {
                                    //                         encontrada = true;
                                    //                         break;
                                    //                       }
                                    //                     }

                                                        
                                    //           }
                                    //           if (encontrada) {
                                    //                       print("La fecha $fechaBuscada se encuentra en la lista.");

                                    //      final _control=  Provider.of<TurnoExtraController>(context,listen: false);
                                         
                                    //       _control.getInfoGuardia(guardia);

                                    //   Navigator.pop(context);
                                    
                                    //  //=================================//
                                                          
                                    //                     } else {
                                    //                   NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                                    //                     }
                                                                                              


                                    //   }
                                     
                                             //    //=============== AGREGAMOS VALIDACION  ===================//
                                          final _controlleravisoSalida=context.read<AusenciasController>();
                                                 String fechaBuscada = '${_controlleravisoSalida.getFechaValida['desde'].substring(0,10)}';
                                      if(_controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno'].isNotEmpty){
                                      

                                                        bool encontrada = false;
                                                        bool _isFechaOk = false;
                                                         Map<String,dynamic>_fecha={};
                                            for (var item in _controlleravisoSalida.getInfoGuardiaVerificaTurno['perTurno']) {

                                              if(item['fechasConsultaDB'].isNotEmpty){

                                                  for (var e in item['fechasConsultaDB']) {
                                                    // print('LA DATA ${e['desde']}'); 
                                                    // print('LA DATA ${item['id']}'); 
                                                     if (e["desde"].substring(0,10) != fechaBuscada) {
                                                          
                                                            _isFechaOk = true;
                                                            break;
                                                          }
                                                          

                                                }
                                                
                                                
                                              }
                                              
                                              
                                                                                                                                                                  

                                 
                                            }
                                            
                                        if(_isFechaOk==true){
                                               final _control=  Provider.of<TurnoExtraController>(context,listen: false);
                                         
                                          _control.getInfoGuardia(guardia);

                                      Navigator.pop(context);
                                           
                                        }else
                                        {
                                            NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                                        }



                                      }







                                 



                                        }


                                     
                                    }
                                    else if (modulo == 'crearMulta') {
                                            if(
                                          guardia['perIdCliente']==""||guardia['perIdCliente']==null&&
                                          guardia['perDocuCliente']==""||guardia['perDocuCliente']==null&&
                                          guardia['perNombreCliente']==""||guardia['perNombreCliente']==null
                                        ){
                                            NotificatiosnService.showSnackBarDanger('El guardia no tiene Cliente  asignado');

                                        }
                                        else{
                                               String _agregarCeros(int numero) {
    return numero.toString().padLeft(2, '0');
  }
                                               //    //=============== AGREGAMOS VALIDACION  ===================//
                                          final _controlleravisoSalida=context.read<AusenciasController>();
                                            final _multasControl=context.read<MultasGuardiasContrtoller>();   

                                                   DateTime fechaActual = DateTime.now();
                                                  String fechaActualFormateada = "${fechaActual.year}-${_agregarCeros(fechaActual.month)}-${_agregarCeros(fechaActual.day)}";
                                                 String fechaBuscada =  fechaActualFormateada.toString();
                                                 _multasControl.setInfoGuardiaVerificaTurno(guardia);
                                      if(_multasControl.getInfoGuardiaVerificaTurno['perTurno'].isNotEmpty){
                                      

                                                        bool encontrada = false;
                                                        bool _isFechaOk = false;
                                                         Map<String,dynamic>_fecha={};
                                            for (var item in _multasControl.getInfoGuardiaVerificaTurno['perTurno']) {

                                              if(item['fechasConsultaDB'].isNotEmpty){

                                                  for (var e in item['fechasConsultaDB']) {
                                                    // print('LA DATA ${e['desde']}'); 
                                                    // print('LA DATA ${item['id']}'); 
                                                     if (e["desde"].substring(0,10) != fechaBuscada) {
                                                            encontrada = true;
                                                            _isFechaOk = true;
                                                            break;
                                                          }
                                                          

                                                }
                                                
                                                
                                              }
                                              
                                              
                                                                                                                                                                  

                                         if (encontrada) {
                                                      
                                         
                                _fecha ={
                                    "desde": "${_multasControl.getInputfechaInicio}T${_multasControl.getInputHoraInicio}",
                                    "hasta": "${_multasControl.getInputfechaFin}T${_multasControl.getInputHoraFin}",
                                    "id": "${item['id']}",
                                    "isSelect":false
                                  };
                           
                                 

                                         }
                                        
                                            }
                                            
                                        if(_isFechaOk==true){
                                          print('la fecha es : $_fecha');
                                        
                                           Provider.of<MultasGuardiasContrtoller>(context,listen: false).getInfomacionGuardia(guardia);
                                      Navigator.pop(context);
                                       Navigator.pushNamed(context, 'crearMultasGuardias');
                                           
                                        }else
                                        {
                                            NotificatiosnService.showSnackBarDanger('No tiene turno para esta fecha');
                                        }



                                      }



                                      //      Provider.of<MultasGuardiasContrtoller>(context,listen: false).getInfomacionGuardia(guardia);
                                      // Navigator.pop(context);
                                      //  Navigator.pushNamed(context, 'crearMultasGuardias');
                                        }
                                     
    
                                    }
                                    else if (modulo == 'editarMulta') {
                                            
                                      Provider.of<MultasGuardiasContrtoller>(context,
                                          listen: false).getInfoGuardiaEdit(guardia);
                                      Navigator.pop(context);
                                     
    
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
