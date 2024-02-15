import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCodeLabel extends StatelessWidget {
  final String label;

  const CustomCodeLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: appTitleTextStyle.copyWith(color: blueJNE)),
        IconButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: label)),
          icon: Icon(
            Icons.copy_rounded,
            color: blueJNE,
          ),
        ),
      ],
    );
  }
}
