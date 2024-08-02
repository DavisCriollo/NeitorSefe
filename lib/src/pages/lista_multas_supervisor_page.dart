import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/models/lista_allNovedades_guardia.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/detalle_multa_guardia.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaMultasSupervisor extends StatefulWidget {
  final Session? user;
  const ListaMultasSupervisor({Key? key, this.user}) : super(key: key);

  @override
  State<ListaMultasSupervisor> createState() => _ListaMultasSupervisorState();
}

class _ListaMultasSupervisorState extends State<ListaMultasSupervisor> {
  final TextEditingController _textSearchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initData();
  }
  @override
  void dispose() {
   _textSearchController.clear();
    super.dispose();
  }

  void initData() async {
    final loadInfo =
        Provider.of<MultasGuardiasContrtoller>(context, listen: false);
    // loadInfo.getTodasLasMultasGuardia('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket?.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'nominanovedad') {
        loadInfo.getTodasLasMultasGuardia('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket?.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'nominanovedad') {
        loadInfo.getTodasLasMultasGuardia('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final multasControler = Provider.of<MultasGuardiasContrtoller>(context);
    final _user = context.read<HomeController>();
      final _ctrlTheme=context.read<ThemeApp>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         
         flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _ctrlTheme.primaryColor,
                  _ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
          title: Consumer<MultasGuardiasContrtoller>(
            builder: (_, providerSearch, __) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                      child: (providerSearch.btnSearch)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal: size.iScreen(0.0)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(1.5)),
                                      color: Colors.white,
                                      height: size.iScreen(4.0),
                                      child: TextField(
                                        controller: _textSearchController,
                                        autofocus: true,
                                        onChanged: (text) {
                                          multasControler.onSearchText(text);
                                          // setState(() {});
                                        },
                                        decoration: const InputDecoration(
                                          // icon: Icon(Icons.search),
                                          border: InputBorder.none,
                                          hintText: 'Buscar...',
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        border:
                                            // Border.all(
                                            //     color: Colors.white)
                                            Border(
                                          left: BorderSide(
                                              width: 0.0, color: Colors.grey),
                                        ),
                                      ),
                                      height: size.iScreen(4.0),
                                      width: size.iScreen(3.0),
                                      child: const Icon(Icons.search,
                                          color: Colors.white),
                                    ),
                                    onTap: () {},
                                  )
                                ],
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: size.wScreen(90.0),
                              child: Text(
                                'Multas',
                                // style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                    ),
                  ),
                  IconButton(
                      splashRadius: 2.0,
                      icon: (!providerSearch.btnSearch)
                          ? Icon(
                              Icons.search,
                              size: size.iScreen(3.5),
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.clear,
                              size: size.iScreen(3.5),
                              color: Colors.white,
                            ),
                      onPressed: () {
                        providerSearch.setBtnSearch(!providerSearch.btnSearch);
                        _textSearchController.text = "";
                        providerSearch.getTodasLasMultasGuardia('', 'false');
                      }),
                ],
              );
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    final _control = context.read<MultasGuardiasContrtoller>();

                    _control.resetValuesMulta();

                    _control.getTodasLasMultasGuardia('', 'false');
                  },
                  icon: Icon(
                    Icons.refresh_outlined,
                    size: size.iScreen(3.0),
                  )),
              //  IconButton(
              //             icon: Icon(Icons.check),
              //             onPressed: () {
              //               final selectedItems = dataProvider.getSelectedItems();
              //               if (selectedItems.isNotEmpty) {
              //                 // Realizar acción con los elementos seleccionados
              //                 print('Elementos seleccionados: $selectedItems');
              //               }
              //             },
              //           ),
            )
          ],
        ),
        body: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.iScreen(1.0),
              ),
              padding: EdgeInsets.only(
                top: size.iScreen(2.0),
                left: size.iScreen(0.0),
                right: size.iScreen(0.0),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: Consumer<MultasGuardiasContrtoller>(
                builder: (_, providers, __) {
                  // if (providers.getErrorMultas == null) {
                  //   return Center(
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           'Cargando Datos...',
                  //           style: GoogleFonts.lexendDeca(
                  //               fontSize: size.iScreen(1.5),
                  //               color: Colors.black87,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         //***********************************************/
                  //         SizedBox(
                  //           height: size.iScreen(1.0),
                  //         ),
                  //         //*****************************************/
                  //         const CircularProgressIndicator(),
                  //       ],
                  //     ),
                  //   );
                  // } else if (providers.getErrorMultas == false) {
                  //   return const NoData(
                  //     label: 'No existen datos para mostar',
                  //   );
                  // } else if (providers.getListaTodasLasMultasGuardias!.isEmpty) {
                  //   return const NoData(
                  //     label: 'No existen datos para mostar',
                  //   );
                  //   // Text("sin datos");
                  // }
                  if (providers.getErrorMultas == null) {
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
                  } else if (providers.getErrorMultas == false) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                  } else if (providers
                      .getListaTodasLasMultasGuardias!.isEmpty) {
                    return const NoData(label:   'No existen datos para mostar');
                    // Center(
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
                  }

                  return
                      //  //***********************************************/
                      Consumer<SocketService>(
                    builder: (_, valueEstadoInter, __) {
                      return valueEstadoInter.serverStatus ==
                              ServerStatus.Online
                          ? RefreshIndicator(
                              onRefresh: () => _onRefresLista(),
                              child: ListView.builder(
                                  itemCount: multasControler
                                      .getListaTodasLasMultasGuardias!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final multas = multasControler
                                        .getListaTodasLasMultasGuardias![index];

                                    String fechaLocal =
                                        DateUtility.fechaLocalConvert(
                                            multas['nomFecReg']!.toString());
                                    //============FECHA UTC=================//

                                    // String inputDateString =multas['nomFecReg']!.toString();
                                    // DateTime inputDateTime = DateTime.parse(inputDateString);
                                    // DateTime utcDateTime = inputDateTime.toUtc();

                                    // String _fechaUTC = DateFormat('yyyy-MM-dd HH:mm:ss').format(utcDateTime);

                                    //======================================//

                                    return Slidable(
                                      startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          //               multas['nomEstado'] == 'EN PROCESO'
                                          //                && multas['nomPorcentaje']=='10'

                                          //                   ? SlidableAction(
                                          //                       backgroundColor: tercearyColor,
                                          //                       foregroundColor: Colors.white,
                                          //                       icon: Icons.add,
                                          //                       label: 'Turno',
                                          //                       onPressed:
                                          //                            multas['nomDetalle'] =='ABANDONO DE PUESTO' ||
                                          //                           multas['nomDetalle'] =='ESTADO ETILICO O ALIENTO A LICOR' ||
                                          //                           multas['nomDetalle'] =='FALTA INJUSTIFICADA'?
                                          //                           (context) async {
                                          //                         // ===================================================//
                                          //                         final _control=context.read<TurnoExtraController>();
                                          //                         final _controlFecha=context.read<AusenciasController>();
                                          //                         _control.resetValuesTurnoExtra();
                                          //                          _control.setIdMulta(multas['nomId'].toString());
                                          //                         // ===================================================//

                                          //                    await  _control.buscaIdPersona(multas['nomIdPer'].toString());
                                          //                    final _fechaDeMulta=multas['nomFecha'].toString().substring(0,10);
                                          //                     print('LA _fechaDeMulta :$_fechaDeMulta');
                                          //                       Map<String,dynamic>_fecha={};
                                          //                       Map<String, dynamic> _itemTurnoPuesto={};
                                          //                     if (_control.getListaIdPersona.isNotEmpty) {
                                          //                         bool _isFecha=false;
                                          //                        String _labelFecha='';
                                          //                        _fecha={};
                                          //                             _itemTurnoPuesto={};
                                          //                       for (var itemTurno in _control.getListaIdPersona['perTurno']) {

                                          //                         // print('LA DATA ITEM :$itemTurno');
                                          //                          for (var item in itemTurno['fechasConsultaDB']) {
                                          //                               //  print(' $_fechaDeMulta ==> DESDE :${item['desde']} - HASTA :${item['hasta']}');
                                          //                                if(item['desde'].toString().substring(0,10)==_fechaDeMulta){
                                          //                                     _labelFecha=item['desde'];
                                          //                                    _isFecha=true;
                                          //                                     print(' $_fechaDeMulta ==> DESDE :${item['desde'].toString().substring(0,10)} - HASTA :${item['hasta'].toString().substring(0,10)}');
                                          //                                       _fecha={};
                                          //                                         _fecha ={
                                          //         "desde": "${item['desde']}",
                                          //         "hasta": "${item['hasta']}",
                                          //         // "id": "${item['id']}",
                                          //         // "isSelect":false
                                          //       };

                                          //  _itemTurnoPuesto={
                                          //         "id": itemTurno['id'].toString(),
                                          //         "idCliente":itemTurno['idClienteIngreso'],
                                          //         "ruccliente":itemTurno['docClienteIngreso'],
                                          //         "razonsocial": itemTurno['clienteIngreso'],
                                          //         "ubicacion": itemTurno['clienteUbicacionIngreso'],
                                          //         "puesto":itemTurno['puestoIngreso']

                                          //       };

                                          //                                   break;
                                          //                                   }
                                          //                               //     else{
                                          //                               //       _isFecha=false;
                                          //                               //         _labelFecha=_fechaDeMulta;
                                          //                               //     //  print('NO EXISTE FECHA: $_labelFecha');

                                          //                               //  }
                                          //                          }

                                          //                     }
                                          //                     if (_isFecha==true) {

                                          //                        print('DATA $_itemTurnoPuesto ');
                                          //                        _controlFecha.setFechaValida(_fecha);
                                          //                                 // ===================================================//

                                          //                       //  _control.resetValuesTurnoExtra();
                                          //                        _control.buscaLstaDataJefeOperaciones('');

                                          //                       _control.setIdCliente(int.parse(_itemTurnoPuesto['idCliente'].toString()));
                                          //                       _control.setCedulaCliente(_itemTurnoPuesto['ruccliente']);
                                          //                       _control.setNombreCliente(_itemTurnoPuesto['razonsocial']);
                                          //                       _control.setLabelINuevoPuesto(_itemTurnoPuesto['puesto']);
                                          //                       _control.setLabelMotivoTurnoExtra(multas['nomDetalle']);
                                          //                       _control.setListTurPuesto(_itemTurnoPuesto);
                                          //                       _control.onNumeroDiasChange('1');

                                          //                         //===================================================//
                                          //                               // NotificatiosnService.showSnackBarDanger('SI EXISTE FECHA $_labelFecha');
                                          //                       // Navigator.pushNamed( context, 'creaTurnoExtra',arguments: 'EXTRA');
                                          //                               // _isFecha==false;
                                          //                        // ===================================================//

                                          //                       _modalCrearTurno(size);

                                          //                         // ===================================================//
                                          //                           } else{

                                          //                               // NotificatiosnService.showSnackBarError('NO PUEDE CREAR TURNO PARA ESTA FECHA $_fechaDeMulta');
                                          //                               NotificatiosnService.showSnackBarError('NO PUEDE CREAR TURNO EL DIA DE HOY');
                                          //                           }

                                          //                     }

                                          //                         //===================================================//
                                          //                       }
                                          //                       :null,
                                          //                     )
                                          //                   : Container(),

                                          multas['nomEstado'] == 'EN PROCESO' &&
                                                  multas['nomUser'] ==
                                                      widget.user!.usuario
                                              ? SlidableAction(
                                                  backgroundColor:
                                                      Colors.purple,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.edit,
                                                  label: 'Editar',
                                                  onPressed: (context) {
                                                    // // ===================================================//
                                                    // multasControler
                                                    //     .resetValuesMulta();
                                                    // multasControler
                                                    //     .getInfomacionMulta(multas);
                                                    // // ===================================================//
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
                                                                        '¿Desea anular Multa?',
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
                                                                          Text(
                                                                        "ANULAR",
                                                                        style: GoogleFonts
                                                                            .lexendDeca(
                                                                          fontSize:
                                                                              size.iScreen(2.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // color: Colors.white,
                                                                        ),
                                                                      ),
                                                                      // trailing: const Icon(Icons.chevron_right_outlined),
                                                                      onTap:
                                                                          () async {
                                                                        // ===================================================//
                                                                        multasControler
                                                                            .resetValuesMulta();
                                                                        multasControler
                                                                            .getInfomacionMulta(multas);
                                                                        // ===================================================//
                                                                        providers
                                                                            .setLabelNombreEstadoMulta('ANULADA');
                                                                        providers
                                                                            .editarMultaGuardia(context);
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

                                                    //===================================================//
                                                  },
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.pushNamed(context, 'detalleMultaGuardia');
                                          final _control = context.read<
                                              MultasGuardiasContrtoller>();
                                          _control.setLabelNombreEstadoMulta(
                                              multas['nomEstado']);
                                          _control.setInfoMultaObtenida(multas);

                                          _control.buscaIdTurnoAsignado(
                                              multas['idTurno']
                                                  .toString()); //idTurno

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      DetalleMultaGuardiaPage(
                                                        infoMultaGuardia:
                                                            multas,
                                                        user: widget.user,
                                                      )))).then((value) {
                                            // final _control = context.read<
                                            //     MultasGuardiasContrtoller>();

                                            multasControler.resetValuesMulta();

                                            multasControler.getTodasLasMultasGuardia( '', 'false');
                                          });
                                        },
                                        child: ClipRRect(
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
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // color: Colors.red,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: size
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                          width: size
                                                              .wScreen(100.0),
                                                          child: Text(
                                                            '${multas['nomNombrePer']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.8),
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Motivo:',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              width:
                                                                  size.wScreen(
                                                                      50.0),
                                                              child: Text(
                                                                '${multas['nomDetalle']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Multa: ',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                '${multas['nomPorcentaje']} %',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Asignado por: ',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                ' ${multas['nomUser'].toString().toUpperCase()}',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                'Fecha de registro: ',
                                                                style: GoogleFonts.lexendDeca(
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
                                                                      .iScreen(
                                                                          0.5),
                                                                  bottom: size
                                                                      .iScreen(
                                                                          0.0)),
                                                              // width: size.wScreen(100.0),
                                                              child: Text(
                                                                //   multas['nomFecReg']!
                                                                //       // .toLocal()
                                                                //       .toString()
                                                                //       .replaceAll(
                                                                //           ".000Z", "")
                                                                //       .replaceAll(
                                                                //           ".000", "")
                                                                //       .replaceAll(
                                                                //           "T", " "),
                                                                // // child: Text(
                                                                // //   _fechaUTC,
                                                                fechaLocal,
                                                                style: GoogleFonts.lexendDeca(
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
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Estado',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.6),
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Text(
                                                        '${multas['nomEstado']}',
                                                        style: GoogleFonts.lexendDeca(
                                                            fontSize: size.iScreen(1.4),
                                                            color: multas['nomEstado'] == 'APELACION'
                                                                ? secondaryColor
                                                                : multas['nomEstado'] == 'EN PROCESO'
                                                                    ? tercearyColor
                                                                    : multas['nomEstado'] == 'ANULADA'
                                                                        ? Colors.red
                                                                        : multas['nomEstado'] == 'ASIGNADA'
                                                                            ? primaryColor
                                                                            : Colors.grey,
                                                            fontWeight: FontWeight.bold,),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                    //   },
                                    // );
                                  }),
                            )
                          : const NoData(label: 'Sin conexión a internet');
                    },
                  );
                  //  //***********************************************/
                },
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                  width: size.wScreen(100.0),
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${widget.user!.rucempresa!}  ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold)),
                      Text('-',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.grey,
                              fontWeight: FontWeight.bold)),
                      Text('  ${widget.user!.usuario!} ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.5),
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            )
          ],
        ),
        floatingActionButton:
            //  //***********************************************/
            Consumer<SocketService>(
          builder: (_, valueEstadoInter, __) {
            return valueEstadoInter.serverStatus == ServerStatus.Online
                ? widget.user!.rol!.contains('SUPERVISOR')
                    ? FloatingActionButton(
                        backgroundColor:  _ctrlTheme.primaryColor,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          multasControler.getTodoosLosTiposDeMultasGuardia();
                          // Navigator.pushNamed(context, 'tipoMultasGuardias');
                          Navigator.pushNamed(
                            context,
                            'multas',
                            arguments: 'NUEVO',
                          ).then((value) => multasControler
                              .getTodasLasMultasGuardia('', 'false'));
                        },
                      )
                    : Container()
                : Container();
          },
        ),
        //  //***********************************************/
      ),
    );
  }

  //======================= ACTUALIZA LA PANTALLA============================//
  Future<void> _onRefresLista() async {
    final _control = context.read<MultasGuardiasContrtoller>();

    _control.resetValuesMulta();

    _control.getTodasLasMultasGuardia('', 'false');
  }
  //===================================================//

