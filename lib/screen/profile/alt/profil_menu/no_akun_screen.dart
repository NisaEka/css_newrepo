import 'package:css_mobile/screen/profile/alt/profil_menu/no_akun_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/profile/account_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoAkunScreen extends StatelessWidget {
  const NoAkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoAkunController>(
        init: NoAkunController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Daftar Akun Transaksi'.tr,
            ),
            body: controller.accountList.isEmpty
                ? Center(child: DataEmpty(text: "Account Kosong".tr))
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: 21),
                            Expanded(
                              child: ListView(
                                children: controller.accountList
                                    .map(
                                      (e) => AccountCard(account: e),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.isLoading ? const LoadingDialog() : Container(),
                    ],
                  ),
          );
        });
  }
}
