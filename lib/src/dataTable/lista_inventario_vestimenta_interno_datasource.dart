

import 'package:flutter/material.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';

class ListaInventarioInternoDTS extends DataTableSource {
  final ActividadesAsignadasController dataProvider;
  final String estado;

  ListaInventarioInternoDTS(this.dataProvider, this.estado);

  @override
  DataRow? getRow(int index) {
    if (index >= dataProvider.dataRows.length) return null;
    final row = dataProvider.dataRows[index];
    return DataRow(
      cells: [
        //  "tipo": "VESTIMENTAS",
				// 	"bodega": "MATRIZ",
				// 	"idBodega": 1,
				// 	"fotos": [],
				// 	"id": 720,
				// 	"nombre": "CAMISA BLANCA",
				// 	"serie": "VES720",
				// 	"cantidad": "1",
				// 	"valor": "1.00",
				// 	"estadoEquipo": "USADO",
				// 	"marca": "N/A",
				// 	"modelo": "N/A",
				// 	"talla": "0",
				// 	"color": "BLANCA",
				// 	"stock": "15"
        DataCell(Row(
          children: [
           estado!='DETALLE' ?  Checkbox(
            value: row['isChecked'],
            onChanged: (value) {
           
              dataProvider.updateCheckedStatus(index,value!);
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
        DataCell(Text(row['talla'] ?? 'S/N')),
        DataCell(Text(row['color'] ?? 'S/N')),
        // DataCell(Text(row['stock'] ?? 'S/N')),
      ],
      
    );
    
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataProvider.dataRows.length;

  @override
  int get selectedRowCount => 0;
}