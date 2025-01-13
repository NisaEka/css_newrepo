import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:flutter/material.dart';

class StickerMegahub2 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;
  final bool hiddenPhoneShipper;

  const StickerMegahub2({
    super.key,
    required this.data,
    this.shippingCost = false,
    this.hiddenPhoneShipper = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Transform.rotate(
            angle: 90 * 3.14 / 180,
            child: StickerMegahub1(
              data: data,
              shippingCost: shippingCost,
              hiddenPhoneShipper: hiddenPhoneShipper,
            ).sticker1(),
          ),
          const SizedBox(height: 25),
          StickerMegahubHybrid1(data: data).sticker2(context),
          Center(
            child: Text(
              'Untuk informasi dan pengecekan status kiriman silahkan mengunjungi www.jne.co.id',
              style: labelTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
