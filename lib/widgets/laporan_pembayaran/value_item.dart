import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueItem extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueFontColor;
  final TextStyle? valueTextStyle;
  final TextStyle? titleTextStyle;
  final double? fontSize;

  const ValueItem({
    super.key,
    required this.title,
    required this.value,
    this.valueFontColor,
    this.fontSize,
    this.valueTextStyle,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleTextStyle ?? subTitleTextStyle.copyWith(fontSize: fontSize ?? 8),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: Get.width / 2,
          child: Text(
            value,
            style: valueTextStyle ??
                listTitleTextStyle.copyWith(
                  fontSize: fontSize ?? 8,
                  color: valueFontColor ?? greyDarkColor1,
                ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
