import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:collection/collection.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/kiriman_stepper.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanScreen extends StatelessWidget {
  const LacakKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LacakKirimanController>(
      init: LacakKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            // title: Text('Lacak Kiriman'.tr),
            title: 'Lacak Kiriman'.tr,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                CustomSearchField(
                  controller: controller.searchField,
                  hintText: 'Masukan Nomor Resimu'.tr,
                  suffixIcon: GestureDetector(
                    onTap: () => Get.to(const BarcodeScanScreen(), arguments: {})?.then((result) {
                      controller.searchField.text = result;
                      controller.update();
                      controller.cekResi(result);
                    }),
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: AppConst.isLightTheme(context) ? whiteColor : redJNE,
                      size: 30,
                    ),
                  ),
                  onSubmit: (value) => controller.cekResi(value),
                ),
                Expanded(
                  child: controller.trackModel != null && controller.trackModel?.error == null || controller.isLoading
                      ? ListView(
                          children: [
                            const SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomCodeLabel(
                                  label: controller.trackModel?.cnote?.cnoteNo ?? '',
                                  isLoading: controller.isLoading,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Service',
                                  value: controller.trackModel?.cnote?.cnoteServicesCode ?? '',
                                  valueColor: redJNE,
                                  alignment: 'end',
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Dari'.tr,
                                  value: controller.trackModel?.detail?.first.cnoteShipperCity ?? '',
                                  width: Get.width / 2,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Status Kiriman'.tr,
                                  value: controller.trackModel?.cnote?.podStatus ?? '',
                                  valueColor: redJNE,
                                  width: Get.width / 3,
                                  alignment: 'end',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Menuju'.tr,
                                  value: controller.trackModel?.cnote?.cityName ?? '',
                                  // width: Get.width / 1.5,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Perkiraan sampai tujuan'.tr,
                                  value: controller.trackModel?.cnote?.estimateDelivery ?? '',
                                  valueColor: redJNE,
                                  // width: Get.width / 4,
                                  alignment: 'end',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomFormLabel(
                              isLoading: controller.isLoading,
                              label: 'Detail Kiriman'.tr,
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Tanggal Kirim'.tr,
                                  value: controller.trackModel?.cnote?.cnoteDate?.toLongDateTimeFormat() ?? '',
                                  width: Get.width / 2,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Berat Kiriman'.tr,
                                  value: '${controller.trackModel?.cnote?.cnoteWeight} KG',
                                  width: Get.width / 3,
                                  alignment: 'end',
                                ),
                              ],
                            ),
                            CustomLabelText(
                              isLoading: controller.isLoading,
                              title: 'Deskripsi'.tr,
                              value: controller.trackModel?.cnote?.cnoteGoodsDescr ?? '',
                              width: Get.width / 2,
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Nama Pengirim'.tr,
                                  value: controller.trackModel?.detail?.first.cnoteShipperName ?? '',
                                  width: Get.width / 3,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Nama Penerima'.tr,
                                  value: controller.trackModel?.detail?.first.cnoteReceiverName ?? '',
                                  width: Get.width / 3,
                                  alignment: 'end',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Kota Pengirim'.tr,
                                  value: controller.trackModel?.detail?.first.cnoteShipperCity ?? '',
                                  // width: Get.width / 2,
                                ),
                                CustomLabelText(
                                  isLoading: controller.isLoading,
                                  title: 'Kota Penerima'.tr,
                                  value: controller.trackModel?.detail?.first.cnoteReceiverCity ?? '',
                                  // width: Get.width / 3,
                                  alignment: 'end',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomFormLabel(label: 'Riwayat Kiriman'.tr),
                            const Divider(),
                            Column(
                              children: controller.trackModel?.history?.isNotEmpty ?? false
                                  ? controller.trackModel?.history!.reversed
                                          .mapIndexed((i, e) => KirimanStepper(
                                                currentStep: i,
                                                length: controller.trackModel?.history?.length,
                                                history: e,
                                                cnote: controller.trackModel?.cnote,
                                                isLogin: controller.isLogin,
                                              ))
                                          .toList() ??
                                      []
                                  : [],
                            ),
                          ],
                        )
                      : Center(
                          child: DataEmpty(
                          text: controller.trackModel?.error ?? 'Data Kosong',
                        )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
