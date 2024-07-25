import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/detail/detail_laporanku_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolan_laporanku_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailLaporankuScreen extends StatelessWidget {
  final TicketModel data;

  const DetailLaporankuScreen({
    super.key,
    required this.data,
  });

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
              onPressed: () => Get.to(const ObrolanLaporankuScreen()),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        });
  }

  Widget _bodyContent(DetailLaporankuController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppConst.isLightTheme(context) ? greyLightColor3 : greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DetailContent(
            title: "No Resi".tr,
            value: data.cnote ?? '-',
          ),
          DetailContent(
            title: "Status".tr,
            value: data.status == "Closed" ? "Selesai".tr : "Masih Diproses".tr,
            valueColor: data.status == "Closed" ? successLightColor3 : warningLightColor3,
          ),
          DetailContent(
            title: "Kategori".tr,
            value: data.category?.description ?? '-',
          ),
          DetailContent(
            title: "Prioritas".tr,
            value: data.priority == "Y" ? 'Ya'.tr : 'Tidak'.tr,
          ),
          DetailContent(
            title: "Tanggal Dibuat".tr,
            value: data.createdAt?.toShortDateTimeFormat() ?? '-',
          ),
          DetailContent(
            title: "Tanggal Diupdate".tr,
            value: data.updatedAt?.toShortDateTimeFormat() ?? '-',
          ),
        ],
      ),
    );
  }
}
