import 'package:intl/intl.dart';
import 'package:css_mobile/util/logger.dart';

extension StringExt on String {
  String digitOnly() {
    return replaceAll(RegExp(r"\D"), "");
  }

  int toInt() {
    return int.parse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  bool toBool() {
    return bool.parse(this);
  }

  String toDateFormat(
      {String targetFormat = "dd-MM-yyyy",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toDateFormat $e");
      return "-";
    }
  }

  String toLongDateTimeFormat(
      {String targetFormat = "dd MMMM yyyy HH:mmzzz",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this);
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toLongDateFormat $e");
      return "-";
    }
  }

  String toShortDateTimeFormat(
      {String targetFormat = "dd MMM yyyy HH:mmzzz",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toShortDateFormat $e");
      return "-";
    }
  }

  String toTimeFormat(
      {String targetFormat = "HH:mm", String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toTimeFormat $e");
      return "-";
    }
  }

  String toLongDateFormat(
      {String targetFormat = "dd MMMM yyyy",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toLongDateFormat $e");
      return "-";
    }
  }

  String toShortDateFormat(
      {String targetFormat = "dd MMM yyyy",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toShortDateFormat $e");
      return "-";
    }
  }

  String toDateTimeFormat(
      {String targetFormat = "dd-MM-yyyy HH:mmzzz",
      String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTimeOrigin = DateTime.parse(this).toLocal();
      DateFormat dateFormat = DateFormat(targetFormat);
      return dateFormat.format(dateTimeOrigin);
    } catch (e) {
      AppLogger.e("ERROR toDateTimeFormat $e");
      return "-";
    }
  }

  DateTime? toDate({String originFormat = "dd/MM/yyyy"}) {
    try {
      DateTime dateTime = DateFormat(originFormat).parse(this).toLocal();

      return dateTime;
    } on FormatException catch (e) {
      AppLogger.e("ERROR toDateFormat $e");
      rethrow;
    } catch (e) {
      AppLogger.e("ERROR toDateFormat $e");
      return null;
    }
  }

  bool isNumeric() {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(this);
  }

  bool isImage() {
    String text = toLowerCase();
    return text.contains(".png") ||
        text.contains(".jpg") ||
        text.contains("jpeg");
  }

  String getInitials() => isNotEmpty
      ? replaceAll(RegExp(r"[^\s\w]"), "")
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  String maskPhoneNumber() {
    if (length > 6) {
      return substring(0, length - 6) + '*' * 6;
    } else {
      return this;
    }
  }
}
