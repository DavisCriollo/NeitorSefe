// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardiasMultiples extends StatefulWidget {
  const BuscarGuardiasMultiples({Key? key}) : super(key: key);

  @override
  State<BuscarGuardiasMultiples> createState() =>
      _BuscarGuardiasMultiplesState();
}

class _BuscarGuardiasMultiplesState extends State<BuscarGuardiasMultiples> {
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
    final infoGuardiaController = Provider.of<AvisoSalidaController>(context);
    final modulo = ModalRoute.of(context)!.settings.arguments;
      final ctrlTheme = context.read<ThemeApp>();
        

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
            children: [
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
                  infoGuardiaController.onInputBuscaGuardiaChange(text);
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
              //*****************************************/
              SizedBox(
                height: size.iScreen(1.0),
              ),
              Wrap(
                children: infoGuardiaController.getListaGuardiaInformeacion
                    .map(
                      (e) => GestureDetector(
                        onTap: () {

                          infoGuardiaController
                              .eliminaGuardiaInformacion(e['id']);

                              Provider.of<LogisticaController>(context,listen: false).eliminaGuardiaPedido(e['id']);

                              
                        },
                        child: Container(
                          margin: EdgeInsets.all(size.iScreen(0.6)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: EdgeInsets.all(size.iScreen(0.2)),
                              decoration: const BoxDecoration(
                                color: primaryColor,
                              ),
                              width: size.iScreen(13.0),
                              child: Text(
                                '${e['nombres']}.',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.4),
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              //
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
                              final guardia =
                                  provider.getListaInfoGuardia[index];
                              return Card(
                                child: ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${guardia['perApellidos']} ${guardia['perNombres']}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        // color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  subtitle: Text(
                                    '${guardia['perDocNumero']}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                        // color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    if (modulo == 'nuevoPedido') {
                                      final controllerCambioPuesto =
                                          Provider.of<AvisoSalidaController>(
                                              context,
                                              listen: false);
                                      controllerCambioPuesto
                                          .setGuardiaInformacion(guardia);
                                      final controllerCreaPedido =
                                          Provider.of<LogisticaController>(
                                              context,
                                              listen: false);
                                      controllerCreaPedido
                                          .setGuardiaVarios(guardia);


                                      // print('INFORMACION DE PPEDIDOS:$guardia');

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
