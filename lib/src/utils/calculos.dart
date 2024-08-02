// import 'dart:math';

// class Calculos {
//   Calculos._internal();
//   static Calculos _instance = Calculos._internal();
//   static Calculos get instance => _instance;
//   }
// =======  REDONDEA NUMEROS A N DECIMALES =====//
// double redondeaDouble(double value, int decimales) {
//   double mod = pow(10.0, decimales);
//   return ((value * mod).round().toDouble() / mod);
// }

// =======  VALIDA SI EL DATO ES NUMERICO =====//
bool isNumeric(String value) {
  if (value.isEmpty) return false;
  final n = num.tryParse(value);
  if (n == null) {
    return false;
  } else {
    return true;
  }
}


String? numberValidator(String? value) {
  if(value == null || value != '-') {
    return null;
  }
  
  final n = num.tryParse(value);
  if(n == null) {
    return '"$value" is not a valid number';
  }
  return null;
}

  formatoFechaActual() {
    DateTime? data = DateTime.now();
    String? anio, mes, dia;
    anio = '${data.year}';
    mes = (data.month < 10) ? '0${data.month}' : '${data.month}';
    dia = (data.day < 10) ? '0${data.day}' : '${data.day}';

    // setState(() {
    return  '${anio.toString()}-${mes.toString()}-${dia.toString()}';

   

    
  }
