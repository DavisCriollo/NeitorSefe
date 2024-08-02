import 'package:intl/intl.dart';

bool validarFechaActual(String fechaStr) {

DateTime fecha = DateTime.parse(fechaStr);
  DateTime fechaActual = DateTime.now();

  // Formatear la fecha actual al formato "yyyy-MM-dd"
  String fechaActualFormateada = DateFormat('yyyy-MM-dd').format(fechaActual);
  // print('fecha: $fechaStr');

// print('fechaActual: $fechaActualFormateada');
  return fecha.isAfter(DateTime.parse(fechaActualFormateada)) || fecha.isAtSameMomentAs(DateTime.parse(fechaActualFormateada));

}