import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/models/lista_allComunicados_clientes.dart';
import 'package:nseguridad/src/pages/comunicado_leido_cliente_page.dart';
import 'package:nseguridad/src/pages/creaEdita_comunicado_cliente_page.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/error_data.dart';
import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListaComunicadosClientesPage extends StatefulWidget {
  const ListaComunicadosClientesPage({Key? key}) : super(key: key);

  @override
  State<ListaComunicadosClientesPage> createState() =>
      _ListaComunicadosClientesPageState();
}

class _ListaComunicadosClientesPageState
    extends State<ListaComunicadosClientesPage> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final comunicadoControler = Provider.of<AvisosController>(context);
    final _user = context.read<HomeController>();
        final _ctrlTheme=context.read<ThemeApp>();

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
                  _ctrlTheme.primaryColor,
                  _ctrlTheme.secondaryColor,
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
                      margin:
                          EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
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
                                          comunicadoControler
                                              .onSearchText(text);
                                          // setState(() {});
                                        },
                                        decoration: const InputDecoration(
                                          // icon: Icon(Icons.search),
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
                                          color: primaryColor),
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
                                'Mis Comunicados',
                                // style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                    ),
                  ),
                  IconButton(
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
                        provider.getTodosLosComunicadosClientes('');
                      }),
                ],
              );
            },
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
              // color: Colors.red,
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),

              child: Consumer<AvisosController>(
                builder: (_, provider, __) {
                  if (provider.getError == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.getError == false) {
                    return const ErrorData();
                    // Text("Error al cargar los datos");
                  } else if (provider
                      .getListaTodosLosComunicadosCliente.isEmpty) {
                    return const NoData(
                      label: 'No existen datos para mostar',
                    );
                    // Text("sin datos");
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        provider.getListaTodosLosComunicadosCliente.length,
                    // itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      final comunicado =
                          provider.getListaTodosLosComunicadosCliente[index];
                      return Slidable(
                        key: ValueKey(index),
                        // The start action pane is the one at the left or the top side.
                        startActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),

                          children: [
                            SlidableAction(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              // label: 'Editar',
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            CreaEditaComunicadoClientePage(
                                              infoComunicadoCliente: comunicado,
                                              accion: 'Editar',
                                            ))));
                              },
                            ),
                            SlidableAction(
                              onPressed: (context) async {
                                ProgressDialog.show(context);
                                await comunicadoControler
                                    .eliminaComunicadoCliente(
                                        context, comunicado);
                                ProgressDialog.dissmiss(context);
                              },
                              backgroundColor: Colors.red.shade700,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_forever_outlined,
                              // label: 'Eliminar',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        ComunicadoLeidoClientePage(
                                            infoComunicadoCliente:
                                                comunicado))));
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
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.0)),
                                        width: size.wScreen(100.0),
                                        child: Text(
                                          '${comunicado.comAsunto}',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.6),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.0)),
                                        width: size.wScreen(100.0),
                                        child: Text(
                                          '${comunicado.comDetalle}',
                                          overflow: TextOverflow.ellipsis,
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
                                        width: size.wScreen(100.0),
                                        child: Text(
                                          comunicado.comFecReg
                                              .toString()
                                              .replaceAll(".000Z", ""),
                                          // '${comunicado.comFecReg.replaceAll("T", "-").replaceAll(".000Z", "")}',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.5),
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                        ),
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
                                    CupertinoSwitch(
                                      // key: Key('$index'),
                                      value: (comunicado.comEstado == 'ACTIVA')
                                          ? true
                                          : false,

                                      onChanged: (value) {
                                        comunicadoControler
                                            .cambiaEstadoComunicadoCliente(
                                                context, comunicado);
                                        // _modalEstadoComunicado(
                                        //     size,
                                        //     comunicadoControler,
                                        //     comunicado,
                                        //     (comunicado.comEstado == 'ACTIVA')
                                        //         ? 'INACTIVA'
                                        //         : 'ACTIVA');
                                      },
                                    ),
                                    // Switch(
                                    //   value: true,
                                    //   onChanged: (val) {},
                                    // ),
                                  ],
                                )
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
        floatingActionButton: FloatingActionButton(
          backgroundColor:     _ctrlTheme.primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const CreaEditaComunicadoClientePage(
                          accion: 'Nuevo',
                        ))));
          },
        ));
  }

//====== MUESTRA MODAL ESTADO =======//
  void _modalEstadoComunicado(
      Responsive size,
      AvisosController comunicadoControler,
      Result? comunicado,
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
                      Text('Aviso $estado ${comunicado!.comId}',
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
                  Text('Seguro de cambiar el estado de la comunicación?',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.normal,
                        // color: Colors.white,
                      )),
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
}
