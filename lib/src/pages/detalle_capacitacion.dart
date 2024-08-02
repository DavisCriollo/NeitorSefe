import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/capacitaciones_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleDeCapacitacion extends StatelessWidget {
  final Session? usuario;
  const DetalleDeCapacitacion({Key? key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _controller = context.read<CapacitacionesController>();
      final ctrlTheme = context.read<ThemeApp>();
         
    // print('USUARIO: ${usuario!.nombre}');
Map<String,dynamic> _infoCapacitado={};
if(int.parse(usuario!.id.toString()) !=
                                    int.parse(_controller.getDataCapacitacion['capaIdCapacitador']
                                        .toString())){
                                           //===========================//

                        
                              if (usuario!.rol!.contains('GUARDIA')) {
                                for (var item
                                    in _controller.getDataCapacitacion['capaGuardias']) {
                                  if (usuario!.usuario == item['perDocNumero']) {
                                   _infoCapacitado.addAll(item);
                                  } else {
                                   _infoCapacitado={};
                                  }
                                }
                              } else if (usuario!.rol!
                                  .contains('SUPERVISOR')) {
                                for (var item
                                    in _controller.getDataCapacitacion['capaSupervisores']) {
                                   if (usuario!.usuario == item['perDocNumero']) {
                                   _infoCapacitado.addAll(item);
                                  } else {
                                   _infoCapacitado={};
                                  }
                                }
                              } else if (usuario!.rol!
                                  .contains('ADMINISTRACION')) {
                                for (var item
                                    in _controller.getDataCapacitacion['capaAdministracion']) {
                                  if (usuario!.usuario == item['perDocNumero']) {
                                   _infoCapacitado.addAll(item);
                                  } else {
                                   _infoCapacitado={};
                                  }
                                }
                              }

                           




                                        }



    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
              'Detalle de Capacitación',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: Container(
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
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //***********************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Título:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        Container(
                        child: Text(
                            _controller.getDataCapacitacion['capaFecReg']
                                .toString()
                                .replaceAll("T", "  ")
                                .replaceAll(".000Z", " "),
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '"${_controller.getDataCapacitacion['capaTitulo']}"',
                      textAlign: TextAlign.center,
                      //
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.3),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //***********************************************/
                  Column(
                    children: [
                      Container(
                        width: size.wScreen(100.0),

                       child: Text('Capacitador :',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                          '${_controller.getDataCapacitacion['capaNombreCapacitador']} ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(0.5),
                      ),
                      //*****************************************/
                    ],
                  ),
                 
                  // //***********************************************/
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        // width: size.wScreen(100.0),
                        child: Text(
                          'Fecha Emisión:  ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.5),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                       child: Text(
                          _controller.getDataCapacitacion['capaFecDesde']
                              .toString()
                              .replaceAll("T", " "),
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.7),
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
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                       child: Text(
                          'Fecha Finalización: ',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(1.5),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          _controller.getDataCapacitacion['capaFecHasta']
                              .toString()
                              .replaceAll("T", " "),
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.7),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  //***********************************************/
                  _controller.getDataCapacitacion['capaDocumento'] == '' ||
                          _controller.getDataCapacitacion['capaDocumento'] ==
                              null ||
                          _controller
                              .getDataCapacitacion['capaDocumento'].isEmpty
                      ? Container()
                      : Column(
                          children: [
                            //*****************************************/

                            SizedBox(
                              height: size.iScreen(1.0),
                            ),
                            //*****************************************/
                            Container(
                             color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Ver Documento ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54)),
                                  IconButton(
                                      onPressed: () {
                                      
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewsPDFs(
                                                  infoPdf:
                                                      '${_controller.getDataCapacitacion['capaDocumento']}',
                                                  labelPdf: 'archivo.pdf')),
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.remove_red_eye_outlined))
                                ],
                              ),
                            ),
                          ],
                        ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Estado: ',
                          style: GoogleFonts.lexendDeca(
                             color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                       child: Text(
                          _controller.getDataCapacitacion['capaEstado'],
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.7),
                              color: _controller
                                          .getDataCapacitacion['capaEstado'] ==
                                      'FINALIZADA'
                                  ? secondaryColor
                                  : _controller.getDataCapacitacion[
                                              'capaEstado'] ==
                                          'ACTIVA'
                                      ? tercearyColor
                                      : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //***********************************************/
                  Column(
                    children: [
                      Container(
                        width: size.wScreen(100.0),

                        child: Text('Detalle :',
                            style: GoogleFonts.lexendDeca(
                               fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                       width: size.wScreen(100.0),
                        child: Text(
                          _controller.getDataCapacitacion['capaDetalles']==''||  _controller.getDataCapacitacion['capaDetalles']==null?'-- -- -- -- -- -- -- -- -- --   ':'${_controller.getDataCapacitacion['capaDetalles']} ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(0.5),
                      ),
                      //*****************************************/
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.5),
                  ),
                  //***********************************************/

                //=============================================//

                 _infoCapacitado.isNotEmpty
                 ?    Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100.0),
                                          child: Row(
                                            children: [
                                              Text('${_infoCapacitado['perDocNumero']} ',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text('Asistencia: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                  Text(
                                                      _infoCapacitado['asistencia']
                                                          ? 'SI   '
                                                          : 'NO   ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: _infoCapacitado[
                                                                      'asistencia']
                                                                  ? secondaryColor
                                                                  : Colors
                                                                      .red)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //***********************************************/
                                        SizedBox(
                                          height: size.iScreen(0.5),
                                        ),
                                        //*****************************************/
                                        Container(
                                          // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                          width: size.wScreen(100.0),
                                          child: Text(
                                            '${_infoCapacitado['perApellidos']} ${_infoCapacitado['perNombres']} ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                // color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        _infoCapacitado['perFoto'].isNotEmpty ||
                                                _infoCapacitado['perFoto'] != ''
                                            ? Column(
                                                children: [
                                                  //***********************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.5),
                                                  ),
                                                  //*****************************************/
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    child: FadeInImage(
                                                      placeholder: const AssetImage(
                                                          'assets/imgs/loader.gif'),
                                                      image: NetworkImage(
                                                        '${_infoCapacitado['perFoto']}}',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),

                                        //***********************************************/
                                        Divider(),
                                      ],
                                    ):Container(),






                //=============================================//





                int.parse(usuario!.id.toString()) ==
                                    int.parse(_controller.getDataCapacitacion['capaIdCapacitador']
                                        .toString())?   Column(
                    children: [
                      Container(
                        width: size.wScreen(100.0),
                       child: Text(' Nómina',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey,
                            )),
                      ),
                            //******************** MUESTRA LISTA DE GUARDIAS ***************************/
                  _controller.getDataCapacitacion['capaGuardias'].isNotEmpty
                      ? Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.5),
                            ),
                            //***********************************************/
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5)),
                              width: size.wScreen(100.0),
                             color: Colors.grey[300],
                              child: Text(
                                  ' Guardias: ${_controller.getDataCapacitacion['capaGuardias'].length}',
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
                            Wrap(
                              children: (_controller
                                          .getDataCapacitacion['capaGuardias']
                                      as List)
                                  .map(
                                    (e) => Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100.0),
                                          child: Row(
                                            children: [
                                              Text('${e['perDocNumero']} ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text('Asistencia: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                  Text(
                                                      e['asistencia']
                                                          ? 'SI   '
                                                          : 'NO   ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: e[
                                                                      'asistencia']
                                                                  ? secondaryColor
                                                                  : Colors
                                                                      .red)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //***********************************************/
                                        SizedBox(
                                          height: size.iScreen(0.5),
                                        ),
                                        //*****************************************/
                                        Container(
                                         width: size.wScreen(100.0),
                                          child: Text(
                                            '${e['perApellidos']} ${e['perNombres']} ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                // color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),

                                        e['perFoto'].isNotEmpty ||
                                                e['perFoto'] != ''
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    child: FadeInImage(
                                                      placeholder: const AssetImage(
                                                          'assets/imgs/loader.gif'),
                                                      image: NetworkImage(
                                                        '${e['perFoto']}}',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),

                                        //***********************************************/
                                        Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            //*****************************************/
                          ],
                        )
                      : Container(),
                        //******************** MUESTRA LISTA DE SUPERVISORES ***************************/
                  _controller.getDataCapacitacion['capaSupervisores'].isNotEmpty
                      ? Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //***********************************************/
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5)),
                              width: size.wScreen(100.0),
                              color: Colors.grey[300],
                              child: Text(
                                  ' Supervisores: ${_controller.getDataCapacitacion['capaSupervisores'].length}',
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
                            Wrap(
                              children: (_controller.getDataCapacitacion[
                                      'capaSupervisores'] as List)
                                  .map(
                                    (e) => Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100.0),
                                          child: Row(
                                            children: [
                                              Text('${e['perDocNumero']} ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text('Asistencia: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                  Text(
                                                      e['asistencia']
                                                          ? 'SI   '
                                                          : 'NO   ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: e[
                                                                      'asistencia']
                                                                  ? secondaryColor
                                                                  : Colors
                                                                      .red)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //***********************************************/
                                        SizedBox(
                                          height: size.iScreen(0.5),
                                        ),
                                        //*****************************************/
                                        Container(
                                          // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                          width: size.wScreen(100.0),
                                          child: Text(
                                            '${e['perApellidos']} ${e['perNombres']} ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                // color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        e['perFoto'].isNotEmpty ||
                                                e['perFoto'] != ''
                                            ? Column(
                                                children: [
                                                  //***********************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.5),
                                                  ),
                                                  //*****************************************/
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    child: FadeInImage(
                                                      placeholder: const AssetImage(
                                                          'assets/imgs/loader.gif'),
                                                      image: NetworkImage(
                                                        '${e['perFoto']}}',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),

                                        //***********************************************/
                                        Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            //*****************************************/
                          ],
                        )
                      : Container(),
                  //******************** MUESTRA LISTA DE ADMINISTRADORES ***************************/
                  _controller
                          .getDataCapacitacion['capaAdministracion'].isNotEmpty
                      ? Column(
                          children: [
                            //***********************************************/
                            SizedBox(
                              height: size.iScreen(0.5),
                            ),
                            //***********************************************/
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.iScreen(0.5)),
                              width: size.wScreen(100.0),
                              // alignment: Alignment.center,
                              color: Colors.grey[300],
                              child: Text(
                                  ' Administradores: ${_controller.getDataCapacitacion['capaAdministracion'].length}',
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
                            Wrap(
                              children: (_controller.getDataCapacitacion[
                                      'capaAdministracion'] as List)
                                  .map(
                                    (e) => 
                                    Column(
                                      children: [
                                        Container(
                                          width: size.wScreen(100.0),
                                          child: Row(
                                            children: [
                                              Text('${e['perDocNumero']} ',
                                                  style: GoogleFonts.lexendDeca(
                                                      // fontSize: size.iScreen(2.0),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey)),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text('Asistencia: ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey)),
                                                  Text(
                                                      e['asistencia']
                                                          ? 'SI   '
                                                          : 'NO   ',
                                                      style: GoogleFonts
                                                          .lexendDeca(
                                                              // fontSize: size.iScreen(2.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: e[
                                                                      'asistencia']
                                                                  ? secondaryColor
                                                                  : Colors
                                                                      .red)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //***********************************************/
                                        SizedBox(
                                          height: size.iScreen(0.5),
                                        ),
                                        //*****************************************/
                                        Container(
                                          // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                          width: size.wScreen(100.0),
                                          child: Text(
                                            '${e['perApellidos']} ${e['perNombres']} ',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                // color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        e['perFoto'].isNotEmpty ||
                                                e['perFoto'] != ''
                                            ? Column(
                                                children: [
                                                  //***********************************************/
                                                  SizedBox(
                                                    height: size.iScreen(0.5),
                                                  ),
                                                  //*****************************************/
                                                  Container(
                                                    width: size.wScreen(100.0),
                                                    child: FadeInImage(
                                                      placeholder: const AssetImage(
                                                          'assets/imgs/loader.gif'),
                                                      image: NetworkImage(
                                                        '${e['perFoto']}}',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),

                                        //***********************************************/
                                        Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            //*****************************************/
                          ],
                        )
                      : Container(),
                    ],
                  ):Container(),

            
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
