import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/pages/crear_informe_guardias.dart';
import 'package:nseguridad/src/pages/detalle_informe_guardia.dart';
import 'package:nseguridad/src/pages/edita_informe_guardia.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaInformesGuardiasPage extends StatefulWidget {
  final Session? usuario;
  const ListaInformesGuardiasPage({Key? key, this.usuario}) : super(key: key);

  @override
  State<ListaInformesGuardiasPage> createState() =>
      _ListaInformesGuardiasPageState();
}

class _ListaInformesGuardiasPageState extends State<ListaInformesGuardiasPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = Provider.of<InformeController>(context, listen: false);
    loadInfo.buscaInformeGuardias('', 'false');

    final serviceSocket = Provider.of<SocketService>(context, listen: false);
    serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
      if (data['tabla'] == 'informe') {
        loadInfo.buscaInformeGuardias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
      if (data['tabla'] == 'informe') {
        loadInfo.buscaInformeGuardias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
    serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
      if (data['tabla'] == 'informe') {
        loadInfo.buscaInformeGuardias('', 'false');
        NotificatiosnService.showSnackBarSuccsses(data['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _user=context.read<HomeController>();
       final _ctrlTheme=context.read<ThemeApp>();
    final informeController =  Provider.of<InformeController>(context, listen: false);

      final ctrlTheme = context.read<ThemeApp>();
        
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
              title: Text(
                'Mis Informes',
                // style: Theme.of(context).textTheme.headline2,
              ),
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
                    child: Consumer<InformeController>(builder: (_, provider, __) {
                      if (provider.getErrorInformesGuardia == null) {
                        return const NoData(
                          label: 'Cargando datos...',
                        );
                      } else if (provider.getErrorInformesGuardia == false) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("Error al cargar los datos");
                      } else if (provider.getListaInformesInforme.isEmpty) {
                        return const NoData(
                          label: 'No existen datos para mostar',
                        );
                        // Text("sin datos");
                      }
                      return RefreshIndicator(
                        
                        onRefresh: onRefresh,
                        child: ListView.builder(
                          itemCount: provider.getListaInformesInforme.length,
                          itemBuilder: (BuildContext context, int index) {
                            final informe = provider.getListaInformesInforme[index];
                               String fechaLocal = DateUtility.fechaLocalConvert(   informe['infFecReg']!.toString());
                            return Slidable(
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),
                      
                                children: [
                                  widget.usuario!.usuario == informe['infUser']
                                      ? SlidableAction(
                                          backgroundColor: Colors.purple,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          // label: 'Editar',
                                          onPressed: (context) {
                                            // loadData;
                                            provider.resetValuesInformes();
                                            // provider.getDataInformeGuardia(informe);
                                            provider.getDataInformes(informe);
                                            provider.setUsuario(widget.usuario);
                      
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        EditaInformeGuardiaPage(
                                                            usuario: widget.usuario!,
                                                            informe: provider
                                                                    .getListaInformesInforme[
                                                                index]['infGuardias'],
                                                            fecha: informe[
                                                                'infFechaSuceso']))));
                                          },
                                        )
                                      : SizedBox(),
                                  SlidableAction(
                                    onPressed: (context) async {
                                      await provider.eliminaInformeGuardia(
                                          context, informe['infId']);
                                    },
                                    backgroundColor: Colors.red.shade700,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_forever_outlined,
                                    // label: 'Eliminar',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              DetalleInformeGuardiaPage(
                                                // informe: informe,
                                                user: widget.usuario!,
                                                informe: provider
                                                    .getListaInformesInforme[index],
                                              ))));
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
                                            // color: Colors.red,
                                            margin: EdgeInsets.only(
                                                top: size.iScreen(0.5),
                                                bottom: size.iScreen(0.0)),
                                            width: size.wScreen(60.0),
                                            child: Text(
                                              // '${informe['infAsunto']}',
                                              '${informe['infAsunto']}',
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
                                            // width: size.wScreen(50.0),
                                            child: Text(
                                              'Dirigido a: ',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(50.0),
                                            // color: Colors.red,
                                            margin: EdgeInsets.only(
                                                top: size.iScreen(0.5),
                                                bottom: size.iScreen(0.0)),
                      
                                            child: Text(
                                              '${informe['infNomDirigido']}',
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
                                              'Fecha: ',
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
                                           
                                              // informe['infFecReg']
                                              //     .toString()
                                              //     .replaceAll("T", " ")
                                              //     .replaceAll("000Z", " "),
                                              fechaLocal,
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.normal),
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
                                            // width: size.wScreen(50.0),
                                            child: Text(
                                              'Elaborado por: ',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.5),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                          Container(
                                            width: size.wScreen(60.0),
                                            // color: Colors.red,
                                            margin: EdgeInsets.only(
                                                top: size.iScreen(0.5),
                                                bottom: size.iScreen(0.0)),
                      
                                            child: Text(
                                              '${informe['infGenerado']}',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.2),
                                                  color: Colors.black87,
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
                      );
                    })),
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
              backgroundColor: _ctrlTheme.primaryColor,
              // backgroundColor: primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                informeController.resetValuesInformes();


                  final _user=context.read<HomeController>();
                   


                // informeController.setUsuario(widget.usuario!);
                informeController.setUsuario(_user.getUsuarioInfo);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CrearInformeGuardiaPage(
                            // usuario: widget.usuario!
                            ))));
              },
            )),
      ),
    );
  }


  Future<void> onRefresh() async {
    final _control =
        Provider.of<InformeController>(context, listen: false);
    _control.buscaInformeGuardias('','false');
  }


}
