import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/sticker_list_item.dart';
import 'package:flutter/material.dart';
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
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(PengaturanLabelController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView(
        children: [
          // CustomSwitch(
          //   value: controller.copyLabel,
          //   label: 'Salin Label'.tr,
          //   onChange: (value) {
          //     controller.copyLabel = value;
          //     controller.update();
          //   },
          // ),
          CustomDropDownField(
            label: 'Biaya Kirim'.tr,
            value: c.shipcost.isNotEmpty ? c.shipcost : "PUBLISH",
            hintText: 'Biaya Kirim'.tr,
            items: [
              DropdownMenuItem(
                value: 'PUBLISH',
                child: Text(
                  'Publish Rate'.tr.toUpperCase(),
                  style: subTitleTextStyle,
                ),
              ),
              DropdownMenuItem(
                value: 'HIDE',
                child: Text(
                  'Sembunyikan'.tr.toUpperCase(),
                  style: subTitleTextStyle,
                ),
              ),
            ],
            onChanged: (value) {
              c.shipcost = value ?? '';
              c.update();
            },
          ),
          const SizedBox(height: 11),
          CustomFormLabel(label: 'Pilih Jenis Label Anda'.tr),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: c.selectedSticker
                  .splitMapJoin(
                    '_',
                    onMatch: (p0) => ' ',
                  )
                  .substring(1),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: c.labelList
                  .map(
                    (e) => StickerListItem(
                      img: e.image ?? '',
                      isSelected: c.selectedSticker == e.name,
                      onTap: () {
                        c.selectedSticker = e.name.toString();
                        c.update();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          CustomFilledButton(
            color: blueJNE,
            title: 'Simpan Perubahan'.tr,
            onPressed: () => c.saveLabel(),
          ),
        ],
      ),
    );
  }
}
