import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar extends StatelessWidget {
  final bool? isSuccess = false;
  final String message;
  final Color? color;

  const CustomSnackbar({
    super.key,
    required this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GetSnackBar(
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      message: message,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      backgroundColor: color ?? greyColor,
    );
  }
}
