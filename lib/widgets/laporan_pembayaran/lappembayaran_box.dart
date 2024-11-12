import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentBox extends StatelessWidget {
  final String title;
  final String value;
  final bool isLoading;

  const PaymentBox({
    super.key,
    required this.title,
    required this.value,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : greyColor,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(title.capitalize ?? '', style: subformLabelTextStyle),
            Shimmer(
              isLoading: isLoading,
              child: Container(
                height: isLoading ? 20 : null,
                width: isLoading ? Get.width / 2 : null,
                color: isLoading ? greyColor : null,
                child: Text(
                  value,
                  style: appTitleTextStyle.copyWith(color: blueJNE),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
