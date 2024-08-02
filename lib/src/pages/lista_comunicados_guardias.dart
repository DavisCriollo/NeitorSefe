import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/pages/comunicado_leido_guardia_page.dart';
import 'package:nseguridad/src/service/notifications_service.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaComunicadosGuardiasPage extends StatefulWidget {
  const ListaComunicadosGuardiasPage({Key? key}) : super(key: key);

  @override
  State<ListaComunicadosGuardiasPage> createState() =>
      _ListaComunicadosGuardiasPageState();
}

class _ListaComunicadosGuardiasPageState
    extends State<ListaComunicadosGuardiasPage> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void initState() {
    // initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<AvisosController>(context, listen: false);
    loadInfo.getTodosLosAvisos('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado' ) {
        loadInfo.getTodosLosAvisos('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado' ) {
        loadInfo.getTodosLosAvisos('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'comunicado' ) {
        loadInfo.getTodosLosAvisos('', 'false');
        // NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final comunicadoControler =
        Provider.of<AvisosController>(context, listen: false);
    final _user = context.read<HomeController>();
      final ctrlTheme = context.read<ThemeApp>();
         
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
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
        title: Consumer<AvisosController>(
          builder: (_, provider, __) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                    child: (provider.btnSearch)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(1.5)),
                                    color: Colors.white,
                                    height: size.iScreen(4.0),
                                    child: TextField(
                                      controller: _textSearchController,
                                      autofocus: true,
                                      onChanged: (text) {
                                        comunicadoControler.onSearchText(text);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Buscar Comunicado',
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        left: BorderSide(
                                            width: 0.0, color: Colors.grey),
                                      ),
                                    ),
                                    height: size.iScreen(4.0),
                                    width: size.iScreen(3.0),
                                    child: const Icon(Icons.search,
                                        color: primaryColor),
                                  ),
                                  onTap: () {
                                    // print('BUSCAR');
                                    // _textSearchController.text = '';
                                  },
                                )
                              ],
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            width: size.wScreen(90.0),
                            child: Text(
                              'Mis Comunicados',
                              // style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                  ),
                ),
                //  //***********************************************/
                Consumer<SocketService>(
                  builder: (_, valueEstadoInter, __) {
                    return valueEstadoInter.serverStatus == ServerStatus.Online
                        ? IconButton(
                            splashRadius: 2.0,
                            icon: (!provider.btnSearch)
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
                              provider.setBtnSearch(!provider.btnSearch);
                              _textSearchController.text = "";
                              provider.getTodosLosAvisos('', 'false');
                            })
                        : Container();
                  },
                ),
                //  //***********************************************/
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
                  final provider = context.read<AvisosController>();

                  provider.getTodosLosAvisos('', 'false');
                },
                icon: Icon(
                  Icons.refresh_outlined,
                  size: size.iScreen(3.0),
                )),
          )
        ],
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
            child: Consumer<AvisosController>(
              builder: (_, provider, __) {
                if (provider.getErrorTodosLosAvisos == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.getListaTodosLosAvisos.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }

                return Consumer<SocketService>(
                  builder: (_, valueEstadoInter, __) {
                    return valueEstadoInter.serverStatus == ServerStatus.Online
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: provider.getListaTodosLosAvisos.length,
                            // itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              final comunicado =
                                  provider.getListaTodosLosAvisos[index];
                              return GestureDetector(
                                onTap: () {
                                  provider.comunicadoLeidoGuardia(
                                      comunicado['aviId'], context);

                                  provider.getInfoComunicado(comunicado);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const ComunicadoLeidoGuardiaPage())));
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: size.iScreen(0.5)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  //  color: Colors.red,
                                                  // width: size.wScreen(16.0),
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(100.0),
                                                  child: Text(
                                                    'Actividad: ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  width: size.wScreen(65.0),
                                                  child: Text(
                                                    '${comunicado['aviAsunto']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
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
                                                  //  color: Colors.red,
                                                  // width: size.wScreen(20.0),
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(100.0),
                                                  child: Text(
                                                    'Remite: ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(70.0),
                                                  child: Text(
                                                    '${comunicado['aviEmpresa']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
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
                                                  //  color: Colors.red,
                                                  // width: size.wScreen(20.0),
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(100.0),
                                                  child: Text(
                                                    'Dirigido a: ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  child: Text(
                                                    '${comunicado['aviOpcion']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
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
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(100.0),
                                                  child: Text(
                                                    'fecha de registro: ',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  margin: EdgeInsets.only(
                                                      top: size.iScreen(0.5),
                                                      bottom:
                                                          size.iScreen(0.0)),
                                                  // width: size.wScreen(70.0),
                                                  child: Text(
                                                    '${comunicado['aviFecReg']}'
                                                        .toString()
                                                        .replaceAll("T", " ")
                                                        .replaceAll(
                                                            ".000Z", " "),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            fontSize: size
                                                                .iScreen(1.5),
                                                            color:
                                                                Colors.black87,
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
                                    ],
                                  ),
                                ),
                              );
                            },
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
                    Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold)),
                    Text('-',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    Text('  ${_user.getUsuarioInfo!.usuario!} ',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  // Future<void> onRefresh() async {
  //   final provider =
  //       Provider.of<AvisosController >(context, listen: false);
  //  provider.getTodosLosAvisos('', 'false');
  // }

}
