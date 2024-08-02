// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nseguridad/src/controllers/home_ctrl.dart';
// import 'package:nseguridad/src/utils/responsive.dart';
// import 'package:provider/provider.dart';

// class Perfil extends StatelessWidget {
//   const Perfil({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//      final ctrlHome= context.read<HomeController>();
//     final Responsive size = Responsive.of(context);
//     return Scaffold(
//       appBar: AppBar(title: Text(' asd asd adsasda dsad asd a d a d ',
//                   style: GoogleFonts.roboto(
//                       fontSize: size.iScreen(3.0),
//                       // color: Colors.black87,
//                       fontWeight: FontWeight.normal)),),
//       body: Container(
//         color: Colors.red,
//     width: size.wScreen(100.0), height: size.hScreen(100.0),
//       ),
//     );
//   }
// }