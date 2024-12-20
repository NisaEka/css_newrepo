import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: primaryColor(context),
    );
  }
}
