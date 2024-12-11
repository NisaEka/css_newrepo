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
                const SizedBox(height: 35),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Detail Kiriman'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 10),
                TextRowItem(
                  title: "Account".tr,
                  value: c.state.transactionModel?.account?.accountName ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Petugas Entry".tr,
                  value: c.state.transactionModel?.shipperName ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Kota Pengiriman".tr,
                  value: c.state.transactionModel?.petugasEntry ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Penerima".tr,
                  value: c.state.transactionModel?.shipperCity ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Kota Penerima".tr,
                  value: c.state.transactionModel?.receiverName ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Nama Barang".tr,
                  value: c.state.transactionModel?.receiverCity ?? '-',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Berat Kiriman".tr,
                  value: c.state.transactionModel?.goodsDesc ?? '-',
                  isLoading: c.state.isLoading,
                ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 20),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Status Kiriman'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Rincian Pembayaran'.tr,
                    isBold: true,
                    fontColor: blueJNE),
                const SizedBox(height: 10),
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
                TextRowItem(
                  title: "Admin COD Ongkir".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.codAmount?.toInt().toCurrency().toString() ?? '0'}',
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
                const SizedBox(height: 20),
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
