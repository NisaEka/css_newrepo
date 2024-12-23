import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String? title;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color color;
  final Color? borderColor;
  final Color? fontColor;
  final double? fontSize;
  final double width;
  final double? height;
  final double radius;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final TextStyle? fontStyle;
  final List<BoxShadow>? boxShadow;
  final bool isTransparent;
  final bool isLoading;

  const CustomFilledButton(
      {Key? key,
      this.title = '',
      this.width = double.infinity,
      this.height,
      this.prefixIcon,
      required this.color,
      this.onPressed,
      this.borderColor = Colors.transparent,
      this.fontColor = whiteColor,
      this.radius = 10,
      this.fontSize = 14,
      this.margin,
      this.padding,
      this.fontStyle,
      this.boxShadow,
      this.isTransparent = false,
      this.isLoading = false,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Shimmer(
        child: ShimmerLoading(
          isLoading: isLoading,
          child: Container(
            alignment: Alignment.center,
            margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
            width: width,
            height: height ?? 40,
            decoration: BoxDecoration(
              color: isLoading
                  ? greyColor
                  : isTransparent
                      ? Colors.transparent
                      : color,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: isTransparent ? color : borderColor!),
              boxShadow: boxShadow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(width: 5),
                prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: isTransparent
                            ? AppConst.isLightTheme(context)
                                ? color
                                : whiteColor
                            : fontColor,
                        size: fontSize! + 2,
                      )
                    : const SizedBox(),
                title != null
                    ? Container(
                        margin: EdgeInsets.only(
                          left: prefixIcon != null && title != null ? 5 : 0,
                          right: suffixIcon != null && title != null ? 5 : 0,
                        ),
                        child: Text(
                          '$title',
                          style: fontStyle ??
                              TextStyle(
                                  color: isTransparent
                                      ? AppConst.isLightTheme(context)
                                          ? color
                                          : whiteColor
                                      : fontColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
                suffixIcon != null
                    ? Icon(
                        suffixIcon,
                        color: isTransparent
                            ? AppConst.isLightTheme(context)
                                ? color
                                : whiteColor
                            : fontColor,
                        size: fontSize! + 2,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
