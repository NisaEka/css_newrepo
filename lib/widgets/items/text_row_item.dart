import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextRowItem extends StatelessWidget {
  final String title;
  final String value;
  final double? titleWidth;
  final double? valueWidth;
  final bool isLoading;
  final bool isTitleBold;
  final bool isValueBold;

  const TextRowItem({
    super.key,
    required this.title,
    required this.value,
    this.titleWidth,
    this.valueWidth,
    this.isLoading = false,
    this.isTitleBold = false,
    this.isValueBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomFormLabel(
          isLoading: isLoading,
          label: title,
          width: titleWidth ?? Get.width / 2.5,
          isBold: isTitleBold,
        ),
        const SizedBox(width: 30),
        CustomFormLabel(
          isLoading: isLoading,
          label: value,
          width: valueWidth ?? Get.width / 3,
          isBold: isValueBold,
        ),
      ],
    );
  }
}
