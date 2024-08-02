import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';


import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:nseguridad/src/widgets/dropdown_estado_bitacora.dart';

class DetalleDeBitacora extends StatefulWidget {
  // final Result? infoComunicadoCliente;
   final  String? action;

  const DetalleDeBitacora({Key? key, this.action}) : super(key: key);

  @override
  State<DetalleDeBitacora> createState() => _DetalleDeBitacoraState();
}

class _DetalleDeBitacoraState extends State<DetalleDeBitacora> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  final ctrlTheme = context.read<ThemeApp>();
        

  final _user = context.read<HomeController>();
  final comunicadoController = context.read<BitacoraController>();
// String fechaLocal = DateUtility.fechaLocalConvert(comunicadoController.getInfoBitacora['bitFecReg'].toString());
String fechaRegistro = DateUtility.fechaLocalConvert(comunicadoController.getInfoBitacora['bitFecReg'].toString());
  String fechaLocalActualizacion =comunicadoController.getInfoBitacora['bitFecReg']==comunicadoController.getInfoBitacora['bitFecUpd']?'--- --- ---':DateUtility.fechaLocalConvert(comunicadoController.getInfoBitacora['bitFecUpd'].toString());

  
 final  _action = widget.action;
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
           title:  _action == 'CREATE' 
                  ? Text(
                      'Detalle de Bitácora',
                      // style: Theme.of(context).textTheme.headline2,
                    )
                  :_action == 'EDIT' 
                  ? Text(
                      'Editar Bitácora',
                      // style: Theme.of(context).textTheme.headline2,
                    ):Text(
                      'Detalle de Bitácora',
                      // style: Theme.of(context).textTheme.headline2,
                    ),
          actions: [
                _action == 'EDIT' && comunicadoController.getInfoBitacora['bitEstado'] !=
                       'ANULADA' ? Container(
                margin: EdgeInsets.only(right: size.iScreen(1.5)),
                child: IconButton(
                    splashRadius: 28,
                    onPressed: () {
                      _onSubmit(context, comunicadoController,'EDIT');
                    },
                    icon: Icon(
                      Icons.save_outlined,
                      size: size.iScreen(4.0),
                    )),
              ):Container(),
            ],
          ),
          body: Container(
           margin: EdgeInsets.only(top: size.iScreen(1.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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

                  _action == 'EDIT' &&comunicadoController.getInfoBitacora['bitEstado'] !=
                       'ANULADA' ?  Column(children: [
                        //***********************************************/
                SizedBox(
                  height: size.iScreen(1.0),
                ),
                //*****************************************/
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      // width: size.wScreen(100.0),
                      child: Text(
                        'Estado: ',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                      width: size.wScreen(60.0),
                      child: const DropMenuEstadoBitacora(
                        // title: 'Tipo de documento:',
                        data: [
                         'SALIDA', 'ANULADA','PENDIENTE'
                        ],
                        hinText: 'Seleccione',
                      ),
                    ),
                  ],
                ),

                    ],):Container(),
      //***********************************************/
                SizedBox(
                  height: size.iScreen(2.0),
                ),
                //*****************************************/

                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Persona: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        width: size.wScreen(70.0),
                        child: Text(
                          '${comunicadoController.getInfoBitacora['bitTipoPersona']}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Cédula: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        width: size.wScreen(70.0),
                        child: Text(
                         '${comunicadoController.getInfoBitacora['bitDocumento']}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      'Nombre: ',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      '${comunicadoController.getInfoBitacora['bitNombres']}',
                      // overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                    Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Teléfono: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        width: size.wScreen(70.0),
                        child: Text(
                         '${comunicadoController.getInfoBitacora['bitTelefono']}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  //   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Se dirige a: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                          child: Text(
                             '${comunicadoController.getInfoBitacora['bitResNombres']}',
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Row(
                    children: [
                      Container(
                       margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Fecha y hora de ingreso: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                        //  comunicadoController.getInfoBitacora['bitFecReg'].toString()
                        //                                 .replaceAll("T", "  ")
                        //                                 .replaceAll(
                        //                                     ".000Z", " "),
                       
                        fechaRegistro,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Row(
                    children: [
                      Container(
                       margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Fecha y hora de Salida: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                        //  comunicadoController.getInfoBitacora['bitFecReg'].toString()
                        //                                 .replaceAll("T", "  ")
                        //                                 .replaceAll(
                        //                                     ".000Z", " "),
                        //  comunicadoController.getInfoBitacora['bitEstadoIngreso'].toString(),
                        fechaLocalActualizacion,

                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: size.iScreen(0.5),
                  // ),

                  // // //*****************************************/
                  // Row(
                  //   children: [
                  //     Container(
                  //      margin: EdgeInsets.only(
                  //           top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                  //       child: Text(
                  //         'Fecha actualización: ',
                  //         style: GoogleFonts.lexendDeca(
                  //             fontSize: size.iScreen(1.8),
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.normal),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.only(
                  //           top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                  //       child: Text(
                  //        comunicadoController.getInfoBitacora['bitFecUpd'].toString()
                  //                                       .replaceAll("T", "  ")
                  //                                       .replaceAll(
                  //                                           ".000Z", " "),
                  //         overflow: TextOverflow.ellipsis,
                  //         style: GoogleFonts.lexendDeca(
                  //             fontSize: size.iScreen(1.8),
                  //             color: Colors.black87,
                  //             fontWeight: FontWeight.normal),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Row(
                    children: [
                      Container(
                       margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                          'Estado: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        child: Text(
                         '${comunicadoController.getInfoBitacora['bitEstado']}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color:
                              
                            comunicadoController.getInfoBitacora['bitEstado'] ==
               'INGRESO'
           ? tercearyColor
           : comunicadoController.getInfoBitacora['bitEstado'] ==
                   'SALIDA'
               ? secondaryColor
               : comunicadoController.getInfoBitacora['bitEstado'] ==
                       'ANULADA'
                   ? Colors.red
                   : primaryColor,
                              
                              
                            
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //   //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  // //*****************************************/
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                          'Observaciones: ',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.iScreen(0.5), bottom: size.iScreen(0.0)),
                        width: size.wScreen(100.0),
                        child: Text(
                         '${comunicadoController.getInfoBitacora['bitObservacion']}',
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                       //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    //==========================================//


  // //==========================================//
                 comunicadoController.getInfoBitacora['bitFotos']!.isNotEmpty
                      
                          ?Column(
        children: [
          Container(
            width: size.wScreen(100.0),
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(0.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografía: ${comunicadoController.getInfoBitacora['bitFotos'].length}',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          SingleChildScrollView(
            child:
               Wrap(
                children: (comunicadoController.getInfoBitacora['bitFotos'] as List).map((e) {



              return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.iScreen(0.0),
                          vertical: size.iScreen(0.5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(
                           
                          ),
                          width: size.wScreen(100.0),
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
      )
                        : Container(),
                  
                    //*****************************************/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onSubmit(
      BuildContext context, BitacoraController _controller, String _action) async {
         
          if (_controller.labelNombreEstadoBitacora==null|| _controller.labelNombreEstadoBitacora=='') {
        NotificatiosnService.showSnackBarDanger('Seleccione estado de Bitácora');
      }
        else  if (_controller.getInfoBitacora['bitEstado']==_controller.labelNombreEstadoBitacora) {
        NotificatiosnService.showSnackBarDanger('Ha seleccionado el mismo estado');
      }
      else{

           if (_action == 'EDIT') {
          _controller.editaBitacora(context);
            Navigator.pop(context);
          }

      }
    }

  //  fechaLocalConvert( String _fecha

  // ) {
  //     // String dateString = ;

  // // Convertir la cadena a un objeto DateTime en formato UTC
  // DateTime utcDateTime = DateTime.parse(_fecha);

  // // Obtener la zona horaria local
  // DateTime localDateTime = utcDateTime.toLocal();

  // // Formatear la fecha y hora en el formato deseado
  // String fechaLocal = DateFormat('yyyy-MM-dd HH:mm').format(localDateTime);
  // return fechaLocal;
  // }



}
