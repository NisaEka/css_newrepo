import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class RequestPickupAddressItem extends StatelessWidget {

  final bool lastItem;

  const RequestPickupAddressItem({
    super.key,
    required this.lastItem
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: lastItem ? const EdgeInsets.only(left: 16, right: 16) : const EdgeInsets.only(left: 16),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: greyColor,
          width: 1
        )
      ),
      child: SizedBox(
        width: 136,
        height: 136,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ZAIM",
                maxLines: 1,
                textAlign: TextAlign.start,
                style: sublistTitleTextStyle.copyWith(
                    fontWeight: semiBold
                ),
              ),
              Text(
                "085315903382",
                maxLines: 1,
                textAlign: TextAlign.start,
                style: itemTextStyle,
              ),
              Text(
                "No.12 Jalan Ir. H. Juanda Panyingkiran 46151; JAWA BARAT; KOTATASIKMALAYA",
                maxLines: 4,
                textAlign: TextAlign.start,
                style: itemTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

}