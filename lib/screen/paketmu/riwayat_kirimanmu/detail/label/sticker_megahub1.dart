import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/solid_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class StickerMegahub1 extends StatelessWidget {
  final TransactionModel data;

  const StickerMegahub1({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: ,
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
                height: 60,
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
                  data.type ?? '-',
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
                width: (Get.width - 50.5) / 1.5,
                decoration: const BoxDecoration(border: Border(right: BorderSide())),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Pengirim: ${data.shipper?.name}\n${data.shipper?.address}, ${data.shipper?.city ?? data.shipper?.origin?.originName}, ${data.shipper?.zip}, Telp.${data.shipper?.phone}',
                        style: labelTextStyle),
                    const Divider(),
                    Text(
                        'Penerima: ${data.receiver?.name}\n${data.receiver?.address}, ${data.receiver?.city}, ${data.receiver?.zip}. Telp.${data.receiver?.phone}\n',
                        style: labelTextStyle),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 3.6,
                child: Text(
                  '${data.receiver?.destinationCode?.substring(0,3)} - \n${data.receiver?.zip}',
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
                    height: 70,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Deskripsi: ', style: itemTextStyle),
                    const Divider(),
                    Text('Intruksi Khusus:', style: itemTextStyle),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanggal: ${data.createdDate?.toLongDateFormat()}', style: labelTextStyle),
                      Text('No. Pelanggan: ${data.account?.accountNumber}', style: labelTextStyle),
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
        const SizedBox(height: 25),
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
                  Text('No. Pelanggan: ${data.account?.accountNumber}', style: labelTextStyle),
                  Text('Deskripsi: -', style: labelTextStyle),
                  Text('Berat: -', style: labelTextStyle),
                  Text('Biaya Kirim: -', style: labelTextStyle),
                  Text('Kota Tujuan: ${data.receiver?.city}', style: labelTextStyle),
                  Text('Asuransi: - ', style: labelTextStyle),
                  Text('Order ID: ${data.orderId}', style: labelTextStyle),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            'Untuk informasi dan pengecekan status kiriman silahkan mengunjungi www.jne.co.id',
            style: labelTextStyle,
          ),
        )
      ],
    );
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    // final font = await PdfGoogleFonts.nunitoExtraLight();
    final img = await rootBundle.load(ImageConstant.logoJNE);
    final logoJNE = img.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            // mainAxisAlignment: ,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(15),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(),
                    top: pw.BorderSide(),
                    right: pw.BorderSide(),
                  ),
                ),
                child: pw.Column(
                  children: [
                    pw.Image(
                      pw.MemoryImage(
                        logoJNE,
                      ),
                      height: 30,
                    ),
                    pw.SizedBox(height: 10),
                    pw.BarcodeWidget(
                      barcode: Barcode.code128(
                        useCode128A: true,
                        escapes: true,
                      ),
                      data: data.awb ?? '',
                      drawText: false,
                      height: 60,
                    ),
                    pw.Text(
                      'Nomor Connote : ${data.awb}',
                      style: const pw.TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        data.service ?? '-',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        data.type ?? '-',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Rp. ${data.codAmount?.toInt().toCurrency()}',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                  ),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: (Get.width - 50.5) / 1.5,
                      decoration: const pw.BoxDecoration(border: pw.Border(right: pw.BorderSide())),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Pengirim: ${data.shipper?.name}\n${data.shipper?.address}\nTelp.${data.shipper?.phone}',
                              style: const pw.TextStyle(fontSize: 8)),
                          pw.Text('Penerima: ${data.receiver?.name}\n${data.receiver?.address}\nTelp.${data.receiver?.phone}\n',
                              style: const pw.TextStyle(fontSize: 8)),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      width: Get.width / 3.6,
                      child: pw.Text(
                        '${data.shipper?.origin} - ${data.receiver?.destinationCode}\n${data.receiver?.zip}',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        margin: const pw.EdgeInsets.all(10),
                        child: pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data: data.awb ?? '',
                          drawText: false,
                          height: 70,
                        ),
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Deskripsi: ', style: const pw.TextStyle(fontSize: 10)),
                          pw.Divider(),
                          pw.Text('Intruksi Khusus:', style: const pw.TextStyle(fontSize: 10)),
                        ],
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.all(3),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Tanggal: ${data.createdDate?.toLongDateFormat()}', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('No. Pelanggan: ${data.receiver?.registrationId}', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Kota Asal: ${data.shipper?.city}', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Berat:', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Jumlah Kiriman:', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Pembayaran: ${data.type == 'COD' ? 'COD' : 'NON COD'}', style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Order ID: ${data.orderId}', style: const pw.TextStyle(fontSize: 8)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 25),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      children: [
                        pw.Container(
                          width: Get.width / 2,
                          padding: const pw.EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 5,
                          ),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(),
                              bottom: pw.BorderSide(),
                            ),
                          ),
                          child: pw.Column(
                            children: [
                              pw.BarcodeWidget(
                                barcode: Barcode.code128(
                                  useCode128A: true,
                                  escapes: true,
                                ),
                                data: data.awb ?? '',
                                drawText: false,
                                height: 20,
                              ),
                              pw.Text(
                                data.awb ?? '-',
                                style: const pw.TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        pw.Container(
                          width: Get.width / 2,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(),
                            ),
                          ),
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.only(top: 5),
                                decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                    right: pw.BorderSide(),
                                  ),
                                ),
                                child: pw.Column(
                                  children: [
                                    pw.Image(
                                      pw.MemoryImage(
                                        logoJNE,
                                      ),
                                      height: 15,
                                    ),
                                    pw.Divider(height: 1),
                                    pw.Container(
                                      height: 1,
                                      color: PdfColor.fromHex('202F72'),
                                      width: 55,
                                    ),
                                    pw.Text(
                                      data.service ?? '-',
                                      style: const pw.TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Pengirim : ${data.shipper?.name}",
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                  pw.Text(
                                    "Penerima : ${data.receiver?.name}",
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    pw.SizedBox(width: 5),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Tanggal: ${data.createdDate}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('No. Pelanggan: ${data.receiver?.registrationId}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Deskripasi: ${data.receiver?.registrationId}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Berat: ${data.receiver?.registrationId}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Biaya Kirim: ${data.receiver?.registrationId}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Kota Tujuan: ${data.receiver?.city}', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Asuransi: ${data.receiver?.registrationId} ', style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Order ID: ${data.orderId}', style: const pw.TextStyle(fontSize: 8)),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Text(
                'Untuk informasi dan pengecekan status kiriman silahkan mengunjungi www.jne.co.id',
                style: const pw.TextStyle(fontSize: 8),
              )
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
