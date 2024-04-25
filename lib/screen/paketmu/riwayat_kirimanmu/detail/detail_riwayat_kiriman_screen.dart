import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_controller.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_screen.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailRiwayatKirimanScreen extends StatelessWidget {
  const DetailRiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailRiwayatKirimanController>(
      init: DetailRiwayatKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: 'Detail Kiriman'.tr,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomTextFormField(
                          controller: TextEditingController(text: controller.transactionModel?.status.toString()),
                          label: 'Status Transaksi'.tr,
                          width: Get.width / 2.5,
                          readOnly: true,
                          backgroundColor: Theme.of(context).brightness == Brightness.light ? greyLightColor2 : greyDarkColor2,
                          noBorder: true,
                          isLoading: controller.isLoading,
                        ),
                        CustomTextFormField(
                          controller: TextEditingController(text: controller.transactionModel?.pickupStatus ?? ''),
                          label: 'Status Pickup'.tr,
                          width: Get.width / 2.5,
                          readOnly: true,
                          backgroundColor: Theme.of(context).brightness == Brightness.light ? greyLightColor2 : greyDarkColor2,
                          noBorder: true,
                          isLoading: controller.isLoading,
                        ),
                      ],
                    ),
                    Shimmer(
                      isLoading: controller.transactionModel == null,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: controller.isLoading ? greyColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: controller.transactionModel?.awb ?? '',
                          drawText: false,
                          height: 120,
                          width: 120,
                          color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                        ),
                      ),
                    )
                  ],
                ),
                Shimmer(
                  isLoading: controller.transactionModel == null,
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: controller.isLoading ? greyColor : (Theme.of(context).brightness == Brightness.light ? whiteColor : greyDarkColor2),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: greyLightColor3,
                          spreadRadius: 1,
                          offset: Offset(-2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomLabelText(
                          title: 'Tanggal Pesanan'.tr,
                          value: controller.transactionModel?.createdDate?.toLongDateTimeFormat() ?? '',
                          titleTextStyle: listTitleTextStyle.copyWith(fontSize: 10, fontWeight: medium),
                          valueTextStyle: sublistTitleTextStyle.copyWith(fontSize: 10, color: greyColor),
                          alignment: 'end',
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("No Resi".tr, style: itemTextStyle),
                                    GestureDetector(
                                      onTap: () => Clipboard.setData(ClipboardData(text: controller.transactionModel?.awb ?? '')),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          size: 10,
                                          Icons.copy_rounded,
                                          color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Tipe".tr, style: itemTextStyle),
                                Text("Service".tr, style: itemTextStyle),
                                Text("Dana COD".tr, style: itemTextStyle),
                                Text("Petugas Entry".tr, style: itemTextStyle),
                                Text("Pengirim".tr, style: itemTextStyle),
                                Text("Kota Pengiriman".tr, style: itemTextStyle),
                                Text("Penerima".tr, style: itemTextStyle),
                                Text("Kontak Penerima".tr, style: itemTextStyle),
                                Row(
                                  children: [
                                    Text("Order ID".tr, style: itemTextStyle),
                                    GestureDetector(
                                      onTap: () => Clipboard.setData(ClipboardData(text: controller.transactionModel?.orderId ?? '')),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          size: 10,
                                          Icons.copy_rounded,
                                          color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Account".tr, style: itemTextStyle),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.transactionModel?.awb ?? '-',
                                  style: itemTextStyle.copyWith(
                                    fontWeight: medium,
                                  ),
                                ),
                                Text(
                                  controller.transactionModel?.type ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.delivery?.serviceCode ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  'Rp. ${controller.transactionModel?.delivery?.flatRate?.toInt().toCurrency() ?? '-'}',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.officerEntry ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.shipper?.name ?? '-',
                                  style: itemTextStyle.copyWith(fontWeight: medium),
                                ),
                                Text(
                                  "${controller.transactionModel?.receiver?.city} / ${controller.transactionModel?.receiver?.district}",
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.receiver?.name ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.receiver?.phone ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.orderId ?? '-',
                                  style: itemTextStyle,
                                ),
                                Text(
                                  controller.transactionModel?.orderId ?? '-',
                                  style: itemTextStyle,
                                ),
                                SizedBox(
                                  width: Get.width - 200,
                                  child: Text(
                                    '${controller.transactionModel?.account?.accountNumber}/${controller.transactionModel?.account?.accountName}/${controller.transactionModel?.account?.accountType ?? 'JLC'}',
                                    style: itemTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CustomFilledButton(
                  color: blueJNE,
                  title: 'Lihat Resi'.tr,
                  onPressed: () => controller.transactionModel != null
                      ? Get.to(const LabelScreen(), arguments: {
                          'data': controller.transactionModel,
                        })
                      : null,
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomFilledButton(
            title: controller.transactionModel?.status == "MASIH DI KAMU" &&
                    controller.transactionModel?.account?.accountType != "CASHLESS" &&
                    controller.transactionModel?.account?.accountService != "JLC" &&
                    controller.transactionModel?.account?.accountNumber?.substring(0, 1) != "3"
                ? "Edit Kiriman".tr
                : "Hubungi Aku".tr,
            color: controller.transactionModel?.status == "MASIH DI KAMU" &&
                    controller.transactionModel?.account?.accountService != "JLC" &&
                    controller.transactionModel?.account?.accountType != "CASHLESS" &&
                    controller.transactionModel?.account?.accountNumber?.substring(0, 1) != "3"
                ? successLightColor3
                : errorLightColor3,
            margin: const EdgeInsets.all(20),
            isLoading: controller.isLoading,
            onPressed: () {
              if (controller.transactionModel?.status == "MASIH DI KAMU" &&
                  controller.transactionModel?.account?.accountService != "JLC" &&
                  controller.transactionModel?.account?.accountType != "CASHLESS" &&
                  controller.transactionModel?.account?.accountNumber?.substring(0, 1) != "3") {
                Get.to(
                  const InformasiPengirimScreen(),
                  arguments: {
                    'data': controller.transactionModel,
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
