import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: greyColor.withOpacity(0.3),
      alignment: Alignment.center,
      child: Container(
        height: Get.width / 4,
        width: Get.width / 4,
        decoration: BoxDecoration(color: greyColor.withOpacity(0.6)),
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}