import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              Text("11117000", style: listTitleTextStyle.copyWith(color: blueJNE)),
              Text("ALEX COLECTION-COD", style: listTitleTextStyle.copyWith(color: blueJNE)),
              Text("NON CASHLESS", style: sublistTitleTextStyle.copyWith(color: blueJNE)),
              Text("SS YES REG OKE JTR", style: sublistTitleTextStyle.copyWith(color: blueJNE)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("COD", style: listTitleTextStyle.copyWith(color: redJNE)),
              Text("LOKAL", style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
              Text("CCNC", style: subTitleTextStyle.copyWith(color: greyDarkColor2)),
            ],
          )
        ],
      ),
    );
  }
}
