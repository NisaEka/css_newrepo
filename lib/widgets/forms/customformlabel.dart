import 'package:css_mobile/base/theme_controller.dart';
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
    this.prefixIcon,
  });

  final String label;
  final String? value;
  final bool showRequired;
  final bool isLoading;
  final bool isBold;
  final Color? fontColor;
  final double? width;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        color: isLoading ? greyLightColor3 : Colors.transparent,
        width: width ?? (isLoading ? Get.width / 3 : null),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            prefixIcon ?? const SizedBox(),
            SizedBox(width: prefixIcon != null ? 5 : null),
            RichText(
              text: TextSpan(
                text: label,
                style: subformLabelTextStyle.copyWith(
                  fontWeight: isBold ? FontWeight.bold : regular,
                  color: fontColor ?? CustomTheme().textColor(context),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: showRequired ? "*" : "",
                      style: const TextStyle(color: Colors.red)),
                  // TextSpan(text: value),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
