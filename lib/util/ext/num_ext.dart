import 'package:intl/intl.dart';

extension NumExt on num {
  String toCurrency() {
    // Create a NumberFormat object to format the number in currency style
    var formatter = NumberFormat("#,##0.00", "ID");

    // Check if the number is a double and format accordingly
    if (this is double) {
      // Round to 2 decimal places if it's a double
      return formatter.format(toDouble());
    } else {
      // If it's an integer, just format it directly
      return formatter.format(this);
    }
  }
}
