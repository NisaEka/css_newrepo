import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_controller.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_a6.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_default.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub2.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_1.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_2.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/sticker_megahub_hybrid_3.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataTransactionModel data = Get.arguments['data'];

    return GetBuilder<LabelController>(
        init: LabelController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Lihat Resi".tr),
              actions: const [
                // IconButton(
                //   onPressed: () async {
                //     // final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
                //     // String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                //     // path = '$directory';
                //     controller.screenshotController
                //         .capture(
                //       delay: const Duration(milliseconds: 10),
                //     )
                //         .then((capturedImage) async {
                //       controller.showCapturedWidget(context, capturedImage!);
                //     })
                //         //     .then((value) {
                //         //   if (image != null) {
                //         //     final directory = await getApplicationDocumentsDirectory();
                //         //     final imagePath = await File('${directory.path}/image.png').create();
                //         //     await imagePath.writeAsBytes(image);
                //         //
                //         //     /// Share Plugin
                //         //     await Share.shareFiles([imagePath.path]);
                //         //   }
                //         // })
                //         .catchError((onError) {
                //       printError(info: onError);
                //     });
                //   },
                //   icon: const Icon(Icons.print),
                // ),
              ],
            ),
            backgroundColor: whiteColor,
            // body: PdfPreview(
            //   maxPageWidth: Get.width,
            //   build: (format) => StickerMegahub1(data: data).generatePdf(format),
            //   // actions: actions,
            //   // onPrinted: _showPrintedToast,
            //   // onShared: _showSharedToast,
            // ),
            body: Screenshot(
              controller: controller.screenshotController,
              child: Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                color: Colors.white,
                // child: StickerMegahubHybrid3(data: data),
                child: controller.stickerLabel == "/sticker_default"
                    ? StickerDefault(
                        data: data,
                        shippingCost: controller.shippingCost,
                      )
                    : controller.stickerLabel == "/sticker_A6"
                        ? StickerA6(
                            data: data,
                            shippingCost: controller.shippingCost,
                          )
                        : controller.stickerLabel == "/sticker_megahub1"
                            ? StickerMegahub1(
                                data: data,
                                shippingCost: controller.shippingCost,
                              )
                            : controller.stickerLabel == "/sticker_vertical_megahub_1"
                                ? StickerMegahub2(
                                    data: data,
                                    shippingCost: controller.shippingCost,
                                  )
                                : controller.stickerLabel == "/sticker_megahub_hybrid_1"
                                    ? StickerMegahubHybrid1(
                                        data: data,
                                        shippingCost: controller.shippingCost,
                                      )
                                    : controller.stickerLabel == "/sticker_megahub_hybrid_2"
                                        ? StickerMegahubHybrid2(
                                            data: data,
                                            shippingCost: controller.shippingCost,
                                          )
                                        : StickerMegahubHybrid3(
                                            data: data,
                                            shippingCost: controller.shippingCost,
                                          ),
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
