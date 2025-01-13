import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/items/text_row_widget.dart';
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
                    isLoading: c.state.isLoading || c.state.data == null,
                    label: 'Status Kiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
                TextRowWidget(
                  title: "Status Kiriman".tr,
                  value: c.state.transactionModel?.statusAwb?.capitalize?.tr
                          .toUpperCase() ??
                      '-',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                TextRowWidget(
                  title: "Permintaan Pickup".tr,
                  value: c.state.transactionModel?.pickupStatus ?? '-',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                c.state.transactionModel?.codOngkir == "YES" &&
                        c.state.transactionModel?.codFlag == "YES"
                    ? TextRowWidget(
                        title: "Tipe Kiriman".tr,
                        value: 'COD Ongkir',
                        isLoading: c.state.isLoading || c.state.data == null,
                        valueStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    : c.state.transactionModel?.codOngkir == "NO" &&
                            c.state.transactionModel?.codFlag == "YES"
                        ? TextRowWidget(
                            title: "Tipe Kiriman".tr,
                            value: 'COD',
                            isLoading:
                                c.state.isLoading || c.state.data == null,
                            valueStyle: Theme.of(context).textTheme.titleMedium,
                          )
                        : TextRowWidget(
                            title: "Tipe Kiriman".tr,
                            value: 'NON COD',
                            isLoading:
                                c.state.isLoading || c.state.data == null,
                            valueStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                const SizedBox(height: 6),
                const Divider(color: greyColor),
                const SizedBox(height: 6),
                CustomFormLabel(
                    isLoading: c.state.isLoading || c.state.data == null,
                    label: 'Detail Kiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Account".tr,
                    value:
                        '${c.state.transactionModel?.account?.accountNumber ?? '-'} - '
                        '${c.state.transactionModel?.account?.accountName ?? '-'}'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Petugas Entry".tr,
                    value: c.state.transactionModel?.petugasEntry ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Pengirim".tr,
                    value: c.state.transactionModel?.shipperName ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Kota Pengiriman".tr,
                    value: c.state.transactionModel?.shipperCity ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Penerima".tr,
                    value: c.state.transactionModel?.receiverName ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Kota Penerima".tr,
                    value: c.state.transactionModel?.receiverCity ?? '-'),
                const SizedBox(height: 6),
                CustomLabelText(
                    isLoading: c.state.isLoading || c.state.data == null,
                    title: "Nama Barang".tr,
                    value: c.state.transactionModel?.goodsDesc ?? '-'),
                const SizedBox(height: 6),
                const Divider(color: greyColor),
                const SizedBox(height: 6),
                CustomFormLabel(
                    isLoading: c.state.isLoading || c.state.data == null,
                    label: 'Rincian Biaya Pengiriman'.tr,
                    isBold: true,
                    fontColor: primaryColor(context)),
                const SizedBox(height: 16),
                TextRowWidget(
                  title: "Berat Kiriman".tr,
                  value:
                      '${c.state.transactionModel?.weight?.toString() ?? '-'} KG',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                TextRowWidget(
                  title: "Service".tr,
                  value: c.state.transactionModel?.serviceCode ?? '-',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                TextRowWidget(
                  title: "Ongkos Kirim".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.deliveryPrice?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                c.state.transactionModel?.codOngkir == "YES" &&
                        c.state.transactionModel?.codFlag == "YES"
                    ? TextRowWidget(
                        title: "Admin COD Ongkir".tr,
                        value: 'Rp. 1.000',
                        isLoading: c.state.isLoading || c.state.data == null,
                      )
                    : const SizedBox(),
                TextRowWidget(
                  title: "Harga Barang".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.goodsAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                TextRowWidget(
                  title: "Asuransi".tr,
                  value:
                      'Rp. ${c.state.transactionModel?.insuranceAmount?.toCurrency().toString() ?? '0'}',
                  isLoading: c.state.isLoading || c.state.data == null,
                ),
                const SizedBox(height: 6),
                const Divider(color: greyColor),
                const SizedBox(height: 6),
                c.state.transactionModel?.codOngkir == "NO" &&
                        c.state.transactionModel?.codFlag == "YES"
                    ? TextRowWidget(
                        title: "COD Amount".tr,
                        value:
                            'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? '0'}',
                        isLoading: c.state.isLoading || c.state.data == null,
                        titleStyle: Theme.of(context).textTheme.titleMedium,
                        valueStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    : const SizedBox(),
                TextRowWidget(
                  title: "Total Ongkos Kirim".tr,
                  value:
                      'Rp. ${((c.state.transactionModel?.deliveryPrice?.toInt() ?? 0) + (c.state.transactionModel?.insuranceAmount?.toInt() ?? 0)).toInt().toCurrency().toString()}',
                  isLoading: c.state.isLoading || c.state.data == null,
                  titleStyle: Theme.of(context).textTheme.titleMedium,
                  valueStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        });
  }
}
