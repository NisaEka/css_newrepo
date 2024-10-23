import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/components/laporanku_body.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/input/input_laporanku_screen.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
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
          return Scaffold(
            appBar: LaporankuAppbar(),
            body: const LaporankuBody(),
            floatingActionButton: CustomFilledButton(
              color: redJNE,
              title: "Buat Laporan".tr,
              width: Get.width / 3,
              icon: Icons.add,
              radius: 30,
              height: 50,
              onPressed: () => Get.to(const InputLaporankuScreen())?.then(
                (_) {
                  controller.state.pagingController.refresh();
                  controller.initData();
                },
              ),
            ),
          );
        });
  }






}
