import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/utils/theme.dart';

class ListaPedidosDevolucionDTS extends DataTableSource {
  final BuildContext context;
  final LogisticaController logisticaController;
  final List? listaItemPedidoDevolucion;
  final Responsive size;

  ListaPedidosDevolucionDTS(
    this.size,
    this.context,
    this.listaItemPedidoDevolucion,
    this.logisticaController,
  );

  @override
  DataRow? getRow(int index) {
    listaItemPedidoDevolucion!.sort((a, b) => b['id'].compareTo(a['id']));

    final pedido = listaItemPedidoDevolucion![index];
    int _cantidadRestada = 0;
     int? _cantidadDevolucion ;

 String _cantidad='${pedido['cantidad']}';
String _cantidadDevoluciones='${pedido['cantidadDevolucion']}';

  if (int.parse(_cantidad) - int.parse(_cantidadDevoluciones) > 0) {
      _cantidadRestada = int.parse(pedido['cantidad']) -
         int.parse((_cantidadDevoluciones));
    } else  if (int.parse(_cantidad) - int.parse(_cantidadDevoluciones) == 0 || int.parse(_cantidad) - int.parse(_cantidadDevoluciones) < 0){
      _cantidadRestada = 0;
    }

    return DataRow.byIndex(
      index: index,
      cells: [
       
        DataCell(
            Row(
              children: [
               
                const SizedBox(width: 30.0),
                Text(
                  pedido['nombre'],
                  style: pedido['estado'] != 'PEDIDO'
                      ? const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        )
                      : GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(1.5),
                          
                        ),
                )
              ],
            ),
            onTap: pedido['estado'] == 'PEDIDO'
                ? () {
                    logisticaController.agregarItemDevolucionPedido(pedido);

                    logisticaController.setItemscantidadDevolucion(
                        pedido['cantidad'].toString(),
                        pedido['cantidadDevolucion'].toString());
                   _modalAgregaPedido(size, logisticaController, pedido);
                  }
                : null),
        DataCell(Text(_cantidadRestada.toString())),
       
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listaItemPedidoDevolucion!.length;

  @override
  int get selectedRowCount => 0;

//====== MUESTRA AGREGAR PEDIDO =======//
  void _modalAgregaPedido(Responsive size,
      LogisticaController logisticaController, dynamic pedido) {
    TextEditingController _cantidad = TextEditingController();
    @override
    void dispose() {
      _cantidad.clear();
      super.dispose();
    }

    logisticaController.resetItemDevolucion();
    logisticaController.setItemCantidadDevolucion(
        logisticaController.getCantidadRestada.toString());
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          _cantidad.text = logisticaController.getCantidadRestada.toString();
         return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(2.0), vertical: size.wScreen(1.0)),
              content: Form(
                key: logisticaController.validaNuevoPedidoGuardiaFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('DEVOLVER PRODUCTO',
                            style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              fontWeight: FontWeight.bold,
                             
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
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            //  color: Colors.red,
                            width: size.wScreen(100.0),
                            child: Text(
                              'Producto:',
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          //*****************************************/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //***********************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/
                              Expanded(
                                child: Text(
                                  '${pedido['nombre']}',
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(1.8),
                                    // color: Colors.black45,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                             
                            ],
                          ),
                        ],
                      ),
                    ),
                    //***********************************************/
                    SizedBox(
                      height: size.iScreen(1.0),
                    ),
                    //*****************************************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // color: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(1.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Stock:',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                 
                                ),
                              ),
                              //***********************************************/
                              SizedBox(
                                height: size.iScreen(1.0),
                              ),
                              //*****************************************/

                              Text(
                              
                                logisticaController.getCantidadRestada
                                    .toString(),
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                               
                                 
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(1.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Cantidad:',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color: Colors.black45,
                                 
                                ),
                              ),
                              Consumer<LogisticaController>(
                                builder: (__, valueCantidad, Widget? child) {
                                  return SizedBox(
                                    width: size.iScreen(10.0),
                                    child: TextFormField(
                                      controller: _cantidad,
                                      
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      decoration: const InputDecoration(
                                         
                                          ),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(

                                        
                                          ),
                                      onChanged: (text) {
                                        valueCantidad
                                            .setItemCantidadDevolucion(text);
                                       
                                      },
                                      validator: (text) {
                                        if (text!.trim().isNotEmpty) {
                                          return null;
                                        } else {
                                          return 'Cantidad inválida';
                                        }
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  width: size.wScreen(100.0),
                  //  color: Colors.red,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: size.iScreen(14.0)),
                    //  width: size.iScreen(20.0),
                    height: size.iScreen(3.5),
                    child: Consumer<LogisticaController>(
                      builder: (_, itemProvider, __) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              itemProvider.getItemDevolucionDisponible == true
                                  ? primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          onPressed:
                              itemProvider.getItemDevolucionDisponible == true
                                  ? () {
                                     itemProvider
                                          .agregaNuevoItemDevolucionPedido();
                                      Navigator.pop(context);
                                    }
                                  : null,
                      
                          child: Text('Agregar',
                              style: GoogleFonts.lexendDeca(
                                  fontSize: size.iScreen(1.8),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
