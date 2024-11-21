import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEditButton extends StatelessWidget {
  final bool isLoading;
  final DataTransactionModel? transactionData;

  const TransactionEditButton({
    super.key,
    this.isLoading = false,
    this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailTransactionController>(
        init: DetailTransactionController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFilledButton(
                  color: blueJNE,
                  title: "Lihar Resi".tr,
                  suffixIcon: Icons.receipt_outlined,
                  width: Get.width / 2,
                  height: 50,
                  fontSize: 15,
                  isLoading: isLoading,
                  onPressed: () => transactionData != null
                      ? Get.to(const LabelScreen(), arguments: {
                          'data': transactionData,
                        })
                      : null,
                ),
                CustomFilledButton(
                  color: successColor,
                  isTransparent: true,
                  prefixIcon: Icons.edit,
                  width: 50,
                  height: 50,
                  fontSize: 23,
                  isLoading: isLoading,
                  onPressed: () {
                    if (c.state.transactionModel?.statusAwb == "MASIH DI KAMU") {
                      Get.to(
                        const InformasiPengirimScreen(),
                        arguments: {
                          'isEdit': true,
                          'data': transactionData,
                        },
                      );
                    }
                  },
                ),
                CustomFilledButton(
                  color: errorColor,
                  isTransparent: true,
                  prefixIcon: Icons.delete,
                  width: 50,
                  height: 50,
                  fontSize: 23,
                  isLoading: isLoading,
                  onPressed: () {
                    if (c.state.transactionModel?.statusAwb == "MASIH DI KAMU") {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteAlertDialog(
                          onDelete: () {
                            c.deleteTransaction();
                            Get.close(2);
                          },
                          onBack: () {
                            Get.back();
                          },
                        ),
                      );
                    }
                  },
                ),
                CustomFilledButton(
                  color: warningColor,
                  isTransparent: true,
                  prefixIcon: Icons.phone,
                  width: 50,
                  height: 50,
                  fontSize: 23,
                  isLoading: isLoading,
                  onPressed: () {
                    Get.bottomSheet(
                      enableDrag: true,
                      isDismissible: true,
                      // isScrollControlled: true,
                      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                        return Container();
                      }),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
