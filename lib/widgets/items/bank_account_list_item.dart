import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';

class BankAccountListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? subtitle2;
  final VoidCallback? onTap;
  final Widget icon;
  final bool isLoading;

  const BankAccountListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitle2,
    this.onTap,
    required this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isLoading ? greyLightColor3 : whiteColor,
          border: Border.all(color: greyDarkColor1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isLoading
              ? []
              : const [
                  BoxShadow(
                    color: blueJNE,
                    spreadRadius: 1,
                    offset: Offset(-2, 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
    );
  }
}
