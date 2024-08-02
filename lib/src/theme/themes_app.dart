//========================================//
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/utils/responsive.dart';

// import 'package:neitor_vet/src/utils/responsive.dart';
// import 'package:neitor_vet/src/utils/theme.dart';

// class AppTheme extends ChangeNotifier {
// // final BuildContext context;

//   bool _darkTheme = false;
//   bool _customTheme = false;

//   ThemeData? _currentTheme;

//   bool get darkTheme => this._darkTheme;
//   bool get customTheme => this._customTheme;
//   ThemeData? get currentTheme => _currentTheme;

//   Color? _primaryTextColor;
//   Color? get getPrimaryTextColor => _primaryTextColor;

//   void setPrimayText(Color _color) {
//     _primaryTextColor = _color;
//     notifyListeners();
//   }
//   Color? _primaryTextColorLigth;
//   Color? get getPrimaryTextColorLigth => _primaryTextColorLigth;

//   void setPrimayTextLigth(Color _color) {
//     _primaryTextColor = _color;
//     notifyListeners();
//   }

//   Color? _secondaryTextColor;
//   Color? get getSecondryTextColor => _secondaryTextColor;

//   void setSecondaryText(Color _color) {
//     _secondaryTextColor = _color;
//     notifyListeners();
//   }

//   Color? _terciaryTextColor;
//   Color? get getTerciaryTextColor => _terciaryTextColor;

//   void setTerciaryText(Color _color) {
//     _terciaryTextColor = _color;
//     notifyListeners();
//   }
  
  
// //     Color? _ligthColor;
// //   Color? get getLigthColor => _ligthColor;

// //   void setLigthColor(Color _color) {
// //     _ligthColor = _color;
// //       String hexCode = colorToHex(_color);

// //     print('COLORS :${hexCode.replaceAll('#ff', '#')}');
// //     // Color rgbColor = hexToRgb(_color);
// //   // print(hexCode); 
// // //    print('COLORS RGB :${rgbColor.runtimeType}');
// // // _ligthColor=rgbColor.


// // String hexColor = hexCode.replaceAll('#ff', '#');//"#FF0000"; // Color rojo en formato hexadecimal
// // Color color = Color(int.parse(hexColor.replaceAll("#", "0xFF")));
// // int red = color.red;
// // int green = color.green;
// // int blue = color.blue;
// // print("RGB: $red, $green, $blue");


// // print("Hexadecimal: ${color.value.toRadixString(16).toUpperCase().runtimeType}");


// //     notifyListeners();
// //   }
  
// //   String colorToHex(Color color) {
// //   String hexAlpha = (color.alpha & 0xff).toRadixString(16).padLeft(2, '0');
// //   String hexRed = (color.red & 0xff).toRadixString(16).padLeft(2, '0');
// //   String hexGreen = (color.green & 0xff).toRadixString(16).padLeft(2, '0');
// //   String hexBlue = (color.blue & 0xff).toRadixString(16).padLeft(2, '0');
// //   return '#$hexAlpha$hexRed$hexGreen$hexBlue';
// // }
// //   Color hexToColor(String hexCode) {
// //   hexCode = hexCode.replaceAll('#', '');
// //   int hexValue = int.parse(hexCode, radix: 16);
// //   return Color(hexValue).withAlpha(0xFF);
// // }

// // Color hexToRgb(String hexColor) {
// //   String formattedColor = hexColor.replaceAll("#", "");
// //   if (formattedColor.length == 6) {
// //     formattedColor = "FF" + formattedColor; // Agrega el valor de opacidad (255) al color si no está presente
// //   }
// //   int colorValue = int.parse(formattedColor, radix: 16);
// //   return Color(colorValue);
// // }

//   ///===== COLORBASE DE LFONDO DEL HOME ====//
//   ///
//   ///   const Color(0xFF973592).withOpacity(0.5),
//                    // const Color(0xFF0092D0)
//   ///
//   ///
//   Color? _colorBase1;//=Color(0xFF973592);
//   Color? get getColorsbase1 => _colorBase1;

//   void setColorBase1(Color _color) {
//     _colorBase1 = _color;
//     notifyListeners();
//   }
//   Color? _colorBase2;//=Color(0xFF0092D0);
//   Color? get getColorsbase2 => _colorBase2;

//   void setColorBase2(Color _color) {
//     _colorBase2 = _color;
//     notifyListeners();
//   }
 

// // Responsive? _getSize;

// // Responsive? get _getResponsiveSize=>_getSize;
// // void setResponsive(Responsive? _size){
// //     _getSize=_size;
// //     print('_getSize:$_getSize');
// //   }

// bool _isTheme=false;

// bool get  getIsTheme=>_isTheme;

// void setIsTheme(bool _istheme){
//   _isTheme=_istheme;
//   notifyListeners();
// }


//   void setAppTheme(bool value, String _tipo, Color _primary, Color _secundary,
//       Color _terciadary,Responsive _size) {
//     _customTheme = false;
//     _darkTheme = value;

//     if (value) {
//       _isTheme=true;
//       _currentTheme = ThemeData.light().copyWith(
//         primaryColor: _primary,
//         //  primaryColorLight:Colors.red,
//         radioTheme: RadioThemeData(
//             fillColor: MaterialStateColor.resolveWith((states) => _primary)
//             // fillColor:MaterialStateProperty(C);
//             ),

