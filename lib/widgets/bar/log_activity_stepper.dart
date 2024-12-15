import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/input_formatter/calculate_text_width.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogActivityStepper extends StatelessWidget {
  final CcrfActivityModel? data;
  final int currentStep;
  final int? length;
  final bool isLogin;

  const LogActivityStepper({
    super.key,
    this.data,
    required this.currentStep,
    this.length,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 5),
              height: 26,
              width: 26,
              // decoration: BoxDecoration(
              //   color: blueJNE,
              // ),
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                    color: currentStep == 0
                        ? (AppConst.isLightTheme(context) ? blueJNE : Colors.lightBlueAccent)
                        : (AppConst.isLightTheme(context)
                            ? greyColor
                            : greyDarkColor1),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(left: 21),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: (currentStep + 1) != length
                        ? greyDarkColor1
                        : Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data?.activityCreateDate.toString().toDateTimeFormat() ?? '',
              style: sublistTitleTextStyle,
            ),
            SizedBox(
              width: Get.width / 1.5,
              child: Text(
                data?.activityDescription ?? '',
                style: sublistTitleTextStyle,
              ),
            ),
            SizedBox(
              width: Get.width / 1.5,
              child: Text(
                "${data?.activityName ?? ''} (${data?.activityBy ?? ''})",
                style: sublistTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? blueJNE
                      : warningColor,
                  fontWeight: bold,
                ),
              ),
            ),
            CustomFilledButton(
              color: successLightColor2,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.only(top: 10),
              title: data?.activityStatus ?? '',
              fontSize: 10,
              // height: 20,
              width: calcTextSize(TextSpan(text: data?.activityStatus ?? ''))
                  .width,
              height: calcTextSize(TextSpan(text: data?.activityStatus ?? ''))
                      .height +
                  5,
            )
          ],
        ),
      ],
    );
  }
}
