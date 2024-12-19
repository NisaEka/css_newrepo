import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBackButton<T> extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    this.result,
    this.onPressed,
    this.color,
  }) : super(key: key);

  final T? result;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Get.back(),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          IconsConstant.arrowCircle,
          color: color ??
              (AppConst.isLightTheme(context) ? blueJNE : warningColor),
        ),
      ),
    );
  }
}
