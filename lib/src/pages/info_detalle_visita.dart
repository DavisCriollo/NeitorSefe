import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/pages/view_image_generic.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class InfoVisita extends StatelessWidget {
  const InfoVisita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
    final _ctrlBitacora = context.read<BitacoraController>();
    final ctrlTheme = context.read<ThemeApp>();
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Detalle de Visitante',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: size.iScreen(0.0)),
        padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
        width: size.wScreen(100.0),
        height: size.hScreen(100),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
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
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.iScreen(0.0), vertical: size.iScreen(0)),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.iScreen(1.0), vertical: size.iScreen(0.0)),
                child: Column(
                  children: [
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Nombre:',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),

                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      child: Text(
                          '${_ctrlBitacora.getInfoVisita['bitVisitanteNombres']}',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey
                          )),
                    ),
                    //  Container(
                    //     width: size.wScreen(100.0),
                    //     child: Row(
                    //       children: [
                    //         Text('Sexo: ',
                    //             style: GoogleFonts.lexendDeca(
                    //                 fontSize: size.iScreen(1.8),
                    //                 fontWeight: FontWeight.normal,
                    //                 color: Colors.grey)),
                    //                   Container(
                    //     // width: size.wScreen(100.0),
                    //     child: Text(
                    //         'NOMBRE',
                    //         style: GoogleFonts.lexendDeca(
                    //             fontSize: size.iScreen(1.8),
                    //             fontWeight: FontWeight.normal,
                    //             // color: Colors.grey
                    //             )),
                    //   ),
                    //       ],
                    //     ),
                    //   ),
                    Container(
                      width: size.wScreen(100.0),
                      child: Row(
                        children: [
                          Text('Documento: ',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                          Container(
                            // width: size.wScreen(100.0),
                            child: Text(
                                '${_ctrlBitacora.getInfoVisita['bitVisitanteCedula']}',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey
                                )),
                          ),
                        ],
                      ),
                    ),

                    //***********************************************/
                    // _ctrlBitacora.getInfoVisita['bitFotoCedulaFrontal']!=''
                    //   ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap:
                              _ctrlBitacora.getInfoVisita['bitFotoPersona'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                            title:'Foto Visitante',
                                            image:
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoPersona']}')));
                                    }
                                  : null,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey.shade300,
                              ),
                              width: size.iScreen(14.0),
                              height: size.iScreen(18.0),
                              child:
                                  //  valueListaVisitas.frontImage == null
                                  //     ? Icon(
                                  //         Icons.add_a_photo_outlined,
                                  //         size: size.iScreen(4.0),
                                  //       )
                                  //     :
                                  _ctrlBitacora.getInfoVisita[
                                              'bitFotoPersona'] !=
                                          ''
                                      ?
                                      // Image.file(File(_ctrlBitacora.getInfoVisita['bitFotoPersona']))
                                      Hero(
                                          tag:
                                              '${_ctrlBitacora.getInfoVisita['bitFotoPersona']}',
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                                'assets/imgs/loader.gif'),
                                            image: NetworkImage(
                                              '${_ctrlBitacora.getInfoVisita['bitFotoPersona']}',
                                            ),
                                          ),
                                        )
                                      : Image.asset('assets/imgs/no-image.png',
                                          fit: BoxFit.cover)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap:
                              _ctrlBitacora.getInfoVisita['bitFotoCedulaFrontal'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                             title:'Foto Cédula - Frontal',
                                              image:
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoCedulaFrontal']}')));
                                    }
                                  : null,
                              child: Container(
                                  margin: EdgeInsets.all(size.iScreen(0.5)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey.shade300,
                                  ),
                                  width: size.iScreen(17.0),
                                  height: size.iScreen(10.0),
                                  child:
                                      //  valueListaVisitas.frontImage == null
                                      //     ? Icon(
                                      //         Icons.add_a_photo_outlined,
                                      //         size: size.iScreen(4.0),
                                      //       )
                                      //     :
                                      //  Image.file(File(_ctrlBitacora.getInfoVisita['fotoCedula']['cedulaFront'])),
                                      _ctrlBitacora.getInfoVisita[
                                                  'bitFotoCedulaFrontal'] !=
                                              ''
                                          ? Hero(
                                             tag:
                                              '${_ctrlBitacora.getInfoVisita['bitFotoCedulaFrontal']}',
                                            child: FadeInImage(
                                                placeholder: const AssetImage(
                                                    'assets/imgs/loader.gif'),
                                                image: NetworkImage(
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoCedulaFrontal']}',
                                                ),
                                              ),
                                          )
                                          : Image.asset(
                                              'assets/imgs/no-image.png',
                                              fit: BoxFit.cover)),
                            ),
                            GestureDetector(
                             onTap: 
                              _ctrlBitacora.getInfoVisita['bitFotoCedulaReverso'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                              title:'Foto Cédula - Posterior',
                                              image:
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoCedulaReverso']}')));
                                    }
                                  : null,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey.shade300,
                                  ),
                                  width: size.iScreen(17.0),
                                  height: size.iScreen(10.0),
                                  child:
                                      // valueListaVisitas.backImage == null
                                      //     ? Icon(
                                      //         Icons.add_a_photo_outlined,
                                      //         size: size.iScreen(4.0),
                                      //       )
                                      //     :
                                      _ctrlBitacora.getInfoVisita[
                                                  'bitFotoCedulaReverso'] !=
                                              ''
                                          ? Hero(
                                            tag:
                                              '${_ctrlBitacora.getInfoVisita['bitFotoCedulaReverso']}',
                                            child: FadeInImage(
                                                placeholder: const AssetImage(
                                                    'assets/imgs/loader.gif'),
                                                image: NetworkImage(
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoCedulaReverso']}',
                                                ),
                                              ),
                                          )
                                          : Image.asset(
                                              'assets/imgs/no-image.png',
                                              fit: BoxFit.cover)
                                  // Image.file(File(_ctrlBitacora.getInfoVisita['fotoCedula']['cedulaBack'])),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // : Container(),

                    _ctrlBitacora.getInfoVisita['fotoPasaporte'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                 onTap: 
                              _ctrlBitacora.getInfoVisita['fotoVisitante'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                              title:'Foto Visitante',
                                              image:
                                                  '${_ctrlBitacora.getInfoVisita['fotoVisitante']}')));
                                    }
                                  : null,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade300,
                                    ),
                                    width: size.iScreen(14.0),
                                    height: size.iScreen(18.0),
                                    child:
                                        //  valueListaVisitas.frontImage == null
                                        //     ? Icon(
                                        //         Icons.add_a_photo_outlined,
                                        //         size: size.iScreen(4.0),
                                        //       )
                                        //     :
                                        _ctrlBitacora.getInfoVisita['fotoVisitante'] !=''
                                            ?
                                            // Image.file(File(_ctrlBitacora.getInfoVisita['fotoVisitante']))
                                            Hero(tag:
                                                '${_ctrlBitacora.getInfoVisita['fotoVisitante']}',
                                              child: FadeInImage(
                                                  placeholder: const AssetImage(
                                                      'assets/imgs/loader.gif'),
                                                  image: NetworkImage(
                                                    '${_ctrlBitacora.getInfoVisita['fotoVisitante']}',
                                                  ),
                                                ),
                                            )
                                            : Image.asset(
                                                'assets/imgs/no-image.png',
                                                fit: BoxFit.cover)),
                              ),
                              GestureDetector(
                               onTap: 
                              _ctrlBitacora.getInfoVisita['fotoPasaporte'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                              title:'Foto Pasaporte',
                                              image:
                                                  '${_ctrlBitacora.getInfoVisita['fotoPasaporte']}')));
                                    }
                                  : null,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade300,
                                    ),
                                    width: size.iScreen(18.0),
                                    height: size.iScreen(10.0),
                                    child:
                                        //  valueListaVisitas.pasaporteImage == null  && valueListaVisitas.pasaporteImage==''
                                        //     ? Icon(
                                        //         Icons.add_a_photo_outlined,
                                        //         size: size.iScreen(4.0),
                                        //       )
                                        //    :
                                        //  Image.file(File(_ctrlBitacora.getInfoVisita['fotoPasaporte'])),
                                        _ctrlBitacora.getInfoVisita[
                                                    'fotoPasaporte'] !=
                                                null
                                            ? Hero(
                                               tag: '${_ctrlBitacora.getInfoVisita['fotoPasaporte']}',
                                              child: FadeInImage(
                                                  placeholder: const AssetImage(
                                                      'assets/imgs/loader.gif'),
                                                  image: NetworkImage(
                                                    '${_ctrlBitacora.getInfoVisita['fotoPasaporte']}',
                                                  ),
                                                ),
                                            )
                                            : Image.asset(
                                                'assets/imgs/no-image.png',
                                                fit: BoxFit.cover)),
                              ),
                            ],
                          )
                        : Container(),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    _ctrlBitacora.getInfoVisita['bitPlaca'].isNotEmpty
                        ? Container(
                            width: size.wScreen(100.0),
                            child: Row(
                              children: [
                                Text('Vehículo: ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                                Container(
                                  // width: size.wScreen(100.0),
                                  child: Text(
                                      '${_ctrlBitacora.getInfoVisita['bitPlaca']}',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey
                                      )),
                                ),
                                _ctrlBitacora.getInfoVisita['vehiculo'] == 'NO'
                                    ? Container(
                                        // width: size.wScreen(100.0),
                                        margin: EdgeInsets.only(
                                            left: size.iScreen(5.0)),
                                        child: Text(
                                            '${_ctrlBitacora.getInfoVisita['vehiculo']}',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.bold,
                                              // color: Colors.grey
                                            )),
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    _ctrlBitacora.getInfoVisita['bitInformacionVehiculo']
                                ['model'] !=
                            ''
                        ? Column(
                            children: [
                              Container(
                                width: size.wScreen(100.0),
                                child: Text('Modelo: ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              SizedBox(
                                height: size.iScreen(0.5),
                              ),
                              Container(
                                width: size.wScreen(100.0),
                                child: Text(
                                    '${_ctrlBitacora.getInfoVisita['bitInformacionVehiculo']['model']}',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.grey
                                    )),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                            ],
                          )
                        : Container(),

                    //***********************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: 
                              _ctrlBitacora.getInfoVisita['bitFotoVehiculo'] !=
                                      ''
                                  ? () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ImageViewGeneric(
                                              title:'Foto Placa',
                                              image:
                                                  '${_ctrlBitacora.getInfoVisita['bitFotoVehiculo']}')));
                                    }
                                  : null,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey.shade300,
                                ),
                                width: size.iScreen(18.0),
                                height: size.iScreen(10.0),
                                child:
                                    //  valueListaVisitas.placaImage == null
                                    //     ? Icon(
                                    //         Icons.add_a_photo_outlined,
                                    //         size: size.iScreen(4.0),
                                    //       )
                                    //     :
                                    // Image.file(File(_ctrlBitacora.getInfoVisita['fotoPlaca'])),
                                    _ctrlBitacora.getInfoVisita[
                                                'bitFotoVehiculo'] !=
                                            ''
                                        ? Hero(
                                           tag: '${_ctrlBitacora.getInfoVisita['bitFotoVehiculo']}',
                                          child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  'assets/imgs/loader.gif'),
                                              image: NetworkImage(
                                                '${_ctrlBitacora.getInfoVisita['bitFotoVehiculo']}',
                                              ),
                                            ),
                                        )
                                        : Image.asset(
                                            'assets/imgs/no-image.png',
                                            fit: BoxFit.cover))),
                      ],
                    ),
                    //***********************************************/

                    _ctrlBitacora.getInfoVisita['bitInformacionVehiculo']
                                ['dni'] !=
                            ''
                        ? Column(
                            children: [
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/
                              Container(
                                width: size.wScreen(100.0),
                                child: Text('Documento: ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              Container(
                                width: size.wScreen(100.0),
                                child: Text(
                                    '${_ctrlBitacora.getInfoVisita['bitInformacionVehiculo']['dni']}',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.grey
                                    )),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //***********************************************/
                              //***********************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/
                              Container(
                                width: size.wScreen(100.0),
                                child: Text('Propietario Vehiculo: ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              Container(
                                width: size.wScreen(100.0),
                                child: Text(
                                    '${_ctrlBitacora.getInfoVisita['bitInformacionVehiculo']['fullname']}',
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.grey
                                    )),
                              ),
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                            ],
                          )
                        : Container(),

                    //***********************************************/

                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(0.5),
                              vertical: size.iScreen(0.2)),
                          width: size.wScreen(100.0),
                          // height: size.iScreen(0.5),
                          color: Colors.grey.shade100,
                          child: Text(
                            'Se dirije a : ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Departamento : ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // width: size.iScreen(28.0),
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.5),
                                    bottom: size.iScreen(0.0)),

                                child: Text(
                                  ' ${_ctrlBitacora.getInfoVisita['bitNombre_dpt']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
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
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Número : ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // width: size.iScreen(28.0),
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.5),
                                    bottom: size.iScreen(0.0)),

                                child: Text(
                                  ' ${_ctrlBitacora.getInfoVisita['bitNumero_dpt']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
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
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Ubicación : ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // width: size.iScreen(28.0),
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.5),
                                    bottom: size.iScreen(0.0)),

                                child: Text(
                                  ' ${_ctrlBitacora.getInfoVisita['bitCliUbicacion']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
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
                              margin: EdgeInsets.only(
                                  top: size.iScreen(0.5),
                                  bottom: size.iScreen(0.0)),
                              // width: size.wScreen(100.0),
                              child: Text(
                                'Motivo : ',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // width: size.iScreen(28.0),
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    top: size.iScreen(0.5),
                                    bottom: size.iScreen(0.0)),

                                child: Text(
                                  ' ${_ctrlBitacora.getInfoVisita['bitAsunto']}',
                                  // overflow:
                                  //     TextOverflow
                                  //         .ellipsis,
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(1.8),
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                        Container(
                          width: size.wScreen(100.0),
                          height: size.iScreen(0.5),
                          color: Colors.grey.shade100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      child: Text('Observación: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    SizedBox(
                      height: size.iScreen(0.5),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      child: Text(
                          '${_ctrlBitacora.getInfoVisita['bitObservacion']}',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            fontWeight: FontWeight.normal,
                            // color: Colors.grey
                          )),
                    ),

                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
