import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class SatuanFieldIcon extends StatelessWidget {
  final String title;
  final bool? isPrefix;
  final bool? isSuffix;

  const SatuanFieldIcon({
    super.key,
    required this.title,
    this.isPrefix = false,
    this.isSuffix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 60,
      margin: EdgeInsets.only(right: isPrefix! ? 10 : 0, left: isSuffix! ? 5 : 0),
      decoration: BoxDecoration(
        color: blueJNE,
        borderRadius: BorderRadius.only(
          topRight: isSuffix! ? Radius.circular(8) : Radius.zero,
          bottomRight: isSuffix! ? Radius.circular(8) : Radius.zero,
          topLeft: isPrefix! ? Radius.circular(8) : Radius.zero,
          bottomLeft: isPrefix! ? Radius.circular(8) : Radius.zero,
        ),
      ),
      child: Text(title, style: listTitleTextStyle.copyWith(color: whiteColor)),
    );
  }
}
