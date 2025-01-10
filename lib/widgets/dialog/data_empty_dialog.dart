import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataEmpty extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final double? height;

  const DataEmpty({
    super.key,
    this.text = "Data Kosong",
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      constraints: BoxConstraints(
        minHeight: context.height / 4,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.dataEmpty,
              width: Get.width / 4,
            ),
            Text(
              text.tr,
              textAlign: TextAlign.center,
              style: subTitleTextStyle.copyWith(
                  fontSize: 15,
                  color: Theme.of(context).brightness == Brightness.light
                      ? blueJNE
                      : whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
