import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/dokumen_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/image_popup_dialog.dart';
import 'package:css_mobile/widgets/dialog/secret_data_dialog.dart';
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
            appBar: _appBarContent(context),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(DokumenController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          DocumentImageItem(
            isLoading: c.isLoading,
            title: 'Lampiran Dokumen KTP'.tr,
            img: c.ccrfProfil?.document?.ccrfKtpattached ?? '',
            onTap: () => showDialog(
              context: context,
              builder: (context) => ImagePopupDialog(
                title: 'Lampiran Dokumen KTP'.tr,
                img: c.ccrfProfil?.document?.ccrfKtpattached ?? '',
              ),
            ),
          ),
          DocumentImageItem(
            isLoading: c.isLoading,
            title: 'Lampiran Dokumen NPWP'.tr,
            img: c.ccrfProfil?.document?.ccrfNpwpattached ?? '',
            onTap: () => showDialog(
              context: context,
              builder: (context) => ImagePopupDialog(
                title: 'Lampiran Dokumen NPWP'.tr,
                img: c.ccrfProfil?.document?.ccrfNpwpattached ?? '',
              ),
            ),
          ),
          DocumentImageItem(
            isLoading: c.isLoading,
            title: 'Lampiran Dokumen Rekening'.tr,
            img: c.ccrfProfil?.document?.ccrfAccountattached ?? '',
            onTap: () => showDialog(
              context: context,
              builder: (context) => ImagePopupDialog(
                title: 'Lampiran Dokumen Rekening'.tr,
                img: c.ccrfProfil?.document?.ccrfAccountattached ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomTopBar _appBarContent(BuildContext context) {
    return CustomTopBar(
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
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SecretDataDialog(text: 'kerahasiaan_data'.tr);
                }),
                backgroundColor:
                    AppConst.isLightTheme(context) ? whiteColor : greyColor,
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
    );
  }
}
