import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crea_encuesta.dart';

import 'package:nseguridad/src/pages/detalle_encuesta.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class EncuastasPage extends StatefulWidget {
  final Session? usuario;
  const EncuastasPage({Key? key, this.usuario}) : super(key: key);

  @override
  State<EncuastasPage> createState() => _EncuastasPageState();
}

class _EncuastasPageState extends State<EncuastasPage> {
  final TextEditingController _textSearchController = TextEditingController();

  // Session? usuario;
  @override
  void dispose() {
    _textSearchController.clear();
    super.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
  
    
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
     final _user=context.read<HomeController>();
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
            title: Container(
              alignment: Alignment.center,
              //                     width: size.wScreen(90.0),
              child: Text(
                'Encuestas',
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(2.45),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
              // ACTIVAR SI REQUIEREN BUSQUEDA
            // title: Consumer<EncuestasController>(
            //   builder: (_, providerSearch, __) {
            //     return Row(
            //       children: [
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.symmetric(
            //                 horizontal: size.iScreen(0.1)),
            //             child: (providerSearch.btnSearchEncuastas)
            //                 ? ClipRRect(
            //                     borderRadius: BorderRadius.circular(5.0),
            //                     child: Row(
            //                       children: [
            //                         Expanded(
            //                           child: Container(
            //                             // margin: EdgeInsets.symmetric(
            //                             //     horizontal: size.iScreen(0.0)),
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal: size.iScreen(1.5)),
            //                             color: Colors.white,
            //                             height: size.iScreen(4.0),
            //                             child: TextField(
            //                               controller: _textSearchController,
            //                               autofocus: true,
            //                               onChanged: (text) {
            //                                 providerSearch.onSearchTextEncuesta(text);
            //                                 // setState(() {});
            //                               },
            //                               decoration: const InputDecoration(
            //                                 // icon: Icon(Icons.search),
            //                                 border: InputBorder.none,
            //                                 hintText: 'Buscar...',
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         GestureDetector(
            //                           child: Container(
            //                             decoration: const BoxDecoration(
            //                               color: Colors.grey,
            //                               border:
            //                                   // Border.all(
            //                                   //     color: Colors.white)
            //                                   Border(
            //                                 left: BorderSide(
            //                                     width: 0.0,
            //                                     color: Colors.grey),
            //                               ),
            //                             ),
            //                             height: size.iScreen(4.0),
            //                             width: size.iScreen(3.0),
            //                             child: const Icon(Icons.search,
            //                                 color: Colors.white),
            //                           ),
            //                           onTap: () {
            //                             // print('BUSCAR');
            //                             // _textSearchController.text = '';
            //                           },
            //                         )
            //                       ],
            //                     ),
            //                   )
            //                 : Container(
            //                     alignment: Alignment.center,
            //                     width: size.wScreen(90.0),
            //                     child: Text(
            //                       'Encuestas ',
            //                       style:
            //                           Theme.of(context).textTheme.headline2,
            //                       // style: GoogleFonts.lexendDeca(
            //                       //     fontSize: size.iScreen(2.45),
            //                       //     color: Colors.white,
            //                       //     fontWeight: FontWeight.normal),
            //                     ),
            //                   ),
            //           ),
            //         ),
            //         IconButton(
            //             splashRadius: 2.0,
            //             icon: (!providerSearch.btnSearchEncuastas)
            //                 ? Icon(
            //                     Icons.search,
            //                     size: size.iScreen(3.5),
            //                     color: Colors.white,
            //                   )
            //                 : Icon(
            //                     Icons.clear,
            //                     size: size.iScreen(3.5),
            //                     color: Colors.white,
            //                   ),
            //             onPressed: () {
            //               providerSearch
            //                   .setBtnSearchEncuastas(!providerSearch.btnSearchEncuastas);
            //               _textSearchController.text = "";
            //               // providerSearch.buscaAusencias('', 'false');
            //             }),
            //       ],
            //     );
            //   },
            // ),
          ),
          body: Stack(
            children: [
              Container(
               margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                  padding: EdgeInsets.only(
                        top: size.iScreen(2.0),
                        left: size.iScreen(0.0),
                        right: size.iScreen(0.0),
                      ),
                width: size.wScreen(100.0),
                height: size.hScreen(100.0),
                child: Consumer<EncuestasController>(builder: (_, provider, __) {
                  if (provider.getErrorEncuestas == null) {
                    return Center(
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
                  } else if (provider.getErrorEncuestas == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("Error al cargar los datos");
                  } else if (provider.getListaEncuastas.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }
                  return ListView.builder(
                    itemCount: provider.getListaEncuastas.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _encuasta = provider.getListaEncuastas[index];
                      // print('el usuario:${ausencia['ausUser']}');
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            _encuasta['docEstado'] == 'PROCESADO'
                                ? SlidableAction(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    // icon: Icons.edit,
                                    label: 'Ver',
                                    onPressed: (context) {
                                      provider.resetValuesEncuestas();
                                      provider.getDataEncuesta(_encuasta);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                      const DetalleEncuesta()
                                                  // HomePageMultiSelect()
                                                  )));
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: _encuasta['docEstado'] == 'PROCESADO'
                              ? null
                              : () {
                                  provider.resetValuesEncuestas();
                                  provider.getDataEncuesta(_encuasta);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => CreaEncuesta(
                                                    usuario: widget.usuario,
                                                    action: 'CREATE',
                                                      menu:'SI'
                                                  )
                                             
                                              )));
                                },
                          child: ClipRRect(
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.only(top: size.iScreen(0.5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.iScreen(1.0),
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
                                                  'Título: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.red,
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                width: size.wScreen(55.0),
                                                child: Text(
                                                  '${_encuasta['docTitulo']}',
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
                                                  'Fecha Emisión: ',
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
                                                  _encuasta['docFechaEmision']
                                                      .toString()
                                                      .replaceAll("T", " "),
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
                                                  'Fecha Finalización: ',
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
                                                  _encuasta['docFechaFinalizacion']
                                                      .toString()
                                                      .replaceAll("T", " "),
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
                                                // width: size.iScreen(10.0),
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  'Obligatorio: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Container(
                                                width: size.iScreen(10.0),
                                                // color: Colors.red,
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),

                                                child: Text(
                                                  ' ${_encuasta['docObligatorio']}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.6),
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
                                      children: [
                                        Text(
                                          'Estado',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          '${_encuasta['docEstado']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              color:
                                                  // tercearyColor, //_colorEstado,

                                                  _encuasta['docEstado'] ==
                                                          'PROCESADO'
                                                      ? secondaryColor
                                                      : _encuasta['docEstado'] ==
                                                              'ACTIVA'
                                                          ? tercearyColor
                                                          : Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
               Positioned(
                  top: 0,
                  child:   Container(
                                              width: size.wScreen(100.0),
                                              margin: const EdgeInsets.all(0.0),
                                              padding: const EdgeInsets.all(0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      '${_user.getUsuarioInfo!.rucempresa!}  ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color:
                                                              Colors.grey.shade600,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('-',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                             size.iScreen(1.5),
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      '  ${_user.getUsuarioInfo!.usuario!} ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.5),
                                                          color:
                                                              Colors.grey.shade600,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )),
               ),

            ],
          ),
        ),
      ),
    );
  }
}
