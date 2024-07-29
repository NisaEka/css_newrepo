import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class Customradiobutton extends StatelessWidget {
  final String title;
  final dynamic groupValue;
  final dynamic value;
  final void Function(dynamic) onChanged;
  final VoidCallback onTap;

  const Customradiobutton({
    super.key,
    required this.title,
    required this.groupValue,
    required this.value,
    required this.onChanged, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: regular),
          ),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
