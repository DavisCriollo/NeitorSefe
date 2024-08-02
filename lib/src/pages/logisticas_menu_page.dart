import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';

import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/item_menu_novedades.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class LogisticaMenuPage extends StatefulWidget {
  final List<String?>? tipo;
  final Session? user;
  const LogisticaMenuPage({Key? key, this.tipo, this.user}) : super(key: key);

  @override
  State<LogisticaMenuPage> createState() => _LogisticaMenuPageState();
}

class _LogisticaMenuPageState extends State<LogisticaMenuPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
   final _user=context.read<HomeController>();
  final ctrlTheme = context.read<ThemeApp>();
        
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
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
          'Logística',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Stack(
         alignment: Alignment.center,
        children: [
          Container(
            width: size.wScreen(100.0),

            padding: EdgeInsets.only(
              top: size.iScreen(0.0),
              left: size.iScreen(3.0),
              right: size.iScreen(3.0),
            ),
            child:

                //  //***********************************************/
                Consumer<SocketService>(
              builder: (_, valueEstadoInter, __) {
                return valueEstadoInter.serverStatus == ServerStatus.Online
                    ? Center(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: size.iScreen(1.0),
                              runSpacing: size.iScreen(2.0),
                              children: [
                                ItemsMenuNovedades(
                                  onTap: () {
                                       Provider.of<LogisticaController>(context,
                                              listen: false)
                                          .getTodosLosPedidosGuardias('','false');
                                    Navigator.pushNamed(
                                        context, 'listaTodosLosPedidos');
                                  },
                                  label: 'Pedidos',
                                  icon: Icons.format_list_numbered_outlined,
                                  color: Colors.green,
                                ),
                                ItemsMenuNovedades(
                                    onTap: () {
                                      Provider.of<LogisticaController>(context,
                                              listen: false)
                                          .getTodasLasDevoluciones('', 'false');
                                      Navigator.pushNamed(
                                          context, 'listaTodasLasDevoluciones');
                                    },
                                    label: 'Devolución',
                                    icon: Icons.published_with_changes_outlined,
                                    color: Colors.blue),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const NoData(label: 'Sin conexión a internet');
              },
            ),
            //  //***********************************************/
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
               )
        ],
      ),
    );
  }

  //===================================================//

}
