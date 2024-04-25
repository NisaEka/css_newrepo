import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomSearchDropdownField<T> extends StatelessWidget {
  final Future<List<T>> Function(String) asyncItems;

  final void Function(dynamic) onChanged;

  // final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;
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

  CustomSearchDropdownField(
      {super.key,
      this.items,
      required this.asyncItems,
      required this.onChanged,
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
      this.value}) {
    if (isRequired) {
      if (value == null || value == hintText || value == label) {
        // return validator!(value as T);
        // validator ??= ValidationBuilder().required().build() as FormFieldValidator<T>?;
        // return "This field is required";
      }
    }
  }

  FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    if (readOnly) {
      return Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: selectedItem.toString()),
            enabled: false,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1,
                  // fontWeight: FontWeight.w600,
                ),
            decoration: InputDecoration(
              label: Text(hintText ?? ''),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light ? neutralColor : greyColor,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefixIconColor: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1,
              suffixIconColor: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1,
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
            if (isRequired) {
              if (value == null || value == hintText || value == label) {
                // return validator!(value as T);
                return "This field is required";
              }
            }
            return null;
          },
          popupProps: PopupProps.menu(
            constraints: const BoxConstraints(maxHeight: 200),
            fit: FlexFit.loose,
            showSelectedItems: false,
            showSearchBox: true,
            searchDelay: const Duration(milliseconds: 500),
            isFilterOnline: true,
            itemBuilder: itemBuilder,
          ),
          dropdownButtonProps: const DropdownButtonProps(
            icon: Icon(Icons.keyboard_arrow_down),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              label: Text(hintText ?? ''),
              hintText: hintText ?? label,
              hintStyle: hintTextStyle,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            baseStyle: textStyle,
          ),
          asyncItems: asyncItems,
          itemAsString: itemAsString,
          onChanged: onChanged,
          selectedItem: value,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
