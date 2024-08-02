
import 'package:flutter/material.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/models/crea_nuevo_pedido.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class PedidosMunisionesDTS extends DataTableSource {
  final BuildContext context;
   final String? estadoPedido;
  final List<Map<String,dynamic>> nuevoPedido;
  final Responsive size;

  PedidosMunisionesDTS(this.nuevoPedido, this.size, this.context, this.estadoPedido);

  @override
  DataRow? getRow(int index) {

 nuevoPedido.sort((a, b) => int.parse(b['id'].toString()).compareTo(int.parse(a['id'].toString())));
    final pedido = nuevoPedido[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        
       estadoPedido=='Nuevo'? DataCell(
            Row(
              children: [
                const Icon(
                  Icons.close_sharp,
                  color: Color(0XFFEF5350),
                ),
                const SizedBox(width: 30.0),
                Text(pedido['nombre']),
              ],
            ), onTap: () {
             
          final controllerCompras =
              Provider.of<LogisticaController>(context, listen: false);
          controllerCompras.eliminaPedidoAgregadoMunisiones(pedido);
              }
        ):DataCell(  Row(
              children: [
                const Icon(
                  Icons.close_sharp,
                  color: Color(0XFFEF5350),
                ),
                const SizedBox(width: 30.0),
               
                Text(pedido['valor']),
              ],
            )),
        DataCell(Text(pedido['valor'].toString())),
        DataCell(Text(pedido['serie'])),
        DataCell(Text(pedido['marca'])),
        DataCell(Text(pedido['modelo'])),
        DataCell(Text(pedido['talla'])),
        DataCell(Text(pedido['bodega'])),
        DataCell(Text(pedido['tipo'])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => nuevoPedido.length;

  @override
  int get selectedRowCount => 0;
}
