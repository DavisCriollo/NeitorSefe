// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';

import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';

import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarClientes extends StatefulWidget {
  // final String? modulo;

  const BuscarClientes({Key? key}) : super(key: key);

  @override
  State<BuscarClientes> createState() => _BuscarClientesState();
}

class _BuscarClientesState extends State<BuscarClientes> {
  TextEditingController textSearchClientes = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchClientes.text = '';
 }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final controllers = Provider.of<CambioDePuestoController>(context);
    final modulo = ModalRoute.of(context)!.settings.arguments;

      final _user=context.read<HomeController>();
        final ctrlTheme = context.read<ThemeApp>();
        

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
          'Buscar Cliente',
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
              controller: textSearchClientes,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar Cliente dsdsd',
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
                controllers.onInputBuscaClienteChange(text);
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
                    child: Consumer<CambioDePuestoController>(
                      builder: (_, provider, __) {
                        if (provider.getErrorClientes == null) {
                          return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          const Text('Cargando lista de Clientes.... '),
                        ],
                      ),
                    );
                        } else if (provider.getErrorClientes == false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (provider.getListaTodosLosClientes.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount: provider.getListaTodosLosClientes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cliente = provider.getListaTodosLosClientes[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${cliente['cliRazonSocial']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  '${cliente['cliDocNumero']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  if (modulo == 'cambioPuesto') {
                                   
                                        Provider.of<CambioDePuestoController>(
                                            context,
                                            listen: false).getInfoCliente(cliente);
                                    Navigator.pop(context);
                                   
                                  } 
                                  else if (modulo == 'turnoExtra') {
                                    Provider.of<TurnoExtraController>(
                                            context,
                                            listen: false).getInfoCliente(cliente);
                                   
                                    Navigator.pop(context);
                                  }
                                  else if (modulo == 'nuevoPedido') {
                                  final _control= Provider.of<LogisticaController>(
                                            context,
                                            listen: false);
                                            _control.getInfoCliente(cliente);
                                         
                                   
                                    Navigator.pop(context);
                                  }
                                  else if (modulo == 'crearPermiso') {
                                    Provider.of<AusenciasController>(
                                            context,
                                            listen: false).getInfoClientes(cliente);
                                   
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
    );
  }
}
