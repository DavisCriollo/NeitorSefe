import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';

class ListaTodasLasDevoluciones extends StatefulWidget {
  const ListaTodasLasDevoluciones({Key? key}) : super(key: key);

  @override
  State<ListaTodasLasDevoluciones> createState() =>
      _ListaTodasLasDevolucionesState();
}

class _ListaTodasLasDevolucionesState extends State<ListaTodasLasDevoluciones> {
  final _logisticaController = LogisticaController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {}

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
      final _user=context.read<HomeController>();
          final _ctrlTheme=context.read<ThemeApp>();
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
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
              title: Text(
                'Devoluciones',
                // style: Theme.of(context).textTheme.headline2,
              ),
              actions: const [],
            ),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.iScreen(1.0),
                  ),
                  width: size.wScreen(100.0),
                  height: size.hScreen(100.0),
                  child: Consumer<LogisticaController>(
                    builder: (_, valuesDevoluciones, __) {
                      if (valuesDevoluciones.getErrorAllDevoluciones == null) {
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
                      } else if (valuesDevoluciones.getErrorAllDevoluciones ==
                          false) {
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
                      } else if (valuesDevoluciones
                          .getListaTodaLasDevoluciones.isEmpty) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                      }

                      return ListView.builder(
                        itemCount:
                            valuesDevoluciones.getListaTodaLasDevoluciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          final devolucion =
                              valuesDevoluciones.getListaTodaLasDevoluciones[index];

                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                (devolucion['disEstado'] == 'PENDIENTE')
                                    ? SlidableAction(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        // label: 'Editar',
                                        onPressed: (context) {
                                          valuesDevoluciones.resetValuesPedidos();
                                          valuesDevoluciones
                                              .getInfoDevolucionPedido(devolucion);
                                          _showAlertDialog(
                                              size, valuesDevoluciones);
                                        })
                                    : Container(),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: size.iScreen(0.5),
                                bottom: size.iScreen(0.0),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0),
                                  vertical: size.iScreen(0.5)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const <BoxShadow>[],
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
                                              child: Text(
                                                'Cliente: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                child: Text(
                                                  '${devolucion['disNombreCliente']}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold),
                                                ),
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
                                              child: Text(
                                                'Fecha devolución : ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  // '2022-08-02',
                                                  devolucion['disFecReg']
                                                      .toString()
                                                      .replaceAll("T", "  ")
                                                      .replaceAll("000Z", " "),
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
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
                                                'Productos : ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),
                                                // width: size.wScreen(100.0),
                                                child: Text(
                                                  // '7',
                                                  '${devolucion['disPedidos'].length}',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
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
                                                '${devolucion['disEstado']}',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: (devolucion[
                                                                'disEstado'] ==
                                                            'ENVIADO')
                                                        ? Colors.blue
                                                        : (devolucion[
                                                                    'disEstado'] ==
                                                                'PENDIENTE')
                                                            ? Colors.orange
                                                            : (devolucion[
                                                                        'disEstado'] ==
                                                                    'RECIBIDO')
                                                                ? Colors.green
                                                                : Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
            floatingActionButton: FloatingActionButton(
              backgroundColor:  _ctrlTheme.primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                final controller =
                    Provider.of<LogisticaController>(context, listen: false);
                controller.resetValuesPedidos();
                controller.getTodosLosPedidosActivos('');
                Navigator.pushNamed(context, 'listaDePedidos');
              },
            )),
      ),
    );
  }

//========ALERTA ESTADO  CAMBIO DE PUESTO========//
  void _showAlertDialog(Responsive size, LogisticaController controller) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return CupertinoAlertDialog(
            title: const Text("Estado de la Devolución"),
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
                      controller
                          .setLabelNombreEstadoDevolucionPedido('ANULADO');
                      await controller.editarDevolucionPedido(context);
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
