

import 'package:flutter/material.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';

class ListaInventarioInternoArmasDTS extends DataTableSource {
  final ActividadesAsignadasController dataProviderArmas;
   final String estado;

  ListaInventarioInternoArmasDTS(this.dataProviderArmas, this.estado);

  @override
  DataRow? getRow(int index) {
    if (index >= dataProviderArmas.dataRowsArmas.length) return null;
    final row = dataProviderArmas.dataRowsArmas[index];
    return DataRow(
      cells: [
       
        DataCell(Row(
          children: [
           estado!='DETALLE' ?   
             Checkbox(
            value: row['isChecked'],
            onChanged: (value) {
           
              dataProviderArmas.updateCheckedStatusArmas(index,value!);
            },
          ):Container(),
            Text(row['nombre']),
          ],
        )),
        
        DataCell(Text(row['cantidad']?? 'S/N')),
        DataCell(Text(row['serie'] ?? 'S/N')),
        // DataCell(Text(row['valor'] ?? 'S/N')),
        DataCell(Text(row['estadoEquipo'] ?? 'S/N')),
        DataCell(Text(row['marca'] ?? 'S/N')),
        DataCell(Text(row['modelo'] ?? 'S/N')),
        DataCell(Text(row['tipoArma'] ?? 'S/N')),
        DataCell(Text(row['calibre'] ?? 'S/N')),
        DataCell(Text(row['color'] ?? 'S/N')),
        // DataCell(Text(row['stock'] ?? 'S/N')),
        // DataCell(Text(row['valor'] ?? 'S/N')),
      ],
      
    );
 
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataProviderArmas.dataRowsArmas.length;

  @override
  int get selectedRowCount => 0;
}