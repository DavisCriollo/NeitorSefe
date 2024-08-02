// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardiasVariosPedidos extends StatefulWidget {
  const BuscarGuardiasVariosPedidos({Key? key}) : super(key: key);

  @override
  State<BuscarGuardiasVariosPedidos> createState() =>
      _BuscarGuardiasVariosPedidosState();
}

class _BuscarGuardiasVariosPedidosState
    extends State<BuscarGuardiasVariosPedidos> {
  TextEditingController textSearchGuardiaMulta = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchGuardiaMulta.text = '';

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final logisticaController = Provider.of<LogisticaController>(context);
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
            'Buscar Personal',
            // style:  Theme.of(context).textTheme.headline2,
           
          ),
         
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.iScreen(1.5),
              ),
              //*****************************************/

              TextFormField(
                controller: textSearchGuardiaMulta,
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
                  // tipoMultaController.onInputBuscaGuardiaChange(text);
                  logisticaController.onInputBuscaItemChange(text);
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
                      child: Consumer<LogisticaController>(
                        builder: (_, provider, __) {
                          if (provider.getErrorInfoGuardiaPedido == null) {
                            return 
                           
                            Center(
                                    // child: CircularProgressIndicator(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Cargando Datos...',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.5),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
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
                          } else if (provider.getErrorInfoGuardiaPedido ==
                              false) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                          } else if (provider
                              .getListaInfoGuardiaPedidos.isEmpty) {
                            return const NoData(
                              label: 'No existen datos para mostar',
                            );
                            // Text("sin datos");
                          }

                          return ListView.builder(
                            itemCount:
                                provider.getListaInfoGuardiaPedidos.length,
                            itemBuilder: (BuildContext context, int index) {
                              final guardia =
                                  provider.getListaInfoGuardiaPedidos[index];
                              return Card(
                                child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      '${guardia['perApellidos']} ${guardia['perNombres']} ',
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
                                      provider.setGuardiaVarios(guardia);
                                       Navigator.pop(context);
                                    }),
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
