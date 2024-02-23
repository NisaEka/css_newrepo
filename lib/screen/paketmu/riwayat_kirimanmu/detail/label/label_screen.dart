import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/megahub_label.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionModel data = Get.arguments['data'];

    return Scaffold(
      appBar: CustomTopBar(
        title: "Cetak Label".tr,
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: MegaHubLabel(
          data: data,
        ),
      ),
    );
  }
}
