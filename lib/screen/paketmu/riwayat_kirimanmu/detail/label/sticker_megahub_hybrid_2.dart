import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/solid_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickerMegahubHybrid2 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;

  const StickerMegahubHybrid2(
      {super.key, required this.data, this.shippingCost = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sticker(),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            'Dengan menyerahkan kiriman, Anda setuju syarat & ketentuan yang tertera pada www.jne.co.id',
            style: labelTextStyle,
          ),
        )
      ],
    );
  }

  Widget sticker() {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    ImageConstant.logoJNE,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Nomor Connote: ${data.awb ?? ''}",
                    style: listTitleTextStyle.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
            Container(
              width: Get.width - 51,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: BarcodeWidget(
                barcode: Barcode.code128(
                  useCode128A: true,
                  // escapes: true,
                ),
                data: data.awb ?? '',
                drawText: false,
                style: const TextStyle(fontSize: 20),
                height: 87,
                // width: Get.width ,
              ),
            ),
            // const Divider(height: 1),
            SolidBorder(height: 1, width: Get.width - 51),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (Get.width - 51) / 1.5,
                  child: Text(
                    'Pengirim: ${data.shipper?.name ?? ''}\n${data.shipper?.address ?? ''}, ${data.shipper?.city ?? data.shipper?.origin?.originName ?? ''}, ${data.shipper?.zipCode ?? ''}, Telp.${data.shipper?.phone ?? ''}',
                    style: labelTextStyle,
                  ),
                ),
                const SolidBorder(width: 1, height: 50),
                Container(
                  width: (Get.width - 51) / 6.5,
                  alignment: Alignment.center,
                  child: Text(
                    data.delivery?.serviceCode.toString() ?? '-',
                    style: TextStyle(fontWeight: bold),
                  ),
                ),
                const SolidBorder(width: 1, height: 50),
                Container(
                  width: (Get.width - 51) / 6.5,
                  alignment: Alignment.center,
                  child: Text(
                    data.type ?? '',
                    style: TextStyle(fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SolidBorder(width: 0, height: 50),
              ],
            ),
            SolidBorder(height: 1, width: Get.width - 51),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: (Get.width - 51) / 1.5,
                  child: Text(
                      'Penerima: ${data.receiver?.name ?? ''}\n${data.receiver?.address ?? ''}, ${data.receiver?.city ?? ''}, ${data.receiver?.zipCode ?? ''}, Telp.${(data.receiver?.phone ?? '').maskPhoneNumber()}\n',
                      style: labelTextStyle),
                ),
                const SolidBorder(width: 1, height: 50),
                // const SolidBorder(width: 0, height: 50),
                // const SolidBorder(width: 0, height: 50),
                Container(
                  width: (Get.width - 51) / 3.2,
                  alignment: Alignment.center,
                  child: Text(
                    "Rp ${shippingCost ? 0 : data.account?.accountService == "COD" ? data.delivery?.codFee?.toInt().toCurrency() ?? '0' : data.delivery?.insuranceFlag == "Y" ? data.delivery?.freightChargeWithInsurance?.toInt().toCurrency() ?? '0' : data.delivery?.freightCharge?.toInt().toCurrency() ?? '0'}",
                    style: TextStyle(fontSize: 15, fontWeight: bold),
                  ),
                ),
                // const SolidBorder(width: 0, height: 50),
                // const SolidBorder(width: 0, height: 50),
              ],
            ),
            SolidBorder(height: 1, width: Get.width - 51),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: (Get.width - 50) / 1.5,
                  // decoration: const BoxDecoration(
                  //   border: Border(
                  //     right: BorderSide(),
                  //   ),
                  // ),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: const TableBorder(
                      verticalInside: BorderSide(),
                      right: BorderSide(),
                    ),
                    children: [
                      TableRow(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Deskripsi: \n${data.goods?.desc ?? '-'}\n\n',
                                  style: labelTextStyle),
                              const SolidBorder(),
                              Text(
                                  'Intruksi Khusus: \n${data.delivery?.specialInstruction ?? '-'}\n\n',
                                  style: labelTextStyle),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            // decoration: const BoxDecoration(
                            //   border: Border(
                            //     left: BorderSide(),
                            //   ),
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Tanggal: ${data.createdDate?.toLongDateTimeFormat() ?? '-'}',
                                    style: labelTextStyle),
                                Text(
                                    'No. Pelanggan: ${data.account?.accountNumber ?? '-'}',
                                    style: labelTextStyle),
                                Text(
                                    'Kota Asal: ${data.shipper?.city ?? data.shipper?.origin?.originName ?? '-'}',
                                    style: labelTextStyle),
                                Text('Berat: ${data.goods?.weight ?? '0'} Kg',
                                    style: labelTextStyle),
                                Text(
                                    'Jumlah Kiriman: ${data.goods?.quantity ?? '0'}',
                                    style: labelTextStyle),
                                Text(
                                    'Jenis Kiriman: ${data.goods?.type ?? '0'}',
                                    style: labelTextStyle),
                                Text('Pembayaran: ${data.type ?? '-'}',
                                    style: labelTextStyle),
                                Text('Order ID: ${data.orderId ?? '-'}',
                                    style: labelTextStyle),
                                // Text('Order ID: ${data.orderId}', style: labelTextStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SolidBorder(width: 1, height: 94),
                Container(
                  width: (Get.width - 51) / 3.2,
                  alignment: Alignment.center,
                  // color: Colors.grey,
                  child: Text(
                    "${data.destination?.destinationCode?.substring(0, 3) ?? '-'}-${data.destination?.facilityCode?.substring(0, 3) ?? data.destination?.cityZone ?? ''}\n${data.receiver?.zipCode}",
                    style: TextStyle(fontSize: 15, fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SolidBorder(width: 0, height: 94),
              ],
            )
          ],
        ),
      ),
    );
  }

// String _maskPhoneNumber(String phoneNumber) {
//   if (phoneNumber.length > 6) {
//     return phoneNumber.substring(0, phoneNumber.length - 6) + '*' * 6;
//   } else {
//     return phoneNumber;
//   }
// }
}
