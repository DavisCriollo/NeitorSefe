

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/pages/detalle_actividad_asignada.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class ListaDeActividades extends StatelessWidget {
  const ListaDeActividades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: ListActividades(),
    );
  }
}

class ProductProvider extends ChangeNotifier {}

class ListActividades extends StatelessWidget {
  const ListActividades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
  final _controls =context.read<ActividadesAsignadasController>();
  final ctrlTheme = context.read<ThemeApp>();
        
    return GestureDetector(
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
                  ctrlTheme.primaryColor,
                  ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
          title: Text(
            'Actividades',
            // style: Theme.of(context).textTheme.headline2,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: size.iScreen(1.5)),
              child: IconButton(
                  splashRadius: 28,
                  onPressed: () {
                    final _control =
                        context.read<ActividadesAsignadasController>();

                    _control.resetValuesActividades();
                    _control.borrarDatos();
                    _control.agruparProductos();
                     _control.setLabelActividad('DEL DIA'); 
                    _control.getActividadesAsignadas('', 'false');
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
        body: 
        Container(
           width: size.wScreen(100.0),
                  height: size.hScreen(100),
          child: Column(
            children: [
               Row(
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
                              ),
              //  SizedBox(
              //   height: size.iScreen(2.5),
              // ),
          
//***********************************************/
                          SizedBox(
                            height: size.iScreen(1.5),
                          ),
                          //*****************************************/
                            Container(
                                      width: size.wScreen(90.0),
        
                                      // color: Colors.blue,
                                      child: Text('Mostrar Actividades:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
        
                                    Container(
                                       width: size.wScreen(90.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // color: Colors.red,
                                              padding: EdgeInsets.only(
                                                top: size.iScreen(0.5),
                                                right: size.iScreen(0.5),
                                              ),
                                              child: Consumer<ActividadesAsignadasController>(
                                                builder: (_, tipo, __) {
                                                  return (tipo.labelActividad ==
                                                              '' ||
                                                          tipo.labelActividad ==
                                                              null)
                                                      ? Text(
                                                          'Seleccione',
                                                          style:
                                                              GoogleFonts.lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(1.8),
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  color: Colors.grey),
                                                        )
                                                      : Text(
                                                          '${tipo.labelActividad} ',
                                                          style:
                                                              GoogleFonts.lexendDeca(
                                                            fontSize:
                                                                size.iScreen(1.8),
                                                            fontWeight:
                                                                FontWeight.normal,
                                                            // color: Colors.grey
                                                          ),
                                                        );
                                                },
                                              ),
                                            ),
                                          ),
                                         
                                  
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: GestureDetector(onTap: () {
                                              _modalSeleccionaTipo(context,size, _controls);
                                            }, child: Consumer<ThemeApp>(
                                              builder: (_, valueTheme, __) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  color:
                                                      valueTheme.primaryColor,
                                                  width: size.iScreen(4.0),
                                                  //  height: size.iScreen(3.0),
                                                  padding: EdgeInsets.only(
                                                    top: size.iScreen(0.0),
                                                    bottom: size.iScreen(0.0),
                                                    left: size.iScreen(0),
                                                    right: size.iScreen(0.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: valueTheme
                                                        .secondaryColor,
                                                    size: size.iScreen(3.0),
                                                  ),
                                                );
                                              },
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //***********************************************/
                          SizedBox(
                            height: size.iScreen(0.5),
                          ),
                          //*****************************************/
                          // Consumer<ActividadesAsignadasController>(
                          //     builder: (_, values, __) {
                          //   return  
                          //       Column(children: [
                          //           Container(
                          //             width: size.wScreen(100.0),
        
                          //             // color: Colors.blue,
                          //             child: Text('Motivo:',
                          //                 style: GoogleFonts.lexendDeca(
                          //                     // fontSize: size.iScreen(2.0),
                          //                     fontWeight: FontWeight.normal,
                          //                     color: Colors.grey)),
                          //           ),
        
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: Container(
                          //                   // color: Colors.red,
                          //                   padding: EdgeInsets.only(
                          //                     top: size.iScreen(1.0),
                          //                     right: size.iScreen(0.5),
                          //                   ),
                          //                   child: Consumer<NuevoPermisoController>(
                          //                     builder: (_, persona, __) {
                          //                       return (persona.labelMotivoAusencia ==
                          //                                   '' ||
                          //                               persona.labelMotivoAusencia ==
                          //                                   null)
                          //                           ? Text(
                          //                               'No hay motivo seleccionado',
                          //                               style:
                          //                                   GoogleFonts.lexendDeca(
                          //                                       fontSize: size
                          //                                           .iScreen(1.8),
                          //                                       fontWeight:
                          //                                           FontWeight.bold,
                          //                                       color: Colors.grey),
                          //                             )
                          //                           : Text(
                          //                               '${persona.labelMotivoAusencia} ',
                          //                               style:
                          //                                   GoogleFonts.lexendDeca(
                          //                                 fontSize:
                          //                                     size.iScreen(1.8),
                          //                                 fontWeight:
                          //                                     FontWeight.normal,
                          //                                 // color: Colors.grey
                          //                               ),
                          //                             );
                          //                     },
                          //                   ),
                          //                 ),
                          //               ),
                                       
                                      
                                    
                          //               ClipRRect(
                          //                 borderRadius: BorderRadius.circular(8),
                          //                 child: GestureDetector(onTap: () {
                          //                   _modalSeleccionaMotivo(size, ctrlHome);
                          //                 }, child: Consumer<AppTheme>(
                          //                   builder: (_, valueTheme, __) {
                          //                     return Container(
                          //                       alignment: Alignment.center,
                          //                       color:
                          //                           valueTheme.getPrimaryTextColor,
                          //                       width: size.iScreen(3.5),
                          //                       padding: EdgeInsets.only(
                          //                         top: size.iScreen(0.5),
                          //                         bottom: size.iScreen(0.5),
                          //                         left: size.iScreen(0.5),
                          //                         right: size.iScreen(0.5),
                          //                       ),
                          //                       child: Icon(
                          //                         Icons.add,
                          //                         color: valueTheme
                          //                             .getSecondryTextColor,
                          //                         size: size.iScreen(2.0),
                          //                       ),
                          //                     );
                          //                   },
                          //                 )),
                          //               ),
                          //             ],
                          //           ));
                          //     }),


              Expanded(
                child: Stack(
                  children: [
                    Consumer<ActividadesAsignadasController>(
                      builder: (context, productProvider, _) {
                        if (productProvider.getErrorActividadesAsignadas == null) {
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
                        } else if (productProvider.getErrorActividadesAsignadas ==
                            false) {
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else if (productProvider.getListaActividadesAsignadas.isEmpty) {
                          // return Center(
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
                          return const NoData(
                            label: 'No existen datos para mostar',
                          );
                        } else {
                          productProvider.agruparProductos();
              
                          List<Widget> expansionTiles = [];
                          productProvider.groupedProducts.forEach((tipo, productList) {
              
                            List<Widget> tiles = [];
              
                            for (var product in productList) {
                             String fechaLocal = DateUtility.fechaLocalConvert(product['act_asigFecReg']!.toString());
                              tiles.add(
                                // ListTile(
                                //   title: Text(product['act_asigEveTipo']),
                                //   subtitle: Text('Cantidad: cantidadprecio'),
                                // ),
                                GestureDetector(
                                      onTap: () {
                                      
              
                                      context
                                          .read<ActividadesAsignadasController>()
                                          .setInfoActividad(product);
              
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const DetalleActividadAsignada())));
                                    },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        left: size.iScreen(0.75),
                                        right: size.iScreen(0.75)),
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
                                                      'Actividad: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.normal),
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
                                                        ' ${product['act_asigEveNombre'].toUpperCase()}',
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
                                                    // width: size.iScreen(10.0),
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      '# Total Actividades: ',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.iScreen(10.0),
                                                    // color: Colors.red,
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),
                                
                                                    child: Text(
                                                      ' ${product['act_asigEveActividades'].length}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.6),
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    // width: size.iScreen(10.0),
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
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: size.iScreen(0.5),
                                                        bottom: size.iScreen(0.0)),
                                                    // width: size.wScreen(100.0),
                                                    child: Text(
                                                      fechaLocal,
                                                      // product['act_asigFecReg']!
                                                      //     // .toLocal()
                                                      //     .toString()
                                                      //     .replaceAll(".000Z", "")
                                                      //     .replaceAll(".000", "")
                                                      //     .replaceAll("T", " "),
                                                      // child: Text(
                                                      //   _fechaUTC,
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize: size.iScreen(1.5),
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight.bold),
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
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.6),
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            Text(
                                              '${product['act_asigEstado']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.4),
                                                  // color: Colors.orange,
                                                  color: '${product['act_asigEstado']}' ==
                                                          'FINALIZADA'
                                                      ? secondaryColor
                                                      : '${product['act_asigEstado']}' ==
                                                              'EN PROCESO'
                                                          ? tercearyColor
                                                          : '${product['act_asigEstado']}' ==
                                                                  'PROCESANDO'
                                                              ? primaryColor
                                                              : '${product['act_asigEstado']}' ==
                                                                      'INCUMPLIDA'
                                                                  ? Colors.red
                                                                  : '${product['act_asigEstado']}' ==
                                                                          'ASIGNADA'
                                                                      ? primaryColor
                                                                      : Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
              
                            expansionTiles.add(
                              Column(
                                mainAxisSize:  MainAxisSize.min,
                                children: [
                                  ExpansionTile(
                                    title: Text(tipo),
                                    children: tiles,
                                  ),
                                   Divider(
                color: Colors.grey.shade300,
                thickness: 1,
                height: 0,
                    )
                                ],
                              ),
                            );
                          });
              
                          return RefreshIndicator(
                            onRefresh: () => onRefresh(context),
                            child: ListView(
                              children: [
                                ...expansionTiles,
                                          ],
                            ),
                          );
                        }
                      },
                    ),
                    // Positioned(
                    //   top: 0,
                    //   child: Container(
                    //       width: size.wScreen(100.0),
                    //       margin: const EdgeInsets.all(0.0),
                    //       padding: const EdgeInsets.all(0.0),
                    //       child: Column(
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                    //                   style: GoogleFonts.lexendDeca(
                    //                       fontSize: size.iScreen(1.5),
                    //                       color: Colors.grey.shade600,
                    //                       fontWeight: FontWeight.bold)),
                    //               Text('-',
                    //                   style: GoogleFonts.lexendDeca(
                    //                       fontSize: size.iScreen(1.5),
                    //                       color: Colors.grey,
                    //                       fontWeight: FontWeight.bold)),
                    //               Text('  ${_user.getUsuarioInfo!.usuario!} ',
                    //                   style: GoogleFonts.lexendDeca(
                    //                       fontSize: size.iScreen(1.5),
                    //                       color: Colors.grey.shade600,
                    //                       fontWeight: FontWeight.bold)),
              
                                     
                    //             ],
                    //           ),
                    //         ],
                    //       )),
                    // ),
                    
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //======================= ACTUALIZA LA PANTALLA============================//
  Future onRefresh( BuildContext context) async {
  final _controls= context.read<ActividadesAsignadasController>();

                    _controls.resetValuesActividades();
                    _controls.borrarDatos();
                    _controls.agruparProductos();
                    _controls.getActividadesAsignadas('', 'false');
  }
  //===================================================//

  //====== MUESTRA MODAL DE MOTIVO =======//
  void _modalSeleccionaTipo(BuildContext context, size, ActividadesAsignadasController actividades) {
    final _data = [
      'DEL DIA',
      'ANTERIORES',
      'POSTERIORES',
    
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
                      Text('MOSTRAR ACTIVIDADES',
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
                  Container(
                    width: size.wScreen(100.0),
                    height: size.hScreen(15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            actividades.setLabelActividad(_data[index]);
                            onRefresh(  context);
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



}
