import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
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
  final FocusNode? focusNode;
  final bool? autofocus;
  final EdgeInsets? contentPadding;
  final bool noBorder;

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
      this.height,
      this.onSubmit,
      this.focusNode,
      this.autofocus,
      this.contentPadding,
      this.noBorder = false}) {
    if (isRequired && !readOnly) {
      validator ??= ValidationBuilder().required().build();
    }
  }

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
            : const SizedBox(),
        SizedBox(
          height: helperText != null ? 16 : 8,
        ),
        helperText != null ? Text(helperText ?? "") : const SizedBox(),
        SizedBox(
          height: helperText != null ? 16 : 0,
        ),
        Container(
          width: width ?? null,
          height: height != null && multiLine == false ? height ?? 39 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            minLines: multiLine ? 3 : 1,
            maxLines: !multiLine ? 1 : 3,
            onTap: onTap,
            enabled: onTap != null ? true : !readOnly,
            controller: controller,
            readOnly: readOnly,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            autofocus: autofocus ?? false,
            focusNode: focusNode,
            validator: validator,
            keyboardType: inputType,
            obscureText: isObscure ?? false,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  // fontWeight: FontWeight.w600,
                ),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: label == null ? Text(hintText ?? '') : const SizedBox(),
                fillColor: backgroundColor ?? (onTap != null || !readOnly ? whiteColor : neutralColor),
                //jika ontap!=null, maka state "active". jika bukan readyonly, maka state "active". Jika readonly dan ontap == null maka state "inactive"
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                prefixIconColor: greyDarkColor1,
                suffixIconColor: greyDarkColor1,
                contentPadding: contentPadding ?? const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                hintText: hintText ?? label,
                disabledBorder: noBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: readOnly ? Colors.white : Theme.of(context).primaryColor,
                          width: readOnly ? 1 : 2,
                          style: BorderStyle.solid,
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: readOnly ? greyDarkColor1 : Theme.of(context).primaryColor,
                    width: readOnly ? 1 : 2,
                    style: BorderStyle.solid,
                  ),
                ),
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
