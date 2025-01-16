import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class CustomSearchDropdownField<T> extends StatefulWidget {
  final Future<List<T>> Function(String)? asyncItems;

  final void Function(dynamic)? onChanged;

  final List<T>? items;
  final String Function(T) itemAsString;
  final Widget Function(BuildContext, T, bool) itemBuilder;
  final String? label;
  final String? hintText;
  final String? selectedItem;
  final bool readOnly;
  final TextStyle? textStyle;
  T? value;
  final double? width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  bool isRequired;
  final bool showClearButton;
  final bool showDropdownButton;
  final VoidCallback? onClear;
  final String? searchHintText;
  final TextEditingController? controller;
  final bool isFilterOnline;

  CustomSearchDropdownField(
      {super.key,
      this.items,
      this.asyncItems,
      this.onChanged,
      required this.itemAsString,
      required this.itemBuilder,
      this.label,
      this.hintText,
      this.selectedItem,
      required this.readOnly,
      this.textStyle,
      this.width,
      this.suffixIcon,
      this.prefixIcon,
      this.isRequired = false,
      this.value,
      this.showClearButton = false,
      this.showDropdownButton = true,
      this.isFilterOnline = true,
      this.onClear,
      this.searchHintText,
      this.controller}) {
    if (isRequired) {
      if (value == null || value == hintText || value == label) {
        // return validator!(value as T);
        // validator ??= ValidationBuilder().required().build() as FormFieldValidator<T>?;
        // return "This field is required";
      }
    }
  }

  @override
  State<CustomSearchDropdownField<T>> createState() =>
      _CustomSearchDropdownFieldState<T>();
}

class _CustomSearchDropdownFieldState<T>
    extends State<CustomSearchDropdownField<T>> {
  FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    if (widget.readOnly) {
      return Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: widget.controller ??
                TextEditingController(text: widget.selectedItem.toString()),
            enabled: false,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: AppConst.isLightTheme(context)
                      ? Colors.black
                      : whiteColor,
                ),
            decoration: InputDecoration(
              label: Text(widget.label ?? widget.hintText ?? ''),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? neutralColor
                  : greyColor,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              prefixIconColor: Theme.of(context).colorScheme.outline,
              suffixIconColor: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 10)
        ],
      );
    }
    return Column(
      children: [
        const SizedBox(height: 10),
        DropdownSearch<T>(
          validator: (value) {
            if (widget.isRequired) {
              if (value == null ||
                  value == widget.hintText ||
                  value == widget.label) {
                return "Masukan tidak boleh kosong".tr;
              }
            }
            return null;
          },
          items: widget.items ?? [],
          popupProps: PopupProps.menu(
            constraints: const BoxConstraints(maxHeight: 200),
            fit: FlexFit.loose,
            showSelectedItems: false,
            errorBuilder: (context, searchEntry, exception) =>
                DataEmpty(text: "Anda sedang offline".tr),
            menuProps: MenuProps(
              backgroundColor:
                  AppConst.isLightTheme(context) ? null : greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            showSearchBox: true,
            searchDelay: const Duration(milliseconds: 500),
            isFilterOnline: widget.isFilterOnline,
            itemBuilder: widget.itemBuilder,
            searchFieldProps: TextFieldProps(
                cursorColor: CustomTheme().cursorColor(context),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: widget.searchHintText,
                  helperText: "Masukan minimal 3 karakter".tr,
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: regular)),
          ),
          dropdownButtonProps: DropdownButtonProps(
            icon: const Icon(Icons.keyboard_arrow_down),
            isVisible: widget.showDropdownButton,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                label: Text(widget.hintText ?? ''),
                hintText: widget.hintText ?? widget.label,
                hintStyle: Theme.of(context).textTheme.titleSmall,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                prefixIconColor: Theme.of(context).colorScheme.outline),
            baseStyle:
                widget.textStyle ?? Theme.of(context).textTheme.titleSmall,
          ),
          asyncItems: widget.asyncItems,
          itemAsString: widget.itemAsString,
          onChanged: widget.onChanged,
          selectedItem: widget.value,
          clearButtonProps: ClearButtonProps(
            icon: const Icon(Icons.close),
            isVisible: widget.showClearButton,
            onPressed: widget.onClear,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
