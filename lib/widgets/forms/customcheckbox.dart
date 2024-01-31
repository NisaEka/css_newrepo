import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool?) onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Checkbox(value: value, onChanged: onChanged),
      title: Text(label, style: subTitleTextStyle),
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
