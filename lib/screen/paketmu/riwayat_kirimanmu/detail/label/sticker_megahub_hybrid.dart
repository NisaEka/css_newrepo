import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/solid_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StickerMegahubHybrid extends StatelessWidget {
  final TransactionModel data;

  const StickerMegahubHybrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
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
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
              const Divider(height: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (Get.width - 51) / 1.5,
                    child: Text(
                      'Pengirim: ${data.shipper?.name}\n${data.shipper?.address}, ${data.shipper?.city ?? data.shipper?.origin?.originName}, ${data.shipper?.zip}, Telp.${data.shipper?.phone}',
                      style: labelTextStyle,
                    ),
                  ),
                  const SolidBorder(width: 1, height: 40),
                  Text(data.service ?? '', style: TextStyle(fontWeight: bold)),
                  const SolidBorder(width: 1, height: 40),
                  Text(data.type ?? '', style: TextStyle(fontWeight: bold)),
                  const SolidBorder(width: 0, height: 40),
                ],
              ),
              const SolidBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: (Get.width - 48) / 1.5,
                    child: Text(
                        'Penerima: ${data.receiver?.name}\n${data.receiver?.address}, ${data.receiver?.city}, ${data.receiver?.zip}, Telp.${data.receiver?.phone}\n',
                        style: labelTextStyle),
                  ),
                  const SolidBorder(width: 1, height: 50),
                  const SolidBorder(width: 0, height: 50),
                  Center(child: Text("Rp ${data.codAmount?.toInt().toCurrency()}", style: TextStyle(fontSize: 15, fontWeight: bold))),
                  const SolidBorder(width: 0, height: 50),
                  const SolidBorder(width: 0, height: 50),
                ],
              ),
              const SolidBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: (Get.width / 1.5) - 54.5,
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     right: BorderSide(),
                    //   ),
                    // ),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Deskripsi: -\n\n\n', style: labelTextStyle),
                                const SolidBorder(),
                                Text('Intruksi Khusus: -\n\n\n', style: labelTextStyle),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tanggal: ${data.createdDate?.toLongDateFormat()}', style: labelTextStyle),
                                  Text('No. Pelanggan: ${data.receiver?.registrationId}', style: labelTextStyle),
                                  Text('Kota Asal: ${data.shipper?.city ?? data.shipper?.origin?.originName}', style: labelTextStyle),
                                  Text('Berat: -', style: labelTextStyle),
                                  Text('Jumlah Kiriman: -', style: labelTextStyle),
                                  Text('Pembayaran: ${data.type}', style: labelTextStyle),
                                  Text('Order ID: ${data.orderId}', style: labelTextStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SolidBorder(width: 1, height: 94),
                  Center(
                      child: Text("${data.receiver?.destinationCode?.substring(0, 3)} - \n${data.receiver?.zip}",
                          style: TextStyle(fontSize: 15, fontWeight: bold))),
                  const SolidBorder(width: 0, height: 94),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: Get.width / 2,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 5,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(), bottom: BorderSide()),
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
                  Container(
                    width: Get.width / 2,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                ImageConstant.logoJNE,
                                height: 15,
                              ),
                              const SolidBorder(
                                width: 55,
                                height: 0,
                              ),
                              Text(
                                data.service ?? '-',
                                style: itemTextStyle,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengirim : ${data.shipper?.name}",
                              style: labelTextStyle,
                            ),
                            Text(
                              "Penerima : ${data.receiver?.name}",
                              style: labelTextStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal: ${data.createdDate}', style: labelTextStyle),
                  Text('No. Pelanggan: ${data.receiver?.registrationId}', style: labelTextStyle),
                  Text('Deskripasi: ${data.receiver?.registrationId}', style: labelTextStyle),
                  Text('Berat: ${data.receiver?.registrationId}', style: labelTextStyle),
                  Text('Biaya Kirim: ${data.receiver?.registrationId}', style: labelTextStyle),
                  Text('Kota Tujuan: ${data.receiver?.city}', style: labelTextStyle),
                  Text('Asuransi: ${data.receiver?.registrationId} ', style: labelTextStyle),
                  Text('Order ID: ${data.orderId}', style: labelTextStyle),
                ],
              ),
            ],
          ),
        ),
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
}
