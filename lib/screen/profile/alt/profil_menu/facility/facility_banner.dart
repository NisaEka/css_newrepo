import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityBanner extends StatelessWidget {
  final Color bannerColor;
  final String bannerText;

  const FacilityBanner({
    super.key,
    required this.bannerColor,
    required this.bannerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bannerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info,
            color: whiteColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              bannerText.tr,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: whiteColor),
            ),
          )
        ],
      ),
    );
  }
}
