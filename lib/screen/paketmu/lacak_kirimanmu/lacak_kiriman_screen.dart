import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:collection/collection.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_controller.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/phone_number_confirmation_screen.dart';
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
          appBar: CustomTopBar(title: 'Lacak Kiriman'.tr),
          body: _bodyContent(controller, context),
        );
      },
    );
  }

  Widget _bodyContent(LacakKirimanController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Masukan Nomor Resimu'.tr,
            suffixIcon: GestureDetector(
              onTap: () =>
                  Get.to(() => const BarcodeScanScreen(), arguments: {})
                      ?.then((result) {
                c.searchField.text = result;
                c.update();
                if (c.isLogin) {
                  c.cekResi(result, '');
                } else {
                  Get.to(
                    () => PhoneNumberConfirmationScreen(
                      awb: result,
                      cekResi: c.cekResi,
                      isLoading: c.isLoading,
                    ),
                  );
                }
              }),
              child: Icon(
                Icons.qr_code_rounded,
                color: AppConst.isLightTheme(context) ? whiteColor : whiteColor,
                size: 25,
              ),
            ),
            onSubmit: (value) {
              if (value.isEmpty) {
                Get.showSnackbar(
                  GetSnackBar(
                    icon: const Icon(
                      Icons.warning,
                      color: whiteColor,
                    ),
                    message: 'Nomor resi tidak boleh kosong'.tr,
                    isDismissible: true,
                    duration: const Duration(seconds: 3),
                    backgroundColor: errorColor,
                  ),
                );
              } else if (value.length < 16) {
                Get.showSnackbar(
                  GetSnackBar(
                    icon: const Icon(
                      Icons.warning,
                      color: whiteColor,
                    ),
                    message: 'Nomor resi maksimal 16 karakter'.tr,
                    isDismissible: true,
                    duration: const Duration(seconds: 3),
                    backgroundColor: errorColor,
                  ),
                );
              } else {
                if (c.isLogin) {
                  c.cekResi(value, '');
                } else {
                  Get.to(
                    () => PhoneNumberConfirmationScreen(
                      awb: value,
                      cekResi: c.cekResi,
                      isLoading: c.isLoading,
                    ),
                  );
                }
              }
            },
          ),
          Expanded(
            child: ListView(
              children: c.trackModel != null && c.trackModel?.error == null ||
                      c.isLoading
                  ? [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCodeLabel(
                            label: c.trackModel?.data?.cnote?.cnoteNo ?? '',
                            isLoading: c.isLoading,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Service',
                            value:
                                c.trackModel?.data?.cnote?.cnoteServicesCode ??
                                    '',
                            valueColor: AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor,
                            alignment: 'end',
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Dari'.tr,
                            value: c.trackModel?.data?.detail?.first
                                    .cnoteShipperCity ??
                                '',
                            width: Get.width / 2,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Status Kiriman'.tr,
                            value: c.trackModel?.data?.cnote?.podStatus ?? '',
                            valueColor: AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor,
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
                            isLoading: c.isLoading,
                            title: 'Menuju'.tr,
                            value: c.trackModel?.data?.cnote?.cityName ?? '',
                            width: Get.width / 2,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Perkiraan Sampai'.tr,
                            value:
                                c.trackModel?.data?.cnote?.estimateDelivery ??
                                    '',
                            valueColor: AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor,
                            width: Get.width / 3,
                            alignment: 'end',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomFormLabel(
                        isLoading: c.isLoading,
                        label: 'Detail Kiriman'.tr,
                      ),
                      const SizedBox(height: 6),
                      const Divider(),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Tanggal Kirim'.tr,
                            value: c.trackModel?.data?.cnote?.cnoteDate
                                    ?.toLongDateTimeFormat() ??
                                '',
                            width: Get.width / 2,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Berat Kiriman'.tr,
                            value:
                                '${c.trackModel?.data?.cnote?.cnoteWeight} KG',
                            width: Get.width / 3,
                            valueColor: AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor,
                            alignment: 'end',
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomLabelText(
                        isLoading: c.isLoading,
                        title: 'Deskripsi'.tr,
                        value: c.trackModel?.data?.cnote?.cnoteGoodsDescr ?? '',
                        width: Get.width / 2,
                      ),
                      const SizedBox(height: 6),
                      const Divider(),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Nama Pengirim'.tr,
                            value: c.trackModel?.data?.detail?.first
                                    .cnoteShipperName ??
                                '',
                            width: Get.width / 3,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Nama Penerima'.tr,
                            value: c.trackModel?.data?.detail?.first
                                    .cnoteReceiverName ??
                                '',
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
                            isLoading: c.isLoading,
                            title: 'Kota Pengirim'.tr,
                            value: c.trackModel?.data?.detail?.first
                                    .cnoteShipperCity ??
                                '',
                            width: Get.width / 3,
                          ),
                          CustomLabelText(
                            isLoading: c.isLoading,
                            title: 'Kota Penerima'.tr,
                            value: c.trackModel?.data?.detail?.first
                                    .cnoteReceiverCity ??
                                '',
                            width: Get.width / 2,
                            alignment: 'end',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomFormLabel(label: 'Riwayat Kiriman'.tr),
                      const SizedBox(height: 6),
                      const Divider(),
                      const SizedBox(height: 16),
                      Column(
                        children:
                            c.trackModel?.data?.history?.isNotEmpty ?? false
                                ? c.trackModel?.data?.history!.reversed
                                        .mapIndexed((i, e) => KirimanStepper(
                                              currentStep: i,
                                              length: c.trackModel?.data
                                                  ?.history?.length,
                                              history: e,
                                              cnote: c.trackModel?.data?.cnote,
                                              isLogin: c.isLogin,
                                              isLoading: c.isLoading,
                                            ))
                                        .toList() ??
                                    []
                                : [],
                      ),
                    ]
                  : [
                      Center(
                        child: DataEmpty(
                            text: c.trackModel?.error ?? 'Data Kosong'),
                      )
                    ],
            ),
          )
        ],
      ),
    );
  }
}
