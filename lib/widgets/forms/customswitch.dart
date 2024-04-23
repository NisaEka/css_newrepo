import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool) onChange;

  const CustomSwitch({super.key, required this.value, required this.label, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: subformLabelTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? greyDarkColor2 : greyLightColor2)),
        Switch(
          value: value,
          onChanged: onChange,
          activeColor: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
          inactiveThumbColor: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
        )
      ],
    );
  }
}
