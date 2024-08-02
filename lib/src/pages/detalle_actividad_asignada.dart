//=======================================//
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/pages/crear_actividad_asignada.dart';
import 'package:nseguridad/src/pages/crear_ronda_asignada.dart';
import 'package:nseguridad/src/pages/detalle_actividades_ronda.dart';
import 'package:nseguridad/src/pages/detalle_inventario_actividad.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/crea_uuid.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';

class DetalleActividadAsignada extends StatelessWidget {
  const DetalleActividadAsignada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);




    final infoContrtoller = context.read<ActividadesAsignadasController>();

// print('la actividad: ${infoContrtoller.getInfoActividad['act_asigTrabajos']}');


    final _user = context.read<HomeController>();
      final ctrlTheme = context.read<ThemeApp>();
        
    String fechaLocalInicio = DateUtility.fechaLocalConvert(
        infoContrtoller.getInfoActividad['act_asigTurno']['desde']!.toString());
    String fechaLocalFin = DateUtility.fechaLocalConvert(
        infoContrtoller.getInfoActividad['act_asigTurno']['hasta']!.toString());

    final _dataPersona = infoContrtoller
        .getInfoActividad['act_asigPerDocApeNom']
        .toString()
        .split(' ');
    String _nomPersona = '';
    for (var i = 0; i < _dataPersona.length; i++) {
      if (i != 0) {
        _nomPersona = _nomPersona + " " + _dataPersona[i];
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
              'Detalle de Actividad',
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
                    height: size.iScreen(0.5),
                  ),

                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Cédula: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        child: Text(
                          // '${infoContrtoller.getInfoActividad['act_asigPerDocApeNom']}',
                          '${_dataPersona[0]}',
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
                  Column(
                    children: [
                      Container(
                        width: size.wScreen(100),
                        child: Text('Guardia: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Container(
                        width: size.wScreen(100),
                        // color: Colors.red,
                        margin:
                            EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                        child: Text(
                          // '${infoContrtoller.getInfoActividad['act_asigPerDocApeNom']}',
                          '${_nomPersona}',

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
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Cliente: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            // '${infoContrtoller.getInfoActividad['act_asigPerDocApeNom']}',
                            ' ${infoContrtoller.getInfoActividad['act_asigEveCienete']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),

                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Tipo de actividad: ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            // '${infoContrtoller.getInfoActividad['act_asigPerDocApeNom']}',
                            ' ${infoContrtoller.getInfoActividad['act_asigEveTipo']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),

                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Descripción : ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            // '${infoContrtoller.getInfoActividad['act_asigPerDocApeNom']}',
                            ' ${infoContrtoller.getInfoActividad['act_asigEveNombre']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Jornada Laboral:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),
                  //***********************************************/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Inicio:',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          //*****************************************/

                          SizedBox(
                            height: size.iScreen(1.0),
                          ),

                          //==========================================//
                          Text(
                            // '${infoContrtoller.getInfoActividad['act_asigTurno']['desde'].toString().replaceAll('T', ' ')} ',
                            '$fechaLocalInicio',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Salida:',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          //*****************************************/

                          SizedBox(
                            height: size.iScreen(1.0),
                          ),

                          //==========================================//
                          Text(
                            '$fechaLocalFin',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //==========================================//
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Terea : ',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
                          child: Text(
                            infoContrtoller
                                    .getInfoActividad['act_asigObservacion']
                                    .isEmpty
                                ? '--- --- --- --- --- --- '
                                : ' ${infoContrtoller.getInfoActividad['act_asigObservacion']}',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                // color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //*****************************************/
                  SizedBox(
                    height: size.iScreen(1.0),
                  ),

                  //==========================================//

                  Container(
                    width: size.wScreen(100),
                    child: Text('Actividades: ',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),

                  Wrap(
                    children: (infoContrtoller
                            .getInfoActividad['act_asigEveActividades'] as List)
                        .map((x) {
                      final _nombreDeActividad = x['nombre'];

                      // print('El NOMBRE DE ACTIVIDAD $_nombreDeActividad');

                      final _totalDeActividades = x['horario'].length;
                      // print('HORARIOS: $_totalDeActividades');
                      //     for (var item in infoContrtoller.getInfoActividad['act_asigEveActividades']['horario']) {

                      //   // final _totalDeActividad=x['nombre'];
                      //     }

                      return Consumer<ThemeApp>(
                        builder: (_, value, __) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.iScreen(0.5),
                                vertical: size.iScreen(0.5)),
                            width: size.wScreen(100.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ), 
                              ],
                            ),
                            child: Column(       
                              children: [ 
                                Container(
                                  width: size.wScreen(100.0),
                                  decoration: BoxDecoration(
                                    color: value.secondaryColor
                                        .withOpacity(0.70),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.wScreen(60.0),
                                        // color:  Colors.red,
                                        child: Text(
                                         " ${x['puesto']} - ${x['nombre']}",
                                        //  "${infoContrtoller.getInfoActividad['act_asigEveId']} - ${x['puesto']}",
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      // Spacer()
                                      InkWell(
                                        onTap: () async {
                                          // print('EL ROL ES : ${_user.getUsuarioInfo!.rol}');

                                          //        if (_user.getUsuarioInfo!.rol!.contains('SUPERVISOR')) {
                                          //                                   String _uuidV4 ='';
                                          //                                  _uuidV4 = generateUniqueId();
                                          //                                infoContrtoller.setIdActividadPorRealizar(_uuidV4);
                
                                          //                                 } 
                                          //                                 else{
                                          //                                   infoContrtoller.setIdActividadPorRealizar('');
                                          //                                 }
                                          //  //***********************//
                                          // if (infoContrtoller.getInfoActividad[
                                          //         'act_asigEveTipo'] !=
                                          //     "INVENTARIO INTERNO") {
                                          //   // print('SELECCIONAMOS A:  ${x['nombre']}');
                                          //   List<Map<String, dynamic>>
                                          //       _listaTrabajos = [];
                                          //   if (infoContrtoller
                                          //               .getInfoActividad[
                                          //           'act_asigEveTipo'] ==
                                          //       "RONDAS") {
                                          //     for (var item in infoContrtoller
                                          //             .getInfoActividad[
                                          //         'act_asigTrabajos']) {
                                          //       //  String myString = "5**CASA 2";
                                          //       List<String> parts =
                                          //           item['qr'].split("**");
                                          //       String result = parts[1].trim();
                                          //       if (result == x['nombre']) {
                                          //         _listaTrabajos.add(item);
                                          //         // print('TRABAJOS :${item['titulo']}');

                                          //       }
                                          //     }
                                          //   } else if (infoContrtoller
                                          //               .getInfoActividad[
                                          //           'act_asigEveTipo'] !=
                                          //       "INVENTARIO INTERNO") {
                                          //     for (var item in infoContrtoller
                                          //             .getInfoActividad[
                                          //         'act_asigTrabajos']) {
                                          //       //  String myString = "5**CASA 2";
                                          //       _listaTrabajos.add(item);
                                          //     }
                                          //   }
                                          //   // print('TRABAJOS :$_listaTrabajos');

                                          //   final _data = {
                                          //     "actividad": x['nombre'],
                                          //     "trabajos": _listaTrabajos
                                          //   };
                                                 
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: ((context) => DetalleActividadesRonda(
                                          //               tipo: infoContrtoller
                                          //                       .getInfoActividad[
                                          //                   'act_asigEveTipo'],
                                          //               dataRonda: _data,
                                          //               requeridos: infoContrtoller
                                          //                       .getInfoActividad[
                                          //                   'act_asigRequerimientosActividad']))));
                                          // } else if (infoContrtoller
                                          //             .getInfoActividad[
                                          //         'act_asigEveTipo'] ==
                                          //     "INVENTARIO INTERNO") {
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: ((context) =>
                                          //               DetalleActividadInventarioInterno(
                                          //                   estado: 'DETALLE',
                                          //                   requeridos: infoContrtoller
                                          //                           .getInfoActividad[
                                          //                       'act_asigRequerimientosActividad']))));
                                          // }

  //***********************//
                                    //           print('LA DATA DEL TIPO: ${infoContrtoller.getInfoActividad[
                                    //               'act_asigEveTipo']}');
                                    //               print('lAS actividadES: ${infoContrtoller.getInfoActividad['act_asigTrabajos']}');
                                     final _data = {
                                              "actividad": x['nombre'],
                                              "trabajos": infoContrtoller.getInfoActividad['act_asigTrabajos']
                                            };

                                          if (infoContrtoller.getInfoActividad[
                                                  'act_asigEveTipo'] !=
                                              "INVENTARIO INTERNO") {
                                            print('SELECCIONAMOS A:  ${x['nombre']}');
                                            List<Map<String, dynamic>>
                                                _listaTrabajos = [];
                                            if (infoContrtoller
                                                        .getInfoActividad[
                                                    'act_asigEveTipo'] ==
                                                "RONDAS") {
                                              for (var item in infoContrtoller
                                                      .getInfoActividad[
                                                  'act_asigTrabajos']) {
                                                //  String myString = "5**CASA 2";
                                                List<String> parts =
                                                    item['qr'].split("**");
                                                String result = parts[1].trim();
                                                if (result == x['nombre']) {
                                                  _listaTrabajos.add(item);
                                                  // print('TRABAJOS REALIZADOS ****** > :${item['titulo']}');

                                                }
                                              }
                                            } else if (infoContrtoller
                                                        .getInfoActividad[
                                                    'act_asigEveTipo'] ==
                                                "INVENTARIO INTERNO") {
                                              for (var item in infoContrtoller
                                                      .getInfoActividad[
                                                  'act_asigTrabajos']) {
                                                //  String myString = "5**CASA 2";
                                                _listaTrabajos.add(item);
                                              }
                                            }
                                            // print('TRABAJOS :$_listaTrabajos');

                                            // final _data = {
                                            //   "actividad": x['nombre'],
                                            //   "trabajos": _listaTrabajos
                                            // };
                                                 
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) => DetalleActividadesRonda(
                                                        tipo: infoContrtoller
                                                                .getInfoActividad[
                                                            'act_asigEveTipo'],
                                                        dataRonda: _data,
                                                        requeridos: infoContrtoller
                                                                .getInfoActividad[
                                                            'act_asigRequerimientosActividad']))));
                                          }
                                            if (infoContrtoller
                                                      .getInfoActividad[
                                                  'act_asigEveTipo'] ==
                                              "INVENTARIO INTERNO") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        DetalleActividadInventarioInterno(
                                                            estado: 'DETALLE',
                                                            requeridos: infoContrtoller
                                                                    .getInfoActividad[
                                                                'act_asigRequerimientosActividad']))));
                                          }

                                          //****************************//


                                        },
                                        child: Container(
                                          // color:  Colors.red,
                                          // margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
                                          margin: EdgeInsets.only(
                                              left: size.iScreen(1.0)),
                                          child: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: size.iScreen(3.5),
                                          ),
                                        ),
                                      ),
                                      //===========================================//
                                      x['horario'].length == 0
                                          ? 
                                          InkWell(
                                              onTap: ()   {
                                                      print('EL ROL ES : ${_user.getUsuarioInfo!.rol}');

                                                 if (_user.getUsuarioInfo!.rol!.contains('SUPERVISOR')) {

                                                                print('EL ID DE LA ACTIVIDAD A REALIZAR: ${x['id']}');


                                                                          //   String _uuidV4 ='';
                                                                          //  _uuidV4 = generateUniqueId();

                                                                         infoContrtoller.setIdActividadPorRealizar(x['id']);
                
                                                                          } 
                                                                          else{
                                                                            infoContrtoller.setIdActividadPorRealizar('');
                                                                          }
                                                String fechaStringDesde =
                                                   
                                                    "$fechaLocalInicio";
                                                String fechaStringHasta =
                                                    // "${infoContrtoller.getInfoActividad['act_asigTurno']['hasta']}";
                                                    "$fechaLocalFin";
                                                DateTime fechaDesde =
                                                    DateTime.parse(
                                                        fechaStringDesde);
                                                DateTime fechaHasta =
                                                    DateTime.parse(
                                                        fechaStringHasta);

                                                DateTime fechaActual =
                                                    DateTime.now();
                                                //=================================================================================//
                                                if (fechaDesde
                                                    .isAfter(fechaActual)) {
                                                  // print("La fecha $fechaStringDesde es mayor que la fecha actual.");
                                                  //=================================================================================//

                                                  NotificatiosnService
                                                      .showSnackBarDanger(
                                                          'La actividad no es posible en este momento.');
                                                } else {
                                                  bool _fechaInicio = false;
                                                  bool _actualHora = false;
                                                  final nowDate =
                                                      DateTime.now();
                                                  final _fechaActividad = DateTime
                                                      .parse(infoContrtoller
                                                                  .getInfoActividad[
                                                              'act_asigTurno']
                                                          ['hasta']);

                                                  // print('FECHA $_fechaActividad');

                                                  int resultado =
                                                      nowDate.compareTo(
                                                          _fechaActividad);

                                                  if (resultado < 0) {
                                                    // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
                                                    _actualHora = false;
                                                  } else if (resultado > 0) {
                                                    // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
                                                    _actualHora = true;
                                                  } else {
                                                    // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
                                                    _actualHora = false;
                                                  }

                                                  //======================================//
                                                  if (infoContrtoller
                                                              .getInfoActividad[
                                                          'act_asigEstado'] !=
                                                      "FINALIZADA") {
                                                    //=======================//

                                                    if (_actualHora == false) {
                                                      if (infoContrtoller
                                                                  .getInfoActividad[
                                                              'act_asigEveTipo'] ==
                                                          "INVENTARIO INTERNO") {
                                                           
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        CrearActividadDesignada(
                                                                          requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
                                                      } else
                                                      // if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                      //         "RONDAS" ||
                                                      //     infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                      //         "INVENTARIO EXTERNO")
                                                      {
                                                        //======================================//
                                                        final _lugar = infoContrtoller
                                                                .getInfoActividad[
                                                            'act_asigEveTipo'];

                                                        int _trabajosRealizados =
                                                            0;
                                                        for (var item in infoContrtoller
                                                                .getInfoActividad[
                                                            'act_asigTrabajos']) {
                                                          //  String myString = "5**CASA 2";
                                                          List<String> parts =
                                                              item['qr']
                                                                  .split("**");
                                                          String result =
                                                              parts[1].trim();
                                                          if (result ==
                                                              x['nombre']) {
                                                            _trabajosRealizados =
                                                                _trabajosRealizados +
                                                                    1;
                                                            // print('TRABAJOS :${item['titulo']}');

                                                          }
                                                        }

                                                        if (_trabajosRealizados >=
                                                                _totalDeActividades &&
                                                            _trabajosRealizados !=
                                                                0) {
                                                          NotificatiosnService
                                                              .showSnackBarSuccsses(
                                                                  '"${x['nombre']}"  Tiene Actividades completas ');
                                                        } else {
                                                          infoContrtoller
                                                              .resetValuesRonda();
                                                          infoContrtoller
                                                              .setNombreEvento(
                                                                  x['nombre']);
                                                              //  infoContrtoller.getCurrentPosition();
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      ((context) =>
                                                                          CrearRondaAsignada(
                                                                            lugar: _lugar,
                                                                             requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
                                                                          ))));
                                                        }

                                                        //======================================//
                                                        //  infoContrtoller
                                                        //       .resetValuesRonda();
                                                        //   infoContrtoller
                                                        //       .setNombreEvento(
                                                        //           x['nombre']);
                                                        //       //  infoContrtoller.getCurrentPosition();
                                                        //   Navigator.push(
                                                        //       context,
                                                        //       MaterialPageRoute(
                                                        //           builder:
                                                        //               ((context) =>
                                                        //                   CrearRondaAsignada(
                                                        //                     lugar: _lugar,
                                                        //                      requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
                                                        //                   ))));

                                                         //======================================//

                                                      }
                                                    } else {
                                                      NotificatiosnService
                                                          .showSnackBarError(
                                                              'Fuera de fecha de la actividad');
                                                    }

                                                    //=======================================//

                                                  } else {
                                                    NotificatiosnService
                                                        .showSnackBarError(
                                                            'La actividad ya está finalizada');
                                                  }
                                                }
                                              },
                                              child: Icon(
                                                Icons.add_circle,
                                                color: Colors.white,
                                                size: size.iScreen(3.5),
                                              ),
                                            )
                                          : Icon(
                                              Icons.lock_clock,
                                              color: Colors.white,
                                              size: size.iScreen(3.5),
                                            ),
                                      //========================================/

//
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                Container(
                                    width: size.wScreen(100.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(1.0)),
                                    child: Container(
                                        // color: Colors.red,
                                        child: Column(
                                      children: [
                                        Row(children: [
                                          Text(
                                            // _user.getUsuarioInfo!.rol!.contains('SUPERVISOR')?'Repetir cada: ':'Minutos: ',
                                            'Minutos: ',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text('${x['minutos']}',
                                              style: GoogleFonts.lexendDeca(
                                                  fontSize: size.iScreen(1.8),
                                                  // color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                          //             Spacer(),
                                          //              Container(
                                          //   //  width: size.wScreen(100.0),
                                          //   margin: EdgeInsets.only(top:size.iScreen(0.7) ),
                                          //   padding:EdgeInsets.all(size.iScreen(0.7)),
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:BorderRadius.circular(50),
                                          //   color:value.getPrimaryTextColor,
                                          //   ),
                                          //    child:InkWell(child: Icon(Icons.location_on_outlined,size: size.iScreen(3.0),color: Colors.white,), onTap:(){

                                          //    },),
                                          //  ),
                                          // Spacer(),
                                          //  InkWell(
                                          //   onTap:(){

                                          //   },
                                          //    child: Container(
                                          //     // color: Colors.red,
                                          //                                              //  width: size.wScreen(100.0),
                                          //                                              margin: EdgeInsets.only(top:size.iScreen(0.2) ),
                                          //                                              padding:EdgeInsets.all(size.iScreen(0.7)),
                                          //                                              decoration: BoxDecoration(
                                          //                                                borderRadius:BorderRadius.circular(50),
                                          //                                             //  color:Colors.red,
                                          //                                              ),
                                          //                                               child:Icon(Icons.info_outlined,size: size.iScreen(3.5),color: value.getTerciaryTextColor,),
                                          //                                             ),
                                          //  ),
                                        ]),
 x['horario'] .isNotEmpty ?
                                        Column(
                                          children: [
                                            Container(
                                              // color:Colors.red,
                                              width: size.wScreen(100.0),
                                              child:
                                              //  _user.getUsuarioInfo!.rol!.contains('GUARDIA')?
                                              Text(
                                                 'Horarios :',
                                                  style: GoogleFonts.lexendDeca(
                                                      fontSize: size.iScreen(1.8),
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.normal))
                                                          // :Container(),
                                            ),
                                        //*****************************************/

                                        SizedBox(
                                          height: size.iScreen(0.0),
                                        ),

                                        //==========================================//
                                        ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap : true,
                                          itemCount: x['horario'].length,
                                          itemBuilder: (BuildContext context, int index) {

                                            final itemHora=x['horario'][index];
                                            // (x['horario'] as List).map((e) {
                                          final now = DateTime.now();
                                          final hora = now.hour;
                                          final minutos = now.minute;
                                          // final segundos = now.second;
                                          bool _colorHora = false;

                                          String _hotaActual =
                                              "${hora.toString()}:${minutos.toString()}";

                                          if (_hotaActual.compareTo(
                                                  "${itemHora['horaFinal']}") >
                                              0) {
                                            // print('El _hotaActual $_hotaActual es mayor que "${e['horaFinal']}"');
                                            _colorHora = false;
                                          } else if (_hotaActual.compareTo(
                                                  "${itemHora['horaFinal']}") <
                                              0) {
                                            _colorHora = false;
                                            // print('El _hotaActual $_hotaActual es mayor que "${e['horaFinal']}"');
                                            // print('El _hotaActual $_hotaActual es menor que "${e['horaFinal']}"');
                                          } else {
                                            _colorHora = false;
                                            // print('El _hotaActual $_hotaActual es igual a "${e['horaFinal']}"');
                                          }
                                            return 
                                            // Text("${x['horario']}");
                                            Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: value
                                                    .primaryColor
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.iScreen(0.3)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.iScreen(1.0),
                                                vertical: size.iScreen(0.5)),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: size.wScreen(100.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Observación: ',
                                                          style: GoogleFonts
                                                              .lexendDeca(
                                                                  fontSize: size
                                                                      .iScreen(
                                                                          1.8),
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                      Expanded(
                                                        child: Text(
                                                            itemHora['observacion'] 
                                                            !=
                                                                    ''
                                                                ? itemHora['observacion']
                                                                : 
                                                                "Ninguna",
                                                            style: GoogleFonts
                                                                .lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.8),
                                                                    // color: Colors.grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //  for (var item in infoContrtoller.getInfoActividad['act_asigEveActividades'].length)

                                                Container(
                                                  width: size.wScreen(100.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: 
                                                    _colorHora == true
                                                        ? tercearyColor
                                                            .withOpacity(0.60)
                                                        : value
                                                            .secondaryColor
                                                            .withOpacity(0.60),
                                                  ),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.iScreen(0.3)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.iScreen(1.0),
                                                      vertical:
                                                          size.iScreen(0.5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(children: [
                                                            Container( 
                                                              width:
                                                                  size.wScreen(
                                                                      23.0),
                                                              child: Text(
                                                                  'H Inicio: ',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ),
                                                            Text(
                                                                " ${itemHora['hora']}",
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.8),
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ]),
                                                          Row(children: [
                                                            Container(
                                                              width:
                                                                  size.wScreen(
                                                                      23.0),
                                                              child: Text(
                                                                  'H Fin: ',
                                                                  style: GoogleFonts.lexendDeca(
                                                                      fontSize:
                                                                          size.iScreen(
                                                                              1.8),
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ),
                                                            Text(
                                                                " ${itemHora['horaFinal']}",
                                                                style: GoogleFonts.lexendDeca(
                                                                    fontSize: size
                                                                        .iScreen(
                                                                            1.8),
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ]),
                                                        ],
                                                      ),
                                                      _colorHora == false
                                                          ? InkWell(
                                                              onTap: () {
                                                                // String
                                                                //     fechaStringDesde =
                                                                //     // "${infoContrtoller.getInfoActividad['act_asigTurno']['desde']}";
                                                                //     "$fechaLocalInicio";
                                                                // String
                                                                //     fechaStringHasta =
                                                                //     // "${infoContrtoller.getInfoActividad['act_asigTurno']['hasta']}";
                                                                //     "$fechaLocalFin";
                                                                // DateTime
                                                                //     fechaDesde =
                                                                //     DateTime.parse(
                                                                //         fechaStringDesde);
                                                                // DateTime
                                                                //     fechaHasta =
                                                                //     DateTime.parse(
                                                                //         fechaStringHasta);

                                                                // DateTime
                                                                //     fechaActual =
                                                                //     DateTime
                                                                //         .now();
                                                                // //=================================================================================//
                                                                // if (fechaDesde
                                                                //     .isAfter(
                                                                //         fechaActual)) {
                                                                //   // print("La fecha $fechaStringDesde es mayor que la fecha actual.");
                                                                //   //=================================================================================//

                                                                //   NotificatiosnService
                                                                //       .showSnackBarDanger(
                                                                //           'La actividad no es posible en este momento.');
                                                                // } else {
                                                                //   bool
                                                                //       _fechaInicio =
                                                                //       false;
                                                                //   bool
                                                                //       _actualHora =
                                                                //       false;
                                                                //   final nowDate =
                                                                //       DateTime
                                                                //           .now();
                                                                //   final _fechaActividad =
                                                                //       DateTime.parse(
                                                                //           infoContrtoller.getInfoActividad['act_asigTurno']
                                                                //               [
                                                                //               'hasta']);

                                                                //   // print('FECHA $_fechaActividad');

                                                                //   int resultado =
                                                                //       nowDate.compareTo(
                                                                //           _fechaActividad);

                                                                //   if (resultado <
                                                                //       0) {
                                                                //     // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
                                                                //     _actualHora =
                                                                //         false;
                                                                //   } else if (resultado >
                                                                //       0) {
                                                                //     // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
                                                                //     _actualHora =
                                                                //         true;
                                                                //   } else {
                                                                //     // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
                                                                //     _actualHora =
                                                                //         false;
                                                                //   }

                                                                //   //======================================//
                                                                //   if (infoContrtoller
                                                                //               .getInfoActividad[
                                                                //           'act_asigEstado'] !=
                                                                //       "FINALIZADA") {
                                                                //     //=======================//

                                                                //     if (_actualHora ==
                                                                //         false) {
                                                                //       if (infoContrtoller
                                                                //               .getInfoActividad['act_asigEveTipo'] ==
                                                                //           "INVENTARIO INTERNO") {
                                                                //         Navigator.push(
                                                                //             context,
                                                                //             MaterialPageRoute(builder: ((context) => CrearActividadDesignada( requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
                                                                //       } else if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                //               "RONDAS" ||
                                                                //           infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                //               "INVENTARIO EXTERNO") {
                                                                //         //======================================//
                                                                //         final _lugar =
                                                                //             infoContrtoller.getInfoActividad['act_asigEveTipo'];

                                                                //         int _trabajosRealizados =
                                                                //             0;
                                                                //         for (var item
                                                                //             in infoContrtoller.getInfoActividad['act_asigTrabajos']) {
                                                                //           //  String myString = "5**CASA 2";
                                                                //           List<String>
                                                                //               parts =
                                                                //               item['qr'].split("**");
                                                                //           String
                                                                //               result =
                                                                //               parts[1].trim();
                                                                //           if (result ==
                                                                //               x['nombre']) {
                                                                //             _trabajosRealizados =
                                                                //                 _trabajosRealizados + 1;
                                                                //             // print('TRABAJOS :${item['titulo']}');

                                                                //           }
                                                                //         }

                                                                //         if (_trabajosRealizados >=
                                                                //                 _totalDeActividades &&
                                                                //             _trabajosRealizados !=
                                                                //                 0) {
                                                                //           NotificatiosnService.showSnackBarSuccsses(
                                                                //               '"${x['nombre']}"  Tiene Actividades completas ');
                                                                //         } else {
                                                                //           infoContrtoller
                                                                //               .resetValuesRonda();
                                                                //           infoContrtoller
                                                                //               .setNombreEvento(x['nombre']);

                                                                //           Navigator.push(
                                                                //               context,
                                                                //               MaterialPageRoute(
                                                                //                   builder: ((context) => CrearRondaAsignada(
                                                                //                         lugar: _lugar,
                                                                //                          requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
                                                                //                       ))));
                                                                //         }

                                                                //         //======================================//

                                                                //       }
                                                                //     } else {
                                                                //       NotificatiosnService
                                                                //           .showSnackBarError(
                                                                //               'Fuera de fecha de la actividad');
                                                                //     }

                                                                //     //=======================================//

                                                                //   } else {
                                                                //     NotificatiosnService
                                                                //         .showSnackBarError(
                                                                //             'La actividad ya está finalizada');
                                                                //   }
                                                                // }

                                                                //*************************************************************************//

                                                                  String
                                                                    fechaStringDesde =
                                                                    // "${infoContrtoller.getInfoActividad['act_asigTurno']['desde']}";
                                                                    "$fechaLocalInicio";
                                                                String
                                                                    fechaStringHasta =
                                                                    // "${infoContrtoller.getInfoActividad['act_asigTurno']['hasta']}";
                                                                    "$fechaLocalFin";
                                                                DateTime
                                                                    fechaDesde =
                                                                    DateTime.parse(
                                                                        fechaStringDesde);
                                                                DateTime
                                                                    fechaHasta =
                                                                    DateTime.parse(
                                                                        fechaStringHasta);




                                                                        DateTime now = DateTime.now();

 DateTime fechaActual = DateTime(
    now.year,
    now.month,
    now.day,
    now.hour,
    now.minute,
  );

 DateTime horaActual = DateTime(
    now.hour,
    now.minute,
  );
// DateTime horaInicial = DateTime(int.parse(itemHora['hora'].toString()) );
//   DateTime horaFinal = DateTime(int.parse(itemHora['horaFinal'].toString()));



  // DateTime now = DateTime.now();
// String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
// DateTime fechaActual = DateFormat('yyyy-MM-dd HH:mm').parse(formattedTime);

//  String fechaString = "2024-03-22 22:36:00.000";
//     DateTime fechaActual = DateTime.parse(fechaString);
//     String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(fechaActual);


                                                                    //  DateTime now = DateTime.now();
                                                                    //  DateTime fechaActual = DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(now));
                                                                     
                                                               
// Función para validar si la hora actual está entre horaA y horaB
   bool estaEntreHoras = validarFecha(fechaActual, fechaDesde, fechaHasta);

    if (estaEntreHoras) {
      //  NotificatiosnService.showSnackBarError( 'Si puede realizarlo');
      //***********************************************//
                                                                    if (itemHora['eliminado']==true) {
                                                                      NotificatiosnService
                                                                          .showSnackBarError(
                                                                              'No pruede realizar actividad');
                                                                      
                                                                    }
                                                                     else {

                                                                       bool relizaActividad=   validarHora(itemHora['hora'].toString(),itemHora['horaFinal'].toString());

                                                                      
                                                                             
                                                                             infoContrtoller.setIdActividadPorRealizar(itemHora['id']);
                                                                          

                                                                      
                                                                        //  NotificatiosnService.showSnackBarError( '${itemHora['id']}Realizar Actividad: $relizaActividad');


                                                                         if (relizaActividad) {
                                                                          bool
                                                                      _fechaInicio =
                                                                      false;
                                                                  bool
                                                                      _actualHora =
                                                                      false;
                                                                  final nowDate =
                                                                      DateTime
                                                                          .now();
                                                                  final _fechaActividad =
                                                                      DateTime.parse(
                                                                          infoContrtoller.getInfoActividad['act_asigTurno']
                                                                              [
                                                                              'hasta']);

                                                                  // print('FECHA $_fechaActividad');

                                                                  int resultado =
                                                                      nowDate.compareTo(
                                                                          _fechaActividad);

                                                                  if (resultado <
                                                                      0) {
                                                                    // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
                                                                    _actualHora =
                                                                        false;
                                                                  } else if (resultado >
                                                                      0) {
                                                                    // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
                                                                    _actualHora =
                                                                        true;
                                                                  } else {
                                                                    // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
                                                                    _actualHora =
                                                                        false;
                                                                  }

                                                                  //======================================//
                                                                  if (infoContrtoller
                                                                              .getInfoActividad[
                                                                          'act_asigEstado'] !=
                                                                      "FINALIZADA") {
                                                                    //=======================//

                                                                    if (_actualHora ==
                                                                        false) {
                                                                      if (infoContrtoller
                                                                              .getInfoActividad['act_asigEveTipo'] ==
                                                                          "INVENTARIO INTERNO") {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: ((context) => CrearActividadDesignada( requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
                                                                      } else if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                              "RONDAS" ||
                                                                          infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                              "INVENTARIO EXTERNO") {
                                                                        //======================================//
                                                                        final _lugar =
                                                                            infoContrtoller.getInfoActividad['act_asigEveTipo'];

                                                                        int _trabajosRealizados =
                                                                            0;
                                                                        for (var item
                                                                            in infoContrtoller.getInfoActividad['act_asigTrabajos']) {
                                                                          //  String myString = "5**CASA 2";
                                                                          List<String>
                                                                              parts =
                                                                              item['qr'].split("**");
                                                                          String
                                                                              result =
                                                                              parts[1].trim();
                                                                          if (result ==
                                                                              x['nombre']) {
                                                                            _trabajosRealizados =
                                                                                _trabajosRealizados + 1;
                                                                            // print('TRABAJOS :${item['titulo']}');

                                                                          }
                                                                        }

                                                                        if (_trabajosRealizados >=
                                                                                _totalDeActividades &&
                                                                            _trabajosRealizados !=
                                                                                0) {
                                                                          NotificatiosnService.showSnackBarSuccsses(
                                                                              '"${x['nombre']}"  Tiene Actividades completas ');
                                                                        } else {
                                                                          infoContrtoller
                                                                              .resetValuesRonda();
                                                                          infoContrtoller
                                                                              .setNombreEvento(x['nombre']);


                                                                              // print('el id de la actividad: a realizar: ${itemHora['id']}');

                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: ((context) => CrearRondaAsignada(
                                                                                        lugar: _lugar,
                                                                                         requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
                                                                                      ))));
                                                                        }

                                                                        //======================================//

                                                                      }
                                                                    } else {
                                                                      NotificatiosnService
                                                                          .showSnackBarError(
                                                                              'Fuera de fecha de la actividad');
                                                                    }

                                                                    //=======================================//

                                                                  } else {
                                                                    NotificatiosnService
                                                                        .showSnackBarError(
                                                                            'La actividad ya está finalizada');
                                                                  }
                                                                           
                                                                         } else {
                                                                          NotificatiosnService
                                                                      .showSnackBarDanger(
                                                                          'La actividad no es posible en este momento.');
                                                                         }

                                                                        //=================================================================================//
                                                                // if (fechaDesde
                                                                //     .isAfter(
                                                                //         fechaActual)) {
                                                                //   // print("La fecha $fechaStringDesde es mayor que la fecha actual.");
                                                                //   //=================================================================================//

                                                                //   NotificatiosnService
                                                                //       .showSnackBarDanger(
                                                                //           'La actividad no es posible en este momento.');
                                                                // } 
                                                                // else {
                                                                //   bool
                                                                //       _fechaInicio =
                                                                //       false;
                                                                //   bool
                                                                //       _actualHora =
                                                                //       false;
                                                                //   final nowDate =
                                                                //       DateTime
                                                                //           .now();
                                                                //   final _fechaActividad =
                                                                //       DateTime.parse(
                                                                //           infoContrtoller.getInfoActividad['act_asigTurno']
                                                                //               [
                                                                //               'hasta']);

                                                                //   // print('FECHA $_fechaActividad');

                                                                //   int resultado =
                                                                //       nowDate.compareTo(
                                                                //           _fechaActividad);

                                                                //   if (resultado <
                                                                //       0) {
                                                                //     // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
                                                                //     _actualHora =
                                                                //         false;
                                                                //   } else if (resultado >
                                                                //       0) {
                                                                //     // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
                                                                //     _actualHora =
                                                                //         true;
                                                                //   } else {
                                                                //     // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
                                                                //     _actualHora =
                                                                //         false;
                                                                //   }

                                                                //   //======================================//
                                                                //   if (infoContrtoller
                                                                //               .getInfoActividad[
                                                                //           'act_asigEstado'] !=
                                                                //       "FINALIZADA") {
                                                                //     //=======================//

                                                                //     if (_actualHora ==
                                                                //         false) {
                                                                //       if (infoContrtoller
                                                                //               .getInfoActividad['act_asigEveTipo'] ==
                                                                //           "INVENTARIO INTERNO") {
                                                                //         Navigator.push(
                                                                //             context,
                                                                //             MaterialPageRoute(builder: ((context) => CrearActividadDesignada( requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
                                                                //       } else if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                //               "RONDAS" ||
                                                                //           infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
                                                                //               "INVENTARIO EXTERNO") {
                                                                //         //======================================//
                                                                //         final _lugar =
                                                                //             infoContrtoller.getInfoActividad['act_asigEveTipo'];

                                                                //         int _trabajosRealizados =
                                                                //             0;
                                                                //         for (var item
                                                                //             in infoContrtoller.getInfoActividad['act_asigTrabajos']) {
                                                                //           //  String myString = "5**CASA 2";
                                                                //           List<String>
                                                                //               parts =
                                                                //               item['qr'].split("**");
                                                                //           String
                                                                //               result =
                                                                //               parts[1].trim();
                                                                //           if (result ==
                                                                //               x['nombre']) {
                                                                //             _trabajosRealizados =
                                                                //                 _trabajosRealizados + 1;
                                                                //             // print('TRABAJOS :${item['titulo']}');

                                                                //           }
                                                                //         }

                                                                //         if (_trabajosRealizados >=
                                                                //                 _totalDeActividades &&
                                                                //             _trabajosRealizados !=
                                                                //                 0) {
                                                                //           NotificatiosnService.showSnackBarSuccsses(
                                                                //               '"${x['nombre']}"  Tiene Actividades completas ');
                                                                //         } else {
                                                                //           infoContrtoller
                                                                //               .resetValuesRonda();
                                                                //           infoContrtoller
                                                                //               .setNombreEvento(x['nombre']);

                                                                //           Navigator.push(
                                                                //               context,
                                                                //               MaterialPageRoute(
                                                                //                   builder: ((context) => CrearRondaAsignada(
                                                                //                         lugar: _lugar,
                                                                //                          requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
                                                                //                       ))));
                                                                //         }

                                                                //         //======================================//

                                                                //       }
                                                                //     } else {
                                                                //       NotificatiosnService
                                                                //           .showSnackBarError(
                                                                //               'Fuera de fecha de la actividad');
                                                                //     }

                                                                //     //=======================================//

                                                                //   } else {
                                                                //     NotificatiosnService
                                                                //         .showSnackBarError(
                                                                //             'La actividad ya está finalizada');
                                                                //   }
                                                                // }


                                                                    }
                                                                    //***********************************************//

  


    } else {
       NotificatiosnService.showSnackBarError('No puede realizar actividad');
                                                                      
    }



                                                                        //  print("La fecha $fechaLocalInicio fechaLocalInicio.");
                                                                        //   print("La fecha $fechaLocalFin fechaLocalFin.");
                                                                        //   //  print("La fecha $formattedTime formattedTime.");
                                                                        //     print("La fecha $fechaActual fechaActual.");



                                                              
                                                                //**********************************************************************//




                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .add_circle,
                                                                color: Colors
                                                                    .white,
                                                                size: size
                                                                    .iScreen(
                                                                        3.5),
                                                              ),
                                                            )
                                                          : Icon(
                                                              Icons.lock_clock,
                                                              color:
                                                                  Colors.white,
                                                              size: size
                                                                  .iScreen(3.5),
                                                            ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                            
                                          },
                                        ),

                                        //==========================================//
//                                         Wrap(
//                                             children:
                                            
//                                                 (x['horario'] as List).map((e) {
//                                           final now = DateTime.now();
//                                           final hora = now.hour;
//                                           final minutos = now.minute;
//                                           // final segundos = now.second;
//                                           bool _colorHora = false;

//                                           String _hotaActual =
//                                               "${hora.toString()}:${minutos.toString()}";

//                                           if (_hotaActual.compareTo(
//                                                   "${e['horaFinal']}") >
//                                               0) {
//                                             // print('El _hotaActual $_hotaActual es mayor que "${e['horaFinal']}"');
//                                             _colorHora = true;
//                                           } else if (_hotaActual.compareTo(
//                                                   "${e['horaFinal']}") <
//                                               0) {
//                                             _colorHora = false;
//                                             // print('El _hotaActual $_hotaActual es mayor que "${e['horaFinal']}"');
//                                             // print('El _hotaActual $_hotaActual es menor que "${e['horaFinal']}"');
//                                           } else {
//                                             _colorHora = false;
//                                             // print('El _hotaActual $_hotaActual es igual a "${e['horaFinal']}"');
//                                           }

//                                           // print('El NOMBRE DE ACTIVIDAD despues  $_nombreDeActividad}');

// //   for (var item in infoContrtoller.getInfoActividad['act_asigEveActividades']) {
// // if(x['nombre']==item['nombre']){
// //   print('El NOMBRE DE ACTIVIDAD ${item['nombre']}');

// // }

// //   }

//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               border: Border.all(
//                                                 color: value
//                                                     .getPrimaryTextColor!
//                                                     .withOpacity(0.7),
//                                               ),
//                                             ),
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: size.iScreen(0.3)),
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: size.iScreen(1.0),
//                                                 vertical: size.iScreen(0.5)),
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   width: size.wScreen(100.0),
//                                                   child: Row(
//                                                     children: [
//                                                       Text('Observación: ',
//                                                           style: GoogleFonts
//                                                               .lexendDeca(
//                                                                   fontSize: size
//                                                                       .iScreen(
//                                                                           1.8),
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .normal)),
//                                                       Expanded(
//                                                         child: Text(
//                                                             e['observacion'] !=
//                                                                     ''
//                                                                 ? e[
//                                                                     'observacion']
//                                                                 : "Ninguna",
//                                                             style: GoogleFonts
//                                                                 .lexendDeca(
//                                                                     fontSize: size
//                                                                         .iScreen(
//                                                                             1.8),
//                                                                     // color: Colors.grey,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal)),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 //  for (var item in infoContrtoller.getInfoActividad['act_asigEveActividades'].length)

//                                                 Container(
//                                                   width: size.wScreen(100.0),
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                     color: _colorHora == true
//                                                         ? tercearyColor
//                                                             .withOpacity(0.60)
//                                                         : value
//                                                             .getPrimaryTextColor!
//                                                             .withOpacity(0.60),
//                                                   ),
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical:
//                                                           size.iScreen(0.3)),
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal:
//                                                           size.iScreen(1.0),
//                                                       vertical:
//                                                           size.iScreen(0.5)),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Row(children: [
//                                                             Container( 
//                                                               width:
//                                                                   size.wScreen(
//                                                                       23.0),
//                                                               child: Text(
//                                                                   'H Inicio: ',
//                                                                   style: GoogleFonts.lexendDeca(
//                                                                       fontSize:
//                                                                           size.iScreen(
//                                                                               1.8),
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .normal)),
//                                                             ),
//                                                             Text(
//                                                                 " ${e['hora']}",
//                                                                 style: GoogleFonts.lexendDeca(
//                                                                     fontSize: size
//                                                                         .iScreen(
//                                                                             1.8),
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold))
//                                                           ]),
//                                                           Row(children: [
//                                                             Container(
//                                                               width:
//                                                                   size.wScreen(
//                                                                       23.0),
//                                                               child: Text(
//                                                                   'H Fin: ',
//                                                                   style: GoogleFonts.lexendDeca(
//                                                                       fontSize:
//                                                                           size.iScreen(
//                                                                               1.8),
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .normal)),
//                                                             ),
//                                                             Text(
//                                                                 " ${e['horaFinal']}",
//                                                                 style: GoogleFonts.lexendDeca(
//                                                                     fontSize: size
//                                                                         .iScreen(
//                                                                             1.8),
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold))
//                                                           ]),
//                                                         ],
//                                                       ),
//                                                       _colorHora == false
//                                                           ? InkWell(
//                                                               onTap: () {
//                                                                 // String
//                                                                 //     fechaStringDesde =
//                                                                 //     // "${infoContrtoller.getInfoActividad['act_asigTurno']['desde']}";
//                                                                 //     "$fechaLocalInicio";
//                                                                 // String
//                                                                 //     fechaStringHasta =
//                                                                 //     // "${infoContrtoller.getInfoActividad['act_asigTurno']['hasta']}";
//                                                                 //     "$fechaLocalFin";
//                                                                 // DateTime
//                                                                 //     fechaDesde =
//                                                                 //     DateTime.parse(
//                                                                 //         fechaStringDesde);
//                                                                 // DateTime
//                                                                 //     fechaHasta =
//                                                                 //     DateTime.parse(
//                                                                 //         fechaStringHasta);

//                                                                 // DateTime
//                                                                 //     fechaActual =
//                                                                 //     DateTime
//                                                                 //         .now();
//                                                                 // //=================================================================================//
//                                                                 // if (fechaDesde
//                                                                 //     .isAfter(
//                                                                 //         fechaActual)) {
//                                                                 //   // print("La fecha $fechaStringDesde es mayor que la fecha actual.");
//                                                                 //   //=================================================================================//

//                                                                 //   NotificatiosnService
//                                                                 //       .showSnackBarDanger(
//                                                                 //           'La actividad no es posible en este momento.');
//                                                                 // } else {
//                                                                 //   bool
//                                                                 //       _fechaInicio =
//                                                                 //       false;
//                                                                 //   bool
//                                                                 //       _actualHora =
//                                                                 //       false;
//                                                                 //   final nowDate =
//                                                                 //       DateTime
//                                                                 //           .now();
//                                                                 //   final _fechaActividad =
//                                                                 //       DateTime.parse(
//                                                                 //           infoContrtoller.getInfoActividad['act_asigTurno']
//                                                                 //               [
//                                                                 //               'hasta']);

//                                                                 //   // print('FECHA $_fechaActividad');

//                                                                 //   int resultado =
//                                                                 //       nowDate.compareTo(
//                                                                 //           _fechaActividad);

//                                                                 //   if (resultado <
//                                                                 //       0) {
//                                                                 //     // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
//                                                                 //     _actualHora =
//                                                                 //         false;
//                                                                 //   } else if (resultado >
//                                                                 //       0) {
//                                                                 //     // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
//                                                                 //     _actualHora =
//                                                                 //         true;
//                                                                 //   } else {
//                                                                 //     // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
//                                                                 //     _actualHora =
//                                                                 //         false;
//                                                                 //   }

//                                                                 //   //======================================//
//                                                                 //   if (infoContrtoller
//                                                                 //               .getInfoActividad[
//                                                                 //           'act_asigEstado'] !=
//                                                                 //       "FINALIZADA") {
//                                                                 //     //=======================//

//                                                                 //     if (_actualHora ==
//                                                                 //         false) {
//                                                                 //       if (infoContrtoller
//                                                                 //               .getInfoActividad['act_asigEveTipo'] ==
//                                                                 //           "INVENTARIO INTERNO") {
//                                                                 //         Navigator.push(
//                                                                 //             context,
//                                                                 //             MaterialPageRoute(builder: ((context) => CrearActividadDesignada( requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
//                                                                 //       } else if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
//                                                                 //               "RONDAS" ||
//                                                                 //           infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
//                                                                 //               "INVENTARIO EXTERNO") {
//                                                                 //         //======================================//
//                                                                 //         final _lugar =
//                                                                 //             infoContrtoller.getInfoActividad['act_asigEveTipo'];

//                                                                 //         int _trabajosRealizados =
//                                                                 //             0;
//                                                                 //         for (var item
//                                                                 //             in infoContrtoller.getInfoActividad['act_asigTrabajos']) {
//                                                                 //           //  String myString = "5**CASA 2";
//                                                                 //           List<String>
//                                                                 //               parts =
//                                                                 //               item['qr'].split("**");
//                                                                 //           String
//                                                                 //               result =
//                                                                 //               parts[1].trim();
//                                                                 //           if (result ==
//                                                                 //               x['nombre']) {
//                                                                 //             _trabajosRealizados =
//                                                                 //                 _trabajosRealizados + 1;
//                                                                 //             // print('TRABAJOS :${item['titulo']}');

//                                                                 //           }
//                                                                 //         }

//                                                                 //         if (_trabajosRealizados >=
//                                                                 //                 _totalDeActividades &&
//                                                                 //             _trabajosRealizados !=
//                                                                 //                 0) {
//                                                                 //           NotificatiosnService.showSnackBarSuccsses(
//                                                                 //               '"${x['nombre']}"  Tiene Actividades completas ');
//                                                                 //         } else {
//                                                                 //           infoContrtoller
//                                                                 //               .resetValuesRonda();
//                                                                 //           infoContrtoller
//                                                                 //               .setNombreEvento(x['nombre']);

//                                                                 //           Navigator.push(
//                                                                 //               context,
//                                                                 //               MaterialPageRoute(
//                                                                 //                   builder: ((context) => CrearRondaAsignada(
//                                                                 //                         lugar: _lugar,
//                                                                 //                          requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
//                                                                 //                       ))));
//                                                                 //         }

//                                                                 //         //======================================//

//                                                                 //       }
//                                                                 //     } else {
//                                                                 //       NotificatiosnService
//                                                                 //           .showSnackBarError(
//                                                                 //               'Fuera de fecha de la actividad');
//                                                                 //     }

//                                                                 //     //=======================================//

//                                                                 //   } else {
//                                                                 //     NotificatiosnService
//                                                                 //         .showSnackBarError(
//                                                                 //             'La actividad ya está finalizada');
//                                                                 //   }
//                                                                 // }

//                                                                 //*************************************************************************//

//                                                                   String
//                                                                     fechaStringDesde =
//                                                                     // "${infoContrtoller.getInfoActividad['act_asigTurno']['desde']}";
//                                                                     "$fechaLocalInicio";
//                                                                 String
//                                                                     fechaStringHasta =
//                                                                     // "${infoContrtoller.getInfoActividad['act_asigTurno']['hasta']}";
//                                                                     "$fechaLocalFin";
//                                                                 DateTime
//                                                                     fechaDesde =
//                                                                     DateTime.parse(
//                                                                         fechaStringDesde);
//                                                                 DateTime
//                                                                     fechaHasta =
//                                                                     DateTime.parse(
//                                                                         fechaStringHasta);




//                                                                         DateTime now = DateTime.now();

//  DateTime fechaActual = DateTime(
//     now.year,
//     now.month,
//     now.day,
//     now.hour,
//     now.minute,
//   );


//   // DateTime now = DateTime.now();
// // String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
// // DateTime fechaActual = DateFormat('yyyy-MM-dd HH:mm').parse(formattedTime);

// //  String fechaString = "2024-03-22 22:36:00.000";
// //     DateTime fechaActual = DateTime.parse(fechaString);
// //     String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(fechaActual);


//                                                                     //  DateTime now = DateTime.now();
//                                                                     //  DateTime fechaActual = DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(now));
                                                                     
                                                               

//                                                                          print("La fecha $fechaLocalInicio fechaLocalInicio.");
//                                                                           print("La fecha $fechaLocalFin fechaLocalFin.");
//                                                                           //  print("La fecha $formattedTime formattedTime.");
//                                                                             print("La fecha $fechaActual fechaActual.");

//                                                                 //=================================================================================//
//                                                                 if (fechaDesde
//                                                                     .isAfter(
//                                                                         fechaActual)) {
//                                                                   // print("La fecha $fechaStringDesde es mayor que la fecha actual.");
//                                                                   //=================================================================================//

//                                                                   NotificatiosnService
//                                                                       .showSnackBarDanger(
//                                                                           'La actividad no es posible en este momento.');
//                                                                 } 
//                                                                 else {
//                                                                   bool
//                                                                       _fechaInicio =
//                                                                       false;
//                                                                   bool
//                                                                       _actualHora =
//                                                                       false;
//                                                                   final nowDate =
//                                                                       DateTime
//                                                                           .now();
//                                                                   final _fechaActividad =
//                                                                       DateTime.parse(
//                                                                           infoContrtoller.getInfoActividad['act_asigTurno']
//                                                                               [
//                                                                               'hasta']);

//                                                                   // print('FECHA $_fechaActividad');

//                                                                   int resultado =
//                                                                       nowDate.compareTo(
//                                                                           _fechaActividad);

//                                                                   if (resultado <
//                                                                       0) {
//                                                                     // print('La fecha1 $nowDate es anterior a la fecha2   $_fechaActividad');
//                                                                     _actualHora =
//                                                                         false;
//                                                                   } else if (resultado >
//                                                                       0) {
//                                                                     // print('La fecha1 $nowDate es posterior a la fecha2 $_fechaActividad');
//                                                                     _actualHora =
//                                                                         true;
//                                                                   } else {
//                                                                     // print('La fecha1 nowDate es igual a la fecha2 $_fechaActividad');
//                                                                     _actualHora =
//                                                                         false;
//                                                                   }

//                                                                   //======================================//
//                                                                   if (infoContrtoller
//                                                                               .getInfoActividad[
//                                                                           'act_asigEstado'] !=
//                                                                       "FINALIZADA") {
//                                                                     //=======================//

//                                                                     if (_actualHora ==
//                                                                         false) {
//                                                                       if (infoContrtoller
//                                                                               .getInfoActividad['act_asigEveTipo'] ==
//                                                                           "INVENTARIO INTERNO") {
//                                                                         Navigator.push(
//                                                                             context,
//                                                                             MaterialPageRoute(builder: ((context) => CrearActividadDesignada( requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],))));
//                                                                       } else if (infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
//                                                                               "RONDAS" ||
//                                                                           infoContrtoller.getInfoActividad['act_asigEveTipo'] ==
//                                                                               "INVENTARIO EXTERNO") {
//                                                                         //======================================//
//                                                                         final _lugar =
//                                                                             infoContrtoller.getInfoActividad['act_asigEveTipo'];

//                                                                         int _trabajosRealizados =
//                                                                             0;
//                                                                         for (var item
//                                                                             in infoContrtoller.getInfoActividad['act_asigTrabajos']) {
//                                                                           //  String myString = "5**CASA 2";
//                                                                           List<String>
//                                                                               parts =
//                                                                               item['qr'].split("**");
//                                                                           String
//                                                                               result =
//                                                                               parts[1].trim();
//                                                                           if (result ==
//                                                                               x['nombre']) {
//                                                                             _trabajosRealizados =
//                                                                                 _trabajosRealizados + 1;
//                                                                             // print('TRABAJOS :${item['titulo']}');

//                                                                           }
//                                                                         }

//                                                                         if (_trabajosRealizados >=
//                                                                                 _totalDeActividades &&
//                                                                             _trabajosRealizados !=
//                                                                                 0) {
//                                                                           NotificatiosnService.showSnackBarSuccsses(
//                                                                               '"${x['nombre']}"  Tiene Actividades completas ');
//                                                                         } else {
//                                                                           infoContrtoller
//                                                                               .resetValuesRonda();
//                                                                           infoContrtoller
//                                                                               .setNombreEvento(x['nombre']);

//                                                                           Navigator.push(
//                                                                               context,
//                                                                               MaterialPageRoute(
//                                                                                   builder: ((context) => CrearRondaAsignada(
//                                                                                         lugar: _lugar,
//                                                                                          requeridos: infoContrtoller.getInfoActividad[ 'act_asigRequerimientosActividad'],
//                                                                                       ))));
//                                                                         }

//                                                                         //======================================//

//                                                                       }
//                                                                     } else {
//                                                                       NotificatiosnService
//                                                                           .showSnackBarError(
//                                                                               'Fuera de fecha de la actividad');
//                                                                     }

//                                                                     //=======================================//

//                                                                   } else {
//                                                                     NotificatiosnService
//                                                                         .showSnackBarError(
//                                                                             'La actividad ya está finalizada');
//                                                                   }
//                                                                 }


//                                                                 //**********************************************************************//




//                                                               },
//                                                               child: Icon(
//                                                                 Icons
//                                                                     .add_circle,
//                                                                 color: Colors
//                                                                     .white,
//                                                                 size: size
//                                                                     .iScreen(
//                                                                         3.5),
//                                                               ),
//                                                             )
//                                                           : Icon(
//                                                               Icons.lock_clock,
//                                                               color:
//                                                                   Colors.white,
//                                                               size: size
//                                                                   .iScreen(3.5),
//                                                             ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           );
//                                         }
//                                         ).toList(),

//                                         //========================================//

//                                         // Container(
//                                         //   decoration: BoxDecoration(
//                                         //       // color: value.getPrimaryTextColor,
//                                         //       borderRadius: BorderRadius.circular(8.0)),
//                                         //   margin: EdgeInsets.symmetric(
//                                         //       horizontal: size.iScreen(5.0),
//                                         //       vertical: size.iScreen(0.0)),
//                                         //   padding: EdgeInsets.symmetric(
//                                         //       horizontal: size.iScreen(3.0),
//                                         //       vertical: size.iScreen(0.5)),
//                                         //   child:
//                                         //   Text('Ver Detalle',
//                                         //           style: GoogleFonts.lexendDeca(
//                                         //             fontSize: size.iScreen(2.0),
//                                         //             fontWeight: FontWeight.normal,
//                                         //             color: value.getPrimaryTextColor,
//                                         //           ))
//                                         // GestureDetector(
//                                         //   child: Container(
//                                         //     alignment: Alignment.center,
//                                         //     height: size.iScreen(3.5),
//                                         //     width: size.iScreen(8.0),
//                                         //     child: Text('Detalle',
//                                         //         style: GoogleFonts.lexendDeca(
//                                         //           fontSize: size.iScreen(2.0),
//                                         //           fontWeight: FontWeight.normal,
//                                         //           // color: Colors.white,
//                                         //         )),
//                                         //   ),
//                                         //   onTap: () {
//                                         //     // _onSubmit(context, controller);
//                                         //   },
//                                         // ),
//                                         //    Container(
//                                         //   decoration: BoxDecoration(
//                                         //       color:value.getPrimaryTextColor,
//                                         //       borderRadius: BorderRadius.circular(8.0)),
//                                         //   margin: EdgeInsets.symmetric(
//                                         //       horizontal: size.iScreen(0.0),
//                                         //       vertical: size.iScreen(0.3)),
//                                         //   padding: EdgeInsets.symmetric(
//                                         //       horizontal: size.iScreen(3.0),
//                                         //       vertical: size.iScreen(0.0)),
//                                         //   child: GestureDetector(
//                                         //     child: Container(
//                                         //       alignment: Alignment.center,
//                                         //       height: size.iScreen(3.5),
//                                         //       width: size.iScreen(6.0),
//                                         //       child: Text('Detalle',
//                                         //           style: GoogleFonts.lexendDeca(
//                                         //             // fontSize: size.iScreen(2.0),
//                                         //             fontWeight: FontWeight.normal,
//                                         //             color: Colors.white,
//                                         //           )),
//                                         //     ),
//                                         //     onTap: () {
//                                         //       // _onSubmit(context, controller);
//                                         //     },
//                                         //   ),
//                                         // // ),
//                                         // ),
//                                         //===========================================//
//                                         )
                                        
                                        
                                        
                                        //==========================================/
                                          ],
                                        ):Container(),
                                      
                                      
                                        ],
                                    ))),
                                //*****************************************/

                                SizedBox(
                                  height: size.iScreen(1.0),
                                ),

                                //==========================================//
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.0),
                  ),

                  //==========================================//
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




// Función para validar si la hora actual está entre horaA y horaB
 bool validarFecha(DateTime fechaActual, DateTime fechaInicio, DateTime fechaFin) {
    return fechaActual.isAfter(fechaInicio) && fechaActual.isBefore(fechaFin);
  }

// void validarHora(String startTime, String endTime) {
//   DateTime now = DateTime.now();
  
//   // Convertir la hora actual a un formato comparable
//   String currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  
//   // Validar si la hora actual está entre startTime y endTime
//   if (currentTime.compareTo(startTime) >= 0 && currentTime.compareTo(endTime) <= 0) {
//     print("La hora actual está entre $startTime y $endTime");
//   } else {
//     print("La hora actual NO está entre $startTime y $endTime");
//   }
// }
bool validarHora(String startTime, String endTime) {
  DateTime now = DateTime.now();
  
  // Convertir la hora actual a un formato comparable
  String currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  
  // Validar si la hora actual está entre startTime y endTime
  if (currentTime.compareTo(startTime) >= 0 && currentTime.compareTo(endTime) <= 0) {
    return true;
  } else {
    return false;
  }
}

}

//=======================================/
