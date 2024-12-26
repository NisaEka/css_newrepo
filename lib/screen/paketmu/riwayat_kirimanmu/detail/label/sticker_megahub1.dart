import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class StickerMegahub1 extends StatelessWidget {
  final DataTransactionModel data;
  final bool shippingCost;

  const StickerMegahub1({
    super.key,
    required this.data,
    this.shippingCost = false,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: ,
          children: [
            sticker1(),
            const SizedBox(height: 25),
            StickerMegahubHybrid1(data: data).sticker2(),
            Center(
              child: Text(
                'Untuk informasi dan pengecekan status kiriman silahkan mengunjungi www.jne.co.id',
                style: labelTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sticker1() {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: Get.width - 51,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(),
                    top: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                  color: Colors.white),
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
              border: const TableBorder(
                  verticalInside: BorderSide(),
                  right: BorderSide(),
                  left: BorderSide(),
                  bottom: BorderSide()),
              children: <TableRow>[
                TableRow(
                  // decoration: BoxDecoration(border: Border.all()),
                  children: <Widget>[
                    Text(
                      data.delivery?.serviceCode ?? '-',
                      style: itemTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      data.type ?? '-',
                      style: itemTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Rp ${shippingCost ? 1 : data.account?.accountService == "COD" ? data.delivery?.codFee?.toInt().toCurrency() : data.delivery?.insuranceFlag == "Y" ? data.delivery?.freightChargeWithInsurance?.toInt().toCurrency() ?? '0' : data.delivery?.freightCharge?.toInt().toCurrency() ?? '0'}',
                      style: itemTextStyle.copyWith(fontWeight: bold),
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
                    decoration: const BoxDecoration(
                        border: Border(right: BorderSide())),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'Pengirim: ${data.shipper?.name ?? ''}\n${data.shipper?.address ?? ''}, ${data.shipper?.city ?? data.shipper?.origin?.originName ?? ''}, ${data.shipper?.zipCode ?? ''}, Telp.${data.shipper?.phone ?? ''}\n\n',
                            style: labelTextStyle),
                        const Divider(height: 1),
                        Text(
                            'Penerima: ${data.receiver?.name ?? ''}\n${data.receiver?.address ?? ''}, ${data.receiver?.city ?? ''}, ${data.receiver?.zipCode ?? ''}. Telp.${data.receiver?.phone ?? ''}\n\n',
                            style: labelTextStyle),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3.6,
                    child: Text(
                      '${data.destination?.destinationCode?.substring(0, 3) ?? ''}-${data.destination?.facilityCode ?? data.destination?.cityZone ?? data.destination?.destinationCode?.substring(0, 3)} \n${data.receiver?.zipCode ?? ''}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Table(
              border: const TableBorder(
                  right: BorderSide(), verticalInside: BorderSide()),
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
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                              'Deskripsi: \n${data.goods?.desc ?? '-'}\n',
                              style: labelTextStyle),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                              'Intruksi Khusus: \n${data.delivery?.specialInstruction ?? '-'}\n',
                              style: labelTextStyle),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Tanggal: ${data.createdDate?.toShortDateFormat() ?? ''}',
                              style: labelTextStyle),
                          Text(
                              'No. Pelanggan: ${data.account?.accountNumber ?? ''}',
                              style: labelTextStyle),
                          Text(
                              'Kota Asal: ${data.shipper?.city ?? data.shipper?.origin?.originName ?? ''}',
                              style: labelTextStyle),
                          Text('Berat: ${data.goods?.weight ?? '0'} Kg',
                              style: labelTextStyle),
                          Text('Jumlah Kiriman: ${data.goods?.quantity ?? '0'}',
                              style: labelTextStyle),
                          Text('Pembayaran: ${data.type ?? ''}',
                              style: labelTextStyle),
                          Text('Order ID: ${data.orderId ?? ''}',
                              style: labelTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
                        data.account?.accountService ?? '-',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        data.type ?? '-',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Rp. ${data.delivery?.freightCharge?.toInt().toCurrency()}',
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
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(right: pw.BorderSide())),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text(
                              'Pengirim: ${data.shipper?.name}\n${data.shipper?.address}\nTelp.${data.shipper?.phone}',
                              style: const pw.TextStyle(fontSize: 8)),
                          pw.Text(
                              'Penerima: ${data.receiver?.name}\n${data.receiver?.address}\nTelp.${data.receiver?.phone}\n',
                              style: const pw.TextStyle(fontSize: 8)),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      width: Get.width / 3.6,
                      child: pw.Text(
                        '${data.shipper?.origin} - ${data.receiver?.destinationCode}\n${data.receiver?.zipCode}',
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
                          pw.Text('Deskripsi: ',
                              style: const pw.TextStyle(fontSize: 10)),
                          pw.Divider(),
                          pw.Text('Intruksi Khusus:',
                              style: const pw.TextStyle(fontSize: 10)),
                        ],
                      ),
                      pw.Container(
                        margin: const pw.EdgeInsets.all(3),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                                'Tanggal: ${data.createdDate?.toLongDateFormat()}',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text(
                                'No. Pelanggan: ${data.receiver?.registrationId}',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Kota Asal: ${data.shipper?.city}',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Berat:',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Jumlah Kiriman:',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text(
                                'Pembayaran: ${data.type == 'COD' ? 'COD' : 'NON COD'}',
                                style: const pw.TextStyle(fontSize: 8)),
                            pw.Text('Order ID: ${data.orderId}',
                                style: const pw.TextStyle(fontSize: 8)),
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
                                      data.account?.accountService ?? '-',
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
                        pw.Text('Tanggal: ${data.createdDate}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text(
                            'No. Pelanggan: ${data.receiver?.registrationId}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Deskripsi: ${data.receiver?.registrationId}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Berat: ${data.receiver?.registrationId}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Biaya Kirim: ${data.receiver?.registrationId}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Kota Tujuan: ${data.receiver?.city}',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Asuransi: ${data.receiver?.registrationId} ',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text('Order ID: ${data.orderId}',
                            style: const pw.TextStyle(fontSize: 8)),
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
