import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/dokumen_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/items/document_image_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DokumenScreen extends StatelessWidget {
  const DokumenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DokumenController>(
        init: DokumenController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Dokumen".tr,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Foto Dokumen KTP".tr, style: subTitleTextStyle),
                      DocumentImageItem(img: controller.ccrfProfil?.document?.idCard ?? ''),
                      Text("Foto Dokumen NPWP".tr, style: subTitleTextStyle),
                      DocumentImageItem(img: controller.ccrfProfil?.document?.npwp ?? ''),
                      Text("Foto Dokumen Buku Rekening".tr, style: subTitleTextStyle),
                      DocumentImageItem(img: controller.ccrfProfil?.document?.bankAccount ?? ''),
                    ],
                  ),
                ),
                controller.isLoading ? const LoadingDialog() : Container(),
              ],
            ),
          );
        });
  }
}
