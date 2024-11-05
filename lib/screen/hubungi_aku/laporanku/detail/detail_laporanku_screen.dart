import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/detail/detail_laporanku_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolan_laporanku_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
    AppLogger.d('ticketID : ${data.id}');
    return GetBuilder<DetailLaporankuController>(
        init: DetailLaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(title: "Detail Laporanku".tr),
            body: Stack(
              children: [
                _bodyContent(controller, context),
                controller.isLoading ? const LoadingDialog() : const SizedBox(),
              ],
            ),
            floatingActionButton: _buttonContent(controller, context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
            value: data.status == "Closed"
                ? "Selesai".tr
                : data.status == "Reply CS"
                    ? "Masih Diproses".tr
                    : "Belum Diproses".tr,
            valueColor: data.status == "Closed"
                ? successLightColor3
                : data.status == "Reply CS"
                    ? warningLightColor3
                    : greyDarkColor2,
          ),
          DetailContent(
            title: "Kategori".tr,
            value: data.category?.categoryDescription ?? '-',
          ),
          DetailContent(
            title: "Prioritas".tr,
            value: data.priority == "Y" ? 'Ya'.tr : 'Tidak'.tr,
          ),
          DetailContent(
            title: "Tanggal Dibuat".tr,
            value: data.createdDate?.toShortDateTimeFormat() ?? '-',
          ),
          DetailContent(
            title: "Tanggal Diupdate".tr,
            value: data.updatedDate?.toShortDateTimeFormat() ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _buttonContent(DetailLaporankuController c, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        data.status != "Closed"
            ? CustomFilledButton(
                color: redJNE,
                title: "Selesai".tr,
                width: Get.width - 50,
                onPressed: () => c.updateStatus(data.id ?? ''),
              )
            : const SizedBox(),
        CustomFilledButton(
          color: blueJNE,
          title:
              data.status == "Closed" ? "Lapor Ulang".tr : "Lihat Obrolan".tr,
          width: Get.width - 50,
          onPressed: () => Get.to(const ObrolanLaporankuScreen(), arguments: {
            "id": data.id,
            "ticket": data,
          }),
        ),
      ],
    );
  }
}
