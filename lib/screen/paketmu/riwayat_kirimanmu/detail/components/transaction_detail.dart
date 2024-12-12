import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/text_row_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailTransactionController>(
        init: DetailTransactionController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: [
                BarcodeWidget(
                  barcode: Barcode.code128(
                    useCode128A: true,
                    // escapes: true,
                  ),
                  color: CustomTheme().textColor(context) ?? greyColor,
                  data: c.state.awb,
                  drawText: false,
                  height: 80,
                  width: Get.width / 1.7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      c.state.awb,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => Clipboard.setData(ClipboardData(
                          text: c.state.transactionModel?.awb ?? '')),
                      icon: const Icon(Icons.copy),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Status Kiriman'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 15),
                TextRowItem(
                  title: "Status Kiriman".tr,
                  value: c.state.transactionModel?.statusAwb?.tr ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Permintaan Pickup".tr,
                  value: c.state.transactionModel?.pickupStatus ?? '-',
                  isLoading: c.state.isLoading,
                ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Detail Kiriman'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 15),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Account :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: '${c.state.transactionModel?.account?.accountNumber ?? '-'} - '
                        '${c.state.transactionModel?.account?.accountName ?? '-'}',
                    fontColor: greyDarkColor2),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Petugas Entry :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.petugasEntry ?? '-',
                    fontColor: greyDarkColor2),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Pengirim :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.shipperName ?? '-',
                    fontColor: greyDarkColor2),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Kota Pengiriman :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.shipperCity ?? '-',
                    fontColor: greyDarkColor2),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Penerima :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.receiverName ?? '-',
                    fontColor: greyDarkColor2),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Kota Penerima :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.receiverCity ?? '-',
                    fontColor: greyDarkColor2),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Nama Barang :'.tr,
                    fontColor: blueJNE),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: c.state.transactionModel?.goodsDesc ?? '-',
                    fontColor: greyDarkColor2),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Tipe Kiriman :'.tr,
                    fontColor: blueJNE),
                c.state.transactionModel?.codOngkir == "YES" &&
                    c.state.transactionModel?.codFlag == "YES"
                    ?
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'COD Ongkir',
                    fontColor: redJNE,
                    isBold: true)
                :c.state.transactionModel?.codOngkir == "NO" &&
                    c.state.transactionModel?.codFlag == "YES"
                    ?
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'COD',
                    fontColor: redJNE,
                    isBold: true
                )
                :CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'NON COD',
                    fontColor: redJNE,
                    isBold: true),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Rincian Biaya Pengiriman'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 10),
                TextRowItem(
                  title: "Berat Kiriman".tr,
                  value: '${c.state.transactionModel?.weight?.toString() ?? '-'} KG',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Service".tr,
                  value: c.state.transactionModel?.serviceCode ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Ongkos Kirim".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.deliveryPrice?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                ),
                c.state.transactionModel?.codOngkir == "YES" &&
                    c.state.transactionModel?.codFlag == "YES"
                    ?
                TextRowItem(
                  title: "Admin COD Ongkir".tr,
                  value:
                      'Rp. 1.000',
                  isLoading: c.state.isLoading,
                ):TextRowItem(
                  title: "Admin COD Ongkir".tr,
                  value:
                  'Rp. 0',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Asuransi".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.insuranceAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Dana COD".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                TextRowItem(
                  title: "Grand Total COD Amount".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                  isTitleBold: true,
                  isValueBold: true,
                ),
                TextRowItem(
                  title: "Grand Total Ongkos Kirim".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.deliveryPrice?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                  isTitleBold: true,
                  isValueBold: true,
                ),
              ],
            ),
          );
        });
  }
}
