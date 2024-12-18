import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/components/transaction_items.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/components/transaction_search_field.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/components/transaction_status_button.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/transaction_filter_button.dart';

class RiwayatKirimanScreen extends StatelessWidget {
  const RiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Riwayat Kiriman'.tr,
              leading: CustomBackButton(
                onPressed: () => Get.delete<DashboardController>()
                    .then((_) => Get.offAll(const DashboardScreen())),
              ),
              action: const [
                TransactionFilterButton(),
              ],
            ),
            body: const Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children: [
                  TransactionSearchField(),
                  TransactionStatusButton(),
                  TransactionItems(),
                ],
              ),
            ),
          );
        });
  }
}
