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
  final String buttonTitle;
  final Widget? icon;
  final Color? fontColor;

  const SuccessScreen({
    super.key,
    required this.message,
    this.nextAction,
    required this.buttonTitle,
    this.icon,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const LogoHeader(),
            icon ?? Lottie.asset(ImageConstant.successLottie),
            Text(
              message.tr,
              style: appTitleTextStyle.copyWith(color: fontColor ?? greyDarkColor1),
              textAlign: TextAlign.center,
            ),
            CustomFilledButton(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              color: blueJNE,
              radius: 50,
              title: buttonTitle.tr,
              onPressed: nextAction,
            ),
          ],
        ),
      ),
    );
  }
}
