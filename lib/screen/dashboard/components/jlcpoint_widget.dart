import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/app_const.dart';

class JLCPointWidget extends StatelessWidget {
  final String point;

  const JLCPointWidget({super.key, required this.point});

  get color => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return controller.state.isLogin &&
                  (controller.state.allow.keuanganBonus == "Y" ||
                      controller.state.allow.bonus == "Y")
              ? GestureDetector(
                  onTap: () => Get.to(const BonusKamuScreen()),
                  child: Shimmer(
                    isLoading: controller.state.isLoading,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: controller.state.isLoading
                            ? greyColor
                            : Colors.transparent,
                        borderRadius: controller.state.isLoading
                            ? BorderRadius.circular(10)
                            : null,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? whiteColor
                                  : whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: color ??
                                  (AppConst.isLightTheme(context)
                                      ? redJNE
                                      : warningColor),
                              spreadRadius: 1,
                              offset: const Offset(-2, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImageConstant.logoJLC2, height: 12),
                            Text(
                                ' ${point != '0' ? point.toDouble().toInt() : 0} Point',
                                style: sublistTitleTextStyle.copyWith(
                                    color: greyDarkColor1)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        });
  }
}
