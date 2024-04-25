import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class OngkirListItem extends StatelessWidget {
  final String serviceTitle;
  final String serviceSubtitle;
  final String servicePrice;
  final String serviceDuration;

  const OngkirListItem({
    super.key,
    required this.serviceTitle,
    required this.serviceSubtitle,
    required this.servicePrice,
    required this.serviceDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceTitle,
                  style: listTitleTextStyle,
                ),
                Text(
                  serviceSubtitle,
                  style: sublistTitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? greyColor : whiteColor),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp. $servicePrice',
                  style: listTitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE),
                ),
                Text(
                  serviceDuration,
                  style: sublistTitleTextStyle.copyWith(color: redJNE),
                )
              ],
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
