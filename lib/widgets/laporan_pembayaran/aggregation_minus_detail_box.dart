import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregationMinusDocBox extends StatelessWidget {

  final String documentNumber;

  const AggregationMinusDocBox({
    super.key,
    this.documentNumber = ""
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyDarkColor1),
        boxShadow: const [
          BoxShadow(
            color: blueJNE,
            spreadRadius: 1,
            offset: Offset(-3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Document no".tr,
            style: subformLabelTextStyle,
          ),
          Text(
            documentNumber,
          )
        ],
      ),
    );
  }
}
