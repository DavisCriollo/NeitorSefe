
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';

import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';


class ComunicadoLeidoGuardiaPage extends StatefulWidget {
  // final Result? infoComunicadoCliente;

  const ComunicadoLeidoGuardiaPage({Key? key})
      : super(key: key);




  @override
  State<ComunicadoLeidoGuardiaPage> createState() => _ComunicadoLeidoGuardiaPageState();
}

class _ComunicadoLeidoGuardiaPageState extends State<ComunicadoLeidoGuardiaPage> {


@override
void initState() {

 super.initState();
  
}


  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    final comunicadoController = Provider.of<AvisosController>(context);
      final ctrlTheme = context.read<ThemeApp>();
        


var _fecha= '${comunicadoController.getListaTodosLosAvisos[0]['aviFechasAviso'][0]}';
var millis = 1678897322670;
var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

// 24 Hour format:
var d24 = DateFormat('dd-MM-yyyy, HH:mm').format(dt); // 31/12/2000, 22:00

   String fechaLocal = DateUtility.fechaLocalConvert( comunicadoController.getComunicado['aviFecReg']!.toString());


  final _user = context.read<HomeController>();




 final  _infoRespuesta=[];
for (var item in comunicadoController.getComunicado['aviDirigido']) {
  // print('EL ITEM ${item.runtimeType}');
  // print('EL ITEM ${item['docnumero']}');
  // print('EL ITEM ${item['respuesta']}');
 

if(_user.getUsuarioInfo!.usuario==item['docnumero'].toString()){

 if(item['respuesta']!=null){
  _infoRespuesta.add(item['respuesta']);


 }else{
  _infoRespuesta.clear();
 }
 
}
else{
  _infoRespuesta.clear();
}






}




  
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: primaryColor,
             
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
            title:  Text('Detalle de Comunicado',
            // style:  Theme.of(context).textTheme.headline2,
            ),
           
          ),
          body: 
          
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
            width: size.wScreen(100.0),
            height: size.hScreen(100),
            child: 
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: 
              Column(
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
                        const Spacer(),
                        Text(
                          // '${comunicadoController.getComunicado['aviFecReg']}'
                          //       .toString()
                          //       .replaceAll("T", " ")
                          //       .replaceAll(".000Z", " "),
                          fechaLocal,
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                    width: size.wScreen(100.0),
                    child: Text(
                      // 'item Novedad: ${controllerActividades.getItemMulta}',
                      // '"${comunicadoController.getItemAsunto}"',
                      '" ${comunicadoController.getComunicado['aviAsunto']} "',
                      // '"${comunicadoController.getListaTodosLosAvisos[0]['aviAsunto']}"',
                      // '"${comunicadoController.getListaTodosLosAvisos}"',
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
                  Row(
                    children: [
                      Container(
                        width: size.wScreen(15.0),
                       
                        child: Text('Remite:',
                            style: GoogleFonts.lexendDeca(
                                // fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       Expanded(
                         child: Container(
                                           margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                                           // width: size.wScreen(100.0),
                                           child: Text(
                         '${comunicadoController.getComunicado['aviUser']} ',
                                             style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            // color: Colors.white,
                            fontWeight: FontWeight.normal),
                                           ),
                                         ),
                       ),
                    ],
                  ),
                 
                 
                  //***********************************************/
                  SizedBox(
                    height: size.iScreen(0.0),
                  ),

                  //*****************************************/
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Fecha de la Actividad :',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                 
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: size.iScreen(1.0)),
                  //   width: size.wScreen(100.0),
                  //   child: Text(
                  //      d24,
                  //     style: GoogleFonts.lexendDeca(
                  //         fontSize: size.iScreen(1.8),
                  //         // color: Colors.white,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                   //==========================================//
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    // //==========================================//


                      Wrap(
                        spacing : size.iScreen(0.5),
                        
                         alignment : WrapAlignment.center,
                        children: (comunicadoController.getComunicado['aviFechasAvisoConsultaDB'] as List).map((e) => 
                       Chip(
                        
                        // padding:EdgeInsets.,
                        backgroundColor:  Colors.grey[300],
                        label:
                        Text(
                                  e['desde'] .toString()
                                .replaceAll("T", " ").substring(0,16),
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    // color: Colors.black45,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ).toList(),
                     
                      ),
                      
                 //==========================================//
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),

                    // //==========================================//
                       
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
                  comunicadoController.getComunicado['aviDetalle'].isEmpty
                  ?'--- --- --- --- --- '
                  :'${comunicadoController.getComunicado['aviDetalle']}',
                  style: GoogleFonts.lexendDeca(
                      fontSize: size.iScreen(1.8),
                      color:  comunicadoController.getComunicado['aviDetalle'].isEmpty? Colors.grey:null,
                      fontWeight: FontWeight.normal),
                ),
              ),
                 
               comunicadoController.getListaTodosLosAvisos[0]['aviDocumento']==''|| comunicadoController.getListaTodosLosAvisos[0]['aviDocumento']==null || comunicadoController.getListaTodosLosAvisos[0]['aviDocumento'].isEmpty
               ?Container():   Container(
                       
                        color: Colors.grey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Ver Documento ',
                                style: GoogleFonts
                                    .lexendDeca(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        color: Colors
                                            .black54)),
                                             IconButton(
                                                          onPressed: () {
                                                           
                                                               Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ViewsPDFs(
                                                                infoPdf:
                                                                    '${comunicadoController.getListaTodosLosAvisos[0]['aviDocumento']}',
                                                                labelPdf: 'archivo.pdf'
                                                               
                                                                )),
                                                      );
                                                          },
                                                          icon: const Icon(Icons
                                                              .remove_red_eye_outlined))
                          ],
                        ),
                      ),
                   //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                 comunicadoController.getListaTodosLosAvisos[0]['aviFotos'].length>0?    SizedBox(
                width: size.wScreen(100.0),
                // color: Colors.blue,
                child: Text('Fotos: ${comunicadoController.getListaTodosLosAvisos[0]['aviFotos'].length}',
                    style: GoogleFonts.lexendDeca(
                     
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ):Container(),
                 //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
             comunicadoController.getListaTodosLosAvisos[0]['aviFotos'].length>0? Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                width: size.wScreen(100.0),
                child: 
                Wrap(children:(comunicadoController.getListaTodosLosAvisos[0]['aviFotos'] as List).map((e)=> FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),
                                      image: NetworkImage(
                                        '${e['url']}',
                                      ),
                                    ),).toList())
              
              ):Container(),


                //================================//
               _infoRespuesta.isNotEmpty 
              ?
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Respuesta al comunicado:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                width: size.wScreen(100.0),
                child: 
                Wrap(children:(_infoRespuesta) .map((e) => SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text(e,
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.8),
                            fontWeight: FontWeight.normal,
                        
                            )),
                  ) ).toList(),)
                
                
              ),
                ],
              )
              :Container()
              
                //================================//





              ],
              ),
            ),
          ),
          
          
          
            floatingActionButton: 
             _infoRespuesta.isEmpty ? FloatingActionButton(child:Icon(Icons.message_outlined),onPressed: () {  
            bottomSheet(comunicadoController, context, size);
           
          },
        ):Container(),
      ),
    ));
  }
  
}
void bottomSheet(
    AvisosController controllerComunicados,
    BuildContext context,
    Responsive size,
  ) {
   showModalBottomSheet(
    shape:  const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,

    
    context: context,
    
    builder: (context) {
      return Container(
        // color: Colors.red,
        height: size.hScreen(50.0),
        margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
        child: Form(
          key: controllerComunicados.comunicadosRespondeFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                //*****************************************/
                        
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
        
                //*****************************************/
                        
                        Container(
                          width: size.wScreen(100.0),
                          alignment: Alignment.center,
                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Text('Responder al Comunicado  ',
                                  style: GoogleFonts.lexendDeca(
                                      fontSize: size.iScreen(2.0),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                                      Icon(Icons.message, color:  Colors.grey,)
                            ],
                          ),
                        ),
                //*****************************************/
                        
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
        
                //*****************************************/
                        
                        // SizedBox(
                        //   width: size.wScreen(100.0),
                        //   // color: Colors.blue,
                        //   child: Text('Asunto:',
                        //       style: GoogleFonts.lexendDeca(
                        //           // fontSize: size.iScreen(2.0),
                        //           fontWeight: FontWeight.normal,
                        //           color: Colors.grey)),
                        // ),
                        //==========================================//
                        TextFormField(
                         
                          decoration: const InputDecoration(
                              // suffixIcon: Icon(Icons.beenhere_outlined)
                              ),
                          textAlign: TextAlign.start,
                          minLines: 1,
                          maxLines: 5,
                        
                           style: const TextStyle(),
            textInputAction: TextInputAction.done,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  // RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                 RegExp(r'^[^\n"]*$')),
            ],
                          onChanged: (text) {
                            controllerComunicados.onInputRespondeComunicadoChange(text);
                          },
                         
                          validator: (text) {
                            if (text!.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Ingrese respuesta del comunicado';
                            }
                          },
                        ),
                         //*****************************************/
                        
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
        
                //*****************************************/
        
                      Container(
                                margin: EdgeInsets.only(
                                    top: size.iScreen(1.0),
                                    bottom: size.iScreen(2.0)),
                                height: size.iScreen(3.5),
                                child: Consumer<ThemeApp>(
                                  builder: (_, valueThem, __) {
                                    return ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            valueThem.primaryColor),
                                      ),
                                      onPressed: () {
                                        final isValid = controllerComunicados.validateFormResponde();
    if (!isValid) return;
    if (isValid)  {
     
//=======================================//
//      if (controller.nombreGuardia == '' || controller.nombreGuardia == null) {
//         NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
//       }  else if (controller.labelAvisoSalida == ''||controller.labelAvisoSalida == null) {
//         NotificatiosnService.showSnackBarDanger('Debe seleccionar motivo');
//       }  

      
//  else  if (controller.nombreGuardia!.isNotEmpty ||
//             controller.nombreGuardia != null &&
//                 controller.labelAvisoSalida!.isNotEmpty ||
//             controller.labelAvisoSalida != null 
                
        
//                 ) {
//           if (widget.action == 'CREATE') {
//                   await controller.crearAvisoSalida(context);
//             Navigator.pop(context);
//           }else
//           if (widget.action == 'EDIT') {
          

//           }
        
//=======================================//
                   controllerComunicados.respondeComunicado(controllerComunicados.getComunicado['aviId'],context);
            Navigator.pop(context);
            Navigator.pop(context);
              controllerComunicados.getTodosLosAvisos(controllerComunicados.getComunicado['aviId'].toString(), 'true');

//=======================================//
        }

                                      },
                                      child: Text('Responder',
                                          style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal)),
                                    );
                                  },
                                ),
                              ),
          //*****************************************/
                        
                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
        
                //*****************************************/
        
        
            ],
          ),
        ),
      );
    }
    
    );






    
  
}