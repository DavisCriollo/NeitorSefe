


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/home_controller.dart';
import 'package:nseguridad/src/dataTable/lista_inventario_armas_datasource.dart';
import 'package:nseguridad/src/dataTable/lista_inventario_municiones_datasource.dart';
import 'package:nseguridad/src/dataTable/lista_inventario_vestimenta_interno_datasource.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/utils/dialogs.dart';
import 'package:nseguridad/src/utils/fecha_local_convert.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/widgets/no_data.dart';


class DetalleActividadInventarioInterno extends StatefulWidget {

final String estado ;
 final Map<String,dynamic> requeridos;
  const DetalleActividadInventarioInterno({Key? key, required this.estado, required this.requeridos}) : super(key: key);

  @override
  State<DetalleActividadInventarioInterno> createState() => _DetalleActividadInventarioInternoState();
}



class _DetalleActividadInventarioInternoState extends State<DetalleActividadInventarioInterno> {
@override
void initState() {
  super.initState();
 _inicio(); 
}



void _inicio(){

final _datos=  Provider.of<ActividadesAsignadasController>(context, listen: false);

_datos.geLisItems(_datos.getInfoActividad['act_asigVestimentas']);
_datos.geLisItemsArmas(_datos.getInfoActividad['act_asigArmas']);
_datos.geLisItemsMuniciones(_datos.getInfoActividad['act_asigMuniciones']);



}

