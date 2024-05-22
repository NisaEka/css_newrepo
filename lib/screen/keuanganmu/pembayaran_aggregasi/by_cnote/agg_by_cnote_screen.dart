import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggByCnoteScreen extends StatelessWidget {
  const AggByCnoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggByCnoteController>(
      init: AggByCnoteController(),
      builder: (controller) => Scaffold(),
    );
  }
}
