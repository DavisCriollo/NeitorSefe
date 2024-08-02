
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/responsive.dart';


import 'package:nseguridad/src/utils/responsive.dart';


class NoData extends StatelessWidget {
  final String label;

  const NoData({Key? key, required this.label}) : super(key: key);
 

  

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(size.iScreen(5.0)),
      // color: Colors.red,
      width: size.iScreen(100.0),
      child: Center(
        child: Text(label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
                fontSize: size.iScreen(1.8),
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}