//         textTheme: TextTheme(
//           headline2: GoogleFonts.lexendDeca(
//               fontSize: _size.iScreen(2.45),
//               color: _secundary,
//               fontWeight: FontWeight.normal),
//           subtitle1: GoogleFonts.lexendDeca(
//               // fontSize: _size.iScreen(1.9),
//               color: _terciadary,
//               fontWeight: FontWeight.normal),
//           subtitle2: GoogleFonts.lexendDeca(
//               // fontSize: _size.iScreen(1.9),
//               color: _terciadary,
//               fontWeight: FontWeight.normal),
//           bodyText1: const TextStyle(color: Colors.black87),
//           bodyText2: const TextStyle(color: Colors.black87),
//           button: const TextStyle(color: Colors.black87),
//           caption: const TextStyle(color: Colors.black87),
//           headline1: const TextStyle(color: Colors.black87),
//           headline3: const TextStyle(color: Colors.black87),
//           headline4: const TextStyle(color: Colors.black87),
//           headline5: const TextStyle(color: Colors.black87),
//           headline6: const TextStyle(color: Colors.black87),
//         ),
       
//         //==== COLOR DEL APPBAR ======//
//         appBarTheme: AppBarTheme(
//           color: _primary,
//           iconTheme: IconThemeData(color: _secundary),
//           foregroundColor: _secundary,
//           titleTextStyle: TextStyle(
//             color: _secundary,
//             // fontSize: _size.iScreen(2.45),
//           ),
//         ),
//         //==== COLOR DEL TIME PICKER ======//
//         //==== COLOR DEL CIRCULAR PROGRES ======//
//         progressIndicatorTheme:ProgressIndicatorThemeData(color: _primary) ,
//         //==== COLOR DEL FLOATBUTTOM ======//
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//             backgroundColor: _primary, foregroundColor: _secundary),

  
//       );
//       setPrimayText(_primary);
//       setSecondaryText(_secundary);
//       setTerciaryText(_terciadary);

//       // setLigthColor(_primary);


//     } else {
//       _currentTheme =ThemeData.light();//_customThemeApp();
//       _isTheme=false;
//     }

//     notifyListeners();
//   }

//   // // ThemeData _customThemeApp() => ThemeData.light();
//   // ThemeData _customThemeApp() => ThemeData.light().copyWith();

//   // set customTheme(bool value) {
//   //   _customTheme = value;
//   //   _darkTheme = false;
//   //   if (value) {
//   //     _currentTheme = ThemeData.dark();
//   //   } else {
//   //     _currentTheme = ThemeData.light();
//   //   }

//   //   // if ( value ) {
//   //   //   _currentTheme = ThemeData.dark().copyWith(
//   //   //       accentColor: Color(0xff48A0EB),
//   //   //       primaryColorLight: Colors.white,
//   //   //       scaffoldBackgroundColor: Color(0xff16202B),
//   //   //       textTheme: TextTheme(
//   //   //         // body1: TextStyle( color: Colors.white )
//   //   //       ),
//   //   //       // textTheme.body1.color
//   //   //   );
//   //   // } else {
//   //   //   _currentTheme = ThemeData.light();
//   //   // }

//   //   notifyListeners();
//   // }

// }





// class ThemeColors {
//   final Color primaryColor;
//   final Color accentColor;

//   ThemeColors({required this.primaryColor, required this.accentColor});
// }


// //*************TEMA DE LA APLICACION *************//

// class ThemeApp extends ChangeNotifier {

//   Color _primaryColor = Colors.blue;
//   Color _secondaryColor = Colors.blueAccent;

//   Color get primaryColor => _primaryColor;
//   Color get secondaryColor => _secondaryColor;

//   void updateTheme(Color primary, Color secondary) {
//     _primaryColor = primary;
//     _secondaryColor = secondary;
//     notifyListeners();
//   }

//   ThemeData get themeData {
//     return ThemeData(
//       colorScheme: ColorScheme.fromSwatch().copyWith(
//         primary: _primaryColor,
//         secondary: _secondaryColor,
//       ),
//     );
//   }

// }

class ThemeApp with ChangeNotifier {
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.blueAccent;

  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  void updateTheme(Color primary, Color secondary) {
    _primaryColor = primary;
    _secondaryColor = secondary;
    notifyListeners();
  }

  ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: _primaryColor,
        secondary: _secondaryColor,
      ),
    );
  }

  //*************COMBINACIÓN DE COLORES*************//

  final Color color1 = Color(0xFF0c7ee9);
  final Color color2 = Color(0xFF9d4343);

  List<Color> _combinedColors = [];

  ThemeApp() {
    _generateCombinedColors();
  }

  List<Color> get combinedColors => _combinedColors;

  void _generateCombinedColors() {
    _combinedColors = [
      _blendColors(color1, color2, 0.25),
      _blendColors(color1, color2, 0.5),
      _blendColors(color1, color2, 0.75),
      _blendColors(color1, color2, 1.0),
    ];
    notifyListeners();
  }

  Color _blendColors(Color c1, Color c2, double ratio) {
    return Color.fromRGBO(
      (c1.red * ratio + c2.red * (1 - ratio)).round(),
      (c1.green * ratio + c2.green * (1 - ratio)).round(),
      (c1.blue * ratio + c2.blue * (1 - ratio)).round(),
      1.0,
    );
  }
}
