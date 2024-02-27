import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/items/sticker_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PengaturanLabelScreen extends StatelessWidget {
  const PengaturanLabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanLabelController>(
        init: PengaturanLabelController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Pengaturan Label'.tr,
              backgroundColor: whiteColor,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  CustomSwitch(
                    value: controller.copyLabel,
                    label: 'Salin Label'.tr,
                    onChange: (value) {
                      controller.copyLabel = value;
                      controller.update();
                    },
                  ),
                  CustomDropDownField(
                    // value: controller.selectedTampil,
                    hintText: 'Biaya Kirim'.tr,
                    items: [
                      DropdownMenuItem(
                        value: 'PUBLISH RATE',
                        child: Text('Publish Rate'.tr.toUpperCase()),
                      ),
                      DropdownMenuItem(
                        value: 'SEMBUNYIKAN',
                        child: Text('Sembunyikan'.tr.toUpperCase()),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedSticker = value ?? '';
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 11),
                  CustomFormLabel(label: 'Pilih Jenis Label Anda'.tr),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.labelList
                          .map(
                            (e) => StickerListItem(
                              img: e.image ?? '',
                              isSelected: controller.selectedSticker == e.name,
                              onTap: () {
                                controller.selectedSticker = e.name.toString();
                                controller.update();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  CustomFilledButton(
                    color: blueJNE,
                    title: 'Simpan Perubahan',
                    onPressed: () => controller.saveLabel(),
                  ),

                ],
              ),
            ),
          );
        });
  }
}
