import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKirimanListItem extends StatelessWidget {
  final String tanggalEntry;
  final String orderID;
  final String noResi;
  final String petugas;
  final String penerima;
  final String status;

  const RiwayatKirimanListItem({
    super.key,
    required this.tanggalEntry,
    required this.orderID,
    required this.noResi,
    required this.petugas,
    required this.penerima,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: greyDarkColor1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tanggalEntry.toLongDateFormat(),
                style: sublistTitleTextStyle,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: errorColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  status,
                  style: sublistTitleTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 8,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID'.tr,
                    style: sublistTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    'No Resi'.tr,
                    style: sublistTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    'Petugas Entry'.tr,
                    style: sublistTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    'Penerima'.tr,
                    style: sublistTitleTextStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ': $orderID',
                    style: listTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    ': $noResi',
                    style: listTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    ': $petugas',
                    style: listTitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(
                    ': $penerima',
                    style: listTitleTextStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
