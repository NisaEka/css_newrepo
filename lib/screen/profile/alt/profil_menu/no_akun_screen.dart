import 'package:collection/collection.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/no_akun_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/log_activity_stepper.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
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
              action: [
                _actionButton(context, controller),
              ],
            ),
            body: controller.accountList.isEmpty && !controller.isLoading
                ? Center(child: DataEmpty(text: "Account Kosong".tr))
                : _bodyContent(controller),
          );
        });
  }

  Widget _actionButton(BuildContext context, NoAkunController ctrl) {
    return IconButton(
        onPressed: () {
          Get.bottomSheet(
            enableDrag: true,
            isDismissible: true,
            // isScrollControlled: true,
            StatefulBuilder(builder: (BuildContext c, StateSetter setState) {
              return _modalContent(c, setState, ctrl);
            }),
            backgroundColor:
                AppConst.isLightTheme(context) ? whiteColor : greyColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
        icon: const Icon(
          Icons.info,
          color: redJNE,
        ));
  }

  Widget _modalContent(
      BuildContext context, StateSetter setState, NoAkunController c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Log Aktivitas'.tr,
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
          c.logActivityList.isNotEmpty
              ? Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList.list(
                          children: c.logActivityList
                              .mapIndexed((i, e) => LogActivityStepper(
                                    currentStep: i,
                                    data: e,
                                    length: c.logActivityList.length,
                                  ))
                              .toList())
                    ],
                  ),
                )
              : Center(
                  child: DataEmpty(
                  text: 'Log Aktivitas Kosong'.tr,
                )),
        ],
      ),
    );
  }

  Widget _bodyContent(NoAkunController c) {
    return c.isLoading
        ? ListView.builder(
            itemBuilder: (context, index) => AccountCard(
              account: Account(),
              isLoading: c.isLoading,
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
                    children: c.accountList
                        .map(
                          (e) => AccountCard(
                            account: e,
                            isLoading: c.isLoading,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
  }
}
