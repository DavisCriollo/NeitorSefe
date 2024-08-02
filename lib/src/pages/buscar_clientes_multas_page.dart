import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarClientesMultas extends StatefulWidget {
  const BuscarClientesMultas({Key? key}) : super(key: key);

  @override
  State<BuscarClientesMultas> createState() => _BuscarClientesMultasState();
}

class _BuscarClientesMultasState extends State<BuscarClientesMultas> {
  TextEditingController textSearchClienteMulta = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
   
    textSearchClienteMulta.text = '';
  }

  @override
  void dispose() {
    textSearchClienteMulta.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final multasController = Provider.of<MultasGuardiasContrtoller>(context);
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
            SizedBox(
              height: size.iScreen(1.5),
            ),
           
            TextFormField(
              controller: textSearchClienteMulta,
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

                  // fontSize: size.iScreen(3.5),
                  // fontWeight: FontWeight.bold,
                  // letterSpacing: 2.0,
                  ),
              onChanged: (text) {
                // tipoMultaController.onInputBuscaGuardiaChange(text);
                multasController.onInputBuscaClienteMultaChange(text);
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
            Wrap(
              children: multasController.getListaCorreosClienteMultas
                  .map(
                    (e) => GestureDetector(
                      onTap: () => multasController.eliminaClienteMulta(e['id']) ,
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
            SizedBox(
              height: size.iScreen(1.0),
            ),
            Expanded(
                child: SizedBox(
                    // color: Colors.red,
                    width: size.iScreen(100),
                    child: Consumer<MultasGuardiasContrtoller>(
                      builder: (_, provider, __) {
                        if (provider.getErrorInfoMultaGuardia == null) {
                          return const NoData(
                            label: 'Ingrese dato para búsqueda',
                          );
                        }
                        //  else if (provider.getErrorInfoMultaGuardia == false) {
                        //   return const NoData(s
                        //     label: 'Error al cargar la información',
                        //   );
                        // Text("Error al cargar los datos");
                        // }
                        else if (provider.getListaInfoMultaGuardia.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount: provider.getListaTodosLosClientes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cliente =
                                provider.getListaTodosLosClientes[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${cliente.cliNombreComercial}',
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
  provider.setListaCorreosClienteMultas(
                                      cliente.cliId,
                                      cliente.cliDocNumero,
                                      cliente.cliNombreComercial,
                                      cliente.perEmail);
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
