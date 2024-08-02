import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/controllers/sugerencias_controller.dart';
import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleSugerencia extends StatefulWidget {
  const DetalleSugerencia({Key? key}) : super(key: key);

  @override
  State<DetalleSugerencia> createState() => _DetalleSugerenciaState();
}

class _DetalleSugerenciaState extends State<DetalleSugerencia> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
  final ctrlTheme = context.read<ThemeApp>();
        
    final _controller = context.read<SugerenciasController>();
    //  print('esta es la info: ${_controller.getdataSugerencia}');
    final _sugerencia = _controller.getdataSugerencia;

    return Scaffold(
      backgroundColor: Colors.white,
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
          'Detalle',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        color: Colors.white,
        width: size.wScreen(100.0),
        height: size.hScreen(100.0),
        padding: EdgeInsets.only(
          left: size.iScreen(1.0),
          right: size.iScreen(1.0),
        ),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //*****************************************/
                SizedBox(
                  width: size.wScreen(100.0),
                  // color: Colors.blue,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                          _sugerencia['mejFecReg']
                              // .toLocal()
                              .toString()
                              .substring(0, 16)
                              .replaceAll(".000Z", "")
                              .replaceAll("T", " "),
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      // width: size.wScreen(100.0),
                      child: Text(
                        'Motivo:  ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(1.5),
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      child: Text(
                        _sugerencia['mejMotivo'],
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.7),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/

                Container(
                  margin: EdgeInsets.only(
                      top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                  width: size.wScreen(100.0),
                  child: Text(
                    'Detalle: ',
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.5),
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Container(
                  margin: EdgeInsets.only(
                      top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                  width: size.wScreen(100.0),
                  child: Text(
                    _sugerencia['mejDetalles'].isEmpty
                        ? '- - -  - - -'
                        : _sugerencia['mejDetalles'],
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.5),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/

                // Container(
                //   margin: EdgeInsets.only(
                //       top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                //   width: size.wScreen(100.0),
                //   child: Text(
                //     'Cédula: ',
                //     style: GoogleFonts.lexendDeca(
                //         fontSize: size.iScreen(1.5),
                //         color: Colors.grey,
                //         fontWeight: FontWeight.normal),
                //   ),
                // ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/
                // Container(
                //   margin: EdgeInsets.only(
                //       top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                //   width: size.wScreen(100.0),
                //   child: Text(
                //     _sugerencia['mejDocumentoCliente'].isEmpty
                //         ? '- - -  - - -'
                //         : _sugerencia['mejDocumentoCliente'],
                //     style: GoogleFonts.lexendDeca(
                //         fontSize: size.iScreen(1.5),
                //         color: Colors.black87,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/

                // Container(
                //   margin: EdgeInsets.only(
                //       top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                //   width: size.wScreen(100.0),
                //   child: Text(
                //     'Cliente: ',
                //     style: GoogleFonts.lexendDeca(
                //         fontSize: size.iScreen(1.5),
                //         color: Colors.grey,
                //         fontWeight: FontWeight.normal),
                //   ),
                // ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(0.5),
                // ),
                // //*****************************************/
                // Container(
                //   margin: EdgeInsets.only(
                //       top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                //   width: size.wScreen(100.0),
                //   child: Text(
                //     _sugerencia['mejNombreCliente'].isEmpty
                //         ? '- - -  - - -'
                //         : _sugerencia['mejNombreCliente'],
                //     style: GoogleFonts.lexendDeca(
                //         fontSize: size.iScreen(1.5),
                //         color: Colors.black87,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/

                Container(
                  margin: EdgeInsets.only(
                      top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                  width: size.wScreen(100.0),
                  child: Text(
                    'Asunto: ',
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.5),
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                //***********************************************/
                SizedBox(
                  height: size.iScreen(0.5),
                ),
                //*****************************************/
                Container(
                  margin: EdgeInsets.only(
                      top: size.iScreen(0.1), bottom: size.iScreen(0.0)),
                  width: size.wScreen(100.0),
                  child: Text(
                    _sugerencia['mejAsunto'].isEmpty
                        ? '- - -  - - -'
                        : _sugerencia['mejAsunto'],
                    style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.5),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                              //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  
                  //*****************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Tiempo de Atención',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                //==========================================//
                SizedBox(
                  height: size.iScreen(1.0),
                ),

                //*****************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Desde:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        //*****************************************/

                        SizedBox(
                          height: size.iScreen(1.0),
                        ),

                        //==========================================//
                        Text(
                          _sugerencia['mejFecDesde'].isEmpty
                              ? '- - -  - - -'
                              : _sugerencia['mejFecDesde'].toString(),
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Hasta:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        //*****************************************/

                        SizedBox(
                          height: size.iScreen(1.0),
                        ),

                        //==========================================//
                        Text(
                          _sugerencia['mejFecHasta'].isEmpty
                              ? '- - -  - - -'
                              : _sugerencia['mejFecHasta'].toString(),
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                //*****************************************/

                SizedBox(
                  height: size.iScreen(1.0),
                ),

                //==========================================//

                _sugerencia['mejDocumento'].isEmpty ||
                        _sugerencia['mejDocumento'].isEmpty == null
                    ? Container()
                    : Container(
                        color: Colors.grey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' Ver Documento ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.5),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewsPDFs(
                                            infoPdf:
                                                '${_sugerencia['mejDocumento']}',
                                            labelPdf: 'archivo.pdf')),
                                  );
                                },
                                icon: const Icon(Icons.remove_red_eye_outlined))
                          ],
                        ),
                      ),
                //*****************************************/

                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                _sugerencia['mejFotos'].length > 0
                    ? SizedBox(
                        width: size.wScreen(100.0),
                        // color: Colors.blue,
                        child: Text('Fotos: ${_sugerencia['mejFotos'].length}',
                            style: GoogleFonts.lexendDeca(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      )
                    : Container(),
                //*****************************************/

                SizedBox(
                  height: size.iScreen(1.0),
                ),
                _sugerencia['mejFotos'].length > 0
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                        width: size.wScreen(100.0),
                        child: Wrap(
                            children: (_sugerencia['mejFotos'] as List)
                                .map(
                                  (e) => FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/imgs/loader.gif'),
                                    image: NetworkImage(
                                      '${e['url']}',
                                    ),
                                  ),
                                )
                                .toList()))
                    : Container(),
                //*****************************************/
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           child: Text('Prioridad: ',
                //               style: GoogleFonts.lexendDeca(
                //                   // fontSize: size.iScreen(2.0),
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.grey)),
                //         ),
                //         Container(
                //           padding: EdgeInsets.only(),
                //           child: Text(
                //             '${consignaController!['conPrioridad']}',
                //             style: GoogleFonts.lexendDeca(
                //               fontSize: size.iScreen(1.4),
                //               fontWeight: FontWeight.normal,
                //               // color: Colors.grey
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //           child: Text('Estado: ',
                //               style: GoogleFonts.lexendDeca(
                //                   // fontSize: size.iScreen(2.0),
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.grey)),
                //         ),
                //         Container(
                //           padding: EdgeInsets.only(),
                //           child: Text(
                //             '${consignaController!['conEstado']}',
                //             style: GoogleFonts.lexendDeca(
                //               fontSize: size.iScreen(1.4),
                //               fontWeight: FontWeight.normal,
                //               // color: Colors.grey
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                // Row(
                //   children: [
                //     Container(
                //       child: Text('Cliente: ',
                //           style: GoogleFonts.lexendDeca(
                //               // fontSize: size.iScreen(2.0),
                //               fontWeight: FontWeight.normal,
                //               color: Colors.grey)),
                //     ),
                //     Expanded(
                //       child: Container(
                //         width: size.wScreen(100.0),
                //         // color: Colors.red,
                //         padding: EdgeInsets.only(),
                //         child: Text(
                //           '${consignaController!['conNombreCliente']}',
                //           style: GoogleFonts.lexendDeca(
                //             fontSize: size.iScreen(1.4),
                //             fontWeight: FontWeight.normal,
                //             // color: Colors.grey
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // //***********************************************/
                // SizedBox(
                //   height: size.iScreen(1.0),
                // ),
                // //*****************************************/
                // Column(
                //   children: [
                //     Container(
                //       width: size.wScreen(100.0),
                //       child: Text('Fecha a realizarse: ',
                //           style: GoogleFonts.lexendDeca(
                //               // fontSize: size.iScreen(2.0),
                //               fontWeight: FontWeight.normal,
                //               color: Colors.grey)),
                //     ),
                //     //***********************************************/
                //     SizedBox(
                //       height: size.iScreen(1.0),
                //     ),
                //     //*****************************************/
                //     SizedBox(
                //         width: size.wScreen(100.0),
                //         child: Wrap(
                //           alignment: WrapAlignment.center,
                //           children: _listaDeFechas
                //               .map(
                //                 (e) => Container(
                //                   margin: EdgeInsets.all(size.iScreen(0.6)),
                //                   child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(8.0),
                //                     child: Container(
                //                         alignment: Alignment.center,
                //                         padding:
                //                             EdgeInsets.all(size.iScreen(0.5)),
                //                         decoration: BoxDecoration(
                //                           color: Colors.grey.shade500,
                //                           // color: Color(0xff2BADEC),
                //                         ),
                //                         width: size.iScreen(12.0),
                //                         child: Text(
                //                           e.toString().substring(0, 10),
                //                           style: GoogleFonts.lexendDeca(
                //                             fontSize: size.iScreen(1.8),
                //                             color: Colors.white,
                //                           ),
                //                         )),
                //                   ),
                //                 ),
                //               )
                //               .toList(),
                //         )),
                //   ],
                // ),
                // //==========================================//

                // //==========================================//
                // consignaController!['conAsignacion']!.isNotEmpty
                //     ? _ListaGuardias(size: size, consigna: consignaController)
                //     : Container(),
                // //*****************************************/

                // consignaController!['conFotosCliente']!.isNotEmpty
                //     ? _CamaraOption(
                //         size: size, consignaFotos: consignaController)
                //     : Container(),
// //*****************************************/
              ],
            )),
      ),
    );
  }
}

