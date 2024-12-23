import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  final Color? background;
  final double? height;
  final double? width;
  final double? size;

  const LoadingDialog({
    super.key,
    this.background,
    this.height,
    this.width,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height,
      width: width ?? Get.width,
      color: background ?? greyColor.withOpacity(0.3),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          height: size ?? 100,
          width: size ?? 100,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: size != null ? 8 : 20,
            backgroundColor: secondaryColor(context),
          ),
        ),
      ),
    );
  }
}
