import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JlcPointBox extends StatelessWidget {
  final String totalTransaksi;
  final String jlcPoint;

  const JlcPointBox({
    super.key,
    required this.totalTransaksi,
    required this.jlcPoint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 62,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(right: 35, top: 10, bottom: 10, left: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : greyDarkColor1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? greyDarkColor1
                : greyLightColor1),
        boxShadow: [
          BoxShadow(
            color: primaryColor(context),
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstant.logoJLC2, height: 28, width: 60),
          Column(
            children: [
              Text("Total Transaksi".tr,
                  style: subformLabelTextStyle.copyWith(
                    color: textColor(context),
                  )),
              Text(
                "Rp. ${totalTransaksi.toInt().toCurrency()}",
                style:
                    formLabelTextStyle.copyWith(color: primaryColor(context)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Poin JLC".tr,
                  style: subformLabelTextStyle.copyWith(
                    color: textColor(context),
                  )),
              Text(
                jlcPoint.toDouble().round().toCurrency(),
                style: formLabelTextStyle.copyWith(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
