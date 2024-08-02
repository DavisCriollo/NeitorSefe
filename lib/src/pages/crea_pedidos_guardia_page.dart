import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/dataTable/pedidos_municiones_datasource.dart';
import 'package:nseguridad/src/dataTable/pedidos_supervisor_datasource.dart';
// import 'package:nseguridad/src/dataTable/pedidos_municiones_datasource.dart';
// import 'package:nseguridad/src/dataTable/pedidos_supervisor_datasource.dart';
import 'package:nseguridad/src/pages/busca_persona_pedido.dart';
import 'package:nseguridad/src/pages/lista_item_pedidos.dart';

import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

import 'package:nseguridad/src/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  TextEditingController textImplemento = TextEditingController();
  int _radioSelected = 1;
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);

    final _user = context.read<HomeController>();
      final ctrlTheme = context.read<ThemeApp>();
        

    final logisticaController =
        Provider.of<LogisticaController>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: const Color(0xFFEEEEEE),
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
              'Crear Pedido',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              Consumer<LogisticaController>(
                builder: (_, btnSave, __) {
                  return btnSave.getNombreCliente!.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(right: size.iScreen(1.5)),
                          child: IconButton(
                              splashRadius: 28,
                              onPressed: () {
                                _onSubmit(context, logisticaController);
                              },
                              icon: Icon(
                                Icons.save_outlined,
                                size: size.iScreen(4.0),
                              )),
                        )
                      : Container();
                },
              ),
              const SizedBox(),
            ],
          ),
          body: DefaultTabController(
            length: 2,
            child: Container(
              // color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
              padding: EdgeInsets.only(
                top: size.iScreen(0.5),
                left: size.iScreen(0.5),
                right: size.iScreen(0.5),
                bottom: size.iScreen(0.5),
              ),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
              child: SingleChildScrollView(
                child: Form(
                  key: logisticaController.pedidoGuardiaFormKey,
                  child: Column(
                    children: [
                      Container(
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
                     
                            //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/

                      SizedBox(
                        width: size.wScreen(100.0),
                        child: Text('Entrega :',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      // ===========RADIO ENTREGA ==============
                      Container(
                        // color: Colors.red,
                        margin:
                            EdgeInsets.symmetric(horizontal: size.iScreen(0.1)),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.iScreen(1.5),
                            vertical: size.iScreen(0.0)),
                        width: size.wScreen(100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('DOTACIÓN'),
                            Radio(
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = 1;
                                  logisticaController.setLabelEntrega(value);
                                  // print(val);
                                });
                              },
                              activeColor: primaryColor,
                              toggleable: true,
                            ),
                            const Text('DESCUENTO'),
                            Radio(
                              value: 2,
                              // groupValue: logisticaController.labelValorEntrega,
                              groupValue: logisticaController.labelValorEntrega,
                              onChanged: (value) {
                                setState(() {
                                  val = 2;
                                  logisticaController.setLabelEntrega(value);
                                  logisticaController.resetTipoDescuento();

                                   NotificatiosnService.showSnackBarDanger(
            'Solo puede seleccionar una Persona');
                                  // print(val);
                                });
                              },
                              activeColor: primaryColor,
                              toggleable: true,
                            ),
                          ],
                        ),
                      ),

                      //==========================================//
                      SizedBox(
                        width: size.wScreen(100.0),
                        child: Text('Cliente :',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                top: size.iScreen(1.0),
                                right: size.iScreen(0.5),
                              ),
                              child: Consumer<LogisticaController>(
                                builder: (_, persona, __) {
                                  return (persona.getNombreCliente == '' ||
                                          persona.getNombreCliente == null)
                                      ? Text(
                                          'No hay cliente designada',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      : Text(
                                          // '${persona.getNombreCliente} ',
                                          '${persona.getInfoClientePedido['cliRazonSocial']} ',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                            // color: Colors.grey
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                _modalSeleccionaPersona(
                                    size, logisticaController, 'CLIENTE');
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: primaryColor,
                                width: size.iScreen(3.5),
                                padding: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.5),
                                  left: size.iScreen(0.5),
                                  right: size.iScreen(0.5),
                                ),
                                child: Icon(
                                  Icons.search_outlined,
                                  color: Colors.white,
                                  size: size.iScreen(2.8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      logisticaController.getNombreCliente == '' ||
                              logisticaController.getNombreCliente == null
                          ? Container()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //*****************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Row(
                                  children: [
                                    Container(
                                      // width: size.wScreen(100.0),

                                      // color: Colors.blue,
                                      child: Row(
                                        children: [
                                          Text('Seleccione Ubicación: ',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.iScreen(1.0)),
                                    Consumer<LogisticaController>(
                                      builder: (_, btnprovider, __) {
                                        return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: GestureDetector(
                                              onTap: () {
                                                {
                                                  _modalSeleccionaPuestoUbicacion(
                                                      size,
                                                      btnprovider,
                                                      btnprovider
                                                          .getDatosOperativos);
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: primaryColor,
                                                width: size.iScreen(3.05),
                                                padding: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.5),
                                                  left: size.iScreen(0.5),
                                                  right: size.iScreen(0.5),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: size.iScreen(2.0),
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                //==========================================//

                                Consumer<LogisticaController>(
                                  builder: (_, valueUbicacion, __) {
                                    return valueUbicacion.getUbicacionCliente !=
                                                '' &&
                                            valueUbicacion.getPuestoCliente !=
                                                ''
                                        ? Container(
                                            width: size.wScreen(100.0),
                                            color: Colors.grey.shade200,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.0)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.5)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Ubicación : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.7),
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${valueUbicacion.getUbicacionCliente} ',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
                                                                  // color: Colors.black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Puesto : ',
                                                        style: GoogleFonts
                                                            .lexendDeca(
                                                                fontSize: size
                                                                    .iScreen(
                                                                        1.7),
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${valueUbicacion.getPuestoCliente}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
                                                                  // color: Colors.black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text('No hay ubicación seleccionada',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey));
                                  },
                                ),
                              ],
                            ),

                      //========================================//
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Row(
                        children: [
                          Container(
                            // width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Row(
                              children: [
                                Text('Guardias: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                                (logisticaController
                                        .getListaGuardiasVarios.isNotEmpty)
                                    ? Consumer<LogisticaController>(
                                        builder: (_, value, __) {
                                          return Text(
                                              ' ${value.getListaGuardias.length}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey));
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(width: size.iScreen(1.0)),
                          Consumer<LogisticaController>(
                            builder: (_, btnprovider, __) {
                              return (btnprovider.getNombreCliente == '' ||
                                      btnprovider.getNombreCliente == null)
                                  ? Container()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (btnprovider.getInfoClientePedido[
                                                  'cliRazonSocial'] !=
                                              '') {
                                            _modalSeleccionaPersona(
                                                size, btnprovider, 'GUARDIA');
                                          } else {
                                            NotificatiosnService.showSnackBarDanger(
                                                'Debe seleccionar un cliente  primero');
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: primaryColor,
                                          width: size.iScreen(3.05),
                                          padding: EdgeInsets.only(
                                            top: size.iScreen(0.5),
                                            bottom: size.iScreen(0.5),
                                            left: size.iScreen(0.5),
                                            right: size.iScreen(0.5),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: size.iScreen(2.0),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ],
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      //==========================================//

                      Consumer<LogisticaController>(
                        builder: (_, valueListaGuardias, __) {
                          return valueListaGuardias.getListaGuardias.isNotEmpty
                              ? Wrap(
                                  children: valueListaGuardias.getListaGuardias
                                      .map((e) => Card(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    valueListaGuardias
                                                        .eliminaGuardiaListPedido(
                                                            e['perId']);
                                                    // Provider.of<AvisoSalidaController>(context,
                                                    //         listen: false)
                                                    //     .eliminaGuardiaInformacion(guardia['id']);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            size.iScreen(0.5)),
                                                    child: const Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Text(
                                                      '${e['perApellidos']} ${e['perNombres']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.7),
                                                              // color: Colors.black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Text('No hay guardias seleccionados',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey));
                        },
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Row(
                        children: [
                          Container(
                            // width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Row(
                              children: [
                                Text('Supervisores: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                                (logisticaController
                                        .getListaGuardiasVarios.isNotEmpty)
                                    ? Consumer<LogisticaController>(
                                        builder: (_, value, __) {
                                          return Text(
                                              ' ${value.getListaGuardiasVarios.length}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey));
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(width: size.iScreen(1.0)),
                          Consumer<LogisticaController>(
                            builder: (_, btnprovider, __) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      {
                                        final _controller = context
                                            .read<AvisoSalidaController>();
                                        _controller.setPersona('SUPERVISOR');
                                        _modalSeleccionaPersona(
                                            size, btnprovider, 'SUPERVISOR');
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: primaryColor,
                                      width: size.iScreen(3.05),
                                      padding: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.5),
                                        left: size.iScreen(0.5),
                                        right: size.iScreen(0.5),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: size.iScreen(2.0),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      //==========================================//

                      Consumer<LogisticaController>(
                        builder: (_, valueListaSupervisores, __) {
                          return valueListaSupervisores
                                  .getListaSupervisores.isNotEmpty
                              ? Wrap(
                                  children: valueListaSupervisores
                                      .getListaSupervisores
                                      .map((e) => Card(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    valueListaSupervisores
                                                        .eliminaSupervisorListPedido(
                                                            e['perId']);
                                                    // Provider.of<AvisoSalidaController>(context,
                                                    //         listen: false)
                                                    //     .eliminaGuardiaInformacion(guardia['id']);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            size.iScreen(0.5)),
                                                    child: const Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Text(
                                                      '${e['perApellidos']} ${e['perNombres']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.7),
                                                              // color: Colors.black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Text('No hay supervisores seleccionados',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey));
                        },
                      ),
                      //========================================//
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Row(
                        children: [
                          Container(
                            // width: size.wScreen(100.0),

                            // color: Colors.blue,
                            child: Row(
                              children: [
                                Text('Administradores: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                                (logisticaController
                                        .getListaGuardiasVarios.isNotEmpty)
                                    ? Consumer<LogisticaController>(
                                        builder: (_, value, __) {
                                          return Text(
                                              ' ${value.getListaGuardiasVarios.length}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey));
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(width: size.iScreen(1.0)),
                          Consumer<LogisticaController>(
                            builder: (_, btnprovider, __) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      {
                                        final _controller = context
                                            .read<AvisoSalidaController>();
                                        _controller
                                            .setPersona('ADMINISTRACION');
                                        _modalSeleccionaPersona(size,
                                            btnprovider, 'ADMINISTRADORES');
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: primaryColor,
                                      width: size.iScreen(3.05),
                                      padding: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.5),
                                        left: size.iScreen(0.5),
                                        right: size.iScreen(0.5),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: size.iScreen(2.0),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      //==========================================//

                      Consumer<LogisticaController>(
                        builder: (_, valueListaAdministradores, __) {
                          return valueListaAdministradores
                                  .getListaAdministrador.isNotEmpty
                              ? Wrap(
                                  children: valueListaAdministradores
                                      .getListaAdministrador
                                      .map((e) => Card(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    valueListaAdministradores
                                                        .eliminaAdministradorListPedido(
                                                            e['perId']);
                                                    // Provider.of<AvisoSalidaController>(context,
                                                    //         listen: false)
                                                    //     .eliminaGuardiaInformacion(guardia['id']);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            size.iScreen(0.5)),
                                                    child: const Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: size
                                                                .iScreen(1.0),
                                                            vertical: size
                                                                .iScreen(1.0)),
                                                    child: Text(
                                                      '${e['perApellidos']} ${e['perNombres']}',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              fontSize: size
                                                                  .iScreen(1.7),
                                                              // color: Colors.black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Text('No hay Administradores seleccionados',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey));
                        },
                      ),

                      //========================================//
                      // //***********************************************/
                      // SizedBox(
                      //   height: size.iScreen(1.0),
                      // ),
                      // //*****************************************/
                      // SizedBox(
                      //   height: size.iScreen(1.0),
                      // ),
                      // //*****************************************/
                      // Row(
                      //   children: [
                      //     Container(
                      //       // width: size.wScreen(100.0),

                      //       // color: Colors.blue,
                      //       child: Row(
                      //         children: [
                      //           Text('Administrativos: ',
                      //               style: GoogleFonts.lexendDeca(
                      //                   // fontSize: size.iScreen(2.0),
                      //                   fontWeight: FontWeight.normal,
                      //                   color: Colors.grey)),
                      //           (logisticaController
                      //                   .getListaGuardiasVarios.isNotEmpty)
                      //               ? Consumer<LogisticaController>(
                      //                   builder: (_, value, __) {
                      //                     return Text(
                      //                         ' ${value.getListaGuardiasVarios.length}',
                      //                         style: GoogleFonts.lexendDeca(
                      //                             fontSize: size.iScreen(1.7),
                      //                             fontWeight: FontWeight.bold,
                      //                             color: Colors.grey));
                      //                   },
                      //                 )
                      //               : const SizedBox(),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(width: size.iScreen(1.0)),
                      //     Consumer<LogisticaController>(
                      //       builder: (_, btnprovider, __) {
                      //         return ClipRRect(
                      //                 borderRadius: BorderRadius.circular(8),
                      //                 child: GestureDetector(
                      //                   onTap: () {
                      //                      final _controller=context.read<AvisoSalidaController>();
                      //                        _controller.setPersona('ADMINISTRACION');

                      //                       _modalSeleccionaPersona(
                      //                           size, btnprovider, 'ADMINISTRADOR');

                      //                   },
                      //                   child: Container(
                      //                     alignment: Alignment.center,
                      //                     color: primaryColor,
                      //                     width: size.iScreen(3.05),
                      //                     padding: EdgeInsets.only(
                      //                       top: size.iScreen(0.5),
                      //                       bottom: size.iScreen(0.5),
                      //                       left: size.iScreen(0.5),
                      //                       right: size.iScreen(0.5),
                      //                     ),
                      //                     child: Icon(
                      //                       Icons.add,
                      //                       color: Colors.white,
                      //                       size: size.iScreen(2.0),
                      //                     ),
                      //                   ),
                      //                 ));
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // //***********************************************/
                      // SizedBox(
                      //   height: size.iScreen(1.0),
                      // ),
                      // //*****************************************/
                      // //==========================================//
                      // logisticaController.getListaGuardiasVarios.isNotEmpty
                      //     ? _ListaGuardias(
                      //         size: size,
                      //         logisticaController: logisticaController)
                      //     : Text('No hay administrativos seleccionados',
                      //         style: GoogleFonts.lexendDeca(
                      //             fontSize: size.iScreen(1.8),
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.grey)),

                      // //========================================//
                    
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),

                        // color: Colors.blue,
                        child: Text('Observación:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(),
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9@#-+.,{" "}]")),
                        ],
                        onChanged: (text) {
                          logisticaController.onObservacionChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese asunto del informe';
                          }
                        },
                      ),

                      //***********************************************/

                      TabBar(
                        tabs: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    textImplemento.text = '';
                                    // _modalAgregaPedido(
                                    //     size, logisticaController);
                                    logisticaController
                                        .resetModalAgregarItems();
                                    logisticaController.setTipoDePedido('');
                                    _modalAgregaPedidoPorTipo(size,
                                        logisticaController, 'IMPLEMENTOS');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: primaryColor,
                                    width: size.iScreen(3.05),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: size.iScreen(2.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.iScreen(1.0)),
                              Tab(
                                child: Text('Implementos',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              (logisticaController
                                      .getListaDeImplementos.isNotEmpty)
                                  ? Consumer<LogisticaController>(
                                      builder: (_, numPedido, __) {
                                        return Text(
                                            ': ${numPedido.getListaDeImplementos.length}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey));
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    // textImplemento.text = '';

                                    // _modalAgregaPedido(size, logisticaController);

                                    logisticaController
                                        .resetModalAgregarItems();
                                    logisticaController.setTipoDePedido('');
                                    _modalAgregaPedidoPorTipo(size,
                                        logisticaController, 'MUNICIONES');
                                    logisticaController
                                        .setTipoDePedido('MUNICIONES');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: primaryColor,
                                    width: size.iScreen(3.05),
                                    padding: EdgeInsets.only(
                                      top: size.iScreen(0.5),
                                      bottom: size.iScreen(0.5),
                                      left: size.iScreen(0.5),
                                      right: size.iScreen(0.5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: size.iScreen(2.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.iScreen(1.0)),
                              Tab(
                                child: Text('Municiones',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              (logisticaController
                                      .getListaDeMunisiones.isNotEmpty)
                                  ? Consumer<LogisticaController>(
                                      builder: (_, numPedido, __) {
                                        return Text(
                                            ': ${numPedido.getListaDeMunisiones.length}',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.7),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey));
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.iScreen(1.0),
                            horizontal: size.iScreen(1.0)),
                        // color: Colors.red,
                        width: size.wScreen(100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Valor Total: \$ ',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                            Consumer<LogisticaController>(
                              builder: (_, valueTotal, __) {
                                return Text('${valueTotal.getTotalPedido}',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.grey,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: size.wScreen(100.0),
                        height: size.hScreen(40.0),
                        child: TabBarView(
                          children: [
                            Container(
                              // color: Colors.red,
                              child: Consumer<LogisticaController>(
                                builder: (_, values, __) {
                                  return (values
                                          .getListaDeImplementos.isNotEmpty)
                                      ? SingleChildScrollView(
                                          child: PaginatedDataTable(
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Valor',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Serie',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Marca',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Modelo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Talla',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Bodega',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Tipo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source:
                                                // PedidosGuardiasDTS(
                                                //     values.getNuevoPedido,
                                                //     size,
                                                //     context,
                                                //     'Nuevo'),
                                                PedidosImplementosDTS(
                                                    values
                                                        .getListaDeImplementos,
                                                    size,
                                                    context,
                                                    'Nuevo'),
                                            rowsPerPage: values
                                                .getListaDeImplementos.length,
                                          ),
                                        )
                                      // : const SizedBox(),
                                      : const NoData(
                                          label:
                                              'No hay Implemento registrados ');
                                },
                              ),
                            ),
                            Container(
                              // color: Colors.blue,
                              child: Consumer<LogisticaController>(
                                builder: (_, values, __) {
                                  return (values
                                          .getListaDeMunisiones.isNotEmpty)
                                      ? SingleChildScrollView(
                                          child: PaginatedDataTable(
                                            columns: [
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text('X'),
                                                  SizedBox(width: 30.0),
                                                  Text('Nombre',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              )),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Valor',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Serie',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Marca',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Modelo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Talla',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Bodega',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                              DataColumn(
                                                  label: Text('Tipo',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .grey))),
                                            ],
                                            source: PedidosMunisionesDTS(
                                                values.getListaDeMunisiones,
                                                size,
                                                context,
                                                'Nuevo'),
                                            rowsPerPage: values
                                                .getListaDeMunisiones.length,
                                          ),
                                        )
                                      // : const SizedBox(),
                                      : const NoData(
                                          label:
                                              'No hay Munisiones registradas ');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(0.0),
                      ),
                      //*****************************************/
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaPersona(
      Responsive size, LogisticaController logisticaController, String tipo) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('SELECCIONAR $tipo',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        )),
                  ),
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
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading:
                            const Icon(Icons.qr_code_2, color: Colors.black),
                        title: Text(
                          "Código QR",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () async {},
                      ),
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
                        title: Text(
                          "Nómina de $tipo",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          // Navigator.pop(context);
                          if (tipo == 'CLIENTE') {
                            Provider.of<CambioDePuestoController>(context,
                                    listen: false)
                                .getTodosLosClientes('');
                            // logisticaController.getTodosLosClientes('');
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'buscaClientes',
                                arguments: 'nuevoPedido');
                          } else if (tipo == 'GUARDIA') {
                            Navigator.pop(context);
                            final _control = Provider.of<LogisticaController>(
                                context,
                                listen: false);
                            _control.resetListaPersonas();
                            _control.buscaListaGuardisDeCliente('');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BuscarPersonaPedido(
                                      persona: 'Guardias',
                                    )));
                          } else if (tipo == 'SUPERVISOR') {
                            Navigator.pop(context);
                            final _control = Provider.of<LogisticaController>(
                                context,
                                listen: false);
                            _control.resetListaPersonas();
                            _control.setPersona('ADMINISTRACION');
                            _control.buscaListaPersonas('');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BuscarPersonaPedido(
                                      persona: 'Supervisores',
                                    )));
                          } else if (tipo == 'ADMINISTRADORES') {
                            Navigator.pop(context);
                            final _control = Provider.of<LogisticaController>(
                                context,
                                listen: false);
                            _control.resetListaPersonas();
                            _control.setPersona('ADMINISTRACION');
                            _control.buscaListaPersonas('');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BuscarPersonaPedido(
                                      persona: 'Administradores',
                                    )));
                          }
                        },
                      ),
                      SizedBox(
                        height: size.iScreen(2.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaTipoImplementos(
      Responsive size, LogisticaController _controller) {
    final _data = [
      'VESTIMENTAS',
      'UTILITARIOS',
    ];

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
                      Text('SELECCIONAR TIPO',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
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
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _controller.setTipoDePedido(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              _data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //====== MUESTRA AGREGAR PEDIDO =======//
  // void _modalAgregaPedido(
  //     Responsive size, LogisticaController logisticaController) {
  //   logisticaController.resetBusquedaImplemento();
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return GestureDetector(
  //           onTap: () => FocusScope.of(context).unfocus(),
  //           child: AlertDialog(
  //             insetPadding: EdgeInsets.symmetric(
  //                 horizontal: size.wScreen(2.0), vertical: size.wScreen(1.0)),
  //             content: Form(
  //               key: logisticaController.validaNuevoPedidoGuardiaFormKey,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text('AGREGAR PEDIDO',
  //                           style: GoogleFonts.lexendDeca(
  //                             fontSize: size.iScreen(2.0),
  //                             fontWeight: FontWeight.bold,
  //                             // color: Colors.white,
  //                           )),
  //                       IconButton(
  //                           splashRadius: size.iScreen(3.0),
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           icon: Icon(
  //                             Icons.close,
  //                             color: Colors.red,
  //                             size: size.iScreen(3.5),
  //                           )),
  //                     ],
  //                   ),
  //                   //*****************************************/
  //                   Container(
  //                     padding:
  //                         EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         SizedBox(
  //                           //  color: Colors.red,
  //                           width: size.wScreen(100.0),
  //                           child: Text(
  //                             'Nombre de Implemento:',
  //                             style: GoogleFonts.lexendDeca(
  //                               fontSize: size.iScreen(1.8),
  //                               color: Colors.black45,
  //                               // fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         //***********************************************/
  //                         SizedBox(
  //                           height: size.iScreen(1.0),
  //                         ),
  //                         //*****************************************/
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             //***********************************************/
  //                             SizedBox(
  //                               height: size.iScreen(1.0),
  //                             ),
  //                             //*****************************************/
  //                             Consumer<LogisticaController>(
  //                               builder: (_, value, __) {
  //                                 return Expanded(
  //                                   child: Text(
  //                                     (value.getTipoPedido != '')
  //                                         ? '${value.getImplementoItem}'
  //                                         : ' ----- ',
  //                                     style: GoogleFonts.lexendDeca(
  //                                       fontSize: size.iScreen(1.8),
  //                                       // color: Colors.black45,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.circular(8),
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   // logisticaController
  //                                   //     .buscaImplementoPedido('');
  //                                   // Navigator.pushNamed(
  //                                   //         context, 'agregaPedidosGuardia')
  //                                   //     .then((value) {
  //                                   //   textImplemento.text = logisticaController
  //                                   //       .getImplementoItem!;
  //                                   // });
  //                                   logisticaController.buscaItemPedido('');
  //                                   // Navigator.pushNamed(
  //                                   //         context, 'agregaPedidosGuardia')
  //                                   //     .then((value) {
  //                                   //   textImplemento.text = logisticaController
  //                                   //       .getImplementoItem!;
  //                                   // });
  //                                   Navigator.push(
  //                                           context,
  //                                           MaterialPageRoute(
  //                                               builder: ((context) =>
  //                                                   const BuscarItemsPedidos())))
  //                                       .then((value) => textImplemento.text =
  //                                           logisticaController
  //                                               .getImplementoItem!);
  //                                 },
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   color: primaryColor,
  //                                   width: size.iScreen(3.5),
  //                                   padding: EdgeInsets.only(
  //                                     top: size.iScreen(0.5),
  //                                     bottom: size.iScreen(0.5),
  //                                     left: size.iScreen(0.5),
  //                                     right: size.iScreen(0.5),
  //                                   ),
  //                                   child: Icon(
  //                                     Icons.search_outlined,
  //                                     color: Colors.white,
  //                                     size: size.iScreen(2.8),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   //***********************************************/
  //                   SizedBox(
  //                     height: size.iScreen(1.0),
  //                   ),

  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                         // color: Colors.red,
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: size.iScreen(1.0)),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           children: [
  //                             Text(
  //                               'Tipo de Pedido:',
  //                               style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.black45,
  //                                 // fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             //***********************************************/
  //                             SizedBox(
  //                               height: size.iScreen(1.0),
  //                             ),
  //                             //*****************************************/
  //                             Consumer<LogisticaController>(
  //                               builder: (_, value, __) {
  //                                 return Text(
  //                                   (value.getTipoPedido != '')
  //                                       ? '${value.getTipoPedido}'
  //                                       : ' ----- ',
  //                                   style: GoogleFonts.lexendDeca(
  //                                     fontSize: size.iScreen(1.8),
  //                                     // color: Colors.black45,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         // color: Colors.red,
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: size.iScreen(1.0)),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                           children: [
  //                             Text(
  //                               'Cantidad:',
  //                               style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.black45,
  //                                 // fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             Consumer<LogisticaController>(
  //                               builder: (__, valueCantidad, Widget? child) {
  //                                 return Column(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: [
  //                                     SizedBox(
  //                                       width: size.iScreen(10.0),
  //                                       child: TextFormField(
  //                                         readOnly:
  //                                             valueCantidad.getTipoPedido == ''
  //                                                 ? true
  //                                                 : false,
  //                                         keyboardType: TextInputType.number,
  //                                         inputFormatters: <TextInputFormatter>[
  //                                           FilteringTextInputFormatter.allow(
  //                                               RegExp(r'[0-9]')),
  //                                         ],
  //                                         decoration: const InputDecoration(),
  //                                         textAlign: TextAlign.center,
  //                                         style: const TextStyle(),
  //                                         onChanged: (text) {
  //                                           valueCantidad.setItemCantidad(text);
  //                                         },
  //                                         validator: (text) {
  //                                           if (text!.trim().isNotEmpty) {
  //                                             return null;
  //                                           } else {
  //                                             return 'Cantidad inválida';
  //                                           }
  //                                         },
  //                                       ),
  //                                     ),
  //                                     valueCantidad.getItemDisponible == false
  //                                         ? Column(
  //                                             mainAxisSize: MainAxisSize.min,
  //                                             children: [
  //                                               SizedBox(
  //                                                 height: size.iScreen(0.5),
  //                                               ),
  //                                               Text(
  //                                                 '* No disponible',
  //                                                 style: GoogleFonts.lexendDeca(
  //                                                   fontSize: size.iScreen(1.5),
  //                                                   color: Colors.red,
  //                                                   fontWeight:
  //                                                       FontWeight.normal,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           )
  //                                         : Container(),
  //                                   ],
  //                                 );
  //                               },
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               SizedBox(
  //                 width: size.wScreen(100.0),
  //                 //  color: Colors.red,
  //                 child: Container(
  //                   margin:
  //                       EdgeInsets.symmetric(horizontal: size.iScreen(14.0)),
  //                   //  width: size.iScreen(20.0),
  //                   height: size.iScreen(3.5),
  //                   child: Consumer<LogisticaController>(
  //                     builder: (_, itemProvider, __) {
  //                       return ElevatedButton(
  //                         style: ButtonStyle(
  //                           backgroundColor: MaterialStateProperty.all(
  //                             itemProvider.getItemDisponible == true
  //                                 ? primaryColor
  //                                 : Colors.grey,
  //                           ),
  //                         ),
  //                         onPressed: itemProvider.getItemDisponible == true &&
  //                                 itemProvider.getItemCantidad != ''
  //                             ? () {
  //                                 _agregarPedido(logisticaController);
  //                               }
  //                             : null,
  //                         child: Text('Agregar',
  //                             style: GoogleFonts.lexendDeca(
  //                                 fontSize: size.iScreen(1.8),
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.normal)),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  //====== MUESTRA AGREGAR PEDIDO POR TIPO=======//
  void _modalAgregaPedidoPorTipo(
      Responsive size, LogisticaController logisticaController, String _tipo) {
    logisticaController.resetBusquedaImplemento();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(2.0), vertical: size.wScreen(0.5)),
              content: Form(
                key: logisticaController.validaNuevoPedidoGuardiaFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AGREGAR $_tipo',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                // color: Colors.white,
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
                      //*****************************************/
                      SizedBox(
                        // color: Colors.green,
                        width: size.wScreen(100.0),
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.red,
                              width: size.wScreen(100.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    //  color: Colors.red,
                                    width: size.wScreen(100.0),
                                    child: Text(
                                      'Bodega:',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        color: Colors.black45,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Consumer<LogisticaController>(
                                        builder: (_, value, __) {
                                          return Expanded(
                                            child: Text(
                                              (value.getnombreBodega != '')
                                                  ? '${value.getnombreBodega}'
                                                  : ' Seleccione bodega ',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: GestureDetector(
                                          onTap: () {
                                            logisticaController
                                                .buscaBodegasPedidos('');
                                            _modalSeleccionaBodegas(
                                                size, logisticaController);

                                            // logisticaController
                                            //     .buscaImplementoPedido('');
                                            // Navigator.pushNamed(
                                            //         context, 'agregaPedidosGuardia')
                                            //     .then((value) {
                                            //   textImplemento.text = logisticaController
                                            //       .getImplementoItem!;
                                            // });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: primaryColor,
                                            width: size.iScreen(3.5),
                                            padding: EdgeInsets.only(
                                              top: size.iScreen(0.5),
                                              bottom: size.iScreen(0.5),
                                              left: size.iScreen(0.5),
                                              right: size.iScreen(0.5),
                                            ),
                                            child: Icon(
                                              Icons.search_outlined,
                                              color: Colors.white,
                                              size: size.iScreen(2.8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.brown,
                              width: size.wScreen(100.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    //  color: Colors.red,
                                    width: size.wScreen(100.0),
                                    child: Text(
                                      'Tipo:',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        color: Colors.black45,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //***********************************************/
                                      SizedBox(
                                        height: size.iScreen(1.0),
                                      ),
                                      //*****************************************/
                                      Consumer<LogisticaController>(
                                        builder: (_, value, __) {
                                          return Expanded(
                                            child: Text(
                                              (value.getTipoDePedido != '')
                                                  ? '${value.getTipoDePedido}'
                                                  : ' Seleccione tipo',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      logisticaController.getTipoDePedido !=
                                              'MUNICIONES'
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _modalSeleccionaTipoImplementos(
                                                      size,
                                                      logisticaController);
                                                  // logisticaController
                                                  //     .buscaImplementoPedido('');
                                                  // Navigator.pushNamed(
                                                  //         context, 'agregaPedidosGuardia')
                                                  //     .then((value) {
                                                  //   textImplemento.text = logisticaController
                                                  //       .getImplementoItem!;
                                                  // });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: primaryColor,
                                                  width: size.iScreen(3.5),
                                                  padding: EdgeInsets.only(
                                                    top: size.iScreen(0.5),
                                                    bottom: size.iScreen(0.5),
                                                    left: size.iScreen(0.5),
                                                    right: size.iScreen(0.5),
                                                  ),
                                                  child: Icon(
                                                    Icons.search_outlined,
                                                    color: Colors.white,
                                                    size: size.iScreen(2.8),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              //  color: Colors.red,
                              width: size.wScreen(100.0),
                              child: Text(
                                'Nombre de Implemento:',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //***********************************************/
                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),
                                //*****************************************/
                                Consumer<LogisticaController>(
                                  builder: (_, value, __) {
                                    return Expanded(
                                      child: Text(
                                        (value.getTipoPedido != '')
                                            ? '${value.getImplementoItem}'
                                            : ' ----- ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          // color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Consumer<LogisticaController>(
                                  builder: (_, valueBoton, __) {
                                    return valueBoton.getnombreBodega != '' &&
                                            valueBoton.getTipoDePedido != ''
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: GestureDetector(
                                              onTap: _tipo == 'IMPLEMENTOS'
                                                  ? () {
                                                      //     if(logisticaController.getTipoDePedido=='IMPLEMENTOS'){

                                                      logisticaController
                                                          .resetListaInventario();
                                                      logisticaController
                                                          .buscaItemPedido('');

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  BuscarItemsPedidos(
                                                                    tipo: _tipo,
                                                                  )))).then(
                                                          (value) => textImplemento
                                                                  .text =
                                                              logisticaController
                                                                  .getImplementoItem!);
                                                    }
                                                  : () {
                                                      logisticaController
                                                          .resetListaInventario();
                                                      logisticaController
                                                          .buscaItemPedido('');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  BuscarItemsPedidos(
                                                                    tipo: logisticaController
                                                                        .getTipoDePedido
                                                                        .toString(),
                                                                  )))).then(
                                                          (value) => textImplemento
                                                                  .text =
                                                              logisticaController
                                                                  .getImplementoItem!);
                                                    },
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: primaryColor,
                                                width: size.iScreen(3.5),
                                                padding: EdgeInsets.only(
                                                  top: size.iScreen(0.5),
                                                  bottom: size.iScreen(0.5),
                                                  left: size.iScreen(0.5),
                                                  right: size.iScreen(0.5),
                                                ),
                                                child: Icon(
                                                  Icons.search_outlined,
                                                  color: Colors.white,
                                                  size: size.iScreen(2.8),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container();
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),

                      Consumer<LogisticaController>(
                        builder: (_, valueCantidad, __) {
                          return valueCantidad.getImplementoItem != ''
                              ? SizedBox(
                                  height: size.hScreen(20.0),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Wrap(
                                        children: valueCantidad
                                            .getLlistEstadosItem
                                            .map(
                                              (e) => Stack(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: size
                                                                .iScreen(0.3)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            size.iScreen(0.5)),
                                                        color: Colors
                                                            .grey.shade200,
                                                        width:
                                                            size.wScreen(100.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Estado ${e['id']}',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    // fontSize: size.iScreen(1.8),
                                                                    color: Colors
                                                                        .black45,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: size
                                                                      .wScreen(
                                                                          30.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${e['estado']}',
                                                                    style: GoogleFonts
                                                                        .lexendDeca(
                                                                      // fontSize: size.iScreen(1.8),
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Disponible',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    // fontSize: size.iScreen(1.8),
                                                                    color: Colors
                                                                        .black45,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${e['disponible']}',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    // fontSize: size.iScreen(1.8),
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Cantidad',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    // fontSize: size.iScreen(1.8),
                                                                    color: Colors
                                                                        .black45,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${e['cantidad']}',
                                                                  style: GoogleFonts
                                                                      .lexendDeca(
                                                                    // fontSize: size.iScreen(1.8),
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  int.parse(e['disponible']
                                                              .toString()) >
                                                          0
                                                      ? Positioned(
                                                          top:
                                                              size.iScreen(2.5),
                                                          right:
                                                              size.iScreen(1.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              //  print("lista Estados : ${logisticaController.getLlistEstadosItem}");
                                                              print(
                                                                  "ITEM : $e}");
                                                              logisticaController
                                                                  .setStockDelItem(
                                                                      e['disponible']
                                                                          .toString());
                                                              _modalSeleccionaCambiarcantidadItem(
                                                                  size,
                                                                  logisticaController,
                                                                  e,
                                                                  _tipo);
                                                            },
                                                            child: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  secondaryColor,
                                                            ),
                                                          ))
                                                      : Container()
                                                ],
                                              ),
                                            )
                                            .toList()),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Container(
                  width: size.wScreen(100.0),
                  //  color: Colors.red,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: size.iScreen(14.0)),
                    //  width: size.iScreen(20.0),
                    height: size.iScreen(3.5),
                    child: Consumer<LogisticaController>(
                      builder: (_, itemProvider, __) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              itemProvider.getLlistEstadosItem.isNotEmpty &&
                                      itemProvider.getImplementoItem != ''
                                  ? primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          onPressed:
                              // itemProvider.getItemDisponible == true &&
                              //         itemProvider.getItemCantidad != ''
                              itemProvider.getLlistEstadosItem.isNotEmpty &&
                                      itemProvider.getImplementoItem != ''
                                  ? () {
                                      _agregarPedido(
                                          logisticaController, _tipo);
                                    }
                                  : null,
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaPuestoUbicacion(
      Responsive size, LogisticaController _controller, List _data) {
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
                      Text('SELECCIONAR UBICACIÓN',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
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
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _controller.setUbicacionCliente(_data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              '${_data[index]['ubicacion']} - ${_data[index]['puesto']}',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //====== MUESTRA MODAL PARA CAMBIAR CANTIDAD DEL ITEM=======//
  void _modalSeleccionaCambiarcantidadItem(
      Responsive size,
      // LogisticaController _controller, int _disponible, String _estado,String _tipo) {
      LogisticaController _controller,
      dynamic _data,
      String _tipo) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AGREGAR CANTIDAD',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.wScreen(100.0),
                          child: Row(
                            children: [
                              Text(
                                'Nombre: ',
                                style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: size.wScreen(50.0),
                                // color: Colors.red,
                                child: Text(
                                  '${_controller.getImplementoItem} ',
                                  style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(1.8),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //***********************************************/

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.wScreen(100.0),
                          child: Row(
                            children: [
                              Text(
                                'Disponible: ',
                                style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${_data['disponible']}',
                                  style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(1.8),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Cantidad:',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            color: Colors.black45,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<LogisticaController>(
                          builder: (__, valueCantidad, Widget? child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: size.iScreen(10.0),
                                  child: TextFormField(
                                    readOnly: valueCantidad.getTipoPedido == ''
                                        ? true
                                        : false,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: const InputDecoration(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(),
                                    onChanged: (text) {
                                      valueCantidad.setItemCantidad(text);
                                    },
                                    validator: (text) {
                                      if (text!.trim().isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'Cantidad inválida';
                                      }
                                    },
                                  ),
                                ),
                                valueCantidad.getItemDisponible == false
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: size.iScreen(0.5),
                                          ),
                                          Text(
                                            '* No disponible',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.5),
                                              color: Colors.red,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          width: size.iScreen(2.0),
                        ),
                        SizedBox(
                          // width: size.wScreen(100.0),
                          //  color: Colors.red,

                          child: Container(
                            // margin:
                            //     EdgeInsets.symmetric(horizontal: size.iScreen(14.0)),
                            //  width: size.iScreen(20.0),
                            height: size.iScreen(3.5),
                            child: Consumer<LogisticaController>(
                              builder: (_, itemProvider, __) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      itemProvider.getItemDisponible == true
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                  onPressed:
                                      itemProvider.getItemDisponible == true &&
                                              itemProvider.getItemCantidad != ''
                                          ? () {
                                              // _agregarPedido(itemProvider);

                                              final _item = {
                                                "id": '${_data['id']}',
                                                "estado": '${_data['estado']}',
                                                "disponible":
                                                    '${_data['disponible']}',
                                              };

                                              itemProvider.actualizaItem(_item);
                                              // print(
                                              // 'lista de Stock: ${itemProvider.getLlistEstadosItem}');
                                              Navigator.pop(context);
                                            }
                                          : null,
                                  child: Text('Cambiar',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal)),
                                );
                              },
                            ),
                          ),
                        ),
                        // SizedBox(width:size.iScreen(2.0)),
                        //  Text(
                        //   'Stock: ',
                        //   style: GoogleFonts.lexendDeca(
                        //     fontSize: size.iScreen(1.8),
                        //     color: Colors.black45,
                        //     // fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Consumer<LogisticaController>(builder: (_, valueStock, __) {
                        //   return
                        // valueStock.getStockItem!=''
                        // ? Text(
                        //   '${valueStock.getStockItem}',
                        //   style: GoogleFonts.lexendDeca(
                        //     fontSize: size.iScreen(1.8),
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ):
                        //  Text(
                        //   '--- ---',
                        //   style: GoogleFonts.lexendDeca(
                        //     fontSize: size.iScreen(1.8),
                        //     color: Colors.grey,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // );
                        // },),
                      ],
                    ),

                    // SizedBox(
                    //   width: size.wScreen(100),
                    //   height: size.hScreen(26),
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: const BouncingScrollPhysics(),
                    //     itemCount: _data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           _controller.setTipoDePedido(_data[index]);
                    //           Navigator.pop(context);
                    //         },
                    //         child: Container(
                    //           color: Colors.grey[100],
                    //           margin: EdgeInsets.symmetric(
                    //               vertical: size.iScreen(0.3)),
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: size.iScreen(1.0),
                    //               vertical: size.iScreen(1.0)),
                    //           child: Text(
                    //             _data[index],
                    //             style: GoogleFonts.lexendDeca(
                    //               fontSize: size.iScreen(1.8),
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black54,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaBodegas(
      Responsive size, LogisticaController _controller) {
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
                      Text('SELECCIONAR BODEGA',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
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
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: Consumer<LogisticaController>(
                      builder: (_, valueBodegas, __) {
                        if (valueBodegas.getErrorBodegasPedido == null) {
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
                        } else if (valueBodegas.getErrorBodegasPedido ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (valueBodegas.getListBodegas.isEmpty) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                          // Text("sin datos");
                        }

                        return Wrap(
                            children: (valueBodegas.getListBodegas[0] as List)
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        _controller.setNombreBodega(e);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: size.wScreen(100.0),
                                        color: Colors.grey[100],
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(0.3)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.0),
                                            vertical: size.iScreen(1.0)),
                                        child: Text(
                                          '${e['bodNombre']}',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList());
                        //   ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: const BouncingScrollPhysics(),
                        //   itemCount: valueBodegas.getListBodegas.length,
                        //   itemBuilder: (BuildContext context, int index) {

                        //     final _bodega=valueBodegas.getListBodegas[index];
                        //     return GestureDetector(
                        //       onTap: () {
                        //         _controller.setNombreBodega(_bodega['bodNombre']);
                        //         Navigator.pop(context);
                        //       },
                        //       child: Container(
                        //         color: Colors.grey[100],
                        //         margin: EdgeInsets.symmetric(
                        //             vertical: size.iScreen(0.3)),
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: size.iScreen(1.0),
                        //             vertical: size.iScreen(1.0)),
                        //         child: Text(
                        //           _bodega['bodNombre'],
                        //           style: GoogleFonts.lexendDeca(
                        //             fontSize: size.iScreen(1.8),
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.black54,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _agregarPedido(
      LogisticaController logisticaController, String _tipos) async {
    // print("lista Estados : $_tipos}");

    String _uuidV4 = logisticaController.generateUniqueId();
    if (_tipos == 'IMPLEMENTOS') {
      logisticaController.agregaItemPedido(_uuidV4);
    } else if (_tipos == 'MUNICIONES') {
      logisticaController.agregaItemPedidoMunisiones(_uuidV4);
    }

    logisticaController.sumaTotalPedido();
    // print("lista Estados : ${logisticaController.getLlistEstadosItem}");

    // if (logisticaController.getImplementoItem != null &&
    //     logisticaController.getItemCantidad != null) {
    // logisticaController.agregaNuevoPedido();

    Navigator.pop(context);
    // }
  }

//********************************************************************************************************************//
  void _onSubmit(
      BuildContext context, LogisticaController logisticaController) async {
    final isValid = logisticaController.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (logisticaController.getNombreCliente == '' ||
          logisticaController.getNombreCliente == null) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar cliente');
      } else if (logisticaController.getListaGuardias.isEmpty && logisticaController.getListaSupervisores.isEmpty&&logisticaController.getListaAdministrador.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar personal');
      } else if (logisticaController.getUbicacionCliente == '' ||
          logisticaController.getPuestoCliente == '') {
        NotificatiosnService.showSnackBarDanger(
            'Debe seleccionar ubicación del cliente');
      } else if (logisticaController.getListaDeImplementos.isEmpty &&
          logisticaController.getListaDeMunisiones.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe agregar pedido');
      } else if (logisticaController.labelEntrega == null) {
        NotificatiosnService.showSnackBarDanger('Seleccione tipo de entrega');
      } else if (
                  logisticaController.getNombreCliente!.isNotEmpty 
                  && logisticaController.labelEntrega != null
                  // && logisticaController.getListaGuardias.isNotEmpty
                  && logisticaController.getUbicacionCliente!=''
                  && logisticaController.getPuestoCliente!=''
             ) {
        logisticaController.crearPedido(context);

        Navigator.pop(context);

        // Provider.of<AvisoSalidaController>(context, listen: false)
        //     .resetValuesAvisoSalida();
      } else {
        NotificatiosnService.showSnackBarDanger('Debe realizar un pedido');
      }
    }
  }
}

class _ListaGuardias extends StatelessWidget {
  final LogisticaController logisticaController;
  const _ListaGuardias({
    Key? key,
    required this.size,
    required this.logisticaController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Consumer<LogisticaController>(
        builder: (_, provider, __) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
            // color: Colors.red,
            width: size.wScreen(100.0),
            height:
                size.iScreen(provider.getListaGuardias.length.toDouble() * 5.5),
            child: ListView.builder(
              itemCount: provider.getListaGuardias.length,
              itemBuilder: (BuildContext context, int index) {
                final guardia = provider.getListaGuardias[index];
                return Card(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          provider.eliminaGuardiaListPedido(guardia['perId']);
                          // Provider.of<AvisoSalidaController>(context,
                          //         listen: false)
                          //     .eliminaGuardiaInformacion(guardia['id']);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: size.iScreen(0.5)),
                          child: const Icon(Icons.delete_forever_outlined,
                              color: Colors.red),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.iScreen(1.0),
                              vertical: size.iScreen(1.0)),
                          child: Text(
                            '${guardia['perApellidos']} ${guardia['perNombres']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.7),
                                // color: Colors.black54,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      onTap: () {
        // print('activa FOTOGRAFIA');
      },
    );
  }
}
