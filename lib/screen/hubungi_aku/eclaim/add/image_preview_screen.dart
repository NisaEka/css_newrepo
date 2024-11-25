import 'dart:io';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/add_eclaim_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewScreen extends StatelessWidget {
  final File image;

  const ImagePreviewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEclaimController>(
        init: AddEclaimController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "E-Claim".tr,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(image),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mengunduh gambar
                      final controller = Get.find<AddEclaimController>();
                      controller.downloadImage();
                    },
                    child: CustomFilledButton(
                      color: blueJNE,
                      title: "Unduh Gambar".tr,
                      isTransparent: true,
                      onPressed: () {
                        controller.downloadImage(); // Panggil fungsi unduh
                        Get.back(); // Tutup dialog setelah mengunduh
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
