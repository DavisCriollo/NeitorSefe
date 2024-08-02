import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nseguridad/src/utils/responsive.dart';


class ItemsMenuNovedades extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final Color color;
  final IconData icon;
  const ItemsMenuNovedades({
    Key? key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      width: size.iScreen(12.5),
      height: size.iScreen(12.0),
  decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 5.0, offset: Offset(0.0, 0.75))
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(size.iScreen(1.0)),
      child: ClipRRect(
         borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration( color: Colors.white,
           borderRadius: BorderRadius.circular(15)),
          child: MaterialButton(
            elevation:20.0 ,
            splashColor:color ,
            onPressed:onTap,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon,color: color, size: size.iScreen(5.0)),
              // Image.asset('assets/imgs/$icon',
              //     color: color, width: size.iScreen(5.0)),
              Text(
                
                label,
                textAlign:TextAlign.center,
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.6),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),)
        ),
      ),
    );
  }
}
