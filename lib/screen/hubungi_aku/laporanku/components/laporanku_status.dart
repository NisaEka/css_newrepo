import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusLaporanku extends StatelessWidget {
  const StatusLaporanku({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppConst.isLightTheme(context) ? blueJNE : greyColor,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    c.state.status = '';
                    c.state.selectedStatus = 0;
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 5.5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.state.selectedStatus == 0
                          ? blueJNE
                          : AppConst.isLightTheme(context)
                              ? whiteColor
                              : bgDarkColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.total.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 0
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? blueJNE
                                    : whiteColor,
                          ),
                        ),
                        Text(
                          'Semua'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 0
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? greyColor
                                    : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedStatus = 3;
                    c.state.status = 'On Process';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 4,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.state.selectedStatus == 3
                          ? blueJNE
                          : AppConst.isLightTheme(context)
                              ? whiteColor
                              : bgDarkColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      //   left: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.waiting.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 3
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? blueJNE
                                    : whiteColor,
                          ),
                        ),
                        Text(
                          'Belum Diproses'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 3
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? greyColor
                                    : whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedStatus = 1;
                    c.state.status = 'Reply CS';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 4.71,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.state.selectedStatus == 1
                          ? blueJNE
                          : AppConst.isLightTheme(context)
                              ? whiteColor
                              : bgDarkColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      //   left: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.onProcess.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 1
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? blueJNE
                                    : whiteColor,
                          ),
                        ),
                        Text(
                          'Masih Diproses'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 1
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? greyColor
                                    : whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedStatus = 2;
                    c.state.status = 'Closed';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 5.5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.state.selectedStatus == 2
                          ? blueJNE
                          : AppConst.isLightTheme(context)
                              ? whiteColor
                              : bgDarkColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.closed.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 2
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? blueJNE
                                    : whiteColor,
                          ),
                        ),
                        Text(
                          'Selesai'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedStatus == 2
                                ? whiteColor
                                : AppConst.isLightTheme(context)
                                    ? greyColor
                                    : whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
