import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfflineBar extends StatelessWidget {
  const OfflineBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 2),
      // margin: const EdgeInsets.only(bottom: 5),
      decoration:  BoxDecoration(
        color: redJNE.withOpacity(0.5),
      ),
      child: Text(
        'Mode offline'.tr,
        style: listTitleTextStyle.copyWith(color: whiteColor),
      ),
    );
  }
}
