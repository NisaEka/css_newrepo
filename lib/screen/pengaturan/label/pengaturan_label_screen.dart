import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/pengaturan/label/components/label_type_field.dart';
import 'package:css_mobile/screen/pengaturan/label/components/mask_phone_shipper_dropdown.dart';
import 'package:css_mobile/screen/pengaturan/label/components/shipping_cost_dropdown.dart';
import 'package:css_mobile/screen/pengaturan/label/components/stickers_list.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanLabelScreen extends StatelessWidget {
  const PengaturanLabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanLabelController>(
        init: PengaturanLabelController(),
        builder: (c) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(title: 'Pengaturan Label'.tr),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView(
                    children: [
                      const ShippingCostDropdown(),
                      const MaskShipperPhoneDropdown(),
                      LabelTypeField(c.selectedSticker),
                      const StickersList(),
                      CustomFilledButton(
                        color: primaryColor(context),
                        title: 'Simpan Perubahan'.tr,
                        onPressed: () => c.saveLabel(),
                      ),
                    ],
                  ),
                ),
              ),
              c.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
