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
        // mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            ImageConstant.logoCSS,
            height: 30,
            width: Get.width,
            color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
          ),
          const SizedBox(height: 5),
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: regular),
            // style: TextStyle(
            //     color: AppConst.isLightTheme(context)
            //         ? greyDarkColor2
            //         : greyLightColor2)),
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
            ?.copyWith(fontWeight: regular),
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
                    color: Theme.of(context).brightness == Brightness.light
                        ? blueJNE
                        : warningColor,
                    title: backButtonTitle ?? '',
                    onPressed: onBack ?? () => Get.back(),
                  )
                : const SizedBox(),
            CustomFilledButton(
                radius: 50,
                color: Theme.of(context).brightness == Brightness.light
                    ? blueJNE
                    : warningColor,
                title: confirmButtonTitle ?? '',
                onPressed: onConfirm),
          ],
        ),
        // TextButton(
        //     style: TextButton.styleFrom(
        //       textStyle: Theme.of(context).textTheme.labelLarge,
        //     ),
        //     onPressed: onBack ?? () => Get.back(),
        //     child: Text(
        //       'Tidak'.tr,
        //       style: TextStyle(
        //           color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
        //     )),
        // TextButton(
        //   style: TextButton.styleFrom(
        //     textStyle: Theme.of(context).textTheme.labelLarge,
        //   ),
        //   onPressed: onLogout,
        //   child: Text(
        //     'Keluar'.tr,
        //     style: TextStyle(
        //         color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
        //   ),
        // ),
      ],
    );
  }
}
