import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/estado_cuenta_controller.dart';

import 'package:nseguridad/src/pages/detalle_contrato_cliente_page.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/error_data.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaEstadoCuentaClientesPage extends StatefulWidget {
  const ListaEstadoCuentaClientesPage({Key? key}) : super(key: key);

  @override
  State<ListaEstadoCuentaClientesPage> createState() =>
      _ListaEstadoCuentaClientesPageState();
}

class _ListaEstadoCuentaClientesPageState
    extends State<ListaEstadoCuentaClientesPage> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
  final ctrlTheme = context.read<ThemeApp>();
        
    return ChangeNotifierProvider(
        create: (_) => EstadoCuentaController(),
        builder: (context, _) {
          final EstadoCuentaController controller =
              context.watch<EstadoCuentaController>();
          return Scaffold(
            backgroundColor: const Color(0xFFEEEEEE),
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
                'Mis Contratos',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.iScreen(1.0),
              ),

              // color: Colors.red,
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),

              child: Consumer<EstadoCuentaController>(
                builder: (_, providers, __) {
                  if (providers.getErrorAllEstadosCuenta == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (providers.getErrorAllEstadosCuenta == false) {
                    return const ErrorData();
                    // Text("Error al cargar los datos");
                  } else if (providers
                      .getTodoslosEstadosdeCuentaCliente.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }

                  return ListView.builder(
                    itemCount:
                        providers.getTodoslosEstadosdeCuentaCliente.length,
                    itemBuilder: (BuildContext context, int index) {
                      final estdoCuenta =
                          providers.getTodoslosEstadosdeCuentaCliente[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetalleContratoPage(
                                      infoEstadoCentaCliente: estdoCuenta))));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: size.iScreen(0.5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(1.5),
                              vertical: size.iScreen(0.5)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Contrato: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            '${estdoCuenta.estPeriodo}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Desde: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                //  '${estdoCuenta.estFecInicio}',
                                                estdoCuenta.estFecInicio
                                                    .toString()
                                                    .replaceAll(
                                                        "00:00:00.000", ""),
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.iScreen(2.0),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Hasta: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                estdoCuenta.estFecFinal
                                                    .toString()
                                                    .replaceAll(
                                                        "00:00:00.000", ""),
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            estdoCuenta.estFecReg
                                                .toString()
                                                .replaceAll(".000Z", ""),
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            '',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //***********************************************/
                                  // SizedBox(
                                  //   height: size.iScreen(0.5),
                                  // ),

                                  //*****************************************/
                                  Text(
                                    'Monto',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.6),
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '${estdoCuenta.estMonto}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Saldo',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.6),
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '${estdoCuenta.estSaldo}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
