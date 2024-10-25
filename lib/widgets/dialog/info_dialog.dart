import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoDialog extends StatelessWidget {
  final String? infoText;
  final VoidCallback? nextButton;
  final String? nextButtonTitle;

  const InfoDialog({
    super.key,
    this.infoText,
    this.nextButton,
    this.nextButtonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // scrollable: false,
      contentPadding: const EdgeInsets.only(top: 10),
      actionsPadding: EdgeInsets.zero,
      // backgroundColor: Colors.white,
      elevation: 0,
      content: SizedBox(
        height: Get.width / 1.3,
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppConst.isDarkTheme(context)
                    ? infoDarkColor
                    : infoLightColor1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                infoText?.tr ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(ImageConstant.mascotPic)
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: nextButton ?? () => Get.back(),
          child: Text(
            nextButton != null ? 'OK' : 'tutup'.tr,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
