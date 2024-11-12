import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/akun_bank_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/secret_data_dialog.dart';
import 'package:css_mobile/widgets/items/bank_account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AkunBankScreen extends StatelessWidget {
  const AkunBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunBankController>(
        init: AkunBankController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(context),
            body: Stack(
              children: [
                _bodyContent(controller, context),
                // controller.isLoading ? const LoadingDialog() : Container(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(AkunBankController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 21),
          Expanded(
            child: ListView(
              children: [
                BankAccountListItem(
                  isLoading: controller.isLoading,
                  icon: const Icon(
                    Icons.credit_card_rounded,
                    color: blueJNE,
                  ),
                  title: controller.ccrfProfil?.bankAccount?.ccrfBankaccount ??
                      '-',
                  subtitle:
                      controller.ccrfProfil?.bankAccount?.ccrfAccountnumber ??
                          '-',
                  subtitle2:
                      controller.ccrfProfil?.bankAccount?.ccrfAccountname ??
                          '-',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomTopBar _appBarContent(BuildContext context) {
    return CustomTopBar(
      title: 'Akun Bank'.tr,
      action: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Get.bottomSheet(
                enableDrag: true,
                isDismissible: true,
                // isScrollControlled: true,
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SecretDataDialog(
                      text: '${'bank_info'.tr}\n\n${'kerahasiaan_data'.tr}');
                }),
                backgroundColor:
                    AppConst.isLightTheme(context) ? whiteColor : greyColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
            icon: const Icon(Icons.info_rounded, color: redJNE),
            tooltip: 'informasi'.tr,
          ),
        )
      ],
    );
  }
}
