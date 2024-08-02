
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/api/api_provider.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/new_permisos_controller.dart';
import 'package:nseguridad/src/service/socket_service.dart';
import 'package:nseguridad/src/utils/dialogs.dart';

class NuevoTurnoExtraController extends ChangeNotifier {
  GlobalKey<FormState> turnoFormKey = GlobalKey<FormState>();
  final _api = ApiProvider();
  bool validateForm() {
    if (turnoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }


void resetVariablesTurno(){
_infoPersonaReemplazo={};
   _labelMotivoPermidos='';
 _inputDetalle;
  _inputAutorizadoPor;
  


  notifyListeners();
}

  //**************  OBTIENE LA INFORMACION DEA PERSONA ******************//

Map<String,dynamic> _infoPersonaReemplazo={};

Map<String,dynamic> get getInfoPersonaReemplazo=>_infoPersonaReemplazo;


void setInfoPersonaReemplazo(Map<String,dynamic> _info){
_infoPersonaReemplazo={};
_infoPersonaReemplazo=_info;
//  print('persona: $_infoPersonaReemplazo');

  notifyListeners();
}

//========================== DROPDOWN MOTIVO AUSENCIA =======================//
  String? _labelMotivoPermidos='';

  String? get labelMotivoPermidos => _labelMotivoPermidos;

  void setLabelMotivoPermidos(String value) {
    _labelMotivoPermidos = value;
    notifyListeners();
  }


  String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    notifyListeners();
  }



  String? _inputAutorizadoPor;
  String? get getInputAutorizadoPor => _inputAutorizadoPor;
  void onAutorizadoPorChange(String? text) {
    _inputAutorizadoPor = text;
    notifyListeners();
  }

//=========================OBTENEMOS LA INFORMACION DE JEFE DE OPERACIONES PARA TOMAR APELLIDO Y NOMBRES==============================//

  List _listaDataJefeOperaciones = [];
  List get getListaDataJefeOperaciones => _listaDataJefeOperaciones;
  void setListataDataJefeOperaciones(List data) {
    _listaDataJefeOperaciones = data;
    notifyListeners();
  }

  bool? _errorListaDataJefeOperaciones; // sera nulo la primera vez
  bool? get getErrLrlistaDataJefeOperaciones => _errorListaDataJefeOperaciones;
  set setErrLrlistaDataJefeOperaciones(bool? value) {
    _errorListaDataJefeOperaciones = value;
    notifyListeners();
  }

  Future buscaLstaDataJefeOperaciones(String? _search) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.getDataJefeOperaciones(
      search: _search,
      notificacion: 'false',
      estado: 'JEFE DE OPERACIONES',
      token: '${dataUser!.token}',
    );
    if (response != null) {
      _errorListaDataJefeOperaciones = true;
      setListataDataJefeOperaciones(response['data']);
      onAutorizadoPorChange(
          "${response['data'][0]['perNombres']} ${response['data'][0]['perApellidos']}");

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorListaDataJefeOperaciones = false;
      notifyListeners();
      return null;
    }
  }



//************  VERIFICA DISPONIVILIDAD DEL GUARDEIA REEEMPLAZO ************//

 Future validaTurnoDiasLibres(BuildContext context,_data)async {
    final dataUser = await Auth.instance.getSession();

   final response = await _api.getAllTurnosDiasLibres(
    context: context,
      data: _data,
          token: '${dataUser!.token}',
    );
    if (response != null) {

      //  notifyListeners();  
      //  Map<String, dynamic> message = jsonDecode(response.body);
// Dialogs.alert(context,
//                               title: 'Atención',
//                               description: '${message['msg']}');


// print('lLA INFORMACION code: ${response.statusCode}');
// print('lLA INFORMACION DEL CONTROLLER: ${message['msg']}');
 


        return response;
  
    }    
    if (response == null) {
      // _errorDiasPermiso= false;
      notifyListeners();
      return null;
    }
  }

//***********   CREAR TURNO EXTRA *******************//

Future crearTurno(BuildContext context) async {
    final serviceSocket = context.read<SocketService>();
  final infoUserLogin = await Auth.instance.getSession();
 final ctrlPermiso = context.read<NuevoPermisoController>();
List _idsFechas=[];

//******los id de las fechas seleecionadas********//
for (var item in ctrlPermiso.selectedFechas) {
  _idsFechas.add(item['id']);
}
                                   


final _pyloadNuevTurnoExtra = {
      "tabla": "turno_extra", // defecto
      "rucempresa": infoUserLogin!.rucempresa, //login
      "rol": infoUserLogin.rol, //loginlogin


  "turnIdPersona": _infoPersonaReemplazo['perId'], // id de la persona del turno extra
  "turnIdPersonaReemplazada":  ctrlPermiso.getInfoPuestoSeleccionado[ 'id_persona'], // id de la persona que solicita permiso
  "turnIdDOperativo": ctrlPermiso.getInfoPuestoSeleccionado[ 'id_dOperativo'], //del item
  "turnIdPermiso": 0, //default
  "turnIdMulta": 0, //default
  "turnIdsJornadaLaboral": _idsFechas, // los id de los dias a reemplazar
  "turnMotivo": _labelMotivoPermidos, //el motivo seleccionado en el permiso
  "turnEstado": "",//vacio
  "turnAutorizado": _inputAutorizadoPor, // revisar como funciona el otro formulario
  "turnDetalle": _inputDetalle, //textarea
  "turnStatusDescripcion": "", //vacio
  "turnUser": infoUserLogin.usuario, //login
  "turnEmpresa": infoUserLogin.rucempresa, // login

};

//  print('_pyloadNuevTurnoExtra :$_pyloadNuevTurnoExtra');

 serviceSocket.socket!.emit('client:guardarData', _pyloadNuevTurnoExtra);
  // serviceSocket.socket!.on('server:guardadoExitoso', (data) async {
  //     // if (data['tabla'] == 'turno_extra') {
  //      print('======================> data socket  :$data');
  //      ctrlPermiso.setListaPersonasReemplazo(data);
       
  //     // }
  //   });


}


//================================== ELIMINAR  MULTA  ==============================//
  Future eliminaTurnoExtra(List idTurno) async {
    final serviceSocket = SocketService();
    final infoUser = await Auth.instance.getSession();
    final _pyloadEliminaTurnoExtra = {

      "tabla": "turno_extra",
  "rucempresa": infoUser!.rucempresa,
  "lista": idTurno,
     
    };

    serviceSocket.socket!.emit('client:eliminarData', _pyloadEliminaTurnoExtra);
    // print('ELIMINAMOS EL TURNO:$_pyloadEliminaTurnoExtra');
  
  }



}