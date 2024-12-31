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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.symmetric(
              horizontal: 20, vertical: isLoading ? 10 : 0),
          decoration: BoxDecoration(
            color: isLoading
                ? AppConst.isLightTheme(context)
                    ? whiteColor
                    : bgDarkColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(account.accountNumber ?? '',
                          style: listTitleTextStyle.copyWith(
                              color: AppConst.isLightTheme(context)
                                  ? blueJNE
                                  : whiteColor)),
                      SizedBox(
                          width: Get.width / 2,
                          child: Text(
                              "${account.accountName?.toUpperCase() ?? ''} / ${account.accountType?.toUpperCase() ?? account.accountService?.toUpperCase()}",
                              style: listTitleTextStyle.copyWith(
                                  color: primaryColor(context)))),
                      Row(
                        children: [
                          Text(account.accountSs == "Y" ? "SS " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : whiteColor)),
                          Text(account.accountYes == "Y" ? "YES " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : whiteColor)),
                          Text(account.accountReg == "Y" ? "REG " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : whiteColor)),
                          Text(account.accountOke == "Y" ? "OKE " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : whiteColor)),
                          Text(account.accountJtr == "Y" ? "JTR " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? blueJNE
                                      : whiteColor)),
                          Text(account.accountIntl == "Y" ? "INTL " : '',
                              style: sublistTitleTextStyle.copyWith(
                                  color: AppConst.isLightTheme(context)
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
                          style: listTitleTextStyle.copyWith(
                              color: primaryColor(context))),
                      Text(account.accountCategory ?? '',
                          style: subTitleTextStyle.copyWith(
                              color: AppConst.isLightTheme(context)
                                  ? greyDarkColor2
                                  : whiteColor)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: greyColor,
              ),
            ],
          )),
    );
  }
}
