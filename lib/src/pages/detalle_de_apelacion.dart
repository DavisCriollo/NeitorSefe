import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class DetalleDeApelacion extends StatelessWidget {
  const DetalleDeApelacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final idMulta = ModalRoute.of(context)!.settings.arguments;


  final _user=context.read<HomeController>();
  final ctrlTheme = context.read<ThemeApp>();
         

    final infoApelacion = context.read<MultasGuardiasContrtoller>();
    final _infoApelacion = [];
    final List _listaDeFotos = [];

    return Scaffold(
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
            'Detalle de Apelación',
            // style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: size.iScreen(0.0)),
          padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
          width: size.wScreen(100.0),
          height: size.hScreen(100),
          child: FutureBuilder(
            future: infoApelacion.getTodasLasMultasGuardia('', 'false'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: size.iScreen(2.0),
                      ),
                      const Text('Preparando Información... '),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                for (var e
                    in infoApelacion.getListaTodasLasMultasGuardias!.toList()) {
                  if (e['nomId'].toString() == idMulta) {
                    _infoApelacion.add(e);

                    _listaDeFotos.addAll(e['nomApelacionFotos']);
                  }
                }
              }
              return
                  // _infoApelacion[0]['nomApelacionTexto']!=[]&&  _infoApelacion[0]['nomApelacionFecha'] != ''?
                  _infoApelacion[0]['nomApelacionFecha'] != ''
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                    
                             //*****************************************/
                                 Container(
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
                            
                              //*****************************************/
                                      SizedBox(
                                height: size.iScreen(1.0),
                              ),

                              //==========================================//
                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Motivo de multa:',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.iScreen(0.5)),
                                width: size.wScreen(100.0),
                                child: Text(
                                  '${_infoApelacion[0]['nomDetalle']}',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              //*****************************************/
                              //*****************************************/

                              SizedBox(
                                height: size.iScreen(0.5),
                              ),
                              //==========================================//

                              //*****************************************/

                              SizedBox(
                                height: size.iScreen(0.5),
                              ),
                              //==========================================//
                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Detalle de Apelación:',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.iScreen(0.5)),
                                width: size.wScreen(100.0),
                                child: Text(
                                  _infoApelacion[0]['nomApelacionTexto'] != ''
                                      ? '${_infoApelacion[0]['nomApelacionTexto']}'
                                      : 'Sin detalle',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              //*****************************************/

                              SizedBox(
                                height: size.iScreen(0.5),
                              ),
                              //==========================================//
                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Fecha de Apelación:',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.iScreen(0.5)),
                                width: size.wScreen(100.0),
                                child: Text(
                                  _infoApelacion[0]['nomApelacionFecha'] != ''
                                      ? DateTime.parse(_infoApelacion[0]
                                              ['nomApelacionFecha']!)
                                          .toLocal()
                                          .toString()
                                          .substring(0, 16)
                                          .replaceAll("T", " ")
                                      : 'Sin fecha',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      // color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              //*****************************************/

                              (_infoApelacion[0]['nomApelacionFotos']
                                      .isNotEmpty)
                                  ? Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100.0),
                                          // color: Colors.blue,
                                          margin: EdgeInsets.symmetric(
                                            vertical: size.iScreen(1.0),
                                            horizontal: size.iScreen(0.0),
                                          ),
                                          child: Text(
                                              // 'Fotografía: ${_listaDeFotos.length}',
                                              'Fotografía: ${_infoApelacion[0]['nomApelacionFotos'].length}',
                                              style: GoogleFonts.lexendDeca(
                                                  // fontSize: size.iScreen(2.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey)),
                                        ),

                                        //==================================/
                                        Wrap(
                                          children: (_infoApelacion[0]
                                                  ['nomApelacionFotos'] as List)
                                              .map(
                                                (e) =>

                                                    // Text(e['url']),
                                                    FadeInImage(
                                                  placeholder: const AssetImage(
                                                      'assets/imgs/loader.gif'),
                                                  image: NetworkImage(e['url']),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        //*****************************************/

                              SizedBox(
                                height: size.iScreen(0.5),
                              ),
                              //==========================================//
                                        //==================================/

                                        // SizedBox(
                                        //   // color: Colors.red,

                                        //   child: ListView.builder(
                                        //     itemCount: _infoApelacion[0]
                                        //         .nomApelacionFotos
                                        //         .length,
                                        //     itemBuilder:
                                        //         (BuildContext context, int index) {
                                        //       final fotos = _infoApelacion[0]
                                        //           .nomApelacionFotos[index];
                                        //       return Container(
                                        //         margin: EdgeInsets.symmetric(
                                        //             horizontal: size.iScreen(0.0),
                                        //             vertical: size.iScreen(0.5)),
                                        //         child: ClipRRect(
                                        //           borderRadius: BorderRadius.circular(10),
                                        //           child: Container(
                                        //             decoration: const BoxDecoration(
                                        //                 // color: Colors.red,
                                        //                 // border: Border.all(color: Colors.grey),
                                        //                 // borderRadius: BorderRadius.circular(10),
                                        //                 ),
                                        //             width: size.wScreen(100.0),
                                        //             // height: size.hScreen(20.0),
                                        //             padding: EdgeInsets.symmetric(
                                        //               vertical: size.iScreen(0.0),
                                        //               horizontal: size.iScreen(0.0),
                                        //             ),
                                        //             child: FadeInImage(
                                        //               placeholder: const AssetImage(
                                        //                   'assets/imgs/loader.gif'),
                                        //               image: NetworkImage(fotos['url']),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },
                                        //   ),
                                        //   height: size.hScreen(
                                        //       _infoApelacion[0]['nomApelacionFotos'].length *
                                        //           67.toDouble()),
                                        // ),

                                        //==================================//
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : const NoData(
                          label: 'No tiene apelación',
                        );
            },
          ),
        ));
  }
}
