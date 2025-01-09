import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class KirimanStepper extends StatelessWidget {
  final HistoryKiriman? history;
  final Cnote? cnote;
  final int currentStep;
  final int? length;
  final bool isLogin;
  final bool isLoading;

  const KirimanStepper({
    super.key,
    required this.currentStep,
    this.history,
    this.length,
    this.cnote,
    this.isLogin = false,
    this.isLoading = false,
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
              child: SvgPicture.asset(
                IconsConstant.box,
                color: currentStep == 0
                    ? (AppConst.isLightTheme(context)
                        ? blueJNE
                        : Colors.lightBlueAccent)
                    : null,
              ),
            ),
            Container(
              height: 60,
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
              history?.date ?? '',
              style: sublistTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? redJNE : whiteColor),
            ),
            SizedBox(
              width: Get.width / 1.5,
              child: Text(
                history?.desc ?? '',
                style: sublistTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? redJNE : warningColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
