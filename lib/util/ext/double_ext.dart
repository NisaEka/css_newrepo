import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toCurrency() {
    var formatter = NumberFormat(
        '#,##0.00', 'ID'); // Adjusted to include two decimal places
    return formatter.format(this);
  }
}