//====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalCrearTurno(
    Responsive size,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
                insetPadding: EdgeInsets.symmetric(
                    horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
                content: Consumer<TurnoExtraController>(
                  builder: (_, valueGuardia, __) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text('',
                            //     style: GoogleFonts.lexendDeca(
                            //       fontSize: size.iScreen(2.0),
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.red,
                            //     )),

                            IconButton(
                                splashRadius: size.iScreen(3.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: size.iScreen(3.5),
                                )),
                          ],
                        ),
                        valueGuardia.getListaIdPersona.isEmpty
                            ? Text('Cargando Información ....',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.7),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.white,
                                ))
                            : Column(
                                children: [
                                  Text('Desea crear turno ?',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.7),
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.white,
                                      )),
                                  //*****************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),

                                  //*****************************************/

                                  Container(
                                    margin: EdgeInsets.only(
                                        top: size.iScreen(1.0),
                                        bottom: size.iScreen(2.0)),
                                    height: size.iScreen(3.5),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF0A4280),
                                        ),
                                      ),
                                      onPressed: () async {
                                        // ProgressDialog.show(context);
                                        // await multasControler.actualizaEstadoMulta(
                                        //     context, multa!);

                                        // ProgressDialog.dissmiss(context);
                                        print(
                                            'la data es:${valueGuardia.getListaIdPersona}');
                                        Navigator.pop(context);

                                        Navigator.pushNamed(
                                            context, 'creaTurnoExtra',
                                            arguments: 'CREATE');

// valueGuardia.resetInfoGuardiaturno();
                                      },
                                      child: Text('Si',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    );
                    // :Navigator.pop(context);
                  },
                )),
          );
        });
  }

