import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JLCPointWidget extends StatelessWidget {
  final String point;

  const JLCPointWidget({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return controller.state.isLogin && (controller.state.allow.keuanganBonus == "Y" || controller.state.allow.bonus == "Y")
            ? GestureDetector(
                onTap: () => Get.to(const BonusKamuScreen()),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? whiteColor : greyColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: redJNE,
                        spreadRadius: 1,
                        offset: Offset(-2, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageConstant.logoJLC, height: 14),
                      Text(' ${point != '0' ? point.toDouble() : 0} Point'),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      }
    );
  }
}
