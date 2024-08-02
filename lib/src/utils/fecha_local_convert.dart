import 'package:intl/intl.dart';

class DateUtility {
  static String fechaLocalConvert(String fecha) {
    DateTime utcDateTime = DateTime.parse(fecha);
    DateTime localDateTime = utcDateTime.toLocal();
    String fechaLocal = DateFormat('yyyy-MM-dd HH:mm').format(localDateTime);
    return fechaLocal;
  }
}