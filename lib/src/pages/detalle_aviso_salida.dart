import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
// import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleAvisoSalida extends StatelessWidget {
  const DetalleAvisoSalida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<AvisoSalidaController>();
    final _user = context.read<HomeController>();
      final ctrlTheme = context.read<ThemeApp>();
        
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
                'Detalle Aviso Salida',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: Container(
              // color: Colors.green,
              margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //*****************************************/
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
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//

                    Row(
                      children: [
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Fecha Registro: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                          // width: size.wScreen(100.0),
                          child: Text(
                            infoContrtoller.getInfoAvisoSalida['nomFecha']
                                // .toLocal()
                                .toString()
                                // .substring(0, 16)
                                .replaceAll(".000Z", "")
                                .replaceAll("T", " "),
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey,
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          // width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Estado:',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                          // width: size.wScreen(100.0),
                          child: Text(
                            ' ${infoContrtoller.getInfoAvisoSalida['nomEstado']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: infoContrtoller
                                            .getInfoAvisoSalida!['nomEstado'] ==
                                        'APROBADO'
                                    ? secondaryColor
                                    : infoContrtoller.getInfoAvisoSalida![
                                                'nomEstado'] ==
                                            'EN PROCESO'
                                        ? tercearyColor
                                        : infoContrtoller.getInfoAvisoSalida![
                                                    'nomEstado'] ==
                                                'ANULADA'
                                            ? Colors.red
                                            : infoContrtoller
                                                            .getInfoAvisoSalida![
                                                        'nomEstado'] ==
                                                    'ASIGNADA'
                                                ? primaryColor
                                                : Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    //***********************************************/

                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              //  width: size.wScreen(100.0),
                              child: Text(
                                'Documento: ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Text(
                              '${infoContrtoller.getInfoAvisoSalida['nomDocuPersona']}',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  // color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Guardia: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          width: size.wScreen(100.0),
                          // '${infoContrtoller.getInfoPuesto['camDocuPersona']}',

                          child: Text(
                            '${infoContrtoller.nombreGuardia}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//
                    //==========================================//
                    Column(
                      children: [
                        SizedBox(
                          width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Motivo: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          width: size.wScreen(100.0),
                          // '${infoContrtoller.getInfoPuesto['camDocuPersona']}',

                          child: Text(
                            '${infoContrtoller.labelAvisoSalida}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),

                   
                    infoContrtoller.getInfoAvisoSalida['nomFechas'].isNotEmpty
                        ? Column(
                            children: [
//*****************************************/

                              SizedBox(
                                height: size.iScreen(0.0),
                              ),
                              //==========================================//
                              SizedBox(
                                width: size.wScreen(100.0),
                                // color: Colors.blue,
                                child: Text('Fechas: ',
                                    style: GoogleFonts.lexendDeca(
                                        // fontSize: size.iScreen(2.0),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: (infoContrtoller
                                            .getInfoAvisoSalida['nomFechas']
                                        as List)
                                    .map((e) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.0)),
                                        child: Chip(
                                            label: Text(
                                          '$e',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: size.iScreen(1.8),
                                            // color: Colors.black45,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ))))
                                    .toList(),
                              )
                            ],
                          )
                        : Container(),
                         //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//
                    Column(
                      children: [
                        SizedBox(
                          width: size.wScreen(100.0),
                          // color: Colors.blue,
                          child: Text('Detalle: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          width: size.wScreen(100.0),
                          child: Text(
                            '${infoContrtoller.getInputDetalle}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    //==========================================//

                    infoContrtoller.getInfoAvisoSalida['nomFotos']!.isNotEmpty
                        ? SizedBox(
                            width: size.wScreen(100.0),
                            // color: Colors.blue,
                            child: Text(
                                'Fotos:  ${infoContrtoller.getInfoAvisoSalida['nomFotos']!.length}',
                                style: GoogleFonts.lexendDeca(
                                    // fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                          )
                        : Container(),
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    infoContrtoller.getInfoAvisoSalida['nomFotos']!.isNotEmpty
                        ? SizedBox(
                            child: ListView.builder(
                              itemCount: infoContrtoller
                                  .getInfoAvisoSalida['nomFotos']!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),
                                      image: NetworkImage(
                                        '${infoContrtoller.getInfoAvisoSalida['nomFotos']![index]['url']}',
                                      ),
                                    ),
                                    //*****************************************/

                                    SizedBox(
                                      height: size.iScreen(1.0),
                                    ),
                                    //*****************************************/
                                  ],
                                );
                              },
                            ),
                            height: size.iScreen(infoContrtoller
                                    .getInfoAvisoSalida['nomFotos']!.length
                                    .toDouble() *
                                36.0),
                          )
                        : Container(),
                    // // //*****************************************/

                    infoContrtoller.getInfoAvisoSalida['nomVideos']!.isNotEmpty
                        ? _CamaraVideo(
                            size: size,
                            // informeController: informeController,
                            video: infoContrtoller
                                .getInfoAvisoSalida['nomVideos']!)
                        : Container(),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(3.0),
                    ),

                    //*****************************************/
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class _CamaraVideo extends StatelessWidget {
  final dynamic video;
  const _CamaraVideo({
    Key? key,
    required this.size,
    //required this.informeController,
    required this.video,
    // required this.videoController,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.wScreen(100.0),
          // color: Colors.blue,
          margin: EdgeInsets.symmetric(
            vertical: size.iScreen(1.0),
            horizontal: size.iScreen(0.0),
          ),
          child: Text('Video:',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        AspectRatio(
          aspectRatio: 16 / 16,
          child: BetterPlayer.network(
            '${video!['nomVideos']![0]['url']}',
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 16,
            ),
          ),
        )
      ],
    );
  }
}
