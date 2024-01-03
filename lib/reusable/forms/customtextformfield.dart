import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.controller,
      this.label,
      this.helperText,
      this.hintText,
      this.readOnly = false,
      this.onChanged,
      this.isRequired = false,
      this.validator,
      this.inputFormatters,
      this.onTap,
      this.suffixIcon,
      this.backgroundColor,
      this.multiLine = false,
      this.inputType,
      this.prefixIcon,
      this.isObscure,
      this.width,
      this.height}) {
    if (isRequired && !readOnly) {
      validator ??= ValidationBuilder().required().build();
    }
  }

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  bool isRequired;
  FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final bool multiLine;
  final bool? isObscure;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? RichText(
                text: TextSpan(
                  text: label,
                  style: formLabelTextStyle,
                  children: const <TextSpan>[
                    // TextSpan(text: isRequired ? "*" : "", style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )
            : SizedBox(),
        SizedBox(
          height: helperText != null ? 16 : 8,
        ),
        helperText != null ? Text(helperText ?? "") : const SizedBox(),
        SizedBox(
          height: helperText != null ? 16 : 0,
        ),
        Container(
          width: width ?? null,
          height: height != null && multiLine == false ? height ?? 55 : null,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            minLines: multiLine ? 3 : 1,
            maxLines: !multiLine ? 1 : 3,
            onTap: onTap,
            enabled: onTap != null ? true : !readOnly,
            controller: controller,
            readOnly: readOnly,
            onChanged: onChanged,
            validator: validator,
            keyboardType: inputType,
            obscureText: isObscure ?? false,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  // fontWeight: FontWeight.w600,
                ),
            decoration: InputDecoration(
                fillColor: backgroundColor ?? (onTap != null || !readOnly ? whiteColor : neutralColor),
                //jika ontap!=null, maka state "active". jika bukan readyonly, maka state "active". Jika readonly dan ontap == null maka state "inactive"
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintText: hintText ?? label,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: readOnly ? Colors.black54 : Theme.of(context).primaryColor, width: readOnly ? 1 : 2, style: BorderStyle.solid)),
                hintStyle: hintTextStyle),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
