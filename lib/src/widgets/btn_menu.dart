import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/responsive.dart';




class ItemsMenuHome extends StatelessWidget {
  
  final VoidCallback? onTap;
  final String label;
  final Color color;
  final bool alerta;
  final String icon;
  const ItemsMenuHome({
    Key? key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
   this.alerta=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return 
    Container(
      width: size.iScreen(12.0),
      height: size.iScreen(12.0),
  decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 5.0, offset: Offset(0.0, 0.75))
        ], color: Colors.white, borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.all(size.iScreen(1.0)),
      child: ClipRRect(
         borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration( color:(alerta)?Colors.red:Colors.grey.shade100,//Aqui se cambia el color de los botones
           borderRadius: BorderRadius.circular(50)),
          child: MaterialButton(
            elevation:20.0 ,
            splashColor:color ,
            onPressed:onTap,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Image.asset('assets/imgs/$icon',
              //     color: (alerta)?Colors.white:color, width: size.iScreen(8.0)),
              Icon(Icons.list,size: size.iScreen(5.0),),
              Text(
               
                label,
                 textAlign:TextAlign.center,
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(1.6),
                    color:(alerta)?Colors.white:Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),)
        ),
      ),
    );
  
  
  
  }
}
