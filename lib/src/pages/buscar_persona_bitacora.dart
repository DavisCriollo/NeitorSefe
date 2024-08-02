import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarPersonaBitacora extends StatefulWidget {
  const BuscarPersonaBitacora({Key? key}) : super(key: key);

  @override
  State<BuscarPersonaBitacora> createState() => _BuscarPersonaBitacoraState();
}

class _BuscarPersonaBitacoraState extends State<BuscarPersonaBitacora> {
  TextEditingController textSearchPersonaBitacora = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
   
   textSearchPersonaBitacora.text = '';
  }

  @override
  void dispose() {
    textSearchPersonaBitacora.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _controller = Provider.of<BitacoraController>(context);
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
          'Buscar Persona ',
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
              controller: textSearchPersonaBitacora,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'búsqueda de Persona',
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
               _controller.onInputBuscaPersonaBitacoraChange(text);
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
                    child: Consumer<BitacoraController>(
                      builder: (_, provider, __) {
                        // if (provider.getErrorTodasPersonasBitacora == null) {
                        //   return const NoData(
                        //     label: 'Ingrese dato para búsqueda',
                        //   );
                        // }
                       
                        // else if (provider
                        //     .getListaTodasPersonasBitacora.isEmpty) {
                        //   return const NoData(
                        //     label: 'No existen datos para mostar',
                        //   );
                        //   // Text("sin datos");
                        // }  

                            if (provider.getErrorTodasPersonasBitacora == null) {
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
                  } else if (provider.getErrorTodasPersonasBitacora == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                  } else if (provider.getListaTodasPersonasBitacora.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                  }

                        return ListView.builder(
                          itemCount:
                              provider.getListaTodasPersonasBitacora.length,
                          itemBuilder: (BuildContext context, int index) {
                            final persona =
                                provider.getListaTodasPersonasBitacora[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${persona['resNombres']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  '${persona['resTelefono']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {

                                  provider.setItemSeDirigeA(persona['resNombres']);
                                  provider.setItemAutorizadoPor('');

                                  provider.setDirigidoAChange(persona);
                                     provider.setListaAutorizadosBitacora(persona['resPersonasAutorizadas']);
                                  Navigator.pop(context);
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
