import 'package:intl/intl.dart';

extension NumExt on num {
  String toCurrency() {
    var formatter = NumberFormat("#,##0", "ID");
    return formatter.format(this);
  }
}