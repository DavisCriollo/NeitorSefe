import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/sugerencias_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crear_sugerencia.dart';
import 'package:nseguridad/src/pages/detalle_sugerencia.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaSugerencias extends StatefulWidget {
  final Session? usuario;
  const ListaSugerencias({Key? key, this.usuario}) : super(key: key);

  @override
  State<ListaSugerencias> createState() => _ListaSugerenciasState();
}

class _ListaSugerenciasState extends State<ListaSugerencias> {
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

  void initData() async {
    final loadInfo = Provider.of<SugerenciasController>(context, listen: false);
    loadInfo.getTodasLasSugerencias('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'mejoracontinua') {
        loadInfo.getTodasLasSugerencias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'mejoracontinua') {
        loadInfo.getTodasLasSugerencias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'mejoracontinua') {
        loadInfo.getTodasLasSugerencias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
        final _ctrlTheme=context.read<ThemeApp>();
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
                  _ctrlTheme.primaryColor,
                  _ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
              title: Consumer<SugerenciasController>(
                builder: (_, providerSearch, __) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.iScreen(0.1)),
                          child: (providerSearch.btnSearch)
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
                                              providerSearch.onSearchText(text);
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
                                                  width: 0.0,
                                                  color: Colors.grey),
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
                                    'Sugerencias ',
                                    style:
                                        Theme.of(context).textTheme.headline2,
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
                            providerSearch
                                .setBtnSearch(!providerSearch.btnSearch);
                            _textSearchController.text = "";
                            providerSearch.getTodasLasSugerencias('', 'false');
                          }),
                    ],
                  );
                },
              ),
            ),
            body: SizedBox(
              // color: Colors.red,
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child:
                  Consumer<SugerenciasController>(builder: (_, provider, __) {
                if (provider.getErrorTodasLasSugerencias == null) {
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
                } else if (provider.getErrorTodasLasSugerencias == false) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                } else if (provider.getListaTodasLasSugerencias.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                }
                return ListView.builder(
                  itemCount: provider.getListaTodasLasSugerencias.length,
                  itemBuilder: (BuildContext context, int index) {
                    final sugerencia =
                        provider.getListaTodasLasSugerencias[index];
                    // print('el usuario:${ausencia['ausUser']}');
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          // _usuario!.usuario == ausencia['ausUser']
                          //     ?
                               SlidableAction(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  // label: 'Editar',
                                  onPressed: (context) {
                                    provider.resetValuesSugerencias();
                                     provider.getDataSugerencia(sugerencia);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => CrearSugerencia(
                                                  usuario: widget.usuario,
                                                  action: 'EDIT',
                                                ))));
                                  },
                                )
                              // : Container(),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          provider.getDataSugerencia(sugerencia);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const DetalleSugerencia())));
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Motivo: ',
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
                                                '${sugerencia['mejMotivo']}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
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
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Asunto: ',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: size.iScreen(31.0),
                                                // color: Colors.red,
                                                margin: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.0)),

                                                child: Text(
                                                  ' ${sugerencia['mejAsunto']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize:
                                                          size.iScreen(1.5),
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                'Fecha desde: ',
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
                                                sugerencia['mejFecDesde']
                                                    .toString()
                                                    .replaceAll("T", " "),
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
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
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.0)),
                                              // width: size.wScreen(100.0),
                                              child: Text(
                                                'Fecha hasta: ',
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
                                                sugerencia['mejFecHasta']
                                                    .toString()
                                                    .replaceAll("T", " "),
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.5),
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor:     _ctrlTheme.primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                final _controller = context
                    .read<SugerenciasController>()
                    .resetValuesSugerencias();
                    

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CrearSugerencia(
                              usuario: widget.usuario,
                              action: 'CREATE',
                            ))));
              },
            )),
      ),
    );
  }
}
