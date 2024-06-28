import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:flutter/material.dart';

class RequestPickupAddressItem extends StatelessWidget {

  final RequestPickupAddressModel address;
  final bool lastItem;

  const RequestPickupAddressItem({
    super.key,
    required this.address,
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
                address.name,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: sublistTitleTextStyle.copyWith(
                    fontWeight: semiBold
                ),
              ),
              Text(
                address.phone,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: itemTextStyle,
              ),
              Text(
                address.address,
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