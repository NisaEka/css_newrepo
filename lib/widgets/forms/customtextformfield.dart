import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String?>? onSaved;
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

  CustomTextFormField({
    super.key,
    this.controller,
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
    this.isLoading = false,
    this.onSaved,
  }) {
    if (isRequired) {
      StorageCore()
          .readString(StorageCore.localeApp)
          .then((value) => ValidationBuilder.setLocale(value));
      validator ??=
          ValidationBuilder(requiredMessage: 'Masukan tidak boleh kosong'.tr)
              .required()
              .build();
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
                  children: const <TextSpan>[],
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: widget.helperText != null ? 16 : 8,
        ),
        widget.helperText != null
            ? Text(widget.helperText ?? "")
            : const SizedBox(),
        SizedBox(
          height: widget.helperText != null ? 16 : 0,
        ),
        Shimmer(
          isLoading: widget.isLoading,
          child: Container(
            width: widget.width ?? Get.width,
            height: widget.height != null && widget.multiLine == false
                ? widget.height ?? 39
                : null,
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
              onSaved: widget.onSaved,
              onFieldSubmitted: widget.onSubmit,
              autofocus: widget.autofocus ?? false,
              focusNode: widget.focusNode,
              validator: widget.validator,
              keyboardType: widget.inputType,
              obscureText: widget.isObscure ?? false,
              cursorColor: CustomTheme().cursorColor(context),
              inputFormatters: widget.inputFormatters ??
                  (widget.hintText?.contains('email') ?? false
                      ? [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return newValue.copyWith(
                                text: newValue.text.toLowerCase());
                          })
                        ]
                      : (!(widget.hintText?.contains('Kata Sandi') ?? false) ||
                              !(widget.hintText?.contains('Password') ?? false))
                          ? [
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                return newValue.copyWith(
                                    text: newValue.text.toUpperCase());
                              })
                            ]
                          : []),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: AppConst.isLightTheme(context)
                        ? Colors.black
                        : whiteColor,
                  ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  filled: true,
                  label: widget.label == null
                      ? Text(widget.hintText ?? '')
                      : const SizedBox(),
                  fillColor: widget.backgroundColor ??
                      (widget.onTap != null || !widget.readOnly
                          ? Colors.transparent
                          : AppConst.isLightTheme(context)
                              ? greyLightColor3
                              : greyColor),
                  //jika ontap!=null, maka state "active". jika bukan readyonly, maka state "active". Jika readonly dan ontap == null maka state "inactive"
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                  prefixIconColor: Theme.of(context).colorScheme.outline,
                  suffixIconColor: Theme.of(context).colorScheme.outline,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                  hintText: widget.hintText ?? widget.label,
                  errorMaxLines: 3,
                  disabledBorder: widget.noBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.readOnly
                                ? Colors.white
                                : AppConst.isLightTheme(context)
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
                          : AppConst.isLightTheme(context)
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
