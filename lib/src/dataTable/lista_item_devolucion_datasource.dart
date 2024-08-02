import 'package:flutter/material.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class DevolucionPedidosDTS extends DataTableSource {
  final BuildContext context;
  //  final String? estadoPedido;
  final List? listaItemDevolucion;
  final Responsive size;

  DevolucionPedidosDTS( this.size, this.context, this.listaItemDevolucion,);

  @override
  DataRow? getRow(int index) {
 final devolucion = listaItemDevolucion![index];
    return DataRow.byIndex(
      index: index,
      cells: [
        
  DataCell(  Row(
              children: [
                const Icon(
                  Icons.close_sharp,
                  color: Color(0XFFEF5350),
                ),
                const SizedBox(width: 30.0),
                Text(devolucion['nombre']),
              ],
            ),
            onTap: () {
             
          final controllerCompras =
              Provider.of<LogisticaController>(context, listen: false);
          controllerCompras.eliminaDevolucionPedidoAgregado(devolucion['id']);
              }), 
        DataCell(Text(devolucion['cantidad'].toString())),
       
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listaItemDevolucion!.length;

  @override
  int get selectedRowCount => 0;











  
}
