import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class JlcPointBox extends StatelessWidget {
  const JlcPointBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 62,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10, left: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyDarkColor1),
        boxShadow: const [
          BoxShadow(
            color: blueJNE,
            spreadRadius: 1,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstant.logoJLC, height: 28, width: 60),
          Column(
            children: [
              Text("Total Transaksi".tr, style: subformLabelTextStyle),
              Text(
                "Rp. 3.910.000",
                style: formLabelTextStyle.copyWith(color: blueJNE),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Poin JLC".tr, style: subformLabelTextStyle),
              Text(
                "112",
                style: formLabelTextStyle.copyWith(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