//====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalEstadoMulta(
      Responsive size,
      MultasGuardiasContrtoller multasControler,
      Result? multa,
      String? estado) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aviso',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  Text('Seguro de cambiar el estado de esta multa ?',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        // color: Colors.white,
                      )),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Ingrese motivo de anulación:',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                  ),
                  TextFormField(
                    maxLines: 2,
                    decoration: const InputDecoration(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(),
                    onChanged: (text) {
                      multasControler.onInputAnulacionDeMultaChange(text);
                    },
                    validator: (text) {
                      if (text!.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Ingrese motivo de desacitvación';
                      }
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(1.0), bottom: size.iScreen(2.0)),
                    height: size.iScreen(3.5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF0A4280),
                        ),
                      ),
                      onPressed: () async {
                        ProgressDialog.show(context);
                        await multasControler.actualizaEstadoMulta(
                            context, multa!);

                        ProgressDialog.dissmiss(context);
                        Navigator.pop(context);
                      },
                      child: Text('Si',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//========ALERTA ESTADO  CAMBIO DE PUESTO========//
  void _showAlertEditarEstadoMulta(
      Responsive size, MultasGuardiasContrtoller controller) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: const Text("Estado del Pedido"),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //==========================================//
                  GestureDetector(
                    child: Container(
                      width: size.wScreen(100.0),
                      padding:
                          EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                      color: Colors.grey.shade400,
                      child: Text(
                        "ANULAR",
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      controller.setLabelNombreEstadoMulta('ANULADO');
                      Navigator.pop(context);
                    },
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  SizedBox(
                    height: size.iScreen(2.0),
                  )
                ],
              ),
            ),
          );
        });
  }
}
