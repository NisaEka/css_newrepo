import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String? message;
  final VoidCallback? onThirdAction;
  final VoidCallback? onFirstAction;
  final VoidCallback? onSecondAction;
  final String? thirdButtonTitle;
  final String? secondButtonTitle;
  final String? firstButtonTitle;
  final Widget? icon;
  final Color? fontColor;
  final String? lottie;
  final Widget? customAction;
  final Widget? customInfo;
  final double? iconHeight;
  final double? iconMargin;
  final EdgeInsets? custompadding;

  const SuccessScreen({
    super.key,
    this.message,
    this.onThirdAction,
    this.thirdButtonTitle,
    this.icon,
    this.fontColor,
    this.onFirstAction,
    this.onSecondAction,
    this.firstButtonTitle,
    this.secondButtonTitle,
    this.lottie,
    this.customAction,
    this.customInfo,
    this.iconHeight,
    this.iconMargin,
    this.custompadding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) =>
            Get.delete<DashboardController>().then(
          (_) {
            Get.offAll(const DashboardScreen());
          },
        ),
        child: Stack(
          children: [
            const LogoHeader(),
            Positioned(
              top: iconMargin ?? 300,
              left: 0,
              right: 0,
              child: icon ??
                  Lottie.asset(
                    lottie ?? ImageConstant.successLottie,
                    height: iconHeight ?? Get.width / 1.2,
                    fit: BoxFit.cover,
                  ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (message?.isNotEmpty ?? false)
                        ? SizedBox(
                            height: customInfo != null ? null : Get.width * 0.5,
                            width: Get.width,
                          )
                        : const SizedBox(),
                    customInfo ?? const SizedBox()
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          onFirstAction != null
              ? CustomFilledButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: primaryColor(context),
                  isTransparent: true,
                  title: firstButtonTitle,
                  radius: 10,
                  onPressed: onFirstAction,
                )
              : const SizedBox(),
          onSecondAction != null
              ? CustomFilledButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: primaryColor(context),
                  radius: 10,
                  title: secondButtonTitle,
                  onPressed: onSecondAction,
                )
              : const SizedBox(),
          thirdButtonTitle != null
              ? CustomFilledButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  isTransparent: true,
                  color: primaryColor(context),
                  radius: 10,
                  title: thirdButtonTitle?.tr,
                  onPressed: onThirdAction,
                )
              : const SizedBox(),
          customAction ?? const SizedBox()
        ],
      ),
    );
  }
}
