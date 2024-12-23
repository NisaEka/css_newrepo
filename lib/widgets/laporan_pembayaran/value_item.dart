import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class ValueItem extends StatelessWidget {
  final String title;
  final String? value;
  final Color? valueFontColor;
  final TextStyle? valueTextStyle;
  final TextStyle? titleTextStyle;
  final double? fontSize;
  final double? width;
  final double? titleWidth;

  const ValueItem({
    super.key,
    required this.title,
    this.value,
    this.valueFontColor,
    this.fontSize,
    this.valueTextStyle,
    this.titleTextStyle,
    this.width,
    this.titleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(
            title,
            style: titleTextStyle ??
                Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: fontSize ?? 11),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          // width: width ?? Get.width / 2,
          child: Text(
            value ?? '',
            style: valueTextStyle ??
                listTitleTextStyle.copyWith(
                  fontSize: fontSize ?? 11,
                  color: valueFontColor ??
                      (Theme.of(context).brightness == Brightness.light
                          ? greyDarkColor1
                          : greyLightColor1),
                ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
