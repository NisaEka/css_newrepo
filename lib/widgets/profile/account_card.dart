import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyDarkColor1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: blueJNE,
              spreadRadius: 1,
              offset: Offset(-2, 2),
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
                Text(account.accountNumber ?? '', style: listTitleTextStyle.copyWith(color: blueJNE)),
                SizedBox(
                    width: Get.width / 2,
                    child: Text("${account.accountName ?? ''} / ${account.accountType ?? account.accountService}",
                        style: listTitleTextStyle.copyWith(color: blueJNE))),
                Row(
                  children: [
                    Text(account.availableService?.ss == "Y" ? "SS " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                    Text(account.availableService?.yes == "Y" ? "YES " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                    Text(account.availableService?.reg == "Y" ? "REG " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                    Text(account.availableService?.oke == "Y" ? "OKE " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                    Text(account.availableService?.jtr == "Y" ? "JTR " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                    Text(account.availableService?.intl == "Y" ? "INTL " : '', style: sublistTitleTextStyle.copyWith(color: blueJNE)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(account.accountService ?? '', style: listTitleTextStyle.copyWith(color: redJNE)),
                Text(account.accountCategory ?? '', style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
                // Text("CCNC", style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