class _ListaGuardias extends StatelessWidget {
  final dynamic consigna;
  const _ListaGuardias({
    Key? key,
    required this.size,
    required this.consigna,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    List _listaDeGuardias = [];
    for (var item in consigna!['conAsignacion']) {
      _listaDeGuardias.add(item);
    }

    return Column(
      children: [
        Container(
          width: size.wScreen(100.0),
          margin: EdgeInsets.symmetric(
            vertical: size.iScreen(1.0),
            horizontal: size.iScreen(0.0),
          ),
          child: Text('Guardias:  ${_listaDeGuardias.length}',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
        Wrap(
          children: _listaDeGuardias
              .map((e) => Card(
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              e['nombres'],
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.7),
                                  // color: Colors.black54,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _CamaraOption extends StatelessWidget {
  final dynamic consignaFotos;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.consignaFotos,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    List _listaDeFotos = [];
    for (var item in consignaFotos!['conFotosCliente']) {
      _listaDeFotos.add(item['url']);
    }
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.wScreen(100.0),
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografías: ${_listaDeFotos.length}',
                style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.normal, color: Colors.grey)),
          ),
          Wrap(
            children: _listaDeFotos
                .map((e) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.0),
                            horizontal: size.iScreen(0.0),
                          ),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/imgs/loader.gif'),
                            image: NetworkImage(
                              e,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return const FadeInImage(
      placeholder: AssetImage('assets/imgs/loader.gif'),
      image: NetworkImage('url'),
    );
  }

  return Image.file(
    File(picture),
    fit: BoxFit.cover,
  );
}