  @override
  Widget build(BuildContext context) {
      final _user = context.read<HomeController>();
  final _controller = context.read<ActividadesAsignadasController>();
    final Responsive size = Responsive.of(context);
   final _ctrl = context.read<ActividadesAsignadasController>();
  final ctrlTheme = context.read<ThemeApp>();
         
    // print('EL MAPA: ${widget.requeridos}');
     String fechaLocal = DateUtility.fechaLocalConvert(_ctrl.getInfoActividad['act_asigFecReg']!.toString());

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                'Detalle de Inventario',
                // style: Theme.of(context).textTheme.headline2,
              ),
            
            ),
        body: Container(
           margin: EdgeInsets.only(top: size.iScreen(0.0)),
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
              width: size.wScreen(100.0),
              height: size.hScreen(100),
          child: Form(
             key: _controller.actividadesAsignadasFormKey,
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Column(
                children: [
                        //*****************************************/
                  
                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                  
            //                     //==========================================//
                        Container(
                            width: size.wScreen(100.0),
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${_user.getUsuarioInfo!.rucempresa!}  ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                                Text('-',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                                Text('  ${_user.getUsuarioInfo!.usuario!} ',
                                    style: GoogleFonts.lexendDeca(
                                        fontSize: size.iScreen(1.5),
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
            //                     //*****************************************/
                  
                        SizedBox(
                          height: size.iScreen(0.5),
                        ),
                  
            //                     //==========================================//
            //                   //***********************************************/
                              
                                    Container(
                                      width: size.wScreen(100.0),
                  
                                      // color: Colors.blue,
                                      child: Text('Detalle de actividad:',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                                     //*****************************************/

                  SizedBox(
                    height: size.iScreen(0.5),
                  ),

                  //==========================================//
                                    Container(
                                      width: size.wScreen(100.0),
                  
                                      // color: Colors.blue,
                                      child: Text('${_controller.getInfoActividad['act_asigEveNombre']} ',
                                          style: GoogleFonts.lexendDeca(
                                              // fontSize: size.iScreen(2.0),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey)),
                                    ),
                           
                                        //***********************************************/
                                          SizedBox(
                                            height: size.iScreen(1.0),
                                          ),
            //                               //*****************************************/
                                          Container(
                                            width: size.wScreen(100.0),
                                              padding:  EdgeInsets.all(size.iScreen(0.5)),
                                            color: Colors.grey.shade200,
                                            child: Text('Lista de Vestimenta:',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                
                _controller.getDataRows.isNotEmpty?  Consumer<ActividadesAsignadasController>(builder: (_, valueDS,__) {  
                    
                    return    PaginatedDataTable(
                    // header: Text('Items'),
                    // rowsPerPage: valueDS.rowsPerPage,
                    // onRowsPerPageChanged: (value) {
                    //   valueDS.updateRowsPerPage(value!);
                    // },
                    // sortColumnIndex: dataProvider.sortColumnIndex,
                    // sortAscending: dataProvider.sortAscending,
                    rowsPerPage: valueDS.getDataRows.length,
                    columns: [
                      // DataColumn(
                      //   label: Text('Item'),
                      //   // onSort: (columnIndex, sortAscending) {
                      //   //   // valueDS.sortDataRows(columnIndex, sortAscending);
                      //   // },
                      // ),
                      // DataColumn(
                      //   label: Text('Description'),
                      // ),
                      // DataColumn(
                      //   label: Text('Select'),
                      // ),
                       DataColumn(
                                                  label: Text('Nombre',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Cantidad',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Serie',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Valor',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Estado',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Marca',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Modelo',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Talla',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Color',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Stock',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                    ],
                   
                    source: ListaInventarioInternoDTS(valueDS, widget.estado),
                 
                  );
                    
                  },):const NoData(label: 'No hay registros '),


                  
                          //***********************************************/
                                          SizedBox(
                                            height: size.iScreen(1.0),
                                          ),
            //                               //*****************************************/
                                          Container(
                                            width: size.wScreen(100.0),
                                              padding:  EdgeInsets.all(size.iScreen(0.5)),
                                            color: Colors.grey.shade200,
                                            child: Text('Lista de Armas:',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                _controller.getDataRowsArmas.isNotEmpty?  Consumer<ActividadesAsignadasController>(builder: (_, valueArmasDS,__) {  
                    
                    return    PaginatedDataTable(
                    // header: Text('Items'),
                    // rowsPerPage: valueDS.rowsPerPage,
                    // onRowsPerPageChanged: (value) {
                    //   valueDS.updateRowsPerPage(value!);
                    // },
                    // sortColumnIndex: dataProvider.sortColumnIndex,
                    // sortAscending: dataProvider.sortAscending,
                    rowsPerPage: valueArmasDS.getDataRowsArmas.length,
                    columns: [
                        DataColumn(
                                                  label: Text('Nombre',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Cantidad',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Serie',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Valor',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Estado',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Marca',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Modelo',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Tipo Arma',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Calibre',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Color',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Stock',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Foto',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                     
                    ],
                   
                    source: ListaInventarioInternoArmasDTS(valueArmasDS, widget.estado),
                 
                  );
                    
                  },):const NoData(label: 'No hay registros '),

                          //***********************************************/
                                          SizedBox(
                                            height: size.iScreen(1.0),
                                          ),
            //                               //*****************************************/
                                          Container(
                                            width: size.wScreen(100.0),
                                              padding:  EdgeInsets.all(size.iScreen(0.5)),
                                            color: Colors.grey.shade200,
                                            child: Text('Lista de Municiones:',
                                                style: GoogleFonts.lexendDeca(
                                                    fontSize: size.iScreen(1.8),
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey)),
                                          ),
                _controller.getDataRowsMuniciones.isNotEmpty?  Consumer<ActividadesAsignadasController>(builder: (_, valueMunicionesDS,__) {  
                    
                    return    PaginatedDataTable(
                    // header: Text('Items'),
                    // rowsPerPage: valueDS.rowsPerPage,
                    // onRowsPerPageChanged: (value) {
                    //   valueDS.updateRowsPerPage(value!);
                    // },
                    // sortColumnIndex: dataProvider.sortColumnIndex,s
                    // sortAscending: dataProvider.sortAscending,
                    rowsPerPage: valueMunicionesDS.getDataRowsMuniciones.length,
                    columns: [
                                     DataColumn(
                                                  label: Text('Materias',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  numeric: true,
                                                  label: Text('Cantidad',
                                                      style: GoogleFonts.lexendDeca(
                                                          // fontSize: size.iScreen(2.0),
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Serie',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Valor',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Estado',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Marca',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Modelo',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Tipo Arma',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Calibre',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              DataColumn(
                                                  label: Text('Color',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Stock',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                                              // DataColumn(
                                              //     label: Text('Foto',
                                              //         style: GoogleFonts.lexendDeca(
                                              //             fontWeight: FontWeight.normal,
                                              //             color: Colors.grey))),
                    ],
                   
                    source: ListaInventarioInternoMunicionesDTS(valueMunicionesDS,widget.estado),
                 
                  );
                    
                  },):const NoData(label: 'No hay registros '),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, ActividadesAsignadasController _actividadController, String _estado)  async{


 final selectedItems = _actividadController.getSelectedItems();
              final unselectedItems = _actividadController.getUnselectedItems();
              final combinedList = [...selectedItems, ...unselectedItems];          
_actividadController.setUnificaListas(combinedList);


 final selectedItemsArmas = _actividadController.getSelectedItemsArmas();
              final unselectedItemsArmas = _actividadController.getUnselectedItemsArmas();
              final combinedListArmas = [...selectedItemsArmas, ...unselectedItemsArmas];          
_actividadController.setUnificaListasArmas(combinedListArmas);


 final selectedItemsMuniciones = _actividadController.getSelectedItemsMuniciones();
              final unselectedItemsMuniciones = _actividadController.getUnselectedItemsMuniciones();
              final combinedListMuniciones = [...selectedItemsMuniciones, ...unselectedItemsMuniciones];
_actividadController.setUnificaListasMuniciones(combinedListMuniciones);



 final isValid = _actividadController.validateForm();
    if (!isValid) return;
    if (isValid)  {


      _actividadController.guardaInventarioInterno(context);
      



 final conexion = await Connectivity().checkConnectivity();
      if (_actividadController.getInputTitulo == null ||_actividadController.getInputTitulo == '') {
        NotificatiosnService.showSnackBarError('Debe agregar Título de actividad');
      } else if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
             ProgressDialog.show(context);
            final response = await _actividadController.guardaInventarioInterno(context);
            ProgressDialog.dissmiss(context);
            if (response != null) {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute<void>(
              //         builder: (BuildContext context) => const SplashPage()));
              Navigator.pop(context);
              Navigator.pop(context);
              _actividadController.getActividadesAsignadas('','false');

            }
       
        } else {
          // print('============== NOOOO TIENE PERMISOS');
          Navigator.pushNamed(context, 'gps');
        }
      }




      // if (_actividadController.getTextDirigido!.isEmpty) {
      //   NotificatiosnService.showSnackBarDanger('Debe seleccionar guardia');
      // } else if (_actividadController.getTextDirigido == null) {
      //   NotificatiosnService.showSnackBarDanger('Debe elegir a persona');
      // } else {
      //   await _actividadController.crearInforme(context);
      //   Navigator.pop(context);
      // }
    }






  }


// class _DataSource extends DataTableSource {
//   final ActividadesAsignadasController dataProvider;

//   _DataSource(this.dataProvider);

//   @override
//   DataRow? getRow(int index) {
//     if (index >= dataProvider.dataRows.length) return null;
//     final row = dataProvider.dataRows[index];
//     return DataRow(
//       cells: [
//         DataCell(Text(row['item'])),
//         DataCell(Text(row['description'])),
//         DataCell(
//           Checkbox(
//             value: row['isChecked'],
//             onChanged: (value) {
           
//               dataProvider.updateCheckedStatus(index,value!);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => dataProvider.dataRows.length;

//   @override
//   int get selectedRowCount => 0;
// }

// class DataProvider with ChangeNotifier {
//   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;
//   List<Map<String, dynamic>> _dataRows = List<Map<String, dynamic>>.generate(
//     50,
//     (index) => {
//       'isChecked': false,
//       'item': 'Item ${index + 1}',
//       'description': 'Description ${index + 1}',
//     },
//   );

//   int get rowsPerPage => _rowsPerPage;
//   int get sortColumnIndex => _sortColumnIndex;
//   bool get sortAscending => _sortAscending;
//   List<Map<String, dynamic>> get dataRows => _dataRows;

//   void updateRowsPerPage(int value) {
//     _rowsPerPage = value;
//     notifyListeners();
//   }

//   void sortDataRows(int columnIndex, bool sortAscending) {
//     _sortColumnIndex = columnIndex;
//     _sortAscending = sortAscending;
//     _dataRows.sort((a, b) {
//       final aValue = a['item'];
//       final bValue = b['item'];
//       return sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
//     });
//     notifyListeners();
//   }

//   void updateCheckedStatus(int index, bool value) {
//     _dataRows[index]['isChecked'] = value;
//     notifyListeners();
//   }

//    List<Map<String, dynamic>> getSelectedItems() {
//     return _dataRows.where((row) => row['isChecked']).toList();
//   }
//  }

 class SelectedItemsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ActividadesAsignadasController>(context);
    final selectedItems = dataProvider.getSelectedItems();

    return ElevatedButton(
      onPressed: selectedItems.isNotEmpty
          ? () {
              // Acción a realizar con los elementos seleccionados
              print('Elementos seleccionados: $selectedItems');
            }
          : null,
      child: Text('Seleccionar elementos'),
    );
  }
}