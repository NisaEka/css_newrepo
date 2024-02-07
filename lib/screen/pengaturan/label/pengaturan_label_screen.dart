import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
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
              backgroundColor: whiteColor,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  CustomSwitch(
                    value: controller.copyLabel,
                    label: 'Copy Label',
                    onChange: (value) {
                      controller.copyLabel = value;
                      controller.update();
                    },
                  ),
                  CustomDropDownField(
                    // value: controller.selectedTampil,
                    hintText: 'Tampilan Biaya Kirim'.tr,
                    items: const [
                      DropdownMenuItem(
                        value: 'PUBLISH RATE',
                        child: Text('PUBLISH RATE'),
                      ),
                      DropdownMenuItem(
                        value: 'SEMBUNYIKAN',
                        child: Text('SEMBUNYIKAN'),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedTampil = value ?? '';
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 11),
                  CustomFormLabel(label: 'Pilih Jenis Label Anda'.tr),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.asset(ImageConstant.labelSample),
                        Image.asset(ImageConstant.labelSample),
                        Image.asset(ImageConstant.labelSample),
                        Image.asset(ImageConstant.labelSample),
                      ],
                    ),
                  ),
                  const CustomFilledButton(
                    color: blueJNE,
                    title: 'Simpan Perubahan',
                  )
                ],
              ),
            ),
          );
        });
  }
}
