import 'package:flutter/material.dart';

class CreaMenuHome {
  bool? alerta;
  String tipo;
  String label;
  IconData icon;
  Color color;
  CreaMenuHome(
    this.alerta,
    this.label,
    this.tipo,
    this.icon,
    this.color,
  );

  Map<String, dynamic> toJson() {
    return {
       'alerta':alerta,
    'tipo':tipo,
    'label':label,
    'icon':icon,
    'color':color,
    };
  }
}
