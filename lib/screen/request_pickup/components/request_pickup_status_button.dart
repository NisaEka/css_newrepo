import 'package:css_mobile/const/app_const.dart';
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
              color: iconColor(context),
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First button (Safe Access)
                _statusCard(
                  context: context,
                  controller: c,
                  label: thirdStatus.isNotEmpty
                      ? thirdStatus.tr
                      : "SUDAH MINTA DIJEMPUT".tr,
                  count: c.state.requestPickupCount
                          .firstWhereOrNull(
                              (element) => element.status == thirdStatus)
                          ?.count ??
                      0,
                  selected: c.state.filterStatus == thirdStatus,
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
                  isFirst: true,
                  isLast: false,
                ),
                // Second button (Safe Access)
                _statusCard(
                  context: context,
                  controller: c,
                  label: secondStatus.isNotEmpty
                      ? secondStatus.tr
                      : "BELUM MINTA DIJEMPUT".tr,
                  count: c.state.requestPickupCount
                          .firstWhereOrNull(
                              (element) => element.status == secondStatus)
                          ?.count ??
                      0,
                  selected: c.state.filterStatus == secondStatus,
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
                  isFirst: false,
                  isLast: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statusCard({
    required BuildContext context,
    required RequestPickupController controller,
    required String label,
    required num count,
    required bool selected,
    required VoidCallback onTap,
    required bool isFirst,
    required bool isLast,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: iconColor(context),
              width: 0.5,
            ),
            color: selected
                ? primaryColor(context)
                : AppConst.isLightTheme(context)
                    ? whiteColor
                    : bgDarkColor,
            borderRadius: BorderRadius.horizontal(
              left: isFirst ? const Radius.circular(8) : Radius.zero,
              right: isLast ? const Radius.circular(8) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: subTitleTextStyle.copyWith(
                  fontWeight: bold,
                  color: selected
                      ? whiteColor
                      : AppConst.isLightTheme(context)
                          ? blueJNE
                          : whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: sublistTitleTextStyle.copyWith(
                    fontSize: 10,
                    color: selected
                        ? whiteColor
                        : AppConst.isLightTheme(context)
                            ? greyColor
                            : whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
