import 'package:intl/intl.dart';

class DateTimeUtils {
  // Format DateTime ke string dengan format '12 Agustus 2024'
  static String formatDateIndo(DateTime date) {
    return DateFormat('d MMMM yyyy', 'en_US').format(date);
  }

  // Contoh format lain
  static String formatDateCustom(DateTime date,
      {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }
}
