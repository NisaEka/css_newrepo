import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/akun_transaksi/akun_transaksi_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AkunTransaksiScreen extends StatelessWidget {
  const AkunTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunTranasksiController>(
        init: AkunTranasksiController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: greyColor,
              elevation: 1,
              // backgroundColor: whiteColor,
              leading: const CustomBackButton(),
              title: Text(
                'Pilih Akun Transaksi'.tr,
                style: appTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: controller.accountList
                    .map(
                      (e) => AccountListItem(
                        accountID: e.accountId ?? '',
                        accountNumber: e.accountNumber ?? '',
                        accountName: e.accountName ?? '',
                        accountType: e.accountService ?? '',
                        isSelected: true,
                        width: Get.width,
                        onTap: () => Get.back(result: e),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        });
  }
}
