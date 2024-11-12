import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailContent extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const DetailContent({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: regular),
        ),
        Container(
          width: Get.width / 2,
          alignment: Alignment.centerRight,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: valueColor,
                ),
          ),
        ),
      ],
    );
  }
}
