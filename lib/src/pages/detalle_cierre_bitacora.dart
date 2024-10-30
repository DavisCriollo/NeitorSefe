import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/cierre_bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';


class DetalleCierreBitacora extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final Responsive size = Responsive.of(context);
    final infoContrtoller = context.read<CierreBitacoraController>();
     final _user = context.read<HomeController>();
      String fechaLocal = DateUtility.fechaLocalConvert(
        infoContrtoller.getInfoBitacora['bitcFecReg']!.toString());
              final ctrlTheme = context.read<ThemeApp>();
    return GestureDetector(
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
                  'Detalle Cierre Bitácora',
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
      mainAxisSize: MainAxisSize.min, // Para minimizar el tamaño del Column
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
          ),
        ),
        //*****************************************/

        SizedBox(
          height: size.iScreen(1.0),
        ),

        //==========================================//
           Row(
          children: [
            SizedBox(
              child: Text('Estado: ',
                  style: GoogleFonts.lexendDeca(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
              child: Text(
                '${infoContrtoller.getInfoBitacora['bitcEstado']}',
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(2.0),
                    color: _colorEstado(infoContrtoller.getInfoBitacora['bitcEstado']),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        //*****************************************/

        SizedBox(
          height: size.iScreen(0.5),
        ),

        //==========================================//
        Row(
          children: [
            SizedBox(
              child: Text('Fecha de Registro: ',
                  style: GoogleFonts.lexendDeca(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
              child: Text(
                fechaLocal,
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.8),
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        //*****************************************/

        SizedBox(
          height: size.iScreen(0.5),
        ),

        //==========================================//
        Row(
          children: [
            SizedBox(
              child: Text('Documento: ',
                  style: GoogleFonts.lexendDeca(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
              child: Text(
              '${infoContrtoller.getInfoBitacora['cliDocNumero']}',
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.8),
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        //*****************************************/
        //*****************************************/

        SizedBox(
          height: size.iScreen(1.0),
        ),

        //==========================================//

        SizedBox(
             width: size.wScreen(100),
          child: Text('Razón Social: ',
              style: GoogleFonts.lexendDeca(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        Flexible(
          fit: FlexFit.loose, // Para permitir que el contenido se ajuste
          child: Container(
            width: size.wScreen(100),
            margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
            child: Text(
              '${infoContrtoller.getInfoBitacora['cliRazonSocial']}',
              style: GoogleFonts.lexendDeca(
                  fontSize: size.iScreen(1.8),
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),

        SizedBox(
          height: size.iScreen(1.0),
        ),

        //==========================================//
      

        SizedBox(
             width: size.wScreen(100),
          child: Text('Observaciobes: ',
              style: GoogleFonts.lexendDeca(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        Flexible(
          fit: FlexFit.loose, // Para permitir que el contenido se ajuste
          child: Container(
            width: size.wScreen(100),
            margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
            child: Text(
              '${infoContrtoller.getInfoBitacora['bitcObservacion']}',
              style: GoogleFonts.lexendDeca(
                  fontSize: size.iScreen(1.8),
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),

         //==========================================//

        SizedBox(
          height: size.iScreen(0.5),
        ),
  //==========================================//
        infoContrtoller.getInfoBitacora['bitcFotos'].isNotEmpty? 
        
        
         Column(
          children: [
             //==========================================//
        Row(
          children: [
            SizedBox(
              child: Text('Fotos: ',
                  style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.8),
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5)),
              child: Text(
               '${infoContrtoller.getInfoBitacora['bitcFotos'].length}',
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.8),
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
          SizedBox(
          height: size.iScreen(0.5),
        ),
        //*****************************************/
          infoContrtoller.getInfoBitacora['bitcFotos'].length>0?  Wrap(
               spacing: 8.0, // Espacio horizontal entre las fotos
                      runSpacing: 8.0,
                children:(infoContrtoller.getInfoBitacora['bitcFotos'] as List).map((e) => FadeInImage(
                                                                placeholder:
                                                                    const AssetImage(
                                                                          'assets/imgs/loader.gif'),
                                                                image: NetworkImage(
                                                                  '${e['url']}',
                                                                ),
                                                              )).toList(),
              ):Container(),
          ],
        ):Container(),
           //*****************************************/
        SizedBox(
          height: size.iScreen(1.0),
        ),
      //*****************************************/
      ],
    ),
  ),
),

       ),
    );
  }


// Función para determinar el color según el estado
Color _colorEstado(String estado) {
  switch (estado) {
    case 'APERTURA':
      return tercearyColor; // Color para APERTURA
    case 'CIERRE':
      return secondaryColor;  // Color para CIERRE
    case 'ANULADA':
      return cuaternaryColor;    // Color para ANULADA
    default:
      return Colors.black;  // Color por defecto
  }
  }


}