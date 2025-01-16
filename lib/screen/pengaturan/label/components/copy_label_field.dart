import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CopyLabelField extends StatelessWidget {
  const CopyLabelField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanLabelController>(
        init: PengaturanLabelController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            child: CustomDropDownField(
              label: 'Copy Label'.tr,
              value: c.copyLabel.isNotEmpty ? c.copyLabel : "1",
              hintText: 'Copy Label'.tr,
              items: [
                DropdownMenuItem(
                  value: '0',
                  child: Text(
                    'Ya'.tr.toUpperCase(),
                    style: subTitleTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: Text(
                    'Tidak'.tr.toUpperCase(),
                    style: subTitleTextStyle,
                  ),
                ),
              ],
              onChanged: (value) {
                c.copyLabel = value ?? '';
                c.update();
              },
            ),
          );
        });
  }
}
