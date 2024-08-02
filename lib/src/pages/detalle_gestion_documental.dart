import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/gestion_documental_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class DetalleGestioDocumental extends StatelessWidget {
final String estado;
  const DetalleGestioDocumental({Key? key, required this.estado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<GestionDocumentalController>();
    // print(',,,.... ${infoContrtoller.getInfoActaGestion}');
     final _user=context.read<HomeController>();
       final ctrlTheme = context.read<ThemeApp>();
         
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
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
                    'Detalle De Acta $estado',
                    // style: Theme.of(context).textTheme.headline2,
                  ),
                ),body: Container(
              margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
              child: SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//
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

                    //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),

                   
                    Row(
                      children: [
                        SizedBox(
                          child: Text('Tipo: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            '${infoContrtoller.getInfoActaGestion['actaTipo']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//
                    Row(
                      children: [
                        SizedBox(
                          child: Text('Estado: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            '${infoContrtoller.getInfoActaGestion['actaEstado']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//

                    //==========================================//
                    Column(
                      children: [
                        Container(
                            width: size.wScreen(100.0),
                          child: Text('Asunto: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          width: size.wScreen(100.0),
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            '${infoContrtoller.getInfoActaGestion['actaAsunto']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//
                     //==========================================//
                    Row(
                      children: [
                        Container(
                          // color:Colors.red,
                           width: size.wScreen(12.0),
                          child: Text('lugar: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                            // color:Colors.red,
                           width: size.wScreen(80.0),
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            infoContrtoller.getInfoActaGestion['actaLugar'] !="" 
                            ? '${infoContrtoller.getInfoActaGestion['actaLugar']}'
                          :'--- --- --- --- --- --- ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                     //==========================================//
                    Row(
                      children: [
                        Container(
                          // color:Colors.red,
                           width: size.wScreen(12.0),
                          child: Text('Fecha: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                            // color:Colors.red,
                           width: size.wScreen(80.0),
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                             '${infoContrtoller.getInfoActaGestion['actaFecha']}',
                             style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                    Row(
                      children: [
                        Container(
                          // color:Colors.red,
                           width: size.wScreen(12.0),
                          child: Text('Para: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                            // color:Colors.red,
                           width: size.wScreen(80.0),
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                             '${infoContrtoller.getInfoActaGestion['actaPerfilPara']}',
                             style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),

                    //==========================================//
                        Container(
                          // color:Colors.red,
                           width: size.wScreen(100.0),
                          child: Text('Personal: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                      //==========================================//
                     SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//
                     Consumer<GestionDocumentalController>(
                        builder: (_, valueListaPersonas, __) {
                          return valueListaPersonas.getLabelPerfil!.isNotEmpty &&
                                  valueListaPersonas.getListaDePersonal.isEmpty
                              ? Column(
                                  children: [
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                                    Text('No hay personal seleccionado',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey)),
                                  ],
                                )
                              : Column(
                                  children: [
                                    //***********************************************/
                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                                    Wrap(
                                      children: valueListaPersonas
                                          .getListaDePersonal
                                          .map((e) => Card(
                                                child: Row(
                                                  children: [
                                                      Expanded(
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.symmetric(
                                                                horizontal: size
                                                                    .iScreen(1.0),
                                                                vertical:
                                                                    size.iScreen(
                                                                        1.0)),
                                                        child: Text(
                                                          '${e['perApellidos']} ${e['perNombres']}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
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
                                    ),
                                  ],
                                );
                        },
                      ),
                        Consumer<GestionDocumentalController>(
                        builder: (_, value, __) {
                          return value.getLabelPerfil == '' ||
                                  value.getLabelPerfil == null
                              ? Container()
                              : Column(
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
                                              Text('Contenido: ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Consumer<
                                                  GestionDocumentalController>(
                                                builder: (_, value, __) {
                                                  return value
                                                          .getListaDeContenidos
                                                          .isNotEmpty
                                                      ? Text(
                                                          ' ${value.getListaDeContenidos.length}',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.7),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey))
                                                      : Container();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: size.iScreen(1.0)),
                                   
                                      ],
                                    ),
                                  ],
                                );
                        },
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.5),
                      ),
                      //***********************************************/
                
                 
                      Consumer<GestionDocumentalController>(builder: (_, valueListaContenidos, __) { 
                
                        return  Wrap(children: valueListaContenidos.getListaDeContenidos.map((e) {
                        
                          return Card(
                        child:
                            ExpansionTile( 
                          title: Text('${e['cabecera']}'), children: [
                          Padding(
                            padding: EdgeInsets.only(left:size.iScreen(3.0),right: size.iScreen(3.0),bottom: size.iScreen(3.0)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.wScreen(100.0),
                
                                    // color: Colors.blue,
                                    child: Text('Título: ',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey)),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  Container(
                                    width: size.wScreen(100.0),
                
                                    // color: Colors.blue,
                                    child: Text('${e['titulo']}',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            
                                            )),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                
                                  Container(
                                    width: size.wScreen(100.0),
                
                                    // color: Colors.blue,
                                    child: Text('Contenido: ',
                                        style: GoogleFonts.lexendDeca(
                                            // fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey
                                            ),
                                            ),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  Container(
                                    width: size.wScreen(100.0),
                
                                    // color: Colors.blue,
                                    child: Text('${e['contenido']}',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(2.0),
                                            fontWeight: FontWeight.normal,
                                            // color: Colors.grey,
                                            )),
                                  ),
                
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                
                                  Container(
                                    // width: size.wScreen(40),
                                    child: Container(
                                      alignment: Alignment.center,
                                      // width: size.wScreen(40),
                                      // height: size.hScreen(30),
                                      child: 
                                      Center(
                                        child:
                                            // Image.network(
                                            //   'https://via.placeholder.com/150',
                                            //   width: size.wScreen(100),
                                            //   height: size.hScreen(100),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            //*****************************************/
                
                                            Consumer<GestionDocumentalController>(
                                          builder: (_, valueUrl, __) {
                                            return
                                             e['foto'].isNotEmpty?Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: size.wScreen(100.0),
                
                                                  // color: Colors.blue,
                                                  child: Text('Foto:',
                                                      style:
                                                          GoogleFonts.lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                                SizedBox(
                                                  height: size.iScreen(1.0),
                                                ),
                                                Consumer<
                                                    GestionDocumentalController>(
                                                  builder: (context,
                                                      imageProvider, child) {
                                                    return
                                                    //  Container(
                                                    //     width: size.wScreen(50.0),
                
                                                    //   child: Image.file(File(e['foto'])),
                                                    // );
                                  //                     Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: size.iScreen(1.5)),
                                  //   child: FadeInImage(
                                  //     placeholder: const AssetImage(
                                  //         'assets/imgs/loader.gif'),
                                  //     image: NetworkImage('${e['foto']}'),
                                  //   ),
                                  // );
                                   Center(
            child: Image.network(
              '${e['foto']}',
              errorBuilder: (context, error, stackTrace) {
                print('Error al cargar la imagen: $error');
                return 
                Icon(
                  Icons.error_outline,
                  size: size.iScreen(4.0),
                  color: Colors.red,
                );
              },
            ),
          );
                                                  },
                                                )
                                              ],
                                            ):Container();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  //***********************************************/
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //***********************************************/
                                ],
                              ),
                            ),
                          ),
                        ]),
                      );
                        },
                    ).toList());
                       },),
                 
                      
                    
                  ],
                ),
              ),)),
      ),
    );
  }
}