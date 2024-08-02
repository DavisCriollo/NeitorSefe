import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';


import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';

class DetalleActividadesRonda extends StatelessWidget {
  final String tipo;
  final Map<String,dynamic> dataRonda;
  final Map<String,dynamic> requeridos;
  const DetalleActividadesRonda({Key? key, required this.dataRonda, required this.tipo, required this.requeridos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final _user = context.read<HomeController>();
    final _ctrl = context.read<ActividadesAsignadasController>();
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
              'Detalle $tipo',
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
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),
                  //***********************************************/
                  Container(
                    width: size.wScreen(100.0),

                    // color: Colors.blue,
                    child: Text('Actividad:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      // 'item Novedad: ${controllerActividades.getItemMulta}',
                      '"${dataRonda['actividad']}"',
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

               dataRonda['trabajos'].isNotEmpty?   Wrap(
                    children:
                        (dataRonda['trabajos'] as List)
                            .map(
                              (e) {
                                    String fechaLocal = DateUtility.fechaLocalConvert(e['fecha']!.toString());
                                return Card(
                                child: Padding(
                                  padding:  EdgeInsets.all(size.iScreen(1.0)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: size.iScreen(0.5),),
                                      Row(
                                        children: [
                                          Container(
                                            // width: size.wScreen(100.0),
                              
                                            // color: Colors.blue,
                                            child: Text('Fecha : ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                                                            Container(
                                        // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                        // width: size.wScreen(100.0),
                                        child: Expanded(
                                          child: Text(
                                            '$fechaLocal',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.7),
                                                // color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                        ],
                                      ),
                                       SizedBox(height: size.iScreen(0.5),),
                                      Row(
                                        children: [
                                          Container(
                                            // width: size.wScreen(100.0),
                              
                                            // color: Colors.blue,
                                            child: Text('Título : ',
                                                style: GoogleFonts.lexendDeca(
                                                    // fontSize: size.iScreen(2.0),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                                                                            Container(
                                        // margin: EdgeInsets.symmetric(vertical: size.iScreen(2.0)),
                                        // width: size.wScreen(100.0),
                                        child: Expanded(
                                          child: Text(
                                            '${e['titulo']}',
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
                                        e['fotos'].isNotEmpty
                                        ?  Column(children: [
                                   SizedBox(
                                                      height: size.iScreen(1.0),
                                                    ),
                                                    //*****************************************/
                                                    SizedBox(
                                                      width: size.wScreen(100.0),
                                                      // color: Colors.blue,
                                                      child:
                                                          Text('Fotos:  ${e['fotos']!.length}',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                                                    ),
                                                    //*****************************************/
                              
                                                    SizedBox(
                                                      height: size.iScreen(1.0),
                                                    ),
                                                    //*****************************************/
                                                 
                                                      
                                  Wrap(
                                    children:(e['fotos'] as List).map((e) => Column(
                                      children: [
                                        FadeInImage(
                                          placeholder: const AssetImage(
                                              'assets/imgs/loader.gif'),
                                          image: NetworkImage(
                                            '${e['url']}',
                                          ),
                                        ),
                                        //*****************************************/
                              
                                        SizedBox(
                                          height: size.iScreen(1.0),
                                        ),
                                        //*****************************************/
                                      ],
                                    )
                                                  ).toList(),
                                  )
                              
                              
                                            
                                          ],): Container(),
                              
                              
                                        e['videos'].isNotEmpty
                                        ?  Column(children: [
                                   SizedBox(
                                                      height: size.iScreen(1.0),
                                                    ),
                                                    //*****************************************/
                                                    SizedBox(
                                                      width: size.wScreen(100.0),
                                                      // color: Colors.blue,
                                                      child:
                                                          Text('Videos:  ${e['videos']!.length}',
                                  style: GoogleFonts.lexendDeca(
                                      // fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                                                    ),
                                                    //*****************************************/
                              
                                                    SizedBox(
                                                      height: size.iScreen(1.0),
                                                    ),
                                                    //*****************************************/
                                                 
                                                      
                                  Wrap(
                                    children:(e['fotos'] as List).map((e) => Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 16 / 16,
                                          child: BetterPlayer.network(
                                           '${e['url']}',
                                            betterPlayerConfiguration: const BetterPlayerConfiguration(
                                              aspectRatio: 16 / 16,
                                            ),
                                          ),
                                        ),
                                        //*****************************************/
                              
                                        SizedBox(
                                          height: size.iScreen(1.0),
                                        ),
                                        //*****************************************/
                                      ],
                                    )
                                                  ).toList(),
                                  )
                              
                              
                                            
                                          ],): Container(),
                              
                                           
                              
                                                    //*****************************************/
                              
                                                    SizedBox(
                                                      height: size.iScreen(3.0),
                                                    ),
                                                    //*****************************************/
                                                   
                                                 
                                    ],
                                  ),
                                ),
                              );
                              },
                            )
                            .toList(),
                  ):const NoData(label: 'No Tiene actividades Realizadas'),
                  //*****************************************/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  
}

