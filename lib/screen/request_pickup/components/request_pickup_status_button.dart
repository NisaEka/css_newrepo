import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupStatusButton extends StatelessWidget {
  const RequestPickupStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
      init: RequestPickupController(),
      builder: (c) {
        // Check if the list is empty or not loaded yet
        bool isListEmpty = c.state.listStatusKiriman.isEmpty;

        // Safe index access
        String firstStatus = c.state.listStatusKiriman.isNotEmpty
            ? c.state.listStatusKiriman[0]
            : '';
        String secondStatus = c.state.listStatusKiriman.length > 1
            ? c.state.listStatusKiriman[1]
            : '';
        String thirdStatus = c.state.listStatusKiriman.length > 2
            ? c.state.listStatusKiriman[2]
            : '';

        // Use Shimmer if the list is empty or loading
        return Shimmer(
          isLoading: isListEmpty, // Show shimmer when list is empty
          child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              color: blueJNE,
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First button (Safe Access)
                GestureDetector(
                  onTap: () {
                    if (c.state.listStatusKiriman.length > 2) {
                      // Safe index access
                      if (c.state.filterStatus == thirdStatus) {
                        c.state.filterStatus = firstStatus;
                      } else {
                        c.state.filterStatus = thirdStatus;
                      }
                      c.update();
                      c.state.pagingController.refresh();
                    }
                  },
                  child: Container(
                    width: Get.width * 0.427,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: c.state.filterStatus == thirdStatus
                          ? primaryColor(context)
                          : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          thirdStatus.isNotEmpty
                              ? thirdStatus.tr
                              : "SUDAH MINTA DIJEMPUT".tr,
                          style: sublistTitleTextStyle.copyWith(
                            fontSize: 10,
                            color: c.state.filterStatus == thirdStatus
                                ? whiteColor
                                : greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Second button (Safe Access)
                GestureDetector(
                  onTap: () {
                    if (c.state.listStatusKiriman.length > 1) {
                      // Safe index access
                      if (c.state.filterStatus == secondStatus) {
                        c.state.filterStatus = firstStatus;
                      } else {
                        c.state.filterStatus = secondStatus;
                      }
                      c.update();
                      c.state.pagingController.refresh();
                    }
                  },
                  child: Container(
                    width: Get.width * 0.42,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: c.state.filterStatus == secondStatus
                          ? primaryColor(context)
                          : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          secondStatus.isNotEmpty
                              ? secondStatus.tr
                              : "BELUM MINTA DIJEMPUT".tr,
                          style: sublistTitleTextStyle.copyWith(
                            fontSize: 10,
                            color: c.state.filterStatus == secondStatus
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
          ),
        );
      },
    );
  }
}
