import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataEmpty extends StatelessWidget {
  final String text;

  const DataEmpty({super.key, this.text = "Data Kosong"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.folder_off_outlined,
          size: 50,
          color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
        ),
        Text(
          text.tr,
          style: appTitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? blueJNE : whiteColor),
        ),
      ],
    );
  }
}
