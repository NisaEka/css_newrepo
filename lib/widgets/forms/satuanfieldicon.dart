import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class SatuanFieldIcon extends StatelessWidget {
  final String title;
  final bool? isPrefix;
  final bool? isSuffix;
  final double? width;

  const SatuanFieldIcon(
      {super.key,
      required this.title,
      this.isPrefix = false,
      this.isSuffix = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 30,
      height: 39,
      margin:
          EdgeInsets.only(right: isPrefix! ? 10 : 0, left: isSuffix! ? 5 : 0),
      decoration: BoxDecoration(
        color: AppConst.isLightTheme(context) ? blueJNE : warningColor,
        borderRadius: BorderRadius.only(
          topRight: isSuffix! ? const Radius.circular(8) : Radius.zero,
          bottomRight: isSuffix! ? const Radius.circular(8) : Radius.zero,
          topLeft: isPrefix! ? const Radius.circular(8) : Radius.zero,
          bottomLeft: isPrefix! ? const Radius.circular(8) : Radius.zero,
        ),
      ),
      child: Text(title,
          style: listTitleTextStyle.copyWith(
              color: AppConst.isLightTheme(context) ? whiteColor : whiteColor)),
    );
  }
}
