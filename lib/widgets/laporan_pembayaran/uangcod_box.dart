import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UangCODBox extends StatelessWidget {
  const UangCODBox({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 62,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Padding(padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Text("COD Terkumpul Dari Pelanggan".tr,
                  style: subformLabelTextStyle),
              Text("Rp. 3.910.000",
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
