import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/models/lista_allConsignas_clientes.dart';
import 'package:nseguridad/src/theme/themes_app.dart';


import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';

class ConsignaLeidaClientePage extends StatelessWidget {
  final Result? infoConsignaCliente;

  const ConsignaLeidaClientePage({Key? key, this.infoConsignaCliente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    final consignasController = Provider.of<ConsignasController>(context);
      final ctrlTheme = context.read<ThemeApp>();
       

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
            // color: Colors.red,
            margin: EdgeInsets.only(top: size.iScreen(3.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: SingleChildScrollView(
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
                            infoConsignaCliente!.conFecReg
                                .toString()
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
                      '"${infoConsignaCliente!.conAsunto}"',
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
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${infoConsignaCliente!.conDetalle}',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  (infoConsignaCliente!.conFotosCliente!.isNotEmpty)
                      ? _CamaraOption(
                          size: size,
                          consignaController: consignasController,
                          infoConsignaCliente: infoConsignaCliente!)
                      : Container(),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    child: Text(
                      'Fecha:',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //*****************************************/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Desde:',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // width: size.wScreen(35),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(0.5)),
                            child: Text(
                              infoConsignaCliente!.conDesde
                                  .toString()
                                  .replaceAll(" 00:00:00.000", ""),
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Hasta:',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            // width: size.wScreen(35),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.wScreen(0.5)),
                            child: Text(
                              infoConsignaCliente!.conHasta
                                  .toString()
                                  .replaceAll(" 00:00:00.000", ""),
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

                  //*****************************************/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Frecuencia: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${infoConsignaCliente!.conFrecuencia}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Prioridad: ',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${infoConsignaCliente!.conPrioridad}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    child: Text(
                      'Repetir:',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

//***********************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    height: size.iScreen(5.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: infoConsignaCliente!.conDiasRepetir!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String dia =
                            infoConsignaCliente!.conDiasRepetir![index];

                        return Container(
                          width: size.iScreen(5.0),
                          height: size.iScreen(5.0),
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(1.8),
                          ),
                          // padding: EdgeInsets.all(size.iScreen(1.0)),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              dia.substring(0, 2),
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),

//*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    child: Text(
                      'Asignado a:',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(1.8),
                        color: Colors.black45,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //***********************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    height: size.wScreen(10.0 *
                        5.8), //Calcular el tamanio depende al numero de elementos de la lista
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: infoConsignaCliente!.conAsignacion!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final guardia =
                            infoConsignaCliente!.conAsignacion![index];
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: EdgeInsets.only(bottom: size.iScreen(0.5)),
                            padding: EdgeInsets.only(
                                top: size.iScreen(0.9),
                                left: size.iScreen(0.5),
                                right: size.iScreen(0.5),
                                bottom: size.iScreen(0.9)),
                            // width: size.wScreen(100.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${guardia.nombres}',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                // const Icon(Icons.chevron_right_outlined),
                              ],
                            ));
                      },
                    ),
                  )

                  //***********************************************/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CamaraOption extends StatelessWidget {
  final ConsignasController consignaController;
  final Result infoConsignaCliente;
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
                children: infoConsignaCliente.conFotosCliente!.map((e) {
              return Stack(
                children: [
                  GestureDetector(
                    // child: Hero(
                    //   tag: image!.id,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(2.0),
                          vertical: size.iScreen(1.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(),
                          width: size.wScreen(35.0),
                          height: size.hScreen(20.0),
                          padding: EdgeInsets.symmetric(
                            vertical: size.iScreen(0.0),
                            horizontal: size.iScreen(0.0),
                          ),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/imgs/loader.gif'),
                            image: NetworkImage('${e.url}'),
                          ),
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
