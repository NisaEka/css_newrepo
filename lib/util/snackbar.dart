import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void success(String message) {
    custom(
      message: message,
      backgroundColor: successColor,
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  static void error(String message) {
    custom(
      message: message,
      backgroundColor: errorColor,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static void info(String message) {
    custom(
      message: message,
      backgroundColor: greyColor.withOpacity(0.8),
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  static void warning(String message) {
    custom(
      message: message,
      backgroundColor: warningColor,
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }

  static void custom({
    required String message,
    Color backgroundColor = Colors.transparent,
    Icon? icon,
    int durationInSeconds = 15,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    SnackStyle snackStyle = SnackStyle.GROUNDED,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Widget? messageText,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        icon: icon,
        message: messageText == null ? message.tr : null,
        messageText: messageText,
        isDismissible: true,
        duration: Duration(seconds: durationInSeconds),
        backgroundColor: backgroundColor,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
        margin: margin ?? const EdgeInsets.all(0.0),
        padding: padding ?? const EdgeInsets.all(16),
      ),
    );
  }
}
