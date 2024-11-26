import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupStatusButton extends StatelessWidget {
  const RequestPickupStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
        init: RequestPickupController(),
        builder: (c) {
          if (c.state.listStatusKiriman.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: blueJNE,
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (c.state.filterStatus == c.state.listStatusKiriman[2]) {
                      c.state.filterStatus = c.state.listStatusKiriman[0];
                    } else {
                      c.state.filterStatus = c.state.listStatusKiriman[2];
                    }
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width * 0.457,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          c.state.filterStatus == c.state.listStatusKiriman[2]
                              ? blueJNE
                              : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.listStatusKiriman[2].isNotEmpty
                              ? c.state.listStatusKiriman[2].tr
                              : "SUDAH MINTA DIJEMPUT".tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.filterStatus ==
                                    c.state.listStatusKiriman[2]
                                ? whiteColor
                                : greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (c.state.filterStatus == c.state.listStatusKiriman[1]) {
                      c.state.filterStatus = c.state.listStatusKiriman[0];
                    } else {
                      c.state.filterStatus = c.state.listStatusKiriman[1];
                    }
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width * 0.457,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          c.state.filterStatus == c.state.listStatusKiriman[1]
                              ? blueJNE
                              : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.listStatusKiriman[1].isNotEmpty
                              ? c.state.listStatusKiriman[1].tr
                              : "SUDAH MINTA DIJEMPUT".tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.filterStatus ==
                                    c.state.listStatusKiriman[1]
                                ? whiteColor
                                : greyColor,
                          ),
                        ),
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
