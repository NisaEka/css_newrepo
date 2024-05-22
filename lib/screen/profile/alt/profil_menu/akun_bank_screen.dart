import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/akun_bank_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
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
            appBar: CustomTopBar(
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
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kerahasiaan Data'.tr,
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomFormLabel(label: '${'bank_info'.tr}\n\n${'kerahasiaan_data'.tr}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        backgroundColor: AppConst.isLightTheme(context) ? whiteColor : greyColor,
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
            ),
            body: Stack(
              children: [
                Padding(
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
                              title: controller.ccrfProfil?.bankAccount?.account ?? '-',
                              subtitle: controller.ccrfProfil?.bankAccount?.accountNumber ?? '-',
                              subtitle2: controller.ccrfProfil?.bankAccount?.accountName ?? '-',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // controller.isLoading ? const LoadingDialog() : Container(),
              ],
            ),
          );
        });
  }
}
