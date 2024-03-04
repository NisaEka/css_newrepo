import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? validationText;
  final bool validate;

  const CustomSearchField({
    super.key,
    required this.hintText,
    this.onTap,
    this.onSubmit,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    required this.controller,
    this.validationText,
    this.validate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: validate ? redJNE : blueJNE,
                  width: 2,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: validate ? redJNE : blueJNE,
              width: 2,
            )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: validate ? redJNE : neutralColor,
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
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
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
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: suffixIcon,
                  )
                : null,
          ),
          onTap: onTap,
          onSubmitted: onSubmit,
          onChanged: onChanged,
        ),
        Text(
          validate ? validationText ?? '' : '',
          style: sublistTitleTextStyle.copyWith(
            color: errorColor,
          ),
        ),
      ],
    );
  }
}
