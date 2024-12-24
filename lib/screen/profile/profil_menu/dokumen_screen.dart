import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/profil_menu/dokumen_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/secret_data_dialog.dart';
import 'package:css_mobile/widgets/items/document_image_item.dart';
import 'package:css_mobile/widgets/items/show_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

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
            onTap: () => showImagePreview(
              context,
              // 'Lampiran Dokumen KTP'.tr,
              c.ccrfProfil?.document?.ccrfKtpattached ?? '',
            ),
          ),
          DocumentImageItem(
            isLoading: c.isLoading,
            title: 'Lampiran Dokumen NPWP'.tr,
            img: c.ccrfProfil?.document?.ccrfNpwpattached ?? '',
            onTap: () => showImagePreview(
              context,
              // 'Lampiran Dokumen NPWP'.tr,
              c.ccrfProfil?.document?.ccrfNpwpattached ?? '',
            ),
          ),
          DocumentImageItem(
            isLoading: c.isLoading,
            title: 'Lampiran Dokumen Rekening'.tr,
            img: c.ccrfProfil?.document?.ccrfAccountattached ?? '',
            onTap: () => showImagePreview(
              context,
              // 'Lampiran Dokumen Rekening'.tr,
              c.ccrfProfil?.document?.ccrfAccountattached ?? '',
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
            icon: Icon(Icons.info_rounded,
                color: AppConst.isLightTheme(context) ? redJNE : warningColor),
            tooltip: 'informasi'.tr,
          ),
        )
      ],
    );
  }

  // Function to show image preview
  // void _showImagePreview(BuildContext context, String title, String imageUrl) {
  //   if (imageUrl.isNotEmpty) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (_) => Scaffold(
  //           backgroundColor: Colors.black,
  //           appBar: AppBar(
  //             backgroundColor: Colors.black,
  //             elevation: 0,
  //             automaticallyImplyLeading: false,
  //             actions: [
  //               IconButton(
  //                 icon: const Icon(Icons.close, color: whiteColor),
  //                 onPressed: () => Navigator.of(context).pop(),
  //               ),
  //             ],
  //           ),
  //           body: Center(
  //             child: PhotoViewGallery.builder(
  //               itemCount: 1,
  //               builder: (context, index) {
  //                 return PhotoViewGalleryPageOptions(
  //                   imageProvider: CachedNetworkImageProvider(imageUrl),
  //                   minScale: PhotoViewComputedScale.contained,
  //                   maxScale: PhotoViewComputedScale.covered * 3.0,
  //                   initialScale: PhotoViewComputedScale.contained,
  //                 );
  //               },
  //               scrollPhysics: const BouncingScrollPhysics(),
  //               backgroundDecoration: const BoxDecoration(color: Colors.black),
  //               pageController: PageController(),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
