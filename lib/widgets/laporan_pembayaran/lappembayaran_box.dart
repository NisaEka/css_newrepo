import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class PaymentBox extends StatelessWidget {
  final String title;
  final String value;

  const PaymentBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyDarkColor1),
        boxShadow: const [
          BoxShadow(
            color: blueJNE,
            spreadRadius: 1,
            offset: Offset(-3, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(title.capitalize ?? '', style: subformLabelTextStyle),
                Text(
                  value,
                  style: appTitleTextStyle.copyWith(color: blueJNE),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
