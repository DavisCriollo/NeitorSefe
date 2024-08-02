// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardiasVarios extends StatefulWidget {
  const BuscarGuardiasVarios({Key? key}) : super(key: key);

  @override
  State<BuscarGuardiasVarios> createState() => _BuscarGuardiasVariosState();
}

class _BuscarGuardiasVariosState extends State<BuscarGuardiasVarios> {
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
    final informeController = Provider.of<InformeController>(context);
    final modulo = ModalRoute.of(context)!.settings.arguments;
      final ctrlTheme = context.read<ThemeApp>();
         
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            'Buscar Personal',
            // style: Theme.of(context).textTheme.headline2,
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
                controller: textSearchGuardiaMulta,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'búsqueda Personal',
                  suffixIcon: GestureDetector(
                    onTap: () async {},
                    child: const Icon(
                      Icons.search,
                      color: Color(0XFF343A40),
                    ),
                  ),
                ),
                textAlign: TextAlign.start,
                style: const TextStyle(),
                onChanged: (text) {},
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
              Wrap(
                children: informeController.getListaGuardiaInforme
                    .map(
                      (e) => GestureDetector(
                        onTap: () =>
                            informeController.eliminaGuardiaInforme(e['id']),
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
                      child: Consumer<InformeController>(
                        builder: (_, provider, __) {
                          if (provider.getErrorInfoGuardia == null) {
                            return const NoData(
                              label: 'Ingrese dato para búsqueda',
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
                                    '${guardia['perNombres']} ${guardia['perApellidos']}',
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
                                    provider.setGuardiaInforme(guardia);
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
