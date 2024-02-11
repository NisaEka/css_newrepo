import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class BankAccountListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? subtitle2;
  final VoidCallback? onTap;
  final Widget icon;

  const BankAccountListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitle2,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: listTitleTextStyle),
              Text(subtitle ?? '', style: sublistTitleTextStyle),
              Text(subtitle2 ?? '', style: sublistTitleTextStyle),
            ],
          )
        ],
      ),
    );
  }
}
