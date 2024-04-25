import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/dokumen_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/image_popup_dialog.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
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
              action: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        enableDrag: true,
                        isDismissible: true,
                        // isScrollControlled: true,
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kerahasiaan Data'.tr,
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomFormLabel(label: 'kerahasiaan_data'.tr),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        backgroundColor: Theme.of(context).brightness == Brightness.light ? whiteColor : greyColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_rounded, color: redJNE),
                    tooltip: 'informasi'.tr,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: [
                  DocumentImageItem(
                    title: 'Lampiran Dokumen KTP'.tr,
                    img: controller.ccrfProfil?.document?.idCard ?? '',
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ImagePopupDialog(
                        title: 'Lampiran Dokumen KTP'.tr,
                        img: controller.ccrfProfil?.document?.idCard ?? '',
                      ),
                    ),
                  ),
                  DocumentImageItem(
                    title: 'Lampiran Dokumen NPWP'.tr,
                    img: controller.ccrfProfil?.document?.npwp ?? '',
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ImagePopupDialog(
                        title: 'Lampiran Dokumen NPWP'.tr,
                        img: controller.ccrfProfil?.document?.npwp ?? '',
                      ),
                    ),
                  ),
                  DocumentImageItem(
                    title: 'Lampiran Dokumen Rekening'.tr,
                    img: controller.ccrfProfil?.document?.bankAccount ?? '',
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ImagePopupDialog(
                        title: 'Lampiran Dokumen Rekening'.tr,
                        img: controller.ccrfProfil?.document?.bankAccount ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
