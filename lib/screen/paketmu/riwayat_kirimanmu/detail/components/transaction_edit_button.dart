import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEditButton extends StatelessWidget {
  final bool isLoading;
  final TransactionModel data;

  const TransactionEditButton({super.key, required this.isLoading, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton(
      title: data.statusName == "MASIH DI KAMU"
          // &&
          // data.account?.accountType != "CASHLESS" &&
          // data.account?.accountService != "JLC" &&
          // data.account?.accountNumber?.substring(0, 1) != "3"
          ? "Edit Kiriman".tr
          : "Hubungi Aku".tr,
      color: data.statusName == "MASIH DI KAMU"
          // &&
          // data.account?.accountService != "JLC" &&
          // data.account?.accountType != "CASHLESS" &&
          // data.account?.accountNumber?.substring(0, 1) != "3"
          ? successLightColor3
          : errorLightColor3,
      margin: const EdgeInsets.all(20),
      isLoading: isLoading,
      onPressed: () {
        if (data.statusName == "MASIH DI KAMU"
            // &&
            // data.account?.accountService != "JLC" &&
            // data.account?.accountType != "CASHLESS" &&
            // data.account?.accountNumber?.substring(0, 1) != "3"
            ) {
          Get.to(
            const InformasiPengirimScreen(),
            arguments: {
              'data': data,
            },
          );
        }
      },
    );
  }
}
