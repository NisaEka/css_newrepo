import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_a6.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_default.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub2.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_2.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_3.dart';
import 'package:css_mobile/util/helper/file_download_helper.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class LabelController extends BaseController {
  DataTransactionModel data = Get.arguments['data'];
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = GlobalKey();
  final GlobalKey globalKey = GlobalKey();

  String? stickerLabel;
  bool shippingCost = false;
  bool hiddenPhoneShipper = false;
  bool isCopyLabel = false;
  PdfPageFormat? sizeLabel;

  BoxConstraints? boxConstraints;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      await setting.getSettingLabel().then(
        (value) async {
          await storage.writeString(StorageCore.transactionLabel,
              value.data?.labels?.where((e) => e.enabled ?? false).first.name);
          await storage.writeString(StorageCore.shippingCost,
              value.data?.priceLabel != '0' ? "PUBLISH" : "HIDE");
          await storage.writeString(StorageCore.hiddenPhoneShipper,
              value.data?.hideShipperphoneLabel != 'Y' ? "PUBLISH" : "HIDE");
          await storage.writeString(
              StorageCore.isCopyLabel, value.data?.copyLabel.toString());
        },
      );

      update();

      stickerLabel = await storage.readString(StorageCore.transactionLabel);
      var shipcost = await storage.readString(StorageCore.shippingCost);
      var hiddenPhone =
          await storage.readString(StorageCore.hiddenPhoneShipper);
      var copyLabel = await storage.readString(StorageCore.isCopyLabel);
      shippingCost = shipcost == "HIDE";
      hiddenPhoneShipper = hiddenPhone == "HIDE";
      isCopyLabel = copyLabel == '0';
      if (stickerLabel == "Default") {
        sizeLabel = const PdfPageFormat(
          8.5 * PdfPageFormat.cm,
          21 * PdfPageFormat.cm,
        );
        boxConstraints = const BoxConstraints(maxHeight: 1200, minHeight: 500);
      } else if (stickerLabel == "Sticker Label (A6 10.50 X 14.80 CM)") {
        sizeLabel = PdfPageFormat.a6;
        boxConstraints = const BoxConstraints(maxHeight: 890, minHeight: 500);
      } else if (stickerLabel == "Sticker Label (Mega HUB 1)") {
        sizeLabel = const PdfPageFormat(
          11.90625 * PdfPageFormat.cm,
          16.271875 * PdfPageFormat.cm,
        );
        boxConstraints = const BoxConstraints();
      } else if (stickerLabel == "Sticker Label Vertikal (Mega HUB 1)") {
        sizeLabel = const PdfPageFormat(
          11.90625 * PdfPageFormat.cm,
          16.271875 * PdfPageFormat.cm,
        );
      } else if (stickerLabel == "Sticker Label (Mega HUB HYBRID)") {
        sizeLabel = const PdfPageFormat(
          9.8667622917 * PdfPageFormat.cm,
          12.111222708 * PdfPageFormat.cm,
        );
      } else if (stickerLabel == "Sticker Label (Mega HUB HYBRID 2)") {
        sizeLabel = const PdfPageFormat(
          9.8667622917 * PdfPageFormat.cm,
          9.1040214583 * PdfPageFormat.cm,
        );
      } else {
        sizeLabel = const PdfPageFormat(
          8.8893914583 * PdfPageFormat.cm,
          13.588497292 * PdfPageFormat.cm,
        );
      }

      update();
    } catch (e) {
      AppLogger.e('error initData label $e');
    }
  }

  Future getPdf(Uint8List screenShot, bool isCopyLabel) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(vertical: 20),
        pageFormat: sizeLabel,
        build: (context) {
          return pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.fill);
        },
      ),
    );
    if (isCopyLabel) {
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.symmetric(vertical: 20),
          pageFormat: sizeLabel,
          build: (context) {
            return pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.fill);
          },
        ),
      );
    }
    String tempPath = (await getDownloadsDirectory())!.path;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = "${data.awb ?? ''}_$timestamp";

    File file = await File('$tempPath/$fileName.pdf').create();
    await file.writeAsBytes(await pdf.save());
    FileDownloaderHelper.saveFileOnDevice("$fileName.pdf", file);
  }

  Future capture(BuildContext context) async {
    if (stickerLabel == "Default" ||
        stickerLabel == "Sticker Label (A6 10.50 X 14.80 CM)") {
      screenshotController
          .captureFromLongWidget(
            myLongWidget(data),
            context: context,
            constraints: boxConstraints,
          )
          .then((capturedImage) async => getPdf(capturedImage, isCopyLabel));
    } else {
      screenshotController
          .capture()
          .then((capturedImage) async => getPdf(capturedImage!, isCopyLabel));
    }
  }

  Widget myLongWidget(DataTransactionModel data) {
    return stickerLabel == "Default"
        ? StickerDefault(
            data: data,
            shippingCost: shippingCost,
            hiddenPhoneShipper: hiddenPhoneShipper,
          )
        : stickerLabel == "Sticker Label (A6 10.50 X 14.80 CM)"
            ? StickerA6(
                data: data,
                shippingCost: shippingCost,
                hiddenPhoneShipper: hiddenPhoneShipper,
              )
            : stickerLabel == "Sticker Label (Mega HUB 1)"
                ? StickerMegahub1(
                    data: data,
                    shippingCost: shippingCost,
                    hiddenPhoneShipper: hiddenPhoneShipper,
                  )
                : stickerLabel == "Sticker Label Vertikal (Mega HUB 1)"
                    ? StickerMegahub2(
                        data: data,
                        shippingCost: shippingCost,
                        hiddenPhoneShipper: hiddenPhoneShipper,
                      )
                    : stickerLabel == "Sticker Label (Mega HUB HYBRID)"
                        ? StickerMegahubHybrid1(
                            data: data,
                            shippingCost: shippingCost,
                            hiddenPhoneShipper: hiddenPhoneShipper,
                          )
                        : stickerLabel == "Sticker Label (Mega HUB HYBRID 2)"
                            ? StickerMegahubHybrid2(
                                data: data,
                                shippingCost: shippingCost,
                                hiddenPhoneShipper: hiddenPhoneShipper,
                              )
                            : StickerMegahubHybrid3(
                                data: data,
                                shippingCost: shippingCost,
                                hiddenPhoneShipper: hiddenPhoneShipper,
                              );
  }
}
