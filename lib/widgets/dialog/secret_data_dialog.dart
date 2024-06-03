import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecretDataDialog extends StatelessWidget {
  final String text;

  const SecretDataDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kerahasiaan Data'.tr,
                style: appTitleTextStyle.copyWith(
                  color: blueJNE,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormLabel(label: text),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
