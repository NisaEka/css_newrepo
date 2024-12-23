import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:flutter/material.dart';

class RequestPickupAddressItem extends StatelessWidget {
  final RequestPickupAddressModel address;

  final bool lastItem;
  final bool selected;

  final Function onItemClick;

  const RequestPickupAddressItem(
      {super.key,
      required this.address,
      required this.lastItem,
      required this.selected,
      required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClick(),
      behavior: HitTestBehavior.translucent,
      child: Card.outlined(
        margin: lastItem
            ? const EdgeInsets.only(left: 16, right: 16)
            : const EdgeInsets.only(left: 16),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: _borderColor(context), width: 1)),
        child: SizedBox(
          width: 136,
          height: 136,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.pickupDataName,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: sublistTitleTextStyle.copyWith(fontWeight: semiBold),
                ),
                Text(
                  address.pickupDataPhone,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: itemTextStyle,
                ),
                Text(
                  address.pickupDataAddress,
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: itemTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _borderColor(BuildContext context) {
    if (selected) {
      return secondaryColor(context);
    } else {
      return greyColor;
    }
  }
}
