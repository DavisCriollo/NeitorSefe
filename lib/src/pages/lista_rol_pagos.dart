import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

import '../models/session_response.dart';

class ListaRolPagos extends StatefulWidget {
  final Session? user;
  const ListaRolPagos({Key? key, required this.user}) : super(key: key);

  @override
  State<ListaRolPagos> createState() => _ListaRolPagosState();
}

class _ListaRolPagosState extends State<ListaRolPagos> {
          final _control = HomeController();
  @override
  Widget build(BuildContext context) {
        final Responsive size = Responsive.of(context);
  final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
      child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
              'Rol de Pagos',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: Container(
            // color: Colors.red,
             margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                    padding: EdgeInsets.only(
                    top: size.iScreen(0.0),
                    left: size.iScreen(0.5),
                    right: size.iScreen(0.5),
                  ),
                    width: size.wScreen(100.0),
                    height: size.hScreen(100.0),
                     child: 
                    Consumer<HomeController>(builder: (_, provider, __) {
                      if (provider.getErrorRolesPago == null) {
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
                      } else if (provider.getErrorRolesPago == false) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("Error al cargar los datos");
                      } else if (provider.getListaRolesPago.isEmpty) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("sin datos");
                      }
                      return RefreshIndicator(
                        
                        onRefresh: onRefresh,
                        child: ListView.builder(
                          itemCount: provider.getListaRolesPago.length,
                          itemBuilder: (BuildContext context, int index) {
                            final rol = provider.getListaRolesPago[index];
                               String fechaLocal = DateUtility.fechaLocalConvert(  rol['rolpFecVinculacion']!.toString());
                            return GestureDetector(
                              onTap: () {
                              //====================//
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewsPDFs(
                              infoPdf:
                                  // 'https://backsigeop.neitor.com/api/reportes/informeindividual?infId=${widget.informe['infId']}&rucempresa=${widget.user!.rucempresa}&usuario=${widget.user!.usuario}',
                                  'https://backsigeop.neitor.com/api/reportes/rolpagoindividual?rolpId=${rol['rolpId']}&rucempresa=${rol['rolpEmpresa']}',
                              labelPdf: 'Rol.pdf')),
                    );
            //         // //====================//
                              },
                              child: 
                              Container(
                                margin: EdgeInsets.only(top: size.iScreen(0.5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.iScreen(1.5),
                                    vertical: size.iScreen(0.5)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
                                            'Periodo: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          width: size.wScreen(60.0),
                                          child: Text(
                                            // '${informe['infAsunto']}',
                                            '${rol['rolpPeriodo']}',
                                            overflow: TextOverflow.ellipsis,
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
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(50.0),
                                          child: Text(
                                            'Cargo: ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.5),
                                                color: Colors.black87,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          width: size.wScreen(50.0),
                                          // color: Colors.red,
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                      
                                          child: Text(
                                            '${rol['rolpCargo']}',
                                            overflow: TextOverflow.ellipsis,
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
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.0)),
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Fecha Vinculación: ',
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
                                         
                                            // rol['infFecReg']
                                            //     .toString()
                                            //     .replaceAll("T", " ")
                                            //     .replaceAll("000Z", " "),
                                            fechaLocal,
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
                            );
                          },
                        ),
                      );
                    })

          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
  
     
    _control.buscaRolesPago();
  }
}