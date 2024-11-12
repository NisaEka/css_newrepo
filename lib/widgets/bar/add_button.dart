import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      onPressed: onPressed,
      icon: Icon(
        Icons.add,
        color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
      ),
    );
  }
}
