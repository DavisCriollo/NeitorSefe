import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/api/authentication_client.dart';

import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/consigna_leida_guardia_page.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaConsignasGuardiasPage extends StatefulWidget {
  const ListaConsignasGuardiasPage({Key? key}) : super(key: key);

  @override
  State<ListaConsignasGuardiasPage> createState() =>
      _ListaConsignasGuardiasPageState();
}

class _ListaConsignasGuardiasPageState
    extends State<ListaConsignasGuardiasPage> {
       Session? dataUser ;
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<ConsignasController>(context, listen: false);

 dataUser = await Auth.instance.getSession();
//  print('dataUser: ${dataUser!.nombre}');


    // loadInfo.getTodasLasConsignasClientes('','false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'consigna') {
        loadInfo.getTodasLasConsignasClientes('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
     final _user=context.read<HomeController>();
    final consignasControler =
        Provider.of<ConsignasController>(context, listen: false);
          final ctrlTheme = context.read<ThemeApp>();
         
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
          'Mis Consignas',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Stack(
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
            child: Consumer<ConsignasController>(
              builder: (_, providers, __) {
                if (providers.getErrorAllConsignas == null) {
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
                } else if (providers.getErrorAllConsignas == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("Error al cargar los datos");
                } else if (providers.getListaTodasLasConsignasCliente.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("sin datos");
                }

                return ListView.builder(
                  itemCount: providers.getListaTodasLasConsignasCliente.length,
                  itemBuilder: (BuildContext context, int index) {
                    final consigna =
                        providers.getListaTodasLasConsignasCliente[index];
                    final fechaRegistro =
                        DateTime.parse(consigna['conFecReg']).toLocal();
                    return Slidable(
                      key: ValueKey(index),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          // SlidableAction(
                          //   backgroundColor: Colors.purple,
                          //   foregroundColor: Colors.white,
                          //   icon: Icons.edit,
                          //   // label: 'Editar',
                          //   onPressed: (context) {},
                          // ),

                          // SlidableAction(
                          //   onPressed: (context) {},
                          //   backgroundColor: Colors.red.shade700,
                          //   foregroundColor: Colors.white,
                          //   icon: Icons.delete_forever_outlined,
                          //   // label: 'Eliminar',
                          // ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          consignasControler.consignaLeidaGuardia(
                              consigna['conId'], context);
                          consignasControler.getInfoConsigna(consigna);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ConsignaLeidaGuardiaPage(
                                  infoConsignaCliente: consigna,user:dataUser ,)),
                            ),
                          );
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
                                            'Asunto: ',
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
                                            '${consigna['conAsunto']}',
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
                                            // width: size.wScreen(100.0),
                                            child: Text(
                                              '${consigna['conNombreCliente']}',
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
                                          // width: size.wScreen(100.0),
                                          child: Text(
                                            'Prioridad: ',
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
                                            '${consigna['conPrioridad']}',
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
                                            'Fecha Registro: ',
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
                                              '$fechaRegistro'
                                                  .toString()
                                                  .substring(0, 16)
                                                  .replaceAll("T", " ")
                                                  .replaceAll(".000Z", ""),
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Column(
                              //   children: [
                              //     Column(
                              //       children: [
                              //         Text(
                              //           'Estado',
                              //           style: GoogleFonts.lexendDeca(
                              //               fontSize: size.iScreen(1.6),
                              //               color: Colors.black87,
                              //               fontWeight: FontWeight.normal),
                              //         ),
                              //         Text(
                              //           '${consigna['conProgreso']}',
                              //           style: GoogleFonts.lexendDeca(
                              //               fontSize: size.iScreen(1.6),
                              //               color: tercearyColor, //_colorEstado,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       ],
                              //     )
                              //   ],
                              // )
                            ],
                          ),
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
    );
  }
}
