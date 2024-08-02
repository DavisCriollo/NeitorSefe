import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/estado_cuenta_controller.dart';
import 'package:nseguridad/src/dataTable/detalle_contrato_datasource.dart';
import 'package:nseguridad/src/models/lista_allEstados_cuenta_cliente.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';

class DetalleContratoPage extends StatelessWidget {
  final Result? infoEstadoCentaCliente;
  const DetalleContratoPage({Key? key, this.infoEstadoCentaCliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerEstadoCuenta = Provider.of<EstadoCuentaController>(context);
    Responsive size = Responsive.of(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // backgroundColor: primaryColor,
         
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
        title:  Text('Detalle de Contrato',
        // style:  Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: size.iScreen(0.0)),
        padding: EdgeInsets.only(
            left: size.iScreen(0),
            right: size.iScreen(0),
            top: size.iScreen(2.0)),
        width: size.wScreen(100.0),
        height: size.hScreen(100),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            child: Column(
              children: [
                //*****************************************/
                Container(
                  padding: EdgeInsets.only(
            left: size.iScreen(1.0),
            right: size.iScreen(1.0),),
                  child: Column(
                    children: [
                      
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Contrato:',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // width: size.wScreen(35),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(3.5)),
                            child: Text(
                              "${infoEstadoCentaCliente!.estPeriodo}",
                              // infoConsignaCliente!.conDesde
                              //     .toString()
                              //     .replaceAll(" 00:00:00.000", ""),
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  Row(
                    children: [
                      Text(
                        'Fecha de registro: ',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                         infoEstadoCentaCliente!.estFecReg
                                      .toString()
                                      .replaceAll(".000Z", ""),
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hasta: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            infoEstadoCentaCliente!.estFecFinal
                                      .toString()
                                      .replaceAll("00:00:00.000", ""),
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Desde: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            infoEstadoCentaCliente!.estFecInicio
                                      .toString()
                                      .replaceAll("00:00:00.000", ""),
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //*****************************************/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Monto: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                           "${infoEstadoCentaCliente!.estMonto}",
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Saldo: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                           "${infoEstadoCentaCliente!.estSaldo}",
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //***********************************************/
                SizedBox(
                  height: size.iScreen(2.0),
                ),
                //*****************************************/
                SizedBox(
                  width: size.wScreen(100.0),
                  child: Text(
                    'Abonos:',
                    style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(1.8),
                      color: Colors.black45,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                    ],
                  ),
                ),
                
                                //***********************************************/
                PaginatedDataTable(columns: const [
                  DataColumn(label: Text('Detalle'),),
                  DataColumn(label: Text('Fecha'),),
                  DataColumn(label: Text('Cuota'),),
                  DataColumn(label: Text('Estado'),),
                  ], source: DetalleContratoDTS(controllerEstadoCuenta.getListaTodasLasCuotasCliente,size),),
                //***********************************************/
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
