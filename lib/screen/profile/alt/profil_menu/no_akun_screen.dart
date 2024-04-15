import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
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
            body: controller.accountList.isEmpty && !controller.isLoading
                ? Center(child: DataEmpty(text: "Account Kosong".tr))
                : controller.isLoading
                    ? ListView.builder(
                        itemBuilder: (context, index) => AccountCard(
                          account: Account(),
                          isLoading: controller.isLoading,
                        ),
                        itemCount: 5,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: 21),
                            Expanded(
                              child: ListView(
                                children: controller.accountList
                                    .map(
                                      (e) => AccountCard(
                                        account: e,
                                        isLoading: controller.isLoading,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
          );
        });
  }
}
