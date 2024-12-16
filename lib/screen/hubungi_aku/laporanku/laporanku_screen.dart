import 'package:css_mobile/screen/hubungi_aku/laporanku/components/laporanku_body.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/laporanku_appbar.dart';

class LaporankuScreen extends StatelessWidget {
  const LaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (controller) {
          return const Scaffold(
            appBar: LaporankuAppbar(),
            body: LaporankuBody(),
          );
        });
  }
}
