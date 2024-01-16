import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomFormLabel extends StatelessWidget{
  const CustomFormLabel({super.key, required this.label, this.showRequired = false});

  final String label;
  final bool showRequired;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: formLabelTextStyle,
        children: <TextSpan>[
          TextSpan(
              text: showRequired ? "*" : "",
              style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

}