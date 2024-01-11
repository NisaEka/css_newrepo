import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool) onChange;

  const CustomSwitch({super.key, required this.value, required this.label, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomFormLabel(label: label),
        Switch(
          value: value,
          onChanged: onChange,
        )
      ],
    );
  }
}
