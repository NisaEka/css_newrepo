import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardInfo extends StatefulWidget {
  const DashboardInfo({super.key});

  @override
  State<DashboardInfo> createState() => _DashboardInfoState();
}

class _DashboardInfoState extends State<DashboardInfo> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (c) {
          return c.state.isCcrf
              ? const SizedBox()
              : isShow
                  ? GestureDetector(
                      onTap: () => Get.to(const FacilityScreen()),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: blueJNE,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lengkapi profil Kamu untuk menikmati semua fitur unggulan.'.tr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 10,
                                color: whiteColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(
                                () => isShow = false,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: whiteColor,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
        });
  }
}
