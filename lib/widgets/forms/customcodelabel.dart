import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomCodeLabel extends StatelessWidget {
  final String label;
  final bool isLoading;

  const CustomCodeLabel({
    super.key,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer(
          isLoading: isLoading,
          child: Container(
            color: isLoading ? greyLightColor2 : Colors.transparent,
            width: isLoading ? Get.width / 2 : null,
            child: Text(label, style: appTitleTextStyle.copyWith(color: blueJNE)),
          ),
        ),
        IconButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: label)),
          icon: const Icon(
            Icons.copy_rounded,
            color: blueJNE,
          ),
        ),
      ],
    );
  }
}
