import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool) onChange;

  const CustomSwitch(
      {super.key,
      required this.value,
      required this.label,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: subformLabelTextStyle.copyWith(
                color: AppConst.isLightTheme(context)
                    ? greyDarkColor2
                    : greyLightColor2)),
        Switch(
          value: value,
          onChanged: onChange,
          activeColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
          // inactiveThumbColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
        )
      ],
    );
  }
}
