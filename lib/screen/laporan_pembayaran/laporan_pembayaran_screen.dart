import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_controller.dart';
import 'package:css_mobile/screen/laporan_pembayaran/laporan_pembayaran_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/jlcpoint/jlcpoint_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanPembayaranScreen extends StatelessWidget {
  const LaporanPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporanPembayaranController>(
        init: LaporanPembayaranController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Pembayaran Aggregasi'.tr,
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: const Column(
                  children: [
                    LapPembayaranBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
