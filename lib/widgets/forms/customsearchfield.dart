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
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: neutralColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        prefixIcon: prefixIcon != null
            ? Container(
                alignment: Alignment.center,
                width: 30,
                height: 39,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: blueJNE,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    bottomLeft: const Radius.circular(8),
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
                decoration: BoxDecoration(
                  color: blueJNE,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(8),
                    bottomRight: const Radius.circular(8),
                  ),
                ),
                child: suffixIcon,
              )
            : null,
      ),
    );
  }
}
