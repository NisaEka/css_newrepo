import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
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
                  color: greyDarkColor1,
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Account".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Pengirim".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Petugas Entry".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Kota Pengiriman".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Penerima".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Kota Penerima".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Nama Barang".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Berat Kiriman".tr),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.accountNumber ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: c.state.transactionModel?.shipperName ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.petugasEntry ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: c.state.transactionModel?.shipperCity ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.receiverName ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.receiverCity ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: c.state.transactionModel?.goodsDesc ?? '',
                            width: Get.width / 2.1),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.weight.toString() ??
                                    ''),
                      ],
                    ),
                  ],
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Status Kiriman".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Permintaan Pickup".tr),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: c.state.transactionModel?.statusAwb ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                c.state.transactionModel?.pickupStatus ?? ''),
                      ],
                    ),
                  ],
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Service".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Ongkos Kirim".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Admin COD Ongkir".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Asuransi".tr),
                        CustomFormLabel(
                            isLoading: c.state.isLoading, label: "Dana COD".tr),
                      ],
                    ),
                    const SizedBox(width: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: c.state.transactionModel?.serviceCode ?? ''),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.deliveryPrice?.toCurrency().toString() ?? ' '}'),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.codAmount?.toInt().toCurrency().toString() ?? ' '}'),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.insuranceAmount?.toCurrency().toString() ?? ' '}'),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? ' '}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: greyColor),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Grand Total COD Amount".tr,
                            isBold: true),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label: "Grand Total Ongkos Kirim".tr,
                            isBold: true),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.codAmount?.toCurrency().toString() ?? ' '}',
                            isBold: true),
                        CustomFormLabel(
                            isLoading: c.state.isLoading,
                            label:
                                'Rp. ${c.state.transactionModel?.deliveryPrice?.toCurrency().toString() ?? ' '}',
                            isBold: true),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
