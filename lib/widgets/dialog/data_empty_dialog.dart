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
        const Icon(
          Icons.folder_off_outlined,
          size: 50,
          color: blueJNE,
        ),
        Text(
          'Account Kosong'.tr,
          style: appTitleTextStyle.copyWith(color: blueJNE),
        ),
      ],
    );
  }
}
