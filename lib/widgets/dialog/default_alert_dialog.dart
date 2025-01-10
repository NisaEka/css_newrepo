import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultAlertDialog extends StatelessWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onBack;
  final String? title;
  final String? subtitle;
  final String? backButtonTitle;
  final String? confirmButtonTitle;
  final Widget? icon;

  const DefaultAlertDialog({
    super.key,
    required this.onConfirm,
    this.onBack,
    this.title,
    this.subtitle,
    this.backButtonTitle,
    this.confirmButtonTitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : bgDarkColor,
      title: Column(
        children: [
          Image.asset(
            ImageConstant.logoCSS,
            height: 30,
            width: Get.width,
            color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
          ),
          const SizedBox(height: 12),
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: regular, fontSize: 16),
          ),
          icon ?? const SizedBox(),
        ],
      ),
      content: Text(
        textAlign: TextAlign.center,
        subtitle ?? '',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: regular, fontSize: 12),
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            onBack != null
                ? CustomFilledButton(
                    radius: 50,
                    margin: EdgeInsets.zero,
                    isTransparent: true,
                    color: primaryColor(context),
                    title: backButtonTitle ?? '',
                    onPressed: onBack ?? () => Get.back(),
                  )
                : const SizedBox(),
            CustomFilledButton(
              radius: 50,
              color: primaryColor(context),
              isTransparent: false,
              title: confirmButtonTitle ?? '',
              onPressed: onConfirm,
            ),
          ],
        ),
      ],
    );
  }
}
