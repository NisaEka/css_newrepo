import 'dart:async';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:screenshot/screenshot.dart';

class LabelController extends BaseController {
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = new GlobalKey();

  String? stickerLabel;
  bool shippingCost = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      stickerLabel = await storage.readString(StorageCore.transactionLabel);
      var shipcost = await storage.readString(StorageCore.shippingCost);
      shippingCost = shipcost == "HIDE";
      update();
    } catch (e) {
      e.printError();
    }
  }

  Future getPdf(Uint8List screenShot, TransactionModel data) async {
    final img = await rootBundle.load(ImageConstant.logoJNE);
    final logoJNE = img.buffer.asUint8List();

    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        // pageFormat: format,
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
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
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
    File pdfFile = File('Your path + File name');
    pdfFile.writeAsBytesSync(pdf.save() as List<int>);
  }

// takeScreenShot() async{
//   RenderObject? boundary = previewContainer.currentContext?.findRenderObject();
//   ui.Image image = await boundary?.toImage();
//   final directory = (await getApplicationDocumentsDirectory()).path;
//   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   Uint8List? pngBytes = byteData?.buffer.asUint8List();
//   print(pngBytes);
//   File imgFile =new File('$directory/screenshot.png');
//   imgFile.writeAsBytes(pngBytes as List<int>);
// }
}
