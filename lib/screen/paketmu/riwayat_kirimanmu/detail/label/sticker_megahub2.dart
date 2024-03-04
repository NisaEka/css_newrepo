import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/solid_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class StickerMegahub2 extends StatelessWidget {
  final DataTransactionModel data;

  const StickerMegahub2({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: ,
      children: [
        // StickerMegahub1(data: data).sticker1(),
        Transform.rotate(
          // quarterTurns: 1,
          angle: 90 * 3.14 / 180,
          child: StickerMegahub1(data: data).sticker1(),
        ),
        const SizedBox(height: 25),
        StickerMegahubHybrid1(data: data).sticker2(),
        Center(
          child: Text(
            'Untuk informasi dan pengecekan status kiriman silahkan mengunjungi www.jne.co.id',
            style: labelTextStyle,
          ),
        )
      ],
    );
  }
}
