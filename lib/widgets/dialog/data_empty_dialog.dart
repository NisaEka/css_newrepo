import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataEmpty extends StatelessWidget {
  final String text;

  const DataEmpty({super.key, this.text = "Data Kosong"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.dataEmpty,
            width: Get.width / 2,
          ),
          Text(
            text.tr,
            style: appTitleTextStyle.copyWith(
                fontSize: 30,
                color: Theme.of(context).brightness == Brightness.light
                    ? blueJNE
                    : whiteColor),
          ),
        ],
      ),
    );
  }
}
