import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final VoidCallback? nextAction;
  final VoidCallback? secondAction;
  final VoidCallback? thirdAction;
  final String? buttonTitle;
  final String? thirdButtonTitle;
  final String? secondButtonTitle;
  final Widget? icon;
  final Color? fontColor;

  const SuccessScreen({
    super.key,
    required this.message,
    this.nextAction,
    this.buttonTitle,
    this.icon,
    this.fontColor,
    this.secondAction,
    this.thirdAction,
    this.secondButtonTitle,
    this.thirdButtonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LogoHeader(),
          Column(
            children: [
              icon ??
                  Lottie.asset(ImageConstant.successLottie,
                      height: Get.width / 1.2),
              Text(
                message.tr,
                style: appTitleTextStyle.copyWith(
                    color: fontColor ??
                        (AppConst.isLightTheme(context)
                            ? greyDarkColor1
                            : greyLightColor1)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              secondAction != null
                  ? CustomFilledButton(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: whiteColor,
                      fontColor: blueJNE,
                      borderColor: blueJNE,
                      title: secondButtonTitle,
                      radius: 10,
                      onPressed: secondAction,
                    )
                  : const SizedBox(),
              thirdAction != null
                  ? CustomFilledButton(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: blueJNE,
                      radius: 10,
                      title: thirdButtonTitle,
                      onPressed: thirdAction,
                    )
                  : const SizedBox(),
              buttonTitle != null
                  ? CustomFilledButton(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Colors.white,
                      borderColor: blueJNE,
                      fontColor: blueJNE,
                      radius: 10,
                      title: buttonTitle?.tr,
                      onPressed: nextAction,
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
