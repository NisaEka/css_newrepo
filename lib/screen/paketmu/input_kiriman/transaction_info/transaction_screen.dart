import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_account_card.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_appbar.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_form.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_services_list.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/trans_account/trans_account_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_controller.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: TransactionAppbar(
                  data: controller.state.data,
                  isOnline: controller.state.isOnline,
                  currentStep: 2,
                ),
                body: RefreshIndicator(
                  color: greyColor,
                  onRefresh: () => controller.initData(),
                  child: CustomScrollView(
                    slivers: [
                      TransactionAccountCard(
                        account: controller.state.account,
                        onTap: () => controller.state.dropship == false
                            ? Get.to(const AkunTransaksiScreen())?.then(
                                (result) => controller.onChangeAccount(result),
                              )
                            : null,
                      ),
                      const TransactionServicesList(),
                      const TransactionForm(),
                    ],
                  ),
                ),
              ),
              controller.state.isLoading ? const LoadingDialog() : Container(),
              controller.state.isShowDialog
                  ? _warningDialog(controller)
                  : const SizedBox()
            ],
          );
        });
  }

  Widget _warningDialog(TransactionController c) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: greyDarkColor2.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: Get.width - 50,
          height: Get.width / 1.5,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Peringatan'.tr,
                style: appTitleTextStyle.copyWith(color: greyDarkColor1),
              ),
              Icon(
                Icons.warning,
                color: warningColor,
                size: Get.width / 4,
              ),
              Text(
                "Total Ongkos Kirim tidak bisa lebih dari Rp.1000.000".tr,
                style: subTitleTextStyle.copyWith(color: greyDarkColor1),
                textAlign: TextAlign.center,
              ),
              CustomFilledButton(
                color: blueJNE,
                isTransparent: true,
                title: 'OK',
                onPressed: () {
                  c.state.isShowDialog = false;
                  c.update();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
