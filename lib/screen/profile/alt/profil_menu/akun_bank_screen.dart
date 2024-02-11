import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/akun_bank_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/bank_account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../const/textstyle.dart';
import '../../../../widgets/forms/customformlabel.dart';

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
                                      'Kerahasiaan Data',
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                      },
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
                                            CustomFormLabel(
                                                label:
                                                'Data ini dipergunakan dalam proses '
                                                    'transfer uang COD kamu. \n'
                                                    '\n'
                                                    'Informasi ini rahasia, '
                                                    'hanya kamu yang dapat melihatnya '
                                                    'dan tidak dibagikan ke pihak manapun'.tr),

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
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_rounded,
                        color: redJNE),
                    tooltip: 'informasi'.tr,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  Expanded(
                    child: ListView(
                      children: [
                        BankAccountListItem(
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
          );
        });
  }
}