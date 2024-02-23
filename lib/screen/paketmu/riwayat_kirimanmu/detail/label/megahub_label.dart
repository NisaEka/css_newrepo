import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MegaHubLabel extends StatelessWidget {
  final TransactionModel data;

  const MegaHubLabel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(),
              top: BorderSide(),
              right: BorderSide(),
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                ImageConstant.logoJNE,
                height: 30,
              ),
              const SizedBox(height: 10),
              BarcodeWidget(
                barcode: Barcode.code128(
                  useCode128A: true,
                  escapes: true,
                ),
                data: data.awb ?? '',
                drawText: false,
                height: 50,
              ),
              Text(
                'Nomor Connote : ${data.awb}',
                style: itemTextStyle,
              )
            ],
          ),
        ),
        Table(
          border: TableBorder.all(),
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(border: Border.all()),
              children: <Widget>[
                Text(
                  data.service ?? '-',
                  style: itemTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  data.apiType ?? '-',
                  style: itemTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Rp. ${data.codAmount?.toInt().toCurrency()}',
                  style: itemTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(),
              right: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: Get.width / 1.7,
                decoration: const BoxDecoration(border: Border(right: BorderSide())),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pengirim: ${data.shipper?.name}\n${data.shipper?.address}\nTelp.${data.shipper?.phone}',
                        style: itemTextStyle.copyWith(fontSize: 8)),
                    const Divider(),
                    Text('Penerima: ${data.receiver?.name}\n${data.receiver?.address}\nTelp.${data.receiver?.phone}',
                        style: itemTextStyle.copyWith(fontSize: 8)),
                  ],
                ),
              ),
              Container(
                width: Get.width / 3.6,
                child: Text(
                  '${data.shipper?.origin} - ${data.receiver?.destinationCode}\n${data.receiver?.zip}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(border: Border.all()),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: data.awb ?? '',
                    drawText: false,
                    height: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deskripsi: ', style: itemTextStyle),
                    const Divider(),
                    Text('Intruksi Khusus:', style: itemTextStyle),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanggal: ${data.createdDate?.toLongDateFormat()}', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('No. Pelanggan: ${data.receiver?.registrationId}', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('Kota Asal: ${data.shipper?.city}', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('Berat:', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('Jumlah Kiriman:', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('Pembayaran: ${data.apiType == 'COD' ? 'COD' : 'NON COD'}', style: itemTextStyle.copyWith(fontSize: 8)),
                      Text('Order ID: ${data.orderId}', style: itemTextStyle.copyWith(fontSize: 8)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
