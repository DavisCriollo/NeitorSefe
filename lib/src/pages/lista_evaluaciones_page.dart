import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/evaluaciones_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crea_evaluacion.dart';
import 'package:nseguridad/src/pages/detalle_evaluacion.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class EvaluacionPage extends StatefulWidget {
  final Session? usuario;
  const EvaluacionPage({Key? key, this.usuario}) : super(key: key);

  @override
  State<EvaluacionPage> createState() => _EvaluacionPageState();
}

class _EvaluacionPageState extends State<EvaluacionPage> {
  final TextEditingController _textSearchController = TextEditingController();

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

  void initData() async {}

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
            title: Text(
              'Evaluaciones',
              style: GoogleFonts.lexendDeca(
                  fontSize: size.iScreen(2.45),
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
              // ACTIVAR SI SE REQUERE BUSQUEDAS
            // title: Consumer<EvaluacionesController>(
            //   builder: (_, providerSearch, __) {
            //     return Row(
            //       children: [
            //         Expanded(
            //           child: Container(
            //             margin:
            //                 EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
            //             child: (providerSearch.btnSearchEvaluacion)
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
            //                                 providerSearch
            //                                     .onSearchTextEval(text);
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
            //                                     width: 0.0, color: Colors.grey),
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
            //                       'Evaluaciones ',
            //                       style: Theme.of(context).textTheme.headline2,
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
            //             icon: (!providerSearch.btnSearchEvaluacion)
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
            //               providerSearch.setBtnSearchEvaluacion(
            //                   !providerSearch.btnSearchEvaluacion);
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
                child: Consumer<EvaluacionesController>(builder: (_, provider, __) {
                  if (provider.getErrorEvaluaciones == null) {
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
                  } else if (provider.getErrorEvaluaciones == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("Error al cargar los datos");
                  } else if (provider.getListaEvaluaciones.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }
                  return ListView.builder(
                    itemCount: provider.getListaEvaluaciones.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _evaluacion = provider.getListaEvaluaciones[index];
                      // print('el usuario:${ausencia['ausUser']}');
                      return Slidable(
                        startActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),

                          children: [
                            _evaluacion['docEstado'] == 'PROCESADO'
                                ? SlidableAction(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                    // icon: Icons.edit,
                                    label: 'Ver',
                                    onPressed: (context) {
                                      provider.resetValuesEvaluaciones();
                                      provider.getDataEvaluacion(_evaluacion);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const DetalleEvaluacion())));
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: _evaluacion['docEstado'] == 'PROCESADO' || _evaluacion['docEstado'] == 'FINALIZADA'
                              ? null
                              : () {
                                  provider.resetValuesEvaluaciones();
                                  provider.getDataEvaluacion(_evaluacion);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => CreaEvaluacion(
                                                    usuario: widget.usuario,
                                                    action: 'CREATE',
                                                    menu:'SI'
                                                  )
                                              // HomePageMultiSelect()
                                              )));

                                 
                                 
                                },
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(8),
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
                                                  '${_evaluacion['docTitulo']}',
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
                                                  _evaluacion['docFechaEmision']
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
                                                  _evaluacion[
                                                          'docFechaFinalizacion']
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
                                                  ' ${_evaluacion['docObligatorio']}',
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
                                          '${_evaluacion['docEstado']}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              color: _evaluacion['docEstado'] ==
                                                      'PROCESADO'
                                                  ? secondaryColor
                                                  : _evaluacion['docEstado'] ==
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
