import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMiniCount extends StatelessWidget {
  final Color? color;
  final String? label;
  final String? value;
  final bool isLoading;
  final double? width;
  final Color? labelBgColor;
  final Color? valueBgColor;
  final double? fontSize;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  const DashboardMiniCount({
    super.key,
    this.color,
    this.label,
    this.value,
    this.isLoading = false,
    this.width,
    this.labelBgColor,
    this.valueBgColor,
    this.fontSize,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width != null ? null : Get.width * 0.28,
          margin: margin ?? const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: valueBgColor ?? primaryColor(context),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: labelBgColor ??
                      (AppConst.isLightTheme(context)
                          ? greyLightColor3
                          : greyDarkColor1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      width: width ?? Get.width * 0.21,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 5,
                            color: labelBgColor != null ? whiteColor : (color),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: width != null ? width! - 16 : null,
                            child: Text(
                              label ?? '',
                              style: TextStyle(
                                color: labelBgColor != null
                                    ? whiteColor
                                    : (AppConst.isLightTheme(context)
                                        ? blueJNE
                                        : warningColor),
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize ?? 7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  value ?? '',
                  style: TextStyle(
                    color: AppConst.isLightTheme(context)
                        ? whiteColor
                        : whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
