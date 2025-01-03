import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_2.dart';
import 'package:flutter/material.dart';

class StickerMegahubHybrid3 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;
  final bool hiddenPhoneShipper;

  const StickerMegahubHybrid3(
      {super.key,
      required this.data,
      this.shippingCost = false,
      this.hiddenPhoneShipper = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RotatedBox(
        //   quarterTurns: 1,
        //   child: StickerMegahubHybrid2(data: data).sticker(),
        // ),
        Transform.rotate(
          // quarterTurns: 1,
          angle: 90 * 3.14 / 180,
          child: StickerMegahubHybrid2(
            data: data,
            shippingCost: shippingCost,
            hiddenPhoneShipper: hiddenPhoneShipper,
          ).sticker(),
        ),
        const SizedBox(height: 20),
        StickerMegahubHybrid1(data: data).sticker2(),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            'Dengan menyerahkan kiriman, Anda setuju syarat & ketentuan yang tertera pada www.jne.co.id',
            style: labelTextStyle,
          ),
        )
      ],
    );
  }
}
