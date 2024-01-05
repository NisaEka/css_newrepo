import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/reusable/forms/customfilledbutton.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuceesDialog extends StatelessWidget {
  const SuceesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Selamat".tr, style: titleTextStyle),
            Lottie.asset(ImageConstant.successIcon),
            Text(
              "Resi telah dibuat".tr,
              style: sublistTitleTextStyle,
            ),
            CustomFilledButton(
              color: successColor,
              title: "Kembali Ke Beranda".tr,
              onPressed: () => Get.offAll(DashboardScreen()),
            )
          ],
        ),
      ),
    );
  }
}
