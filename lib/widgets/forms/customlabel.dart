import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLabelText extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final String? alignment;
  final double? width;

  const CustomLabelText({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.alignment,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: alignment == 'end' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: sublistTitleTextStyle.copyWith(color: greyColor),
          ),
          Text(
            value.toUpperCase(),
            textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
            style: listTitleTextStyle.copyWith(color: valueColor ?? greyDarkColor1),
          )
        ],
      ),
    );
  }
}
