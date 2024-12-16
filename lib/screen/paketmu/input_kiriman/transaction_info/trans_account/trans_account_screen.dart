import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/trans_account/trans_account_controller.dart';
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
            appBar: _appBarContent(context),
            body: _bodyContent(controller, context),
          );
        });
  }

  AppBar _appBarContent(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _bodyContent(AkunTranasksiController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: c.accountList
            .map(
              (e) => AccountListItem(
                data: e,
                isSelected: e.accountNumber == c.currentAccount?.accountNumber,
                width: Get.width,
                onTap: () => Get.back(result: e),
              ),
            )
            .toList(),
      ),
    );
  }
}
