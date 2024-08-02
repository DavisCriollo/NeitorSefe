// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';

import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/gestion_documental_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';

import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarPersonaGestionDocumental extends StatefulWidget {

final String  persona;
final String?  lugar ;

  const BuscarPersonaGestionDocumental({Key? key,  required this.persona, this.lugar}) : super(key: key);

  @override
  State<BuscarPersonaGestionDocumental> createState() => _BuscarPersonaGestionDocumentalState();
}

class _BuscarPersonaGestionDocumentalState extends State<BuscarPersonaGestionDocumental> {
  TextEditingController textSearchPersona = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchPersona.text = '';
 }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final controllers = Provider.of<GestionDocumentalController>(context);
       final ctrlTheme = context.read<ThemeApp>();
      final _user=context.read<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
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
          'Buscar ${widget.persona}',
          // style:  Theme.of(context).textTheme.headline2,
          
        ),
       
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
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


            SizedBox(
              height: size.iScreen(1.5),
            ),
            //*****************************************/

            TextFormField(
              controller: textSearchPersona,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar ${widget.persona}',
                suffixIcon: GestureDetector(
                  onTap: () async {
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
                // tipoMultaController.onInputBuscaGuardiaChange(text);
                controllers.onInputBuscaPersonaChange(text);
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
                    child: Consumer<GestionDocumentalController>(
                      builder: (_, provider, __) {
                        if (provider.getErrorPersonalGestion == null) {
                          return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          const Text('Cargando información.... '),
                        ],
                      ),
                    );
                        } else if (provider.getErrorPersonalGestion == true ) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (provider.getListaPersonalGestion.isEmpty) {
                          return   Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                           Text('Cargando lista de ${widget.persona}.... '),
                        ],
                      ),
                    );
                        }

                        return ListView.builder(
                          itemCount: provider.getListaPersonalGestion.length,
                          itemBuilder: (BuildContext context, int index) {
                            final _persona = provider.getListaPersonalGestion[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${_persona['perApellidos']} ${_persona['perNombres']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  '${_persona['perDocNumero']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  // if (widget.persona == 'Guardias') {
                                  //  if (widget.lugar=='gestionDocumental') {
                                  //  final ctrl= context.read<GestionDocumentalController>();
                                  //  ctrl.setListaDePersonal(_persona);
                                  //   // Navigator.pop(context);
                                  // }
                                  //  controllers.getListaDeGuardias(_persona);
                                  //   Navigator.pop(context);
                                   
                                  // } 
                                  // else  if (widget.persona == 'Supervisores') {
                                  //  if (widget.lugar=='gestionDocumental') {
                                  //  final ctrl= context.read<GestionDocumentalController>();
                                  //  ctrl.setListaDePersonal(_persona);
                                  //   // Navigator.pop(context);
                                  // }
                                  //  controllers.getListaDeSupervisores(_persona);
                                  //   Navigator.pop(context);
                                   
                                  // } 
                                  // else  if (widget.persona == 'Administradores') {
                                  //  if (widget.lugar=='gestionDocumental') {
                                  //  final ctrl= context.read<GestionDocumentalController>();
                                  //  ctrl.setListaDePersonal(_persona);
                                  //   // Navigator.pop(context);
                                   
                                  // }
                                   controllers.setListaDePersonal(_persona);
                                    Navigator.pop(context);
                                   
                                  } 
                                   
                                  // else if (modulo == 'nuevoPedido') {
                                  //  Provider.of<GestionDocumentalController>(
                                  //           context,
                                  //           listen: false).getInfoCliente(cliente);
                                   
                                  //   Navigator.pop(context);
                                  // }
                                  // else if (modulo == 'crearPermiso') {
                                  //   Provider.of<AusenciasController>(
                                  //           context,
                                  //           listen: false).getInfoClientes(cliente);
                                   
                                  //   Navigator.pop(context);
                                  // }
                                // },
                              ),
                            );
                          },
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
