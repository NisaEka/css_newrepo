import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ShippingCostDropdown extends HookWidget {
  const ShippingCostDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanLabelController>(
        init: PengaturanLabelController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            child: CustomDropDownField(
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
          );
        });
  }
}
