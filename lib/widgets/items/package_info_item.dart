import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PackageInfoItem extends StatelessWidget {
  const PackageInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: warningColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const CustomLabelText(
              title: 'awb number',
              value: '1234',
              fontColor: whiteColor,
            ),
            leading: const MenuIcon(
              radius: 100,
              background: whiteColor,
              showContainer: false,
              menuIcon: Icon(
                CupertinoIcons.cube_fill,
                color: blueJNE,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            trailing: IconButton(
              onPressed: () => Clipboard.setData(
                const ClipboardData(text: 'awb'),
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.copy),
            ),
          ),
          CustomFormLabel(
            label: 'Detail Paket'.tr,
            fontColor: whiteColor,
            isBold: true,
          ),
          CustomLabelText(
            title: 'Nama Barang'.tr,
            value: "test",
            fontColor: whiteColor,
          ),
          CustomLabelText(
            title: 'Berat Kiriman'.tr,
            value: "test",
            fontColor: whiteColor,
          ),
          CustomLabelText(
            title: 'Ongkos Kirim'.tr,
            value: "test",
            fontColor: whiteColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Dari'.tr,
                value: "Bandung",
                fontColor: whiteColor,
              ),
              Transform.flip(
                  flipX: true,
                  child: const Icon(Icons.arrow_back, color: whiteColor)),
              CustomLabelText(
                title: 'Menuju'.tr,
                value: "Jakarta",
                fontColor: whiteColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
