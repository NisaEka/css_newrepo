import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';

class CustomLabelText extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final Color? fontColor;
  final String? alignment;
  final double? width;
  final double? maxline;
  final double? fontSize;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final bool isHorizontal;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final int? valueMaxline;
  final bool isLoading;
  final bool isHasSpace;
  final Color? color;

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
    this.isLoading = false,
    this.maxline,
    this.isHasSpace = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      decoration: BoxDecoration(
        color: color,
      ),
      child: isHorizontal
          ? Row(
              crossAxisAlignment: alignment == 'end'
                  ? CrossAxisAlignment.end
                  : alignment == 'center'
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              mainAxisAlignment: isHasSpace ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                Shimmer(
                  isLoading: isLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLoading ? greyColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      title,
                      style: titleTextStyle ??
                          subTitleTextStyle.copyWith(
                            color: fontColor ?? (AppConst.isLightTheme(context) ? greyColor : whiteColor),
                            fontSize: fontSize,
                          ),
                    ),
                  ),
                ),
                Shimmer(
                  isLoading: isLoading,
                  child: Container(
                    decoration: BoxDecoration(color: isLoading ? greyColor : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                    width: width != null ? width! - 100 : null,
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      value.toUpperCase(),
                      // "This is a long text This is a long text This is a long text",
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: valueMaxline ?? 1,
                      textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
                      style: valueTextStyle ??
                          listTitleTextStyle.copyWith(
                            color: fontColor ?? valueColor ?? (AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1),
                            fontSize: fontSize,
                          ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: alignment == 'end'
                  ? CrossAxisAlignment.end
                  : alignment == 'center'
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Shimmer(
                  isLoading: isLoading,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(color: isLoading ? greyColor : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      title,
                      style: titleTextStyle ??
                          subTitleTextStyle.copyWith(
                            color: fontColor ?? (AppConst.isLightTheme(context) ? greyColor : whiteColor),
                            fontSize: fontSize,
                          ),
                    ),
                  ),
                ),
                Shimmer(
                  isLoading: isLoading,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(color: isLoading ? greyColor : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      value.toUpperCase(),
                      // "This is a long text This is a long text This is a long text",
                      // overflow: TextOverflow.fade,
                      // maxLines: 1,
                      softWrap: true,
                      textAlign: alignment == 'end' ? TextAlign.right : TextAlign.left,
                      style: valueTextStyle ??
                          listTitleTextStyle.copyWith(
                            color: fontColor ?? valueColor ?? (AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1),
                            fontSize: fontSize,
                          ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
