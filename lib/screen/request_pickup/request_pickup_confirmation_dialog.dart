import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupConfirmationDialog extends StatelessWidget {
  final String pickupTime;
  final Function onConfirmAction;
  final Function onCancelAction;

  const RequestPickupConfirmationDialog(
      {super.key,
      required this.pickupTime,
      required this.onConfirmAction,
      required this.onCancelAction});

  @override
  Widget build(BuildContext context) {
    return DefaultAlertDialog(
      title: "Konfirmasi".tr,
      subtitle:
          "Apakah kamu sudah yakin untuk melakukan penjemputan di jam $pickupTime"
              .tr,
      backButtonTitle: "Batal".tr,
      confirmButtonTitle: "Ya".tr,
      onBack: Get.back,
      onConfirm: () => onConfirmAction(),
    );
  }
}
