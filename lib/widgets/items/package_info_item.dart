import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PackageInfoItem extends StatelessWidget {
  final TransactionModel data;

  const PackageInfoItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: warningDarkColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: CustomLabelText(
              title: 'awb number',
              value: data.awb ?? '',
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
                ClipboardData(text: data.awb ?? ''),
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
            value: data.goodsDesc ?? '',
            fontColor: whiteColor,
          ),
          CustomLabelText(
            title: 'Berat Kiriman'.tr,
            value: data.weight?.toString() ?? '',
            fontColor: whiteColor,
          ),
          CustomLabelText(
            title: 'Ongkos Kirim'.tr,
            value: "Rp. ${data.deliveryPrice?.toInt().toCurrency()}",
            fontColor: whiteColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLabelText(
                title: 'Dari'.tr,
                value: data.originDesc ?? '',
                fontColor: whiteColor,
              ),
              Transform.flip(
                  flipX: true,
                  child: const Icon(Icons.arrow_back, color: whiteColor)),
              CustomLabelText(
                title: 'Menuju'.tr,
                value: data.destinationDesc ?? '',
                fontColor: whiteColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
