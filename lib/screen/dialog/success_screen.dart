import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const LogoHeader(),
          Positioned(
            top: iconMargin ?? 150,
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
                  // Container(
                  //   color: Colors.grey,
                  //   child: icon ??
                  //       Lottie.asset(
                  //         lottie ?? ImageConstant.successLottie,
                  //         // height: iconHeight ?? Get.width / 1.2,
                  //         fit: BoxFit.cover,
                  //       ),
                  // ),
                  (message?.isNotEmpty ?? false)
                      ? SizedBox(
                          height: Get.width * 0.5,
                          width: Get.width,
                          child: Text(
                            message?.tr ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox(),
                  customInfo ?? const SizedBox()
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          onFirstAction != null
              ? CustomFilledButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // color: whiteColor,
                  //
                  // fontColor: blueJNE,
                  // borderColor: blueJNE,
                  color: blueJNE,
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
                  color:
                      AppConst.isLightTheme(context) ? blueJNE : warningColor,
                  radius: 10,
                  title: secondButtonTitle,
                  onPressed: onSecondAction,
                )
              : const SizedBox(),
          thirdButtonTitle != null
              ? CustomFilledButton(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // color: Colors.white,
                  isTransparent: true,
                  // borderColor: blueJNE,
                  // fontColor: AppConst.isLightTheme(context) ? blueJNE : warningColor,
                  color: blueJNE,
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
