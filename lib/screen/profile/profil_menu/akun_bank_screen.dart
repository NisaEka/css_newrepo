import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/profil_menu/akun_bank_controller.dart';
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
            ],
          ),
        );
      },
    );
  }

  Widget _bodyContent(AkunBankController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 15),
                BankAccountListItem(
                  isLoading: controller.isLoading,
                  icon: Icon(
                    Icons.credit_card_rounded,
                    color: Theme.of(context).brightness == Brightness.light
                        ? redJNE
                        : warningColor,
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
                const SizedBox(height: 30),
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
            icon: Icon(Icons.info_rounded,
                color: Theme.of(context).brightness == Brightness.light
                    ? redJNE
                    : warningColor),
            tooltip: 'informasi'.tr,
          ),
        )
      ],
    );
  }
}
