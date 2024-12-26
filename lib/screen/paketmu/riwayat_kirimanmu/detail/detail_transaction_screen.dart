import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/components/transaction_detail.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/components/transaction_edit_button.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTransactionScreen extends StatelessWidget {
  const DetailTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailTransactionController>(
      init: DetailTransactionController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: 'Detail Kiriman'.tr,
            // leading: CustomBackButton(
            //   onPressed: () => Get.offAll(const DashboardScreen()),
            // ),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.initData(),
            child: const TransactionDetail(),
          ),
          bottomNavigationBar: const TransactionEditButton(),
        );
      },
    );
  }
}
