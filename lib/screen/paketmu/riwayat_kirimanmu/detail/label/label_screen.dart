import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_controller.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_a6.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_default.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionModel data = Get.arguments['data'];

    return GetBuilder<LabelController>(
        init: LabelController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Cetak Label".tr,
            ),
            // body: PdfPreview(
            //   // maxPageWidth: Get.width
            //
            //   build: (format) => StickerMegahub1(data: data).generatePdf(format),
            //   // actions: actions,
            //   // onPrinted: _showPrintedToast,
            //   // onShared: _showSharedToast,
            // ),
            body: Screenshot(
              controller: controller.screenshotController,
              child: Container(
                margin: const EdgeInsets.all(25),
                child: StickerMegahubHybrid(data: data),
                // child: controller.stickerLabel == "/sticker_default"
                //     ? StickerDefault(data: data)
                //     : controller.stickerLabel == "/sticker_A6"
                //         ? StickerA6(data: data)
                //         : controller.stickerLabel == "/sticker_megahub1"
                //             ? StickerMegahub1(data: data)
                //             : StickerMegahubHybrid(data: data),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   shape: const CircleBorder(),
            //   backgroundColor: redJNE,
            //
            //   onPressed: () async {
            //     final screenShot = await controller.screenshotController.capture();
            //     controller.getPdf(screenShot!, data);
            //   },
            //   // onPressed: () => PdfPreview(
            //   //   build: (format) => StickerMegahub1(data: data).generatePdf(format),
            //   // ),
            //   child: const Icon(
            //     Icons.print,
            //     color: whiteColor,
            //   ),
            // ),
          );
        });
  }
}
