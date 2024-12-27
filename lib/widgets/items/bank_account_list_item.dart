import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin:
            EdgeInsets.symmetric(horizontal: 20, vertical: isLoading ? 10 : 0),
        color: isLoading ? greyColor : Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      left: 0, bottom: 10, right: 20, top: 10),
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
            const SizedBox(height: 8),
            const Divider(
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
