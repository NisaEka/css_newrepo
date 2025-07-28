import 'package:collection/collection.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/kiriman_stepper.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanDetail extends StatelessWidget {
  final PostLacakKirimanModel data;
  final bool isLogin;

  const LacakKirimanDetail({
    super.key,
    required this.data,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(
        title: "Lacak Kiriman".tr,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCodeLabel(
                label: data.cnote?.cnoteNo ?? '',
              ),
              CustomLabelText(
                title: 'Service',
                value: data.cnote?.cnoteServicesCode ?? '',
                valueColor:
                    AppConst.isLightTheme(context) ? redJNE : warningColor,
                alignment: 'end',
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Dari'.tr,
                value: data.detail?.first.cnoteShipperCity ?? '',
                width: Get.width / 2,
              ),
              CustomLabelText(
                title: 'Status Kiriman'.tr,
                value: data.cnote?.podStatus ?? '',
                valueColor:
                    AppConst.isLightTheme(context) ? redJNE : warningColor,
                width: Get.width / 3,
                alignment: 'end',
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelText(
                title: 'Menuju'.tr,
                value: data.cnote?.cityName ?? '',
                width: Get.width / 2,
              ),
              CustomLabelText(
                title: 'Perkiraan Sampai'.tr,
                value: data.cnote?.estimateDelivery ?? '',
                valueColor:
                    AppConst.isLightTheme(context) ? redJNE : warningColor,
                width: Get.width / 3,
                alignment: 'end',
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomFormLabel(
            label: 'Detail Kiriman'.tr,
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Tanggal Kirim'.tr,
                value: data.cnote?.cnoteDate?.toLongDateTimeFormat() ?? '',
                width: Get.width / 2,
              ),
              CustomLabelText(
                title: 'Berat Kiriman'.tr,
                value: '${data.cnote?.cnoteWeight} KG',
                width: Get.width / 3,
                valueColor:
                    AppConst.isLightTheme(context) ? redJNE : warningColor,
                alignment: 'end',
              ),
            ],
          ),
          const SizedBox(height: 6),
          CustomLabelText(
            title: 'Deskripsi'.tr,
            value: data.cnote?.cnoteGoodsDescr ?? '',
            width: Get.width / 2,
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Nama Pengirim'.tr,
                value: data.detail?.first.cnoteShipperName ?? '',
                width: Get.width / 3,
              ),
              CustomLabelText(
                title: 'Nama Penerima'.tr,
                value: data.detail?.first.cnoteReceiverName ?? '',
                width: Get.width / 3,
                alignment: 'end',
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Kota Pengirim'.tr,
                value: data.detail?.first.cnoteShipperCity ?? '',
                width: Get.width / 3,
              ),
              CustomLabelText(
                title: 'Kota Penerima'.tr,
                value: data.detail?.first.cnoteReceiverCity ?? '',
                width: Get.width / 2,
                alignment: 'end',
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomFormLabel(
            label: 'Riwayat Kiriman'.tr,
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 16),
          Column(
            children: data.history?.isNotEmpty ?? false
                ? data.history!.reversed
                    .mapIndexed((i, e) => KirimanStepper(
                          currentStep: i,
                          length: data.history?.length,
                          history: e,
                          cnote: data.cnote,
                          isLogin: isLogin,
                        ))
                    .toList()
                : [],
          ),
        ],
      ),
    );
  }
}
