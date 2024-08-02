import 'dart:io';

import 'package:better_player/better_player.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';

import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/models/crea_fotos.dart';

import 'package:nseguridad/src/models/session_response.dart';

import 'package:nseguridad/src/pages/views_pdf.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleInformeGuardiaPage extends StatefulWidget {
  final Session? user;
  // Informe? informe;
  dynamic informe;
  DetalleInformeGuardiaPage({Key? key, this.informe, this.user})
      : super(key: key);

  @override
  State<DetalleInformeGuardiaPage> createState() =>
      _DetalleInformeGuardiaPageState();
}

class _DetalleInformeGuardiaPageState extends State<DetalleInformeGuardiaPage> {
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _horaInicioController = TextEditingController();

  final informesVideo = InformeController();

  late TimeOfDay timeInicio;

  @override
  void initState() {
    timeInicio = TimeOfDay.now();

    super.initState();
  }

  @override
  void dispose() {
    _fechaInicioController.clear();
    _horaInicioController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final informeController = Provider.of<InformeController>(context);
      final _user=context.read<HomeController>();
        final ctrlTheme = context.read<ThemeApp>();
         
       String fechaLocal = DateUtility.fechaLocalConvert(  widget.informe!['infFechaSuceso']!.toString());

       String _respuesta='';
       if( widget.informe!['infGuardias'].isNotEmpty ){


      for (var item in  widget.informe!['infGuardias']) {

        if(item['docnumero']==widget.user!.usuario.toString() && item['respuesta']!=null){
            _respuesta=item['respuesta'].toString();
        }
        
      }

       }


    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFEEEEEE),
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
              'Detalle de Informe',
              // style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    //====================/

                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewsPDFs(
                              infoPdf:
                                  'https://backsigeop.neitor.com/api/reportes/informeindividual?infId=${widget.informe['infId']}&rucempresa=${widget.user!.rucempresa}&usuario=${widget.user!.usuario}',
                              labelPdf: 'Informe.pdf')),
                    );
                    //====================/
                  },
                  icon: const FaIcon(FontAwesomeIcons.solidFilePdf),
                  splashRadius: size.iScreen(3.0),
                  splashColor: Colors.red,
                  color: Colors.white)
            ],
          ),
          body: Container(
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            padding: EdgeInsets.only(
              left: size.iScreen(1.0),
              right: size.iScreen(1.0),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: informeController.informesGuardiasFormKey,
                child: Column(
                  children: [
                      //*****************************************/
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
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      children: [
                        Container(
                          // width: size.wScreen(100.0),

                          // color: Colors.blue,
                          child: Text('Elaborado por: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          // width: size.wScreen(100.0),
                          // color: Colors.red,
                          padding: EdgeInsets.only(),
                          child: Text(
                            ' ${widget.informe!['infGenerado']}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/

                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Dirigido a :',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Text(
                        '${widget.informe!['infNomDirigido']}',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey
                        ),
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
                          child: Text('Asunto: ',
                              style: GoogleFonts.lexendDeca(
                                  // fontSize: size.iScreen(2.0),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                        ),
                        Container(
                          width: size.wScreen(73.0),
                          // color: Colors.red,
                          padding: EdgeInsets.only(),
                          child: Text(
                            ' ${widget.informe!['infAsunto']}',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              fontWeight: FontWeight.normal,
                              // color: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),

                    // //*****************************************/
                    SizedBox(
                      height: size.iScreen(2.0),
                    ),
                    Container(
                      width: size.wScreen(100),
                      child: Text(
                        'Fecha y hora del suceso:',
                        style: GoogleFonts.lexendDeca(
                          // fontSize: size.iScreen(1.8),
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    Container(
                      width: size.wScreen(100),
                      margin:
                          EdgeInsets.symmetric(horizontal: size.wScreen(3.5)),
                      child: Text(fechaLocal,
                        // widget.informe!['infFechaSuceso']
                        //     .toString()
                        //     replaceAll("T", "  "),
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          // color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Lugar:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Text(
                        '${widget.informe!['infLugar']}',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey
                        ),
                      ),
                    ),

                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Implicado:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Text(
                        '${widget.informe!['infPerjudicado']}',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey
                        ),
                      ),
                    ),

                    // //*****************************************/

                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      width: size.wScreen(100.0),

                      // color: Colors.blue,
                      child: Text('Detalle:',
                          style: GoogleFonts.lexendDeca(
                              // fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ),
                    Container(
                      width: size.wScreen(100.0),
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Text(
                        '${widget.informe!['infSucedido']}',
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey
                        ),
                      ),
                    ),
                   
                    //==========================================//
                    widget.informe!['infGuardias']!.isNotEmpty
                        ? _ListaGuardias(size: size, informe: widget.informe)
                        : Container(),
                    //*****************************************/
                   
                 widget.informe!['infFotos']!.isNotEmpty
                 ?   Column(
                      children: [
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                    SizedBox(
                      width: size.wScreen(100.0),
                      // color: Colors.blue,
                      child:
                          Text('Fotos:  ${widget.informe!['infFotos']!.length}',
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
                   
                    widget.informe!['infFotos']!.isNotEmpty
                      
                        ? SizedBox(
                            child: ListView.builder(
                              itemCount: widget.informe!['infFotos']!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/imgs/loader.gif'),
                                      image: NetworkImage(
                                        '${widget.informe!['infFotos']![index]['url']}',
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
                            height: size.iScreen(
                                widget.informe!['infFotos']!.length.toDouble() *
                                    36.0),
                          )
                        : Container(),
                      ],
                    ):Container(),
                    
                
                    widget.informe!['infVideo']!.isNotEmpty
                        ? _CamaraVideo(
                            size: size,
                            // informeController: informeController,
                            informe: widget.informe)
                        : Container(),

                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(3.0),
                    ),
                    //*****************************************/
                      //================================//
               _respuesta!='' 
              ?
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.wScreen(100.0),
                    // color: Colors.blue,
                    child: Text('Respuesta al informe:',
                        style: GoogleFonts.lexendDeca(
                            // fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ),
                  Container(
                margin: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
                width: size.wScreen(100.0),
                child:  Container(
                      width: size.wScreen(100.0),
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        top: size.iScreen(1.0),
                        right: size.iScreen(0.5),
                      ),
                      child: Text(
                        _respuesta,
                        style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.8),
                          fontWeight: FontWeight.normal,
                          // color: Colors.grey
                        ),
                      ),
                    ),
                // Wrap(children:(_infoRespuesta) .map((e) => SizedBox(
                //     width: size.wScreen(100.0),
                //     // color: Colors.blue,
                //     child: Text(e,
                //         style: GoogleFonts.lexendDeca(
                //             fontSize: size.iScreen(1.8),
                //             fontWeight: FontWeight.normal,
                        
                //             )),
                //   ) ).toList(),
                  ),
                
                
              
                ],
              )
              :Container(),
              
                //================================//
                    //*****************************************/

                    SizedBox(
                      height: size.iScreen(3.0),
                    ),
                    //*****************************************/
                  ],
                ),
              ),
            ),
          ),

           floatingActionButton: 
              _respuesta==''  ? 
             FloatingActionButton(child:Icon(Icons.message_outlined),onPressed: () {  

            bottomSheetRespondde(  widget.informe!['infId'].toString(),context, size);
           
          },

             ):Container()
        ),
      ),
    );
  }

  //********************************************************************************************************************//
  void bottomSheetRespondde(
    String _idInf,
    BuildContext context,
    Responsive size,
  ) {
   showModalBottomSheet(
    shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,

    
    context: context,
    
    builder: (context) {


        final _control=context.read<InformeController>();

      return Container(
        // color: Colors.red,
        // height: size.hScreen(50.0),
        height: size.hScreen(50.0),
        margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
        child: GestureDetector(
           onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _control.informeRespondeFormKey,
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
                                Text('Responder al Informe  ',
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
                              _control.onInputRespondeInformeChange(text);
                            },
                           
                            validator: (text) {
                              if (text!.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Ingrese respuesta del Informe';
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
                                          final isValid = _control.validateFormRespondeInforme();
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
                     _control.respondeInforme(int.parse(_idInf.toString()),context);
              Navigator.pop(context);
              Navigator.pop(context);
              
                _control.buscaInformeGuardias(_idInf.toString(), 'true');
        
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
        ),
      );
    }
    
    );






    
  
}
  //********************************************************************************************************************//

  Future<void> _launchUrl(Uri _data) async {
    if (!await launchUrl(_data)) {
      throw Exception('Could not launch $_data');
    }
  }

  //********************************************************************************************************************//
  void _onSubmit(BuildContext context, InformeController controller) async {
    final isValid = controller.validateForm();
    if (!isValid) return;
    if (isValid) {
      if (controller.getListaGuardiaInforme.isEmpty) {
        NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
      } else if (controller.getTextDirigido == null) {
        NotificatiosnService.showSnackBarDanger('Debe elegir a persona');
      } else {
        ProgressDialog.show(context);
        await controller.crearInforme(context);
        ProgressDialog.dissmiss(context);
        Navigator.pop(context);
      }
    }
  }

//================================================= SELECCIONA FECHA INICIO ==================================================//
  _selectFecha(
      BuildContext context, InformeController informeController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      String? anio, mes, dia;
      anio = '${picked.year}';
      mes = (picked.month < 10) ? '0${picked.month}' : '${picked.month}';
      dia = (picked.day < 10) ? '0${picked.day}' : '${picked.day}';

     
      final _fechaInicio =
          '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      _fechaInicioController.text = _fechaInicio;
      informeController.onInputFechaInformeGuardiaChange(_fechaInicio);
      
    }
  }

  void _seleccionaHora(context, InformeController informeController) async {
    TimeOfDay? _hora =
        await showTimePicker(context: context, initialTime: timeInicio);

    if (_hora != null) {
      setState(() {
        timeInicio = _hora;
        String horaInicio = '${timeInicio.hour}:${timeInicio.minute}';
        _horaInicioController.text = horaInicio;
        informeController.onInputHoraInformeGuardiaChange(horaInicio);
       
      });
    }
  }

  void bottomSheet(
    InformeController informeController,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.camera, informeController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    _funcionCamara(ImageSource.gallery, informeController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            
            ));
  }

  void _funcionCamara(
      ImageSource source, InformeController informeController) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return;
    }
    informeController.setNewPictureFile('${pickedFile.path}');
    
    Navigator.pop(context);

  }

  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaPersona(
      Responsive size, InformeController informeController) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SELECCIONAR CLIENTE',
                      style: GoogleFonts.lexendDeca(
                        fontSize: size.iScreen(2.0),
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      )),
                  IconButton(
                      splashRadius: size.iScreen(3.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: size.iScreen(3.5),
                      )),
                ],
              ),
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(3.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading:
                            const Icon(Icons.qr_code_2, color: Colors.black),
                        title: Text(
                          "Código QR",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () async {
                          
                        },
                      ),
                     
                      const Divider(),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.badge_outlined,
                            color: Colors.black),
                        title: Text(
                          "Nómina de Personal",
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                        informeController.getTodosLosClientesInformes('');
                         Navigator.pop(context);
                          Navigator.pushNamed(
                              context, 'buscaClienteInformeGuardia');
                        },
                      ),
                      SizedBox(
                        height: size.iScreen(2.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _CamaraOption extends StatelessWidget {
  final InformeController informeController;
  final dynamic informe;
  const _CamaraOption({
    Key? key,
    required this.size,
    required this.informeController,
    required this.informe,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.wScreen(100.0),
            margin: EdgeInsets.symmetric(
              vertical: size.iScreen(1.0),
              horizontal: size.iScreen(0.0),
            ),
            child: Text('Fotografía: ${informe!['infFotos']!.length}',
                style: GoogleFonts.lexendDeca(
                    // fontSize: size.iScreen(2.0),
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
          ),
          ListView.builder(
            itemCount: informe!['infFotos']!.length,
            itemBuilder: (BuildContext context, int index) {
              return Text('dadadad');
            },
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

class _ItemFoto extends StatelessWidget {
  final CreaNuevaFotoInformeGuardias? image;
  final InformeController informeController;

  const _ItemFoto({
    Key? key,
    required this.size,
    required this.informeController,
    required this.image,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: image!.id,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.iScreen(2.0), vertical: size.iScreen(1.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              width: size.wScreen(35.0),
              height: size.hScreen(20.0),
              padding: EdgeInsets.symmetric(
                vertical: size.iScreen(0.0),
                horizontal: size.iScreen(0.0),
              ),
              child: getImage(image!.path),
            ),
          ),
        ),
      ),
      onTap: () {
       
      },
    );
  }
}

class _CamaraVideo extends StatelessWidget {
  final dynamic informe;
  const _CamaraVideo({
    Key? key,
    required this.size,
    //required this.informeController,
    required this.informe,
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
           '${informe!['infVideo']![0]['url']}',
            betterPlayerConfiguration: const BetterPlayerConfiguration(
              aspectRatio: 16 / 16,
            ),
          ),
        )
      ],
    );
  }
}

class _ListaGuardias extends StatelessWidget {
  // final InformeController informeController;
  final dynamic informe;
  const _ListaGuardias({
    Key? key,
    required this.size,
    required this.informe,
    // required this.informeController,
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
          child: Text('Respuesta: ',
              style: GoogleFonts.lexendDeca(
                  // fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.normal,
                  color: Colors.grey)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.5)),
          width: size.wScreen(100.0),
          height:
              size.iScreen(informe!['infGuardias']!.length.toDouble() * 5.0),
          child: ListView.builder(
            itemCount: informe!['infGuardias']!.length,
            itemBuilder: (BuildContext context, int index) {
              final guardia = informe!['infGuardias']![index];
              return guardia['asignado'] != false
                  ? Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.iScreen(1.0),
                                  vertical: size.iScreen(1.0)),
                              child: Text(
                                '${guardia['nombres']}',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.7),
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                    )
                  : const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
