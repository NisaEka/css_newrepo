import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggMinusBox extends StatelessWidget {
  const AggMinusBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 39,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blueJNE),
        boxShadow: const [
          BoxShadow(
            color: blueJNE,
            spreadRadius: 1,
            offset: Offset(-2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.info_rounded, color: redJNE, size: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Data diperbaharui setiap jam 06.45 WIB".tr,
              style: inputTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
