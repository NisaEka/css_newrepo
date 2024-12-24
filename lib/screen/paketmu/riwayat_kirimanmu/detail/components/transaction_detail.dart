import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
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
                const SizedBox(height: 16),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Status Kiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
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
                c.state.transactionModel?.codOngkir == "YES" &&
                        c.state.transactionModel?.codFlag == "YES"
                    ? TextRowItem(
                        title: "Tipe Kiriman".tr,
                        value: 'COD Ongkir',
                        isLoading: c.state.isLoading,
                        isValueBold: true,
                      )
                    : c.state.transactionModel?.codOngkir == "NO" &&
                            c.state.transactionModel?.codFlag == "YES"
                        ? TextRowItem(
                            title: "Tipe Kiriman".tr,
                            value: 'COD',
                            isLoading: c.state.isLoading,
                            isValueBold: true,
                          )
                        : TextRowItem(
                            title: "Tipe Kiriman".tr,
                            value: 'NON COD',
                            isLoading: c.state.isLoading,
                            isValueBold: true,
                          ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Detail Kiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Account".tr,
                    value:
                        '${c.state.transactionModel?.account?.accountNumber ?? '-'} - '
                        '${c.state.transactionModel?.account?.accountName ?? '-'}'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Petugas Entry".tr,
                    value: c.state.transactionModel?.petugasEntry ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Pengirim".tr,
                    value: c.state.transactionModel?.shipperName ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Kota Pengiriman".tr,
                    value: c.state.transactionModel?.shipperCity ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Penerima".tr,
                    value: c.state.transactionModel?.receiverName ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading,
                    title: "Nama Barang".tr,
                    value: c.state.transactionModel?.goodsDesc ?? '-'),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                CustomFormLabel(
                    isLoading: c.state.isLoading,
                    label: 'Rincian Biaya Pengiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
                TextRowItem(
                  title: "Berat Kiriman".tr,
                  value:
                      '${c.state.transactionModel?.weight?.toString() ?? '-'} KG',
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
                    ? TextRowItem(
                        title: "Admin COD Ongkir".tr,
                        value: 'Rp. 1.000',
                        isLoading: c.state.isLoading,
                      )
                    : const SizedBox(),
                TextRowItem(
                  title: "Harga Barang".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.goodsAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "Asuransi".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.insuranceAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                ),
                TextRowItem(
                  title: "COD Amount".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading,
                  isTitleBold: true,
                  isValueBold: true,
                ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 10),
                TextRowItem(
                  title: "Total Ongkos Kirim".tr,
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
