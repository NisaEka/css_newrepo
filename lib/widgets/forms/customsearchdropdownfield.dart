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


  CustomSearchDropdownField({
    super.key,
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
  });



  @override
  Widget build(BuildContext context) {
    if (readOnly) {
      return TextField(
        controller: TextEditingController(text: selectedItem.toString()),
        enabled: false,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              color: Colors.black,
              // fontWeight: FontWeight.w600,
            ),
        decoration: InputDecoration(
          fillColor: neutralColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconColor: greyDarkColor1,
          suffixIconColor: greyDarkColor1,
        ),
      );
    }
    return DropdownSearch<T>(
      validator: (value) {
        if (value == null || value == hintText || value == label) {
          // return validator!(value as T);
          return "This field is required";
        }
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
    );
  }

  dynamic _getIdSelectedValue(T selected) {
    DropdownMenuItem? item = items?.firstWhere((DropdownMenuItem item) => (item.child as Text).data == selected) as DropdownMenuItem;
    return item.value;
  }

  String _getSelectedValue() {
    if (items != null) {
      if (items!.isNotEmpty) {
        if (value != null) {
          DropdownMenuItem? item = items?.firstWhere((DropdownMenuItem item) => item.value == value, orElse: () => items!.first) as DropdownMenuItem;
          Text textView = item.child as Text;

          return textView.data ?? hintText ?? label ?? '';
        }
      }
    }

    return hintText ?? label ?? '';
  }
}
