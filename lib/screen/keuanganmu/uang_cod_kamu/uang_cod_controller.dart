import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UangCODController extends BaseController {
  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;
  String dateFilter = '3';
  String? date;

  void resetFilter() {
    startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    isFiltered = false;
    dateFilter = '0';

    update();
    Get.back();
  }

  applyFilter() {
    if (startDate != null || endDate != null) {
      isFiltered = true;

      if (startDate != null && endDate != null) {
        date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
      } else {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.dialog(
            DefaultAlertDialog(
              title: "Peringatan".tr,
              icon: Icon(
                Icons.warning,
                color: warningColor,
                size: Get.width / 4,
              ),
              subtitle: "Tanggal Tidak Boleh Kosong".tr,
              backButtonTitle: "OK",
              onBack: () => Get.back(),
            ),
          );
        });
      }
      update();
      update();
      Get.back();
    }
  }
}
