import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKirimanListItem extends StatelessWidget {
  final String tanggalEntry;
  final String orderID;
  final String noResi;
  final String petugas;
  final String penerima;

  const RiwayatKirimanListItem({
    super.key,
    required this.tanggalEntry,
    required this.orderID,
    required this.noResi,
    required this.petugas,
    required this.penerima,
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
              Text(tanggalEntry.toLongDateFormat()),
            ],
          )
        ],
      ),
    );
  }
}
