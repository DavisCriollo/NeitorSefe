import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarClientesPedidos extends StatefulWidget {
  final String? tipo;
  const BuscarClientesPedidos({Key? key, this.tipo}) : super(key: key);

  @override
  State<BuscarClientesPedidos> createState() => _BuscarClientesPedidosState();
}

class _BuscarClientesPedidosState extends State<BuscarClientesPedidos> {
  TextEditingController textSearchClientePedidos = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadData = LogisticaController();

    textSearchClientePedidos.text = '';
  }

  @override
  void dispose() {
    textSearchClientePedidos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final logisticaController = Provider.of<LogisticaController>(context);
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
          // style: Theme.of(context).textTheme.headline2,
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
              controller: textSearchClientePedidos,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'búsqueda Cliente',
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
              onChanged: (text) {
                logisticaController.onInputBuscaClienteChangeChange(
                    text, widget.tipo);
              },
              validator: (text) {
                if (text!.trim().isNotEmpty) {
                  return null;
                } else {
                  return 'Ingrese dato para búsqueda';
                }
              },
              onSaved: (value) {},
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
                        if (provider.getErrorClientesPedidos == null) {
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
                        } else if (provider
                            .getListaTodosLosClientesPedidos.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount:
                              provider.getListaTodosLosClientesPedidos.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cliente =
                                provider.getListaTodosLosClientesPedidos[index];
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
                                  '${cliente.cliNombreComercial}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  provider.getClientePedido(cliente);
                                  // provider.setDirigidoAChange(cliente);
                                  Navigator.pop(context);
                                  // provider.setListaCorreosClienteMultas(
                                  //     cliente.cliId,
                                  //     cliente.cliDocNumero,
                                  //     cliente.cliNombreComercial,
                                  //     cliente.perEmail);
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
