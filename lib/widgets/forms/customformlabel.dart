import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFormLabel extends StatelessWidget {
  const CustomFormLabel({
    super.key,
    required this.label,
    this.showRequired = false,
    this.isLoading = false,
    this.isBold = false,
    this.value,
    this.fontColor,
    this.width,
  });

  final String label;
  final String? value;
  final bool showRequired;
  final bool isLoading;
  final bool isBold;
  final Color? fontColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        color: isLoading ? greyLightColor3 : Colors.transparent,
        width: width ?? (isLoading ? Get.width / 3 : null),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: label,
            style: subformLabelTextStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : regular,
              color: AppConst.isLightTheme(context)
                  ? (fontColor ?? greyDarkColor2)
                  : greyLightColor2,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: showRequired ? "*" : "",
                  style: const TextStyle(color: Colors.red)),
              // TextSpan(text: value),
            ],
          ),
        ),
      ),
    );
  }
}
