import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_2.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/solid_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickerMegahubHybrid1 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;
  final bool hiddenPhoneShipper;
  final String? stickerLabel;

  const StickerMegahubHybrid1({
    super.key,
    required this.data,
    this.shippingCost = false,
    this.hiddenPhoneShipper = false,
    this.stickerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Column(
        children: [
          StickerMegahubHybrid2(
            data: data,
            shippingCost: shippingCost,
            hiddenPhoneShipper: hiddenPhoneShipper,
          ).sticker(context),
          const SizedBox(height: 20),
          sticker2(context),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              'Dengan menyerahkan kiriman, Anda setuju syarat & ketentuan yang tertera pada www.jne.co.id',
              style: labelTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget sticker2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        decoration: BoxDecoration(border: Border.all(), color: Colors.white),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth < 400 ? Get.width / 2.1 : Get.width / 2,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 5,
                    top: 10,
                    bottom: 5,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  child: Column(
                    children: [
                      BarcodeWidget(
                        barcode: Barcode.code128(
                          useCode128A: true,
                          escapes: true,
                        ),
                        data: data.awb ?? '',
                        drawText: false,
                        height: 20,
                      ),
                      Text(
                        data.awb ?? '-',
                        style: itemTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 5),
                                Image.asset(
                                  ImageConstant.logoJNE,
                                  height: 20,
                                ),
                                const SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    data.delivery?.serviceCode ?? '-',
                                    style: sublistTitleTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SolidBorder(
                            width: 1,
                            height: 50,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: Get.width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengirim : ${data.shipper?.name ?? ''}",
                                  style: labelTextStyle,
                                ),
                                Text(
                                  "Penerima : ${data.receiver?.name ?? ''}",
                                  style: labelTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 5,
                bottom: 0,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Tanggal: ${data.createdDate?.toLongDateTimeFormat() ?? ''}',
                      style: labelTextStyle),
                  Text('No. Pelanggan: ${data.account?.accountNumber ?? ''}',
                      style: labelTextStyle),
                  SizedBox(
                    width: Get.width / 2.9,
                    child: Text('Deskripsi: ${data.goods?.desc ?? ''}',
                        style: labelTextStyle),
                  ),
                  Text('Berat: ${data.goods?.weight ?? '0'} Kg',
                      style: labelTextStyle),
                  Text('Jumlah Kiriman: ${data.goods?.quantity ?? '0'}',
                      style: labelTextStyle),
                  Text(
                      'Biaya Kirim: Rp ${data.delivery?.insuranceFlag == "Y" ? data.delivery?.freightChargeWithInsurance?.toInt().toCurrency() ?? '0' : data.delivery?.freightCharge?.toInt().toCurrency() ?? '0'}',
                      style: labelTextStyle),
                  Text('Kota Tujuan: ${data.receiver?.city ?? ''}',
                      style: labelTextStyle),
                  Text('Order ID: ${data.orderId ?? '-'}',
                      style: labelTextStyle),
                  Text(
                      "Biaya Asuransi : Rp ${data.delivery?.insuranceFlag == "Y" ? data.delivery?.insuranceFee?.toCurrency() : 0}",
                      style: labelTextStyle),
                  Text(
                      "Biaya Admin Asuransi : Rp ${data.delivery?.insuranceFlag == "Y" ? (data.delivery?.insuranceFee?.toInt() ?? 0) - 600 : 0}",
                      style: labelTextStyle),
                  Text(
                      "Total Biaya Asuransi : Rp ${data.delivery?.insuranceFlag == "Y" ? data.delivery?.insuranceFee ?? '0' : 0}",
                      style: labelTextStyle),
                  const SizedBox(height: 5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
