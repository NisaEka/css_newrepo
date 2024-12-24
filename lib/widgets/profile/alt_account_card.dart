import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';

import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: greyDarkColor2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.accountNumber ?? '',
                  style: listTitleTextStyle.copyWith(
                      color: primaryColor(context))),
              Text(account.accountName ?? '',
                  style: listTitleTextStyle.copyWith(
                      color: primaryColor(context))),
              Text(account.accountService ?? '',
                  style: sublistTitleTextStyle.copyWith(
                      color: primaryColor(context))),
              Row(
                children: [
                  Text(account.accountSs == "Y" ? "SS " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                  Text(account.accountYes == "Y" ? "YES " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                  Text(account.accountReg == "Y" ? "REG " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                  Text(account.accountOke == "Y" ? "OKE " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                  Text(account.accountJtr == "Y" ? "JTR " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                  Text(account.accountIntl == "Y" ? "INTL " : '',
                      style: sublistTitleTextStyle.copyWith(
                          color: primaryColor(context))),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(account.accountService ?? '',
                  style: listTitleTextStyle.copyWith(
                      color: secondaryColor(context))),
              Text(account.accountCategory ?? '',
                  style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
              // Text("CCNC", style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
            ],
          )
        ],
      ),
    );
  }
}
