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

import '../../const/app_const.dart';

class PackageInfoItem extends StatelessWidget {
  final TransactionModel data;
  final String? message;

  const PackageInfoItem({super.key, required this.data, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppConst.isLightTheme(context) ? blueJNE : warningColor,
              width: 2.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomLabelText(
                title: '',
                value: message?.tr ?? '',
                fontColor:
                    AppConst.isLightTheme(context) ? blueJNE : warningColor,
              ),
            ],
          ),
          ListTile(
            title: CustomFormLabel(
              label: data.awb ?? '',
              fontColor:
                  AppConst.isLightTheme(context) ? blueJNE : warningColor,
              isBold: true,
            ),
            leading: MenuIcon(
              radius: 100,
              background: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              showContainer: false,
              menuIcon: Icon(
                CupertinoIcons.cube_fill,
                color:
                    AppConst.isLightTheme(context) ? whiteColor : warningColor,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            trailing: IconButton(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: data.awb ?? ''),
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.copy_rounded),
            ),
          ),
          const Divider(color: greyLightColor3),
          CustomLabelText(
            title: 'Nama Barang'.tr,
            value: data.goodsDesc ?? '',
            fontColor: AppConst.isLightTheme(context) ? blueJNE : warningColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomLabelText(
                title: 'Berat Kiriman'.tr,
                value: '${data.weight?.toInt()} Kg',
                fontColor:
                    AppConst.isLightTheme(context) ? blueJNE : warningColor,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: data.deliveryPrice != null
                    ? CustomLabelText(
                        title: 'Ongkos Kirim'.tr,
                        value:
                            "Rp. ${data.deliveryPrice?.toInt().toCurrency()}",
                        fontColor: AppConst.isLightTheme(context)
                            ? blueJNE
                            : warningColor,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          const Divider(color: greyLightColor3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomLabelText(
                title: 'Dari'.tr,
                value: data.originDesc ?? '',
                fontColor:
                    AppConst.isLightTheme(context) ? blueJNE : warningColor,
              ),
              Transform.flip(
                  flipX: false,
                  child: Icon(Icons.arrow_circle_right_rounded,
                      color: AppConst.isLightTheme(context)
                          ? blueJNE
                          : warningColor)),
              Align(
                alignment: Alignment.centerRight,
                child: CustomLabelText(
                  title: 'Menuju'.tr,
                  value: data.destinationDesc ?? '',
                  fontColor:
                      AppConst.isLightTheme(context) ? blueJNE : warningColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
