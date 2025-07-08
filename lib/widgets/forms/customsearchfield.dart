import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/forms/multiplesearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomSearchField<T> extends StatefulWidget {
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmit;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? validationText;
  final bool validate;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final VoidCallback? onClear;
  final EdgeInsets? margin;
  final bool autoFocus;
  final bool isMultiple;

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
    this.margin,
    this.autoFocus = false,
    this.isMultiple = false,
  });

  @override
  State<CustomSearchField<T>> createState() => _CustomSearchFieldState<T>();
}

class _CustomSearchFieldState<T> extends State<CustomSearchField<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: widget.isMultiple
                ? (widget.controller.text.split('\n').length < 5 ? (39 * widget.controller.text.split('\n').length).toDouble() : 150)
                : 39,
            // padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.validate ? redJNE : primaryColor(context),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    inputFormatters: widget.inputFormatters,
                    autofocus: widget.autoFocus,
                    maxLines: widget.isMultiple ? null : 1,
                    cursorColor: CustomTheme().cursorColor(context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: regular),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      // enabledBorder: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          // color: validate ? redJNE : primaryColor(context),
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          // color: validate ? redJNE : primaryColor(context),
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          // color: validate ? redJNE : neutralColor,
                          color: Colors.transparent,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      prefixIcon: widget.prefixIcon != null
                          ? Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 39,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: primaryColor(context),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(8),
                                  bottomLeft: Radius.circular(widget.controller.text.split('\n').length == 1 ? 8 : 0),
                                ),
                              ),
                              child: widget.prefixIcon,
                            )
                          : null,
                      // suffix: isMultiple
                      //     ? GestureDetector(
                      //         onTap: () => Get.to(const Multiplesearchfield())?.then(
                      //           (value) {
                      //             controller.text = value;
                      //           },
                      //         ),
                      //         child:
                      //             Container(padding: const EdgeInsets.symmetric(vertical: 5), child: const Icon(Icons.keyboard_return_rounded, size: 25)),
                      //       )
                      //     : null,
                      // suffixIcon: suffixIcon != null
                      //     ? Container(
                      //         alignment: Alignment.center,
                      //         width: 30,
                      //         height: 39,
                      //         margin: const EdgeInsets.only(left: 10),
                      //         decoration: BoxDecoration(
                      //           color: primaryColor(context),
                      //           borderRadius: const BorderRadius.only(
                      //             topRight: Radius.circular(8),
                      //             bottomRight: Radius.circular(8),
                      //           ),
                      //         ),
                      //         child: suffixIcon,
                      //       )
                      //     : controller.text.isNotEmpty
                      //         ? IconButton(
                      //             onPressed: onClear ?? () => controller.clear(),
                      //             icon: const Icon(Icons.close),
                      //           )
                      //         : null,
                    ),
                    onTap: widget.onTap,
                    onSubmitted: (value) => widget.onSubmit!(value),
                    onChanged: widget.onChanged ?? (_) => setState(() {}),
                  ),
                ),
                widget.isMultiple
                    ? GestureDetector(
                        onTap: () => widget.onSubmit!(widget.controller.text),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: const Icon(Icons.keyboard_return_rounded, size: 25),
                        ),
                      )
                    : const SizedBox(),
                widget.suffixIcon != null
                    ? Container(
                        alignment: Alignment.center,
                        width: 30,
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: primaryColor(context),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: widget.suffixIcon,
                      )
                    : widget.controller.text.isNotEmpty
                        ? IconButton(
                            onPressed: widget.onClear ?? () => widget.controller.clear(),
                            icon: const Icon(Icons.close),
                          )
                        : const SizedBox(),
              ],
            ),
          ),
          widget.validationText != null
              ? Text(
                  widget.validate ? widget.validationText ?? '' : '',
                  style: sublistTitleTextStyle.copyWith(
                    color: errorColor,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
