

import 'package:flutter/material.dart';

class BotonTurnoController extends ChangeNotifier {

  //========ESTE BOTON INICIA Y FINALIZA TURNO ======//
  bool _turnoBTN =
      false; //POR DEFECTO ES FALSE  SE CAMBIO A TRUE PARA SEGUIR AVANZANDO
  bool get getTurnoBTN => _turnoBTN;
  void setTurnoBTN(bool estado) {
    _turnoBTN = estado;
    print('EL getTurnoBTN es: $_turnoBTN');
    notifyListeners();
  }


  
}