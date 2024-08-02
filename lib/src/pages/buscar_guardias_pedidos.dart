import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarGuardiasPedido extends StatefulWidget {
  const BuscarGuardiasPedido({Key? key}) : super(key: key);

  @override
  State<BuscarGuardiasPedido> createState() =>
      _BuscarGuardiasPedidoState();
}

class _BuscarGuardiasPedidoState
    extends State<BuscarGuardiasPedido> {
  TextEditingController textSearchClienteDistribucion = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadData = LogisticaController();
   textSearchClienteDistribucion.text = '';
  }

  @override
  void dispose() {
    textSearchClienteDistribucion.clear();
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
          'Buscar Guardia',
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
              controller: textSearchClienteDistribucion,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'buscar....',
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
              logisticaController.onInputBuscaGuardiasPedidoChange(text);
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
                        if (provider.getErrorGuardiasPedido == null) {
                          return const NoData(
                            label: 'Ingrese dato para búsqueda',
                          );
                        }
                       
                        else if (provider
                            .getListaTodosLosGuardiasPedido.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return ListView.builder(
                          itemCount:
                              provider.getListaTodosLosGuardiasPedido.length,
                          itemBuilder: (BuildContext context, int index) {
                            final guardia =
                                provider.getListaTodosLosGuardiasPedido[index];
                            return Card(
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  '${guardia.perNombres} ${guardia.perApellidos}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  '${guardia.perEmpresa}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.7),
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                                onTap: () {
                                  provider.getGuardiaPedido(guardia);
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
