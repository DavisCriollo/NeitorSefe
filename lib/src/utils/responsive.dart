
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;


class Responsive
{
  final double width, height, inch;

  Responsive({ 
    required this.width,
     required this.height,
      required this.inch
      });

factory Responsive.of(BuildContext context)
{
  final MediaQueryData data =MediaQuery.of(context);
  // ANCHO ALTO DE DISPOSITIVO
  final size= data.size;
  // VALOR DE LA DIAGONAL
  /**
   * APLICO TEOREMA DE PITAGORAS  
   *  c2 = a2 +b2 =>c = sqrt(a2 +b+)
   *  */ 
   final inch = math.sqrt(math.pow(size.width, 2)+math.pow(size.height, 2)) ;

  return Responsive( width: size.width , height: size.height, inch: inch);
}

// OBTENGO PORCENTAHE DE ANCHO DE PANTALLA  

double wScreen(double percent)
{
 return width *percent/100;
}
// OBTENGO PORCENTAHE DE ALTO DE PANTALLA  

double hScreen(double percent)
{
 return height *percent/100;
}
// OBTENGO PORCENTAHE DE LA DIAGONAL DE PANTALLA  

double iScreen(double percent)
{
 return inch * percent / 100;
}




}