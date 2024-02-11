import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final void Function()? onSubmit;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const   CustomSearchField({
    super.key,
    required this.hintText,
    this.onTap,
    this.onSubmit,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: blueJNE,
          width: 2,
        )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: neutralColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        prefixIcon: prefixIcon != null
            ? Container(
                alignment: Alignment.center,
                width: 40,
                height: 39,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: blueJNE,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Container(
                alignment: Alignment.center,
                width: 30,
                height: 39,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: blueJNE,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: suffixIcon,
              )
            : null,
      ),
    );
  }
}
