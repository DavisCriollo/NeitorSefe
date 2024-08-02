import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarClientesInformes extends StatefulWidget {
  const BuscarClientesInformes({Key? key}) : super(key: key);

  @override
  State<BuscarClientesInformes> createState() => _BuscarClientesInformesState();
}

class _BuscarClientesInformesState extends State<BuscarClientesInformes> {
  TextEditingController textSearchClienteInformes = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadData = MultasGuardiasContrtoller();
    textSearchClienteInformes.text = '';
  }

  @override
  void dispose() {
    textSearchClienteInformes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final informesController = Provider.of<InformeController>(context);
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.iScreen(1.5),
            ),
           
            TextFormField(
              controller: textSearchClienteInformes,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'búsqueda Cliente',
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
               informesController.onInputBuscaClienteInformesChange(text);
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
                    width: size.iScreen(100),
                    child: Consumer<InformeController>(
                      builder: (_, provider, __) {
                        if (provider.getErrorClientesInformes == null) {
                          return const NoData(
                            label: 'Ingrese dato para búsqueda',
                          );
                        }
                       
                        else if (provider
                            .getListaTodosLosClientesInfomes.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount:
                              provider.getListaTodosLosClientesInfomes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cliente =
                                provider.getListaTodosLosClientesInfomes[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${cliente.cliRazonSocial}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  '${cliente.cliCelular} - ${cliente.cliTelefono}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  provider.setDirigidoAClienteChange(cliente);
              Navigator.pop(context);
                                  
                                },
                              ),
                            );
                        
                          },
                        );
                      },
                    )

                    
                    ))
          ],
        ),
      ),
    );
  }
}
