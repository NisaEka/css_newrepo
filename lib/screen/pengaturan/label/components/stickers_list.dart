import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/sticker_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickersList extends StatelessWidget {
  const StickersList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanLabelController>(
        init: PengaturanLabelController(),
        builder: (c) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: c.labelList.isNotEmpty
                  ? c.labelList
                      .map(
                        (e) => StickerListItem(
                          img: e.image ?? '',
                          isSelected: c.selectedSticker == e,
                          onTap: () {
                            c.selectedSticker = e;
                            c.update();
                          },
                        ),
                      )
                      .toList()
                  : List.generate(
                      3,
                      (index) => Shimmer(
                        isLoading: true,
                        child: Container(
                          height: Get.width,
                          width: Get.width / 2,
                          color: greyColor,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}
