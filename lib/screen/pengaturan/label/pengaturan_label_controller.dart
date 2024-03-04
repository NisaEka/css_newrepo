import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanLabelController extends BaseController {
  bool copyLabel = false;

  String selectedSticker = '';

  List<StickerLabel> labelList = [
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/label-default1-webp.webp",
      name: "/sticker_default",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/label-default2-webp.webp",
      name: "/sticker_A6",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/label_default3-webp.webp",
      name: "/sticker_megahub_1",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/vertical-megahub-webp.webp",
      name: "/sticker_vertical_megahub1",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/argox-webp.webp",
      name: "/sticker_megahub_hybrid_1",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/argox2-webp.webp",
      name: "/sticker_megahub_hybrid_2",
    ),
    StickerLabel(
      image: "https://css.jne.co.id//assets/img/vertical-megahub-hybrid-webp.webp",
      name: "/sticker_vertical_megahub_hybrid",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      selectedSticker = await storage.readString(StorageCore.transactionLabel);
      update();
      var sticker = labelList.where((e) => e.name == selectedSticker).first;
    } catch (e) {
      e.printError();
    }

    update();
  }

  Future<void> saveLabel() async {
    await storage.writeString(StorageCore.transactionLabel, selectedSticker).then(
          (value) => Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.info,
                color: whiteColor,
              ),
              message: 'Label di update'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor,
            ),
          ),
        );
    update();
  }
}
