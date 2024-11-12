import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/components/transaction_detail.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/components/transaction_edit_button.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanScreen extends StatelessWidget {
  const DetailRiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailRiwayatKirimanController>(
      init: DetailRiwayatKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: 'Detail Kiriman'.tr),
          body: const TransactionDetail(),
          bottomNavigationBar: TransactionEditButton(
            isLoading: controller.isLoading,
            data: controller.transactionModel ?? TransactionModel(),
          ),
        );
      },
    );
  }
}
