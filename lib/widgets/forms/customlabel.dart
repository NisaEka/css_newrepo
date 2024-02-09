import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLabelText extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final Color? fontColor;
  final String? alignment;
  final double? width;

  const CustomLabelText({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.alignment,
    this.width,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: alignment == 'end' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subTitleTextStyle.copyWith(color: fontColor ?? greyColor),
          ),
          Text(
            value.toUpperCase(),
            // "This is a long text This is a long text This is a long text",
            // overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
            textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
            style: listTitleTextStyle.copyWith(color: fontColor ?? valueColor ?? greyDarkColor1),
          )
        ],
      ),
    );
  }
}
