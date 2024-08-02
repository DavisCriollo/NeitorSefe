import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/controllers/consignas_clientes_controller.dart';
import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/detalle_consigna_realizada_guardia.dart';

import 'package:nseguridad/src/pages/realizar_consigna_guardia.dart';

import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';


import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';

class ConsignaLeidaGuardiaPage extends StatelessWidget {
  final dynamic infoConsignaCliente;
  final Session? user;

  const ConsignaLeidaGuardiaPage({Key? key, this.infoConsignaCliente, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    // print('PASAMOS  LA INFO:${user!.nombre}');
    //  String fechaLocalDesde = trabajo['fecha']==''?'--- --- ':DateUtility.fechaLocalConvert( trabajo['fecha']!.toString());
    //  String fechaLocalhasta = trabajo['fecha']==''?'--- --- ':DateUtility.fechaLocalConvert( trabajo['fecha']!.toString());
  final ctrlTheme = context.read<ThemeApp>();
        
final List<dynamic> _listaTrabajos = [];
 int? _numTrabajos=0;

    final consignasController = Provider.of<ConsignasController>(context);

    final fechaRegistro =
        DateTime.parse(infoConsignaCliente['conFecReg']).toLocal();
        final List _listFecha=infoConsignaCliente!['conFechasConsignaConsultaDB'];
  if( infoConsignaCliente['conGuardias'] != []){
    
        for (var item in infoConsignaCliente['conGuardias']) {
          if(item['perDocNumero']==user!.usuario)
          {
          _numTrabajos=item['trabajos'].length;
          }
          
        }


  }
  else  if( infoConsignaCliente['conSupervisores'] != []){
    
        for (var item in infoConsignaCliente['conSupervisores']) {
          if(item['perDocNumero']==user!.usuario)
          {
          _numTrabajos=item['trabajos'].length;
          }
          
        }   }
else  if( infoConsignaCliente['conAdministracion'] != []){
    
        for (var item in infoConsignaCliente['conAdministracion']) {
          if(item['perDocNumero']==user!.usuario)
          {
          _numTrabajos=item['trabajos'].length;
          }
          
        }   }


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
              'Detalle de Consigna',
              // style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.iScreen(1.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child:
            
           
            
            
            
             SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Text('Asunto:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        Spacer(),
                        Text(
                            fechaRegistro
                                .toString()
                                .substring(0, 16)
                                .replaceAll(".000Z", ""),
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.1)),
                    width: size.wScreen(100.0),
                    child: Text(
                      // 'item Novedad: ${controllerActividades.getItemMulta}',
                      '"${infoConsignaCliente!['conAsunto']}"',
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
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Detalle:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child: Text(
                      ' ${infoConsignaCliente!['conDetalle']}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Text('Trabajos realizados: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        Text(' $_numTrabajos',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.bold,
                                // color: Colors.grey,
                                )),
                      ],
                    ),
                  ),
                  
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Column(


                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Container(
                            width: size.wScreen(100.0),
                          child: Text('Fecha de consigna:',
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
                        Row(


                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                
                                // color: Colors.red,
                                child: Text('Desde:     ',
                                style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // color: Colors.blue,
                                child: Text('     Hasta:',
                                style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                    width: size.wScreen(100.0),
                    child:
                 
                    Wrap(
                      children:
                      _listFecha.map((e) {
                            String fechaLocalDesde = e['desde']==''?'--- --- ':DateUtility.fechaLocalConvert( e['desde']!.toString());
                            String fechaLocalHasta = e['hasta']==''?'--- --- ':DateUtility.fechaLocalConvert( e['hasta']!.toString());
                        return Container(
                         margin: EdgeInsets.symmetric(vertical: size.iScreen(0.2)),
                         padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(0.5)),

                          // color:Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            // Text(e['desde'] .replaceAll("T", " ").toString(),//.substring(0,16),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(0.5)),
                              color:Colors.grey.shade200,
                              child: Text(fechaLocalDesde,//.substring(0,16),
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                            )),
                            ),
                            Container(
                              color:Colors.grey.shade200,
                              child: Text(fechaLocalHasta,
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            fontWeight: FontWeight.normal,
                                            )),
                            ),
                          ],
                        ),
                      );
                      },).toList()
                    ),
                  ),


                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.5),
                  ),
                  //*****************************************/
                  SizedBox(
                    width: size.iScreen(1.5),
                  ),
                  //*****************************************/
                  (infoConsignaCliente!['conDocumento']!.isNotEmpty)
                      ? Container(
                          // padding: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                          color: Colors.grey[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  // '${valueFiles.getFilesPicker!.name.toString()}  - ${valueFiles.getSizeFile} ',
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
                                                  '${infoConsignaCliente!['conDocumento']}',
                                              labelPdf: 'archivo.pdf')),
                                    );
                                  },
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined))
                            ],
                          ),
                        )
                      : Container(),
                  (infoConsignaCliente!['conFotosCliente']!.isNotEmpty)
                      ? _CamaraOption(
                          size: size,
                          consignaController: consignasController,
                          infoConsignaCliente: infoConsignaCliente!)
                      : Container(),

                  //***********************************************/ hasta aqui
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

//*****************************************/
                  //***********************************************/
                ],
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetalleConsignasRealizadasGuardias(
                          idConsigna: infoConsignaCliente['conId'],
                          user: user,)));
                },
                heroTag: "btnVisualizar",
                child: const Icon(Icons.content_paste_search_outlined),
              ),
              SizedBox(
                height: size.iScreen(1.5),
              ),
              FloatingActionButton(
                backgroundColor: primaryColor,
                heroTag: "btnRealizar",
                onPressed: () {
                  context
                      .read<ConsignasClientesController>()
                      .resetVariablesRealizarConsigna();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RealizarConsignaPage(
                          infoConsignaGuardia: infoConsignaCliente))).then((value) => consignasController.getTodasLasConsignasClientes('','false'));
                },
                child: const Icon(Icons.rate_review_outlined),
              ),

              //***********************************************/
              SizedBox(
                height: size.iScreen(2.0),
              ),
              //*****************************************/
            ],
          ),
        ),
      ),
    );
  }
}

class _CamaraOption extends StatelessWidget {
  final ConsignasController consignaController;
  final Map<String, dynamic> infoConsignaCliente;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.consignaController,
    required this.infoConsignaCliente,
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
            child: Text('Fotografía:',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
            child: Wrap(
                children:
                    (infoConsignaCliente['conFotosCliente']! as List).map((e) {
              return Stack(
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      child: ClipRRect(
                        child: Container(
                          decoration: const BoxDecoration(),
                          padding: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.0),
                            horizontal: size.iScreen(0.0),
                          ),
                          child: getImage(e['url']),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            }).toList()),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}

Widget? getImage(String? picture) {
  if (picture == null) {
    return InteractiveViewer(
        child: Image.asset('assets/imgs/no-image.png', fit: BoxFit.cover));
  }
  if (picture.startsWith('http')) {
    return InteractiveViewer(
      child: FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/imgs/loader.gif'),
        image: NetworkImage(picture),
      ),
    );
  }

  return InteractiveViewer(
    child: Image.file(
      File(picture),
      fit: BoxFit.cover,
    ),
  );
}
