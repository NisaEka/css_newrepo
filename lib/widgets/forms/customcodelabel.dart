import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomCodeLabel extends StatelessWidget {
  final String label;
  final bool isLoading;
  final MainAxisAlignment alignment;

  const CustomCodeLabel({
    super.key,
    required this.label,
    this.isLoading = false,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 400 ? 16 : 18;
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Shimmer(
          isLoading: isLoading,
          child: Container(
            decoration: BoxDecoration(
                color: isLoading ? greyLightColor2 : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            width: isLoading ? Get.width / 2 : null,
            child: Text(
              label,
              style: appTitleTextStyle.copyWith(
                  color: primaryColor(context), fontSize: fontSize),
            ),
          ),
        ),
        IconButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: label)),
          icon: Icon(
            Icons.copy_rounded,
            color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
          ),
        ),
      ],
    );
  }
}
