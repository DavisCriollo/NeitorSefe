// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:sincop_app/src/controllers/consignas_clientes_controller.dart';
// import 'package:sincop_app/src/controllers/consignas_contrtoller.dart';
// import 'package:sincop_app/src/utils/responsive.dart';
// import 'package:sincop_app/src/widgets/no_data.dart';

// class BusquedaGuardiasConsignas extends StatelessWidget {
//   BusquedaGuardiasConsignas({Key? key}) : super(key: key);
//   final TextEditingController textSearchGuardiaConsignas =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final controllers=Provider.of<ConsignasController>(context);
//     return 
//     Scaffold(
//       appBar: AppBar(
//         // backgroundColor: const Color(0XFF343A40), // primaryColor,
//         title: Text(
//           'Buscar Personalddd',
//           style: GoogleFonts.lexendDeca(
//               fontSize: size.iScreen(2.8),
//               color: Colors.white,
//               fontWeight: FontWeight.normal),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//               colors: <Color>[
//                 Color(0XFF153E76),
//                 Color(0XFF0076A7),

//                 // Color(0XFF005B97),
//                 // Color(0XFF0075BE),
//                 // Color(0XFF1E9CD7),
//                 // Color(0XFF3DA9F4),
//               ],
//             ),
//           ),
//         ),
//         //  actions: [
//         //   //  IconButton(onPressed: (){}, icon: icon)
//         //  ],
//       ),
//       body: 
//       Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           // color: Colors.red,
//           // child: ListView.builder(
//           //       itemCount: controllers.getListaBusquedaGuardiasConsigna.length,
//           //       itemBuilder: (BuildContext context, int index) {
//           //         return Text(
//           //             " DSDASDKKAHSDKHAKSJDDHSAKJSDDHK: ${controllers.getListaBusquedaGuardiasConsigna[index]}");
//           //       },
//           //     )
//           // Consumer<ConsignasClientesController>(
//           //   builder: (_, dataGuardias, __) {
//           //     // if (controllers.getErrorListaBusquedaGuardiasConsigna == null) {
//           //     //   return const NoData(
//           //     //     label: 'Cargando datos...',
//           //     //   );
//           //     // } else if (controllers.getErrorListaBusquedaGuardiasConsigna == false) {
//           //     //   return const NoData(
//           //     //     label: 'No existen datos para mostar',
//           //     //   );
//           //     //   // Text("Error al cargar los datos");
//           //     // } else if (controllers.getListaBusquedaGuardiasConsigna.isEmpty) {
//           //     //   return const NoData(
//           //     //     label: 'No existen datos para mostar',
//           //     //   );
//           //     //   // Text("sin datos");
//           //     // }
//           //    return ListView.builder(
//           //       itemCount: controllers.getListaBusquedaGuardiasConsigna.length,
//           //       itemBuilder: (BuildContext context, int index) {
//           //         return Text(
//           //             " DSDASDKKAHSDKHAKSJDDHSAKJSDDHK: ${controllers.getListaBusquedaGuardiasConsigna[index]}");
//           //       },
//           //     );
             
//           //   },
//           // )),
    
    
    
//     ));
  
  
  
  
//   }
// }
