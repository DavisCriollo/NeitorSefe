// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardiasConsignas extends StatefulWidget {
  const BuscarGuardiasConsignas({Key? key}) : super(key: key);

  @override
  State<BuscarGuardiasConsignas> createState() =>
      _BuscarGuardiasConsignasState();
}

class _BuscarGuardiasConsignasState extends State<BuscarGuardiasConsignas> {
  TextEditingController textSearchGuardiaConsignas = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchGuardiaConsignas.text = '';

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final consignasController = Provider.of<ConsignasController>(context);
      final ctrlTheme = context.read<ThemeApp>();
    return Scaffold(
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
          children: [
            SizedBox(
              height: size.iScreen(1.5),
            ),
            //*****************************************/

            TextFormField(
              controller: textSearchGuardiaConsignas,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar Guardias',
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

            Consumer<ConsignasController>(
              builder: (_, valuesSeleccionados, __) {
                return Wrap(
                  children: valuesSeleccionados.getListaGuardiasConsigna
                      .map(
                        (e) => GestureDetector(
                          onTap: () => valuesSeleccionados
                              .eliminaGuardiaConsigna(e['id']),
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
                );
//
              },
            ),

            Expanded(
                child: SizedBox(
                    // color: Colors.red,
                    width: size.iScreen(100),
                    child: Consumer<ConsignasController>(
                      builder: (_, provider, __) {
                       

                        if (provider.getErrorListaGuardiasConsignas == null) {
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
                        } else if (provider.getErrorListaGuardiasConsignas ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (provider
                            .getListaInfoGuardiaConsigna.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount:
                              provider.getListaInfoGuardiaConsigna.length,
                          itemBuilder: (BuildContext context, int index) {
                            final guardia =
                                provider.getListaInfoGuardiaConsigna[index];
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
                                  '${guardia['perPerfil'][0]}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.5),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  provider.setGuardiaConsigna(guardia);
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
