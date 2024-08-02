import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/gestion_documental_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/pages/crea_gestion_documental.dart';
import 'package:nseguridad/src/pages/detalle_gestion_documental.dart';
import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

import '../models/session_response.dart';

class ListaGestioDocumental extends StatefulWidget {
  final Session? user;
  const ListaGestioDocumental({Key? key, required this.user}) : super(key: key);

  @override
  State<ListaGestioDocumental> createState() => _ListaGestioDocumentalState();
}

class _ListaGestioDocumentalState extends State<ListaGestioDocumental>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<HomeController>(context, listen: false);
    loadInfo.buscaGestionDocumental('', 'ENVIADO');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      // print('LA TABLA GESTION  EXITO >>>>>>>> ${data}');

      if (data['tabla'] == 'acta_entrega_recepcion') {
        loadInfo.buscaGestionDocumental('', 'ENVIADO');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      // print('LA TABLA GESTION  ACTUALIZA >>>>>>>> ${data}');
      if (data['tabla'] == 'acta_entrega_recepcion') {
        loadInfo.buscaGestionDocumental('', 'ENVIADO');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      // print('LA TABLA GESTION  ELIMINA >>>>>>>> ${data}');
      if (data['tabla'] == 'acta_entrega_recepcion') {
        loadInfo.buscaGestionDocumental('', 'ENVIADO');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  final _control = HomeController();
  @override
  Widget build(BuildContext context) {
      final ctrlTheme = context.read<ThemeApp>();
        
    final Responsive size = Responsive.of(context);
     final _ctrlTheme=context.read<ThemeApp>();
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        appBar: AppBar(
          // backgroundColor: const Color(0XFF343A40), // primaryColor,
           
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
            'Gestión Documental',
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
            child: Consumer<HomeController>(builder: (_, provider, __) {
              // if (provider.getErrorRolesPago == null) {
              //    return Center(
              //   // child: CircularProgressIndicator(),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         'Cargando Datos...',
              //         style: GoogleFonts.lexendDeca(
              //             fontSize: size.iScreen(1.5),
              //             color: Colors.black87,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       //***********************************************/
              //       SizedBox(
              //         height: size.iScreen(1.0),
              //       ),
              //       //*****************************************/
              //       const CircularProgressIndicator(),
              //     ],
              //   ),
              // );
              // } else if (provider.getErrorRolesPago == false) {
              //   return const NoData(
              //     label: 'No existen datos para mostar',
              //   );
              //   // Text("Error al cargar los datos");
              // } else if (provider.getListaRolesPago.isEmpty) {
              //   return const NoData(
              //     label: 'No existen datos para mostar',
              //   );
              //   // Text("sin datos");
              // }
              return DefaultTabController(
                length: 2, // Número de pestañas
                child: Column(
                  children: [
                    // Pestañas
                    TabBar(
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(text: ' ENVIADOS'),
                        Tab(text: ' RECIBIDOS'),

                        // Container(
                        // width: size.wScreen(100),
                        // color: Colors.red,
                        // child: GestureDetector(
                        //    onTap: () {
                        //   // Manejar el gesto en la pestaña "RECIBIDOS"
                        //  _control.buscaGestionDocumental('', 'ENVIADO');
                        // },
                        //   child: const Tab(text: ' RECIBIDOS')),
                        // ),
                        // Container(
                        // width: size.wScreen(100),
                        // color: Colors.red,
                        // child: GestureDetector(
                        //    onTap: () {
                        //   // Manejar el gesto en la pestaña "RECIBIDOS"
                        //   _control.buscaGestionDocumental('', 'RECIBIDO');
                        // },
                        //   child: const Tab(text: ' RECIBIDOS')),
                        // ),
                      ],
                      onTap: (index) {
                        // print('EL INDICE :$index');
                       
                        provider.selectedTabIndex = index;
                        if (  provider.selectedTabIndex==0) {

                          _control.resetListasGestion();
                          _control.buscaGestionDocumental('', 'ENVIADO');
                        }
                        if ( provider.selectedTabIndex==1) {
                            _control.resetListasGestion();
                          _control.buscaGestionDocumental('', 'RECIBIDO');
                        }
                      },
                    ),
                    // Contenido de las pestañas
                    Expanded(child: Consumer<HomeController>(
                      builder: (_, value, __) {
                        return TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // Contenido de la primera pestaña
                            value.getErrorGestionDocumentalEnviados == false &&
                                    value.getListaGestionDocumentalEnviados
                                        .isEmpty
                                ? Center(
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
                                  )
                                : value.getErrorGestionDocumentalEnviados ==
                                        null
                                    ? Center(
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
                                      )
                                    : value.getErrorGestionDocumentalEnviados ==
                                            false
                                        ? const NoData(
                                            label:
                                                'No existen datos para mostar',
                                          )
                                        : value.getListaGestionDocumentalEnviados
                                                .isEmpty
                                            ? const NoData(
                                                label:
                                                    'No existen datos para mostar',
                                              )
                                            : RefreshIndicator(
                                                onRefresh: onRefresEnviados,
                                                child: ListView.builder(
                                                  itemCount: value
                                                      .getListaGestionDocumentalEnviados
                                                      .length,
                                                  itemBuilder:
                                                      (context, index)
                                                      
                                                      
                                                      
                                                       {
                                                     final _docEnviado =index!=null?provider.getListaGestionDocumentalEnviados[ index]:provider.getListaGestionDocumentalEnviados[0];
                                                    String fechaLocal = DateUtility
                                                        .fechaLocalConvert(
                                                            _docEnviado[
                                                                    'actaFecha']!
                                                                .toString());
                                                    return GestureDetector(
                                                      onTap: () {
                                                      // print('xxxxxxx ${_docEnviado}');
                                                     final _ctrl =context.read<GestionDocumentalController>();
                                                                _ctrl.resetValuesGestionDocumental();
                                                                _ctrl.setInfoActaGestion(_docEnviado);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        const DetalleGestioDocumental(estado: 'Enviada',)))
                                                            // HomePageMultiSelect()
                                                            );
                                                      },
                                                      child: Slidable(
                                                        startActionPane:
                                                            ActionPane(
                                                          motion:
                                                              const ScrollMotion(),
                                                          children: [
                                                            // _usuario!.usuario == ausencia['ausUser']
                                                            //     ?
                                                            SlidableAction(
                                                              backgroundColor:
                                                                  Colors.purple,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              icon: Icons.edit,
                                                              // label: 'Editar',
                                                              onPressed:
                                                                  (context)
                                                                   {
                                                                final _ctrl =
                                                                    context.read<
                                                                        GestionDocumentalController>();
                                                                _ctrl
                                                                    .resetValuesGestionDocumental();


                                                                // _ctrl.setInfoActaGestion(
                                                                //     _docEnviado);
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder: ((context) =>
                                                                //             CreaGestionDocumental(
                                                                //               usuario: widget.user,
                                                                //               action: 'EDIT',
                                                                //             )))
                                                                //     // HomePageMultiSelect()
                                                                //     );



                                                       _ctrl.setEstadoActa( _docEnviado['actaEstado']); 
                                                                 showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),
                                                            child: Container(
                                                              constraints: BoxConstraints(
                                                                  maxHeight: size
                                                                      .wScreen(
                                                                          60.0)),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(size
                                                                        .iScreen(
                                                                            3.0)),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '¿Desea anular Comunicado?',
                                                                        style: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontSize:
                                                                              size.iScreen(2.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // color: Colors.white,
                                                                        )),
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              2.0),
                                                                    ),
                                                                    ListTile(
                                                                      tileColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      leading: const Icon(
                                                                          Icons
                                                                              .do_disturb_alt_outlined,
                                                                          color:
                                                                              Colors.red),
                                                                      title:
                                                                      Consumer<GestionDocumentalController>(builder: (_, value, __) { 
                                                                        return  Text(
                                                                      _docEnviado['actaEstado']=='ACTIVA'? "ANULAR":'ACTIVAR',
                                                                        style: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontSize:
                                                                              size.iScreen(2.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // color: Colors.white,
                                                                        ),
                                                                      );
                                                                       },),
                                                                          
                                                                      // trailing: const Icon(Icons.chevron_right_outlined),
                                                                      onTap:
                                                                          () async {
                                                                              final _ctrl =context.read<GestionDocumentalController>();
                                                                              final _ctrlHome =context.read<HomeController>();
                                                                        // ===================================================//
                                                                    String  _estado='';
                                                                      if (_docEnviado['actaEstado']=='ACTIVA') {
                                                                         _estado="ANULADA";
                                                                        
                                                                      } else if (_docEnviado['actaEstado']=='ANULADA') {
                                                                          _estado="ACTIVA";

                                                                      }

                                                                      
                                                                _ctrl .resetValuesGestionDocumental();
                                                                 
                                                                _ctrl.setEstadoActa( _estado);
                                                                _ctrl.setInfoActaGestion( _docEnviado);
                                                                _ctrl.editaActaDegestion(context);

                                                                       _ctrlHome.buscaGestionDocumental('','ENVIADO');

                                                                        Navigator.pop(
                                                                            context);
                                                                        // _modalTerminosCondiciones(size, homeController);
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                             
                                                             
                                                             
                                                             
                                                              },
                                                            )
                                                            //     : Container(),
                                                          ],
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.5),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Tipo: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // color: Colors.red,
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    width: size
                                                                        .wScreen(
                                                                            60.0),
                                                                    child: Text(
                                                                      // '${informe['infAsunto']}',
                                                                      '${_docEnviado['actaTipo']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),   Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Asunto: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // color: Colors.red,
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    width: size
                                                                        .wScreen(
                                                                            60.0),
                                                                    child: Text(
                                                                      // '${informe['infAsunto']}',
                                                                      '${_docEnviado['actaAsunto']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                                 Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Fecha: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      // rol['infFecReg']
                                                                      //     .toString()
                                                                      //     .replaceAll("T", " ")
                                                                      //     .replaceAll("000Z", " "),
                                                                      fechaLocal.substring(0, 10),
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                  // color:  Colors.yellow,
                                                                 width: size.wScreen(100.0),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      // color:  Colors.red,
                                                                      margin: EdgeInsets.only(
                                                                          top: size.iScreen(
                                                                              0.5),
                                                                          bottom:
                                                                              size.iScreen(0.0)),
                                                                      width: size.wScreen(100.0),
                                                                      child: Text(
                                                                        'Para: ',
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.5),
                                                                            color: Colors
                                                                                .black87,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Wrap(
                                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                                      children:
                                                                      (_docEnviado['actaGuardias'] as List ).map((e) {
                                                                        return 
                                                                        Container(
                                                                        width: size .wScreen( 100.0),
                                                                        decoration:  BoxDecoration(
                                                                        color: Colors.grey.shade200,
                                                                          borderRadius: BorderRadius.circular(3.0)
                                                                        ),
                                                                        margin: EdgeInsets.all(size.iScreen( 0.2)),
                                                                        padding: EdgeInsets.all(size.iScreen( 0.4)),
                                                                        child: Text(
                                                                          // '${informe['infAsunto']}',
                                                                          '${e['perApellidos']} ${e['perNombres']}',
                                                                          // overflow:
                                                                          //     TextOverflow
                                                                          //         .ellipsis,
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(
                                                                                  1.5),
                                                                              color: Colors
                                                                                  .black87,
                                                                              fontWeight:
                                                                                  FontWeight.bold),
                                                                        ),
                                                                      );
                                                                      },).toList(),),
                                                                   
                                                                  ],
                                                                ),
                                                              ),
                                                           
                                                               Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Estado: ',
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
                                              width: size.wScreen(60.0),
                                              child: Text(
                                                '${_docEnviado['actaEstado']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: (_docEnviado[
                                                                'actaEstado'] ==
                                                            'ACTIVA')
                                                        ?  Colors.green
                                                        : (_docEnviado[
                                                                    'actaEstado'] ==
                                                                'ANULADA')
                                                            ? Colors.red
                                                          
                                                                : Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    
                                                  
                                                  },
                                                ),
                                              ),
                            /////////////////////////////////////////// Contenido de la segunda pestaña

                            // value.getErrorGestionDocumentalRecibidos == false &&
                            //         value.getListaGestionDocumentalRecibidos
                            //             .isEmpty
                            //     ? Center(
                            //         // child: CircularProgressIndicator(),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Text(
                            //               'Cargando Datos...',
                            //               style: GoogleFonts.lexendDeca(
                            //                   fontSize: size.iScreen(1.5),
                            //                   color: Colors.black87,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //             //***********************************************/
                            //             SizedBox(
                            //               height: size.iScreen(1.0),
                            //             ),
                            //             //*****************************************/
                            //             const CircularProgressIndicator(),
                            //           ],
                            //         ),
                            //       )
                            //     : value.getErrorGestionDocumentalRecibidos ==
                            //                 false ||
                            //             value.getErrorGestionDocumentalRecibidos ==
                            //                 null
                            //         ? const NoData(
                            //             label: 'No existen datos para mostar',
                            //           )
                            //         : value.getListaGestionDocumentalRecibidos
                            //                 .isEmpty
                            //             ? const NoData(
                            //                 label:
                            //                     'No existen datos para mostar',
                            //               )
                            //             : Refreshr(
                            //                 onRefresh: onRefresRecividos,
                            //                 child: ListView.builder(
                            //                   itemCount: value
                            //                       .getListaGestionDocumentalRecibidos
                            //                       .length,
                            //                   itemBuilder: (context, index) {
                            //                     final _docEnviado = provider
                            //                             .getListaGestionDocumentalRecibidos[
                            //                         index];
                            //                     String fechaLocal = DateUtility
                            //                         .fechaLocalConvert(
                            //                             _docEnviado[
                            //                                     'actaFecha']!
                            //                                 .toString());
                            //                     return Container(
                            //                       margin: EdgeInsets.only(
                            //                           top: size.iScreen(0.5)),
                            //                       padding: EdgeInsets.symmetric(
                            //                           horizontal:
                            //                               size.iScreen(1.5),
                            //                           vertical:
                            //                               size.iScreen(0.5)),
                            //                       decoration: BoxDecoration(
                            //                         color: Colors.white,
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                                 8),
                            //                       ),
                            //                       child: Column(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment.start,
                            //                         children: [
                            //                           Row(
                            //                             children: [
                            //                               Container(
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 // width: size.wScreen(100.0),
                            //                                 child: Text(
                            //                                   'Tipo: ',
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .normal),
                            //                                 ),
                            //                               ),
                            //                               Container(
                            //                                 // color: Colors.red,
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 width: size
                            //                                     .wScreen(60.0),
                            //                                 child: Text(
                            //                                   // '${informe['infAsunto']}',
                            //                                   '${_docEnviado['actaTipo']}',
                            //                                   overflow:
                            //                                       TextOverflow
                            //                                           .ellipsis,
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold),
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                           Row(
                            //                             children: [
                            //                               Container(
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 // width: size.wScreen(100.0),
                            //                                 child: Text(
                            //                                   'Lugar: ',
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .normal),
                            //                                 ),
                            //                               ),
                            //                               Container(
                            //                                 // color: Colors.red,
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 width: size
                            //                                     .wScreen(60.0),
                            //                                 child: Text(
                            //                                   // '${informe['infAsunto']}',
                            //                                   '${_docEnviado['actaAsunto']}',
                            //                                   overflow:
                            //                                       TextOverflow
                            //                                           .ellipsis,
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold),
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                           Row(
                            //                             children: [
                            //                               Container(
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 // width: size.wScreen(100.0),
                            //                                 child: Text(
                            //                                   'Asunto: ',
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .normal),
                            //                                 ),
                            //                               ),
                            //                               Container(
                            //                                 // color: Colors.red,
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 width: size
                            //                                     .wScreen(60.0),
                            //                                 child: Text(
                            //                                   // '${informe['infAsunto']}',
                            //                                   '${_docEnviado['actaLugar']}',
                            //                                   overflow:
                            //                                       TextOverflow
                            //                                           .ellipsis,
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold),
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                            Row(
                            //               children: [
                            //                 Container(
                            //                   margin: EdgeInsets.only(
                            //                       top: size.iScreen(0.5),
                            //                       bottom: size.iScreen(0.0)),
                            //                   // width: size.wScreen(100.0),
                            //                   child: Text(
                            //                     'Estado: ',
                            //                     style: GoogleFonts.lexendDeca(
                            //                         fontSize: size.iScreen(1.5),
                            //                         color: Colors.black87,
                            //                         fontWeight: FontWeight.normal),
                            //                   ),
                            //                 ),
                            //                 Container(
                            //                   margin: EdgeInsets.only(
                            //                       top: size.iScreen(0.5),
                            //                       bottom: size.iScreen(0.0)),
                            //                   width: size.wScreen(60.0),
                            //                   child: Text(
                            //                     '${_docEnviado['actaEstado']}',
                            //                     style: GoogleFonts.lexendDeca(
                            //                         fontSize: size.iScreen(1.5),
                            //                         color: (_docEnviado[
                            //                                     'actaEstado'] ==
                            //                                 'ACTIVA')
                            //                             ? Colors.blue
                            //                             : (_docEnviado[
                            //                                         'actaEstado'] ==
                            //                                     'ANULADA')
                            //                                 ? Colors.orange
                            //                                 : (_docEnviado[
                            //                                             'actaEstado'] ==
                            //                                         'RECIBIDO')
                            //                                     ? Colors.green
                            //                                     : Colors.red,
                            //                         fontWeight: FontWeight.bold),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //                           Row(
                            //                             children: [
                            //                               Container(
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 // width: size.wScreen(100.0),
                            //                                 child: Text(
                            //                                   'Fecha: ',
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .normal),
                            //                                 ),
                            //                               ),
                            //                               Container(
                            //                                 margin: EdgeInsets.only(
                            //                                     top: size
                            //                                         .iScreen(
                            //                                             0.5),
                            //                                     bottom: size
                            //                                         .iScreen(
                            //                                             0.0)),
                            //                                 // width: size.wScreen(100.0),
                            //                                 child: Text(
                            //                                   // rol['infFecReg']
                            //                                   //     .toString()
                            //                                   //     .replaceAll("T", " ")
                            //                                   //     .replaceAll("000Z", " "),
                            //                                   fechaLocal,
                            //                                   style: GoogleFonts.lexendDeca(
                            //                                       fontSize: size
                            //                                           .iScreen(
                            //                                               1.5),
                            //                                       color: Colors
                            //                                           .black87,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold),
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     );
                            //                   },
                            //                 ),
                            //               ),
                              // Contenido de la primera pestaña
                            value.getErrorGestionDocumentalRecibidos == false &&
                                    value.getListaGestionDocumentalRecibidos
                                        .isEmpty
                                ? Center(
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
                                  )
                                : value.getErrorGestionDocumentalRecibidos ==
                                        null
                                    ? Center(
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
                                      )
                                    : value.getErrorGestionDocumentalRecibidos ==
                                            false
                                        ? const NoData(
                                            label:
                                                'No existen datos para mostar',
                                          )
                                        : value.getListaGestionDocumentalRecibidos
                                                .isEmpty
                                            ? const NoData(
                                                label:
                                                    'No existen datos para mostar',
                                              )
                                            : RefreshIndicator(
                                                onRefresh: onRefresRecividos,
                                                child: ListView.builder(
                                                  itemCount: value
                                                      .getListaGestionDocumentalRecibidos
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final _docRecibido = index!=null?provider .getListaGestionDocumentalRecibidos[index]:provider .getListaGestionDocumentalRecibidos[0];
                                                    String fechaLocal = DateUtility
                                                        .fechaLocalConvert(_docRecibido['actaFecha']!=null? _docRecibido['actaFecha']!
                                                                .toString():DateTime.now().toString());
                                                    return GestureDetector(
                                                      onTap: () {
                                                      // print('xxxxxxx ${_docEnviado}');
                                                     final _ctrl =context.read<GestionDocumentalController>();
                                                                _ctrl.resetValuesGestionDocumental();
                                                                _ctrl.setInfoActaGestion(_docRecibido);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        const DetalleGestioDocumental(estado: 'Recibida',)))
                                                            // HomePageMultiSelect()
                                                            );
                                                      },
                                                      child: Slidable(
                                                        startActionPane:
                                                            ActionPane(
                                                          motion:
                                                              const ScrollMotion(),
                                                          children: [
                                                            // _usuario!.usuario == ausencia['ausUser']
                                                            //     ?
                                                            SlidableAction(
                                                              backgroundColor:
                                                                  Colors.purple,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              icon: Icons.edit,
                                                              // label: 'Editar',
                                                              onPressed:
                                                                  (context)
                                                                   {
                                                                final _ctrl =
                                                                    context.read<
                                                                        GestionDocumentalController>();
                                                                // _ctrl
                                                                //     .resetValuesGestionDocumental();


                                                                // _ctrl.setInfoActaGestion(
                                                                //     _docEnviado);
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder: ((context) =>
                                                                //             CreaGestionDocumental(
                                                                //               usuario: widget.user,
                                                                //               action: 'EDIT',
                                                                //             )))
                                                                //     // HomePageMultiSelect()
                                                                //     );



                                                       _ctrl.setEstadoActa( _docRecibido['actaEstado']); 
                                                                 showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),
                                                            child: Container(
                                                              constraints: BoxConstraints(
                                                                  maxHeight: size
                                                                      .wScreen(
                                                                          60.0)),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(size
                                                                        .iScreen(
                                                                            3.0)),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '¿Desea anular Comunicado?',
                                                                        style: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontSize:
                                                                              size.iScreen(2.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // color: Colors.white,
                                                                        )),
                                                                    SizedBox(
                                                                      height: size
                                                                          .iScreen(
                                                                              2.0),
                                                                    ),
                                                                    ListTile(
                                                                      tileColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      leading: const Icon(
                                                                          Icons
                                                                              .do_disturb_alt_outlined,
                                                                          color:
                                                                              Colors.red),
                                                                      title:
                                                                      Consumer<GestionDocumentalController>(builder: (_, value, __) { 
                                                                        return  Text(
                                                                      _docRecibido['actaEstado']=='ACTIVA'? "ANULAR":'ACTIVAR',
                                                                        style: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontSize:
                                                                              size.iScreen(2.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // color: Colors.white,
                                                                        ),
                                                                      );
                                                                       },),
                                                                          
                                                                      // trailing: const Icon(Icons.chevron_right_outlined),
                                                                      onTap:
                                                                          () async {
                                                                              final _ctrl =context.read<GestionDocumentalController>();
                                                                              final _ctrlHome =context.read<HomeController>();
                                                                        // ===================================================//
                                                                    String  _estado='';
                                                                      if (_docRecibido['actaEstado']=='ACTIVA') {
                                                                         _estado="ANULADA";
                                                                        
                                                                      } else if (_docRecibido['actaEstado']=='ANULADA') {
                                                                          _estado="ACTIVA";

                                                                      }

                                                                      
                                                                        // provider.selectedTabIndex = 1;
                                                                _ctrl .resetValuesGestionDocumental();
                                                                 
                                                                _ctrl.setEstadoActa( _estado);
                                                                _ctrl.setInfoActaGestion( _docRecibido);
                                                                _ctrl.editaActaDegestion(context);

                                                                       _ctrlHome.buscaGestionDocumental('','RECIBIDO');
                                                                       _ctrlHome.buscaGestionDocumental('','RECIBIDO');
                                                                      //  _ctrlHome.buscaGestionDocumental('','RECIBIDA');

                                                                        Navigator.pop(context);
                                                                        // _modalTerminosCondiciones(size, homeController);
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                             
                                                             
                                                             
                                                             
                                                              },
                                                            )
                                                            //     : Container(),
                                                          ],
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: size
                                                                      .iScreen(
                                                                          1.5),
                                                                  vertical: size
                                                                      .iScreen(
                                                                          0.5)),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Tipo: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // color: Colors.red,
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    width: size
                                                                        .wScreen(
                                                                            60.0),
                                                                    child: Text(
                                                                      // '${informe['infAsunto']}',
                                                                      '${_docRecibido['actaTipo']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),   Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Asunto: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // color: Colors.red,
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    width: size
                                                                        .wScreen(
                                                                            60.0),
                                                                    child: Text(
                                                                      // '${informe['infAsunto']}',
                                                                      '${_docRecibido['actaAsunto']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                                 Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      'Fecha: ',
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: size.iScreen(
                                                                            0.5),
                                                                        bottom:
                                                                            size.iScreen(0.0)),
                                                                    // width: size.wScreen(100.0),
                                                                    child: Text(
                                                                      // rol['infFecReg']
                                                                      //     .toString()
                                                                      //     .replaceAll("T", " ")
                                                                      //     .replaceAll("000Z", " "),
                                                                      fechaLocal.substring(0, 10),
                                                                      style: GoogleFonts.lexendDeca(
                                                                          fontSize: size.iScreen(
                                                                              1.5),
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                  // color:  Colors.yellow,
                                                                 width: size.wScreen(100.0),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      // color:  Colors.red,
                                                                      margin: EdgeInsets.only(
                                                                          top: size.iScreen(
                                                                              0.5),
                                                                          bottom:
                                                                              size.iScreen(0.0)),
                                                                      width: size.wScreen(100.0),
                                                                      child: Text(
                                                                        'Para: ',
                                                                        style: GoogleFonts.lexendDeca(
                                                                            fontSize: size.iScreen(
                                                                                1.5),
                                                                            color: Colors
                                                                                .black87,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Wrap(
                                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                                      children:
                                                                      (_docRecibido['actaGuardias'] as List ).map((e) {
                                                                        return 
                                                                        Container(
                                                                        width: size .wScreen( 100.0),
                                                                        decoration:  BoxDecoration(
                                                                        color: Colors.grey.shade200,
                                                                          borderRadius: BorderRadius.circular(3.0)
                                                                        ),
                                                                        margin: EdgeInsets.all(size.iScreen( 0.2)),
                                                                        padding: EdgeInsets.all(size.iScreen( 0.4)),
                                                                        child: Text(
                                                                          // '${informe['infAsunto']}',
                                                                          '${e['perApellidos']} ${e['perNombres']}',
                                                                          // overflow:
                                                                          //     TextOverflow
                                                                          //         .ellipsis,
                                                                          style: GoogleFonts.lexendDeca(
                                                                              fontSize: size.iScreen(
                                                                                  1.5),
                                                                              color: Colors
                                                                                  .black87,
                                                                              fontWeight:
                                                                                  FontWeight.bold),
                                                                        ),
                                                                      );
                                                                      },).toList(),),
                                                                   
                                                                  ],
                                                                ),
                                                              ),
                                                           
                                                               Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Estado: ',
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
                                              width: size.wScreen(60.0),
                                              child: Text(
                                                '${_docRecibido['actaEstado']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: (_docRecibido[
                                                                'actaEstado'] ==
                                                            'ACTIVA')
                                                        ?  Colors.green
                                                        : (_docRecibido[
                                                                    'actaEstado'] ==
                                                                'ANULADA')
                                                            ? Colors.red
                                                          
                                                                : Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                          ],
                        );
                      },
                    )),
                  ],
                ),
              );
              //           RefreshIndicator(

              //             onRefresh: onRefresh,
              //             child: ListView.builder(
              //               itemCount: provider.getListaRolesPago.length,
              //               itemBuilder: (BuildContext context, int index) {
              //                 final rol = provider.getListaRolesPago[index];
              //                    String fechaLocal = DateUtility.fechaLocalConvert(  rol['rolpFecVinculacion']!.toString());
              //                 return GestureDetector(
              //                   onTap: () {
              //                   //====================//
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ViewsPDFs(
              //                   infoPdf:
              //                       // 'https://backsigeop.neitor.com/api/reportes/informeindividual?infId=${widget.informe['infId']}&rucempresa=${widget.user!.rucempresa}&usuario=${widget.user!.usuario}',
              //                       'https://backsigeop.neitor.com/api/reportes/rolpagoindividual?rolpId=${rol['rolpId']}&rucempresa=${rol['rolpEmpresa']}',
              //                   labelPdf: 'Rol.pdf')),
              //         );
              // //         // //====================//
              //                   },
              //                   child: Container(
              //                     margin: EdgeInsets.only(top: size.iScreen(0.5)),
              //                     padding: EdgeInsets.symmetric(
              //                         horizontal: size.iScreen(1.5),
              //                         vertical: size.iScreen(0.5)),
              //                     decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.circular(8),
              //                     ),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),
              //                               // width: size.wScreen(100.0),
              //                               child: Text(
              //                                 'Periodo: ',
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.normal),
              //                               ),
              //                             ),
              //                             Container(
              //                               // color: Colors.red,
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),
              //                               width: size.wScreen(60.0),
              //                               child: Text(
              //                                 // '${informe['infAsunto']}',
              //                                 '${rol['rolpPeriodo']}',
              //                                 overflow: TextOverflow.ellipsis,
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         Row(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),
              //                               // width: size.wScreen(50.0),
              //                               child: Text(
              //                                 'Cargo: ',
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.normal),
              //                               ),
              //                             ),
              //                             Container(
              //                               width: size.wScreen(50.0),
              //                               // color: Colors.red,
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),

              //                               child: Text(
              //                                 '${rol['rolpCargo']}',
              //                                 overflow: TextOverflow.ellipsis,
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         Row(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),
              //                               // width: size.wScreen(100.0),
              //                               child: Text(
              //                                 'Fecha Vinculación: ',
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.normal),
              //                               ),
              //                             ),
              //                             Container(
              //                               margin: EdgeInsets.only(
              //                                   top: size.iScreen(0.5),
              //                                   bottom: size.iScreen(0.0)),
              //                               // width: size.wScreen(100.0),
              //                               child: Text(

              //                                 // rol['infFecReg']
              //                                 //     .toString()
              //                                 //     .replaceAll("T", " ")
              //                                 //     .replaceAll("000Z", " "),
              //                                 fechaLocal,
              //                                 style: GoogleFonts.lexendDeca(
              //                                     fontSize: size.iScreen(1.5),
              //                                     color: Colors.black87,
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                             ),
              //                           ],
              //                         ),

              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               },
              //             ),
              //           );
            })),
        floatingActionButton: FloatingActionButton(
          backgroundColor: _ctrlTheme.primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            final _ctrl = context.read<GestionDocumentalController>();
            _ctrl.resetValuesGestionDocumental();
            _ctrl.setLabelTipo('Comunicados');
            _ctrl.setLabelPerfil('ADMINISTRACION');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => CreaGestionDocumental(
                          usuario: widget.user,
                          action: 'CREATE',
                        )))
                // HomePageMultiSelect()
                );
          },
        ),
      ),
    ));
  }

  Future<void> onRefresEnviados() async {
    _control.buscaGestionDocumental('', 'ENVIADO');
  }

  Future<void> onRefresRecividos() async {
    _control.buscaGestionDocumental('', 'RECIBIDO');
  }
}
