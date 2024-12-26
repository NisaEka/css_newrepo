import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/detail/detail_laporanku_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolan_laporanku_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/items/text_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/forms/customlabel.dart';

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
      margin: const EdgeInsets.only(left: 30, top: 16, right: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCodeLabel(
                        label: data.cnote ?? '-',
                        isLoading: false,
                      ),
                      Row(
                        children: [
                          CustomFilledButton(
                            color: successColor,
                            isTransparent: true,
                            prefixIcon: Icons.message,
                            width: 40,
                            height: 40,
                            fontSize: 19,
                            isLoading: false,
                            onPressed: () => Get.to(
                                () => const ObrolanLaporankuScreen(),
                                arguments: {
                                  "id": data.id,
                                  "ticket": data,
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Shimmer(
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          right: 20), // Margin between the two text widgets
                      child: Text(
                        'Informasi Tiket Laporan'.tr,
                        style: listTitleTextStyle.copyWith(
                          color: primaryColor(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextRowWidget(
                    title: "Tanggal Laporan".tr,
                    value: data.createdDate?.toShortDateTimeFormat() ?? '-',
                    isLoading: false,
                  ),
                  TextRowWidget(
                    title: "Update Terakhir".tr,
                    value: data.updatedDate?.toShortDateTimeFormat() ?? '-',
                    isLoading: false,
                  ),
                  TextRowWidget(
                    title: "Prioritas".tr,
                    value: data.priority == "Y" ? 'Ya'.tr : 'Tidak'.tr,
                    isLoading: false,
                  ),
                  TextRowWidget(
                    title: "Status Laporan".tr,
                    value: data.status == "Closed"
                        ? "Selesai".tr
                        : data.status == "Reply CS"
                            ? "Masih Diproses".tr
                            : "Belum Diproses".tr,
                    isLoading: false,
                    valueStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: greyColor),
                  const SizedBox(height: 10),
                  CustomLabelText(
                    title: "Kategori".tr,
                    value: data.category?.categoryDescription ?? '-',
                    valueColor: primaryColor(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonContent(DetailLaporankuController c, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFilledButton(
          color: AppConst.isLightTheme(context) ? redJNE : warningColor,
          title: data.status != "Closed" ? "Selesai".tr : "Lapor Ulang".tr,
          width: Get.width - 60,
          onPressed: () => data.status != "Closed"
              ? c.updateStatus(data.id ?? '')
              : Get.to(() => const ObrolanLaporankuScreen(), arguments: {
                  "id": data.id,
                  "ticket": data,
                }),
        ),
      ],
    );
  }
}
