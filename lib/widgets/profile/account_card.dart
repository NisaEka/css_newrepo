import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final bool isLoading;

  const AccountCard({
    super.key,
    required this.account,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppConst.isLightTheme(context) ? whiteColor : greyColor,
          border: Border.all(color: greyDarkColor1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness ==
                Brightness.light
                ? blueJNE
                : warningColor,
              spreadRadius: 1,
              offset: const Offset(-2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(account.accountNumber ?? '',
                    style: listTitleTextStyle.copyWith(color: AppConst.isLightTheme(context)
                        ? blueJNE
                        : whiteColor)
                ),
                SizedBox(
                    width: Get.width / 2,
                    child: Text(
                        "${account.accountName?.toUpperCase() ?? ''} / ${account.accountType?.toUpperCase() ?? account.accountService?.toUpperCase()}",
                        style: listTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : warningColor))),
                Row(
                  children: [
                    Text(account.accountSs == "Y" ? "SS " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                    Text(account.accountYes == "Y" ? "YES " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                    Text(account.accountReg == "Y" ? "REG " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                    Text(account.accountOke == "Y" ? "OKE " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                    Text(account.accountJtr == "Y" ? "JTR " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                    Text(account.accountIntl == "Y" ? "INTL " : '',
                        style: sublistTitleTextStyle.copyWith(color:
                        AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(account.accountService ?? '',
                    style: listTitleTextStyle.copyWith(color:
                    AppConst.isLightTheme(context)
                        ? blueJNE
                        : warningColor)),
                Text(account.accountCategory ?? '',
                    style: subTitleTextStyle.copyWith(color: AppConst.isLightTheme(context)
                        ? greyDarkColor2
                        : whiteColor)),
                // Text("CCNC", style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
