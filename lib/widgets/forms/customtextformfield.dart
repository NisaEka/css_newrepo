import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
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
  final bool isLoading;

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
      this.noBorder = false,
      this.isLoading = false}) {
    if (isRequired && !readOnly) {
      validator ??= ValidationBuilder().required().build();
    }
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? RichText(
                text: TextSpan(
                  text: widget.label,
                  style: formLabelTextStyle,
                  children: const <TextSpan>[
                    // TextSpan(text: isRequired ? "*" : "", style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: widget.helperText != null ? 16 : 8,
        ),
        widget.helperText != null ? Text(widget.helperText ?? "") : const SizedBox(),
        SizedBox(
          height: widget.helperText != null ? 16 : 0,
        ),
        Shimmer(
          isLoading: widget.isLoading,
          child: Container(
            width: widget.width ?? Get.width,
            height: widget.height != null && widget.multiLine == false ? widget.height ?? 39 : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.isLoading ? greyColor : Colors.transparent,
            ),
            child: TextFormField(
              minLines: widget.multiLine ? 3 : 1,
              maxLines: !widget.multiLine ? 1 : 3,
              onTap: widget.onTap,
              enabled: widget.onTap != null ? true : !widget.readOnly,
              controller: widget.controller,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmit,
              autofocus: widget.autofocus ?? false,
              focusNode: widget.focusNode,
              validator: widget.validator,
              keyboardType: widget.inputType,
              obscureText: widget.isObscure ?? false,
              inputFormatters: widget.inputFormatters ??
                  (widget.hintText!.contains('email')
                      ? [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return newValue.copyWith(text: newValue.text.toLowerCase());
                          })
                        ]
                      : (!widget.hintText!.contains('Kata Sandi') || !widget.hintText!.contains('Password'))
                          ? [
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                return newValue.copyWith(text: newValue.text.toUpperCase());
                              })
                            ]
                          : []),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    // fontWeight: FontWeight.w600,
                  ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  filled: true,
                  label: widget.label == null ? Text(widget.hintText ?? '') : const SizedBox(),
                  fillColor: widget.backgroundColor ??
                      (widget.onTap != null || !widget.readOnly
                          ? Colors.transparent
                          : Theme.of(context).brightness == Brightness.light
                              ? greyLightColor3
                              : greyColor),
                  //jika ontap!=null, maka state "active". jika bukan readyonly, maka state "active". Jika readonly dan ontap == null maka state "inactive"
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                  prefixIconColor: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1,
                  suffixIconColor: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1,
                  contentPadding: widget.contentPadding ?? const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  hintText: widget.hintText ?? widget.label,
                  errorMaxLines: 3,
                  disabledBorder: widget.noBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.readOnly
                                ? Colors.white
                                : Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(context).primaryColor
                                    : greyLightColor1,
                            width: widget.readOnly ? 1 : 2,
                            style: BorderStyle.solid,
                          ),
                        )
                      : null,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.readOnly
                          ? greyDarkColor1
                          : Theme.of(context).brightness == Brightness.light
                              ? Theme.of(context).primaryColor
                              : whiteColor,
                      width: widget.readOnly ? 1 : 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintStyle: hintTextStyle),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
