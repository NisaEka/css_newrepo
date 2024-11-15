import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/offlinebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionAppbar extends StatelessWidget implements PreferredSizeWidget {
  final DataTransactionModel? data;
  final bool isOnline;
  final int currentStep;

  const TransactionAppbar({
    super.key,
    this.data,
    this.isOnline = true,
    this.currentStep = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(220);

  @override
  Widget build(BuildContext context) {
    List<String> steps = [
      'Data Pengirim'.tr,
      'Data Penerima'.tr,
      'Data Kiriman'.tr
    ];

    return CustomTopBar(
      title: 'Input Transaksi'.tr,
      leading: CustomBackButton(
        onPressed: () =>
            data != null ? Get.back() : Get.delete<DashboardController>().then((_) => Get.offAll(const DashboardScreen())),
      ),
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: currentStep,
            totalStep: steps.length,
            steps: steps,
          ),
          const SizedBox(height: 10),
          isOnline ? const SizedBox() : const OfflineBar(),
        ],
      ),
    );
  }
}
