import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/detail/detail_laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailLaporankuScreen extends StatelessWidget {
  const DetailLaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailLaporankuController>(
        init: DetailLaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(title: "Detail Laporanku".tr),
            body: _bodyContent(controller, context),
            floatingActionButton: CustomFilledButton(
              color: blueJNE,
              title: "Lihat Obrolan".tr,
              width: Get.width - 50,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        });
  }

  Widget _bodyContent(DetailLaporankuController c, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: greyLightColor3, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DetailContent(
            title: "No Resi".tr,
            value: 'CSS5229104463291324',
          ),
          DetailContent(
            title: "Status".tr,
            value: 'Selesai',
            valueColor: successLightColor3,
          ),
          DetailContent(
            title: "Kategori".tr,
            value: 'Permintaan Kirim Ulang',
          ),
          DetailContent(
            title: "Prioritas".tr,
            value: 'Ya',
          ),
          DetailContent(
            title: "Tanggal Dibuat".tr,
            value: DateTime.now().toString().toShortDateTimeFormat(),
          ),
          DetailContent(
            title: "Tanggal Diupdate".tr,
            value: DateTime.now().toString().toShortDateTimeFormat(),
          ),
        ],
      ),
    );
  }
}
