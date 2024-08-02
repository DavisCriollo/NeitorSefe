import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/consignas_clientes_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

import '../models/lista_allConsignas_clientes.dart';

class DetalleConsignasRealizadasGuardias extends StatefulWidget {
  final int? idConsigna;
  final Session? user;
  const DetalleConsignasRealizadasGuardias({Key? key, this.idConsigna, this.user})
      : super(key: key);

  @override
  State<DetalleConsignasRealizadasGuardias> createState() =>
      _DetalleConsignasRealizadasGuardiasState();
}

class _DetalleConsignasRealizadasGuardiasState
    extends State<DetalleConsignasRealizadasGuardias> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrlTheme = context.read<ThemeApp>();
         
final controllerConsigna=Provider.of<ConsignasClientesController>(context ,listen: false);

  final _infoConsigna = [];
    final List<dynamic> _listaTrabajos = [];
    return SafeArea(
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
          title:  Text('Trabajos Realizados',
          // style:  Theme.of(context).textTheme.headline2,
          ),
        ),
        body: FutureBuilder(
          future: controllerConsigna.getTodasLasConsignasClientes('','false'),
             builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            for (var e in controllerConsigna.getListaTodasLasConsignasCliente) {

              
              // if (e['conId'] == widget.idConsigna) {
              //   _infoConsigna.addAll(e['data['msg']']);
              //   for (var item in _infoConsigna) {
              //   _listaTrabajos.addAll(item['trabajos']);
                  
              //   }

              if (e['conId'] == widget.idConsigna && widget.user!.rol!.contains('GUARDIA')) {
                _infoConsigna.addAll(e['conGuardias']);

              
             } else if (e['conId'] == widget.idConsigna && widget.user!.rol!.contains('SUPERVISOR')) {
                     _infoConsigna.addAll(e['conSupervisores']);
              }else if (e['conId'] == widget.idConsigna && widget.user!.rol!.contains('ADMINISTRACION')) {
                   _infoConsigna.addAll(e['conAdministracion']);
              }

              // if (e['conId'] == widget.idConsigna && widget.user!.rol!.contains('GUARDIA')) {
              //   _infoConsigna.addAll(e['conGuardias']);
              
                
                for (var item in _infoConsigna) {
                _listaTrabajos.addAll(item['trabajos']);
                  
                }
           
       
    
    return _listaTrabajos.isNotEmpty
    ?SizedBox(
       width: size.wScreen(100.0),
        height: size.hScreen(100),
      child:   ListView.builder(
      itemCount: _listaTrabajos.length,
      itemBuilder: (BuildContext context, int index) {
         final trabajo = _listaTrabajos[index];
// final _data=DateTime.parse((trabajo['fecha']))
// final _fecha='${_data.year}-${_data.month}-${_data.day}';
// final _fecha=DateTime.parse((trabajo['fecha']));
  String fechaLocal = trabajo['fecha']==''?'--- --- ':DateUtility.fechaLocalConvert( trabajo['fecha']!.toString());

        return 
        Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.iScreen(1.5),
                        vertical: size.iScreen(0.5)),
                    child: Column(
                      children: [
                        Column(
                          children: [
                          
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.0)),
                                    // width: size.wScreen(100.0),
                                    child: Text(
                                      'Detalle: ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.grey,
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
                                      '${trabajo['detalle']}',
                                      // overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.0)),
                                    // width: size.wScreen(100.0),
                                    child: Text(
                                      'fecha: ',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    margin: EdgeInsets.only(
                                        top: size.iScreen(0.5),
                                        bottom: size.iScreen(0.0)),
                                    width: size.wScreen(60.0),
                                   child:
                                    // Text(_fecha.toString(,
                                    Text(fechaLocal.toString().replaceAll(".", " ").toString().substring(0,16),
                                //       '${trabajo['fecha'].timeZoneName
                                // .replaceAll("T", " ")
                                // .replaceAll(".000Z", " ")}',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.5),
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                           
                             //==========================================//
                      trabajo['fotos'].isNotEmpty
                          ? _CamaraOption(
                              size: size, trabajo:trabajo)
                          : Container(),
                      //*****************************************/
                          ],
                        ),
                     
                      ],
                    ),
                  ),
                );
      },
      ),
    ):const NoData(label: 'No ha realizado consigna');
    
    
  
              }
        
            }
          // }
          // else{

          // return const Text( 'No ha realizado Consigna');
          // }
                   
          return const Text( 'No ha realizado Consigna');
          // return const NoData(label: 'No ha realizado Consigna');
          }
        ),
      ),
    );
  }
}


class _CamaraOption extends StatelessWidget {
 dynamic trabajo;
   _CamaraOption({
    Key? key,
    required this.size,
   
    required this.trabajo,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: size.wScreen(100.0),
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografías: ${trabajo!['fotos'].length}',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
            child:
               Wrap(
                children: (trabajo!['fotos']as List).map((e) {



              return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.1),
                          vertical: size.iScreen(1.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(
                            // color: Colors.red,
                            // border: Border.all(color: Colors.grey),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                          width: size.wScreen(100.0),
                          // height: size.hScreen(20.0),
                          padding: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.0),
                            horizontal: size.iScreen(0.0),
                          ),
                          child:  FadeInImage(
                            placeholder: const AssetImage('assets/imgs/loader.gif'),
                            image: NetworkImage(e['url']),
                          ),
                        ),
                      ),
                    );
            }).toList()),
          
          
          ),
        ],
      ),
      onTap: () {
        // print('activa FOTOGRAFIA');
      },
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return const FadeInImage(
      placeholder: AssetImage('assets/imgs/loader.gif'),
      image: NetworkImage('url'),
    );
  }

  return Image.file(
    File(picture),
    fit: BoxFit.cover,
  );
}

