import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
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
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Pengaturan Label'.tr,
                ),
                body: _bodyContent(controller, context),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
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
              text: c.selectedSticker?.name ??
                  ''
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
