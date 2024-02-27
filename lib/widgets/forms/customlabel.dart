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
  final double? fontSize;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final bool isHorizontal;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final int? valueMaxline;

  const CustomLabelText({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.alignment,
    this.width,
    this.fontColor,
    this.fontSize,
    this.titleTextStyle,
    this.valueTextStyle,
    this.isHorizontal = false,
    this.margin,
    this.padding,
    this.valueMaxline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      child: isHorizontal
          ? Row(
              crossAxisAlignment: alignment == 'end'
                  ? CrossAxisAlignment.end
                  : alignment == 'center'
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  "$title ",
                  style: titleTextStyle ??
                      subTitleTextStyle.copyWith(
                        color: fontColor ?? greyColor,
                        fontSize: fontSize,
                      ),
                ),
                Text(
                  value.toUpperCase(),
                  // "This is a long text This is a long text This is a long text",
                  // overflow: TextOverflow.ellipsis,
                  maxLines: valueMaxline ?? 1,
                  softWrap: true,
                  textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
                  style: valueTextStyle ??
                      listTitleTextStyle.copyWith(
                        color: fontColor ?? valueColor ?? greyDarkColor1,
                        fontSize: fontSize,
                      ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: alignment == 'end'
                  ? CrossAxisAlignment.end
                  : alignment == 'center'
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleTextStyle ??
                      subTitleTextStyle.copyWith(
                        color: fontColor ?? greyColor,
                        fontSize: fontSize,
                      ),
                ),
                Text(
                  value.toUpperCase(),
                  // "This is a long text This is a long text This is a long text",
                  // overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
                  style: valueTextStyle ??
                      listTitleTextStyle.copyWith(
                        color: fontColor ?? valueColor ?? greyDarkColor1,
                        fontSize: fontSize,
                      ),
                )
              ],
            ),
    );
  }
}
