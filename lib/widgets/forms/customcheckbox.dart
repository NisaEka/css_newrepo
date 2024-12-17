import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool?) onChanged;
  final double? width;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        dense: false,
        leading: SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
          ),
        ),
        title: Text(label, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Checkbox(
    //       value: value,
    //       onChanged: onChange,
    //     ),
    //     CustomFormLabel(label: label),
    //   ],
    // );
  }
}
