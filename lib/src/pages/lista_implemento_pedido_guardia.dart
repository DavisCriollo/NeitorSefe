import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class BuscarImplementoPedidoGuardiaPage extends StatefulWidget {
  const BuscarImplementoPedidoGuardiaPage({Key? key}) : super(key: key);

  @override
  State<BuscarImplementoPedidoGuardiaPage> createState() =>
      _BuscarImplementoPedidoGuardiaPageState();
}

class _BuscarImplementoPedidoGuardiaPageState
    extends State<BuscarImplementoPedidoGuardiaPage> {
  TextEditingController textSearchImplemento = TextEditingController();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    textSearchImplemento.text = '';
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final logisticaController = Provider.of<LogisticaController>(context);
      final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
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
            title: Text(
              'Implementos',
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
                  controller: textSearchImplemento,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Búscar...',
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
                    logisticaController.onInputBuscaItemChange(text);
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
                            if (provider.getErrorImplementoPedido == null) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    SizedBox(
                                      height: size.iScreen(2.0),
                                    ),
                                    const Text('Cargando Implementos.... '),
                                  ],
                                ),
                              );
                            } else if (provider.getErrorImplementoPedido ==
                                false) {
                              return const NoData(
                                label: 'No existen datos para mostar',
                              );
                            } else if (provider
                                .getListaImplementoPedido.isEmpty) {
                              return const NoData(
                                label: 'No existen datos para mostar',
                              );
                              // Text("sin datos");
                            }

                            return ListView.builder(
                              itemCount:
                                  provider.getListaImplementoPedido.length,
                              itemBuilder: (BuildContext context, int index) {
                                final implemento =
                                    provider.getListaImplementoPedido[index];
                                return GestureDetector(
                                  onTap: () {
                                    provider.getImplemento(implemento);

                                    Navigator.pop(context);
                                  },
                                  child:
                                  //  ClipRRect(
                                  //   child: Card(
                                  //     child: Container(
                                  //       margin: EdgeInsets.only(
                                  //           top: size.iScreen(0.5)),
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: size.iScreen(1.0),
                                  //           vertical: size.iScreen(0.5)),
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius:
                                  //             BorderRadius.circular(8),
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Column(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.start,
                                  //             children: [
                                  //               Container(
                                  //                 // color: Colors.red,
                                  //                 margin: EdgeInsets.only(
                                  //                     top: size.iScreen(0.5),
                                  //                     bottom:
                                  //                         size.iScreen(0.0)),
                                  //                 width: size.wScreen(70.0),
                                  //                 child: Expanded(
                                  //                   child: Text(
                                  //                     '${implemento['invNombre']}',
                                  //                     // overflow:
                                  //                     //     TextOverflow.ellipsis,
                                  //                     style:
                                  //                         GoogleFonts.lexendDeca(
                                  //                             fontSize: size
                                  //                                 .iScreen(1.5),
                                  //                             color:
                                  //                                 Colors.black87,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .bold),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 width: size.wScreen(70.0),
                                  //                 child: Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment.start,
                                  //                   children: [
                                  //                     Container(
                                  //                       // color: Colors.red,
                                  //                       margin: EdgeInsets.only(
                                  //                           top: size
                                  //                               .iScreen(0.5),
                                  //                           bottom: size
                                  //                               .iScreen(0.0)),
                                  //                       width:
                                  //                           size.wScreen(10.0),
                                  //                       // width: size.wScreen(100.0),
                                  //                       child: Text(
                                  //                         'Color: ',
                                  //                         style: GoogleFonts
                                  //                             .lexendDeca(
                                  //                                 fontSize: size
                                  //                                     .iScreen(
                                  //                                         1.5),
                                  //                                 color: Colors
                                  //                                     .black87,
                                  //                                 fontWeight:
                                  //                                     FontWeight
                                  //                                         .normal),
                                  //                       ),
                                  //                     ),
                                  //                     Container(
                                  //                       // color: Colors.red,
                                  //                       margin: EdgeInsets.only(
                                  //                           top: size
                                  //                               .iScreen(0.5),
                                  //                           bottom: size
                                  //                               .iScreen(0.0)),
                                  //                       // width: size.wScreen(60.0),
                                  //                       child: Expanded(
                                  //                         child: Text(
                                  //                           '${implemento['invColor']}',
                                  //                           overflow:
                                  //                               TextOverflow
                                  //                                   .ellipsis,
                                  //                           style: GoogleFonts.lexendDeca(
                                  //                               fontSize: size
                                  //                                   .iScreen(
                                  //                                       1.5),
                                  //                               color: Colors
                                  //                                   .black87,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .bold),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           Column(
                                  //             children: [
                                  //               Container(
                                  //                 margin: EdgeInsets.only(
                                  //                     top: size.iScreen(0.5),
                                  //                     bottom:
                                  //                         size.iScreen(0.0)),
                                  //                 // width: size.wScreen(100.0),
                                  //                 child: Text(
                                  //                   'Stock ',
                                  //                   style:
                                  //                       GoogleFonts.lexendDeca(
                                  //                           fontSize: size
                                  //                               .iScreen(1.5),
                                  //                           color:
                                  //                               Colors.black87,
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .normal),
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 // color: Colors.red,
                                  //                 margin: EdgeInsets.only(
                                  //                     top: size.iScreen(0.5),
                                  //                     bottom:
                                  //                         size.iScreen(0.0)),
                                  //                 // width: size.wScreen(60.0),
                                  //                 child: Text(
                                  //                   '${implemento['invStock']}',
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style:
                                  //                       GoogleFonts.lexendDeca(
                                  //                           fontSize: size
                                  //                               .iScreen(1.5),
                                  //                           color:
                                  //                               Colors.black87,
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .bold),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                           ClipRRect(
                                          child: Card(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.iScreen(1.0),
                                                  vertical: size.iScreen(0.5)),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black54,
                                                      blurRadius: 1.0,
                                                      offset: Offset(0.0, 1.0))
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          // color: Colors.red,
                                                          margin: EdgeInsets.only(
                                                              top: size.iScreen(0.5),
                                                              bottom:
                                                                  size.iScreen(0.0)),
                                                          width: size.wScreen(100.0),
                                                          child: Text(
                                                              '${implemento['invNombre']}',
                                                            // overflow:
                                                            //     TextOverflow.ellipsis,
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(1.8),
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Color: ',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal),
                                                              ),
                                                            ),
                                                            Container(
                                                              // color: Colors.red,
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              width:
                                                                  size.wScreen(50.0),
                                                              child: Text(
                                                                      '${implemento['invColor']}',
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Marca: ',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                  '${implemento['invMarca']}',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Modelo: ',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(0.5),
                                                                  bottom: size
                                                                      .iScreen(0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                  '${implemento['invModelo']}',
                                                                style: GoogleFonts
                                                                    .lexendDeca(
                                                                        fontSize: size
                                                                            .iScreen(
                                                                                1.5),
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                       
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Stock',
                                                        style: GoogleFonts.lexendDeca(
                                                            fontSize:
                                                                size.iScreen(1.6),
                                                            color: Colors.black87,
                                                            fontWeight:
                                                                FontWeight.normal),
                                                      ),
                                                      Text(
                                                          '${implemento['invStock']}',
                                                        style: GoogleFonts.lexendDeca(
                                                            fontSize:
                                                                size.iScreen(1.6),
                                                            color: primaryColor,
                                                                           
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
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
      ),
    );
  }
}
