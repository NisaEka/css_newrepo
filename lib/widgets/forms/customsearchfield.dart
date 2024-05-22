import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchField<T> extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? validationText;
  final bool validate;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final VoidCallback? onClear;

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
    this.inputFormatters,
    this.inputType,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: inputType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: validate
                      ? redJNE
                      : Theme.of(context).brightness == Brightness.light
                          ? blueJNE
                          : whiteColor,
                  width: 2,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: validate
                  ? redJNE
                  : Theme.of(context).brightness == Brightness.light
                      ? blueJNE
                      : whiteColor,
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? blueJNE : whiteColor,
                      borderRadius: const BorderRadius.only(
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? blueJNE : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: suffixIcon,
                  )
                : controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: onClear,
                        icon: const Icon(Icons.close),
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
