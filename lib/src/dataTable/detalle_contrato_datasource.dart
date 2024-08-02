import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/models/lista_allEstados_cuenta_cliente.dart';
import 'package:nseguridad/src/utils/responsive.dart';

class DetalleContratoDTS extends DataTableSource {
  final Responsive size;

  final List<EstCuota>? listaEstdoCuenta;

  DetalleContratoDTS(this.listaEstdoCuenta, this.size);
  @override
  DataRow? getRow(int index) {
    final estadoCuenta = listaEstdoCuenta![index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(
        '${estadoCuenta.detalle}',
        style: GoogleFonts.lexendDeca(
            fontSize: size.iScreen(1.7),
            color: Colors.black87,
            fontWeight: FontWeight.normal),
      )),
      DataCell(Text(
        estadoCuenta.fecha.toString().replaceAll("00:00:00.000", ""),
        style: GoogleFonts.lexendDeca(
            fontSize: size.iScreen(1.7), fontWeight: FontWeight.normal),
      )),
      DataCell(Text(
        '${estadoCuenta.cuota}',
        style: GoogleFonts.lexendDeca(
            fontSize: size.iScreen(1.7),
            color: Colors.black87,
            fontWeight: FontWeight.normal),
      )),
      DataCell(Text(
        '${estadoCuenta.estado}',
        style: GoogleFonts.lexendDeca(
            fontSize: size.iScreen(1.7),
            color: Colors.black87,
            fontWeight: FontWeight.normal),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listaEstdoCuenta!.length;

  @override
  int get selectedRowCount => 0;
}
