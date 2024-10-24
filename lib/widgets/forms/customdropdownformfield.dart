import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class CustomDropDownFormField<T> extends StatelessWidget {
  CustomDropDownFormField({
    super.key,
    required this.items,
    this.label,
    this.value,
    this.hintText,
    this.readOnly = false,
    this.onChanged,
    this.isRequired = false,
    this.validator,
    this.selectedItem,
    this.textStyle,
    this.width,
    this.suffixIcon,
    this.prefixIcon,
    this.searchHintText,
  }) {
    if (isRequired) {
      // validator ??= ValidationBuilder().required().build() as FormFieldValidator<T>?;
    }
  }

  final String? label;
  final String? hintText;
  final String? selectedItem;
  final bool readOnly;
  final TextStyle? textStyle;
  T? value;
  final ValueChanged<T?>? onChanged;
  bool isRequired;
  FormFieldValidator<T>? validator;
  final List<DropdownMenuItem<T>>? items;
  final double? width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? searchHintText;

  _getDropDown(BuildContext context) {
    if (items == null) {
      return const SizedBox();
    }
    return DropdownSearch<String>(
      validator: (value) {
        if (value == null || value.isEmpty || value == hintText || value == label) {
          // return validator!(value as T);
          return "This field is required";
        }
        return null;
      },
      popupProps: PopupProps.menu(
        constraints: const BoxConstraints(maxHeight: 200),
        fit: FlexFit.loose,
        showSelectedItems: true,
        showSearchBox: items!.length >= 15,
        searchDelay: const Duration(milliseconds: 500),
        searchFieldProps: TextFieldProps(
          cursorColor: CustomTheme().cursorColor(context),
          autofocus: true,
          decoration: InputDecoration(
            hintText: searchHintText,
            helperText: "Masukan minimal 3 karakter".tr,
          ),
        ),
        itemBuilder: (context, item, bool bool) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              item,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: regular),
            ),
          );
        },
      ),
      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(Icons.keyboard_arrow_down),
      ),
      items: items!.map((DropdownMenuItem e) => (e.child as Text).data!).toList(),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          label: Text(hintText ?? ''),
          hintText: hintText ?? label,
          hintStyle: hintTextStyle,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        baseStyle: textStyle ?? Theme.of(context).textTheme.titleSmall,
      ),
      onChanged: (value) {
        onChanged!(_getIdSelectedValue(value ?? "") as T?);
      },
      selectedItem: _getSelectedValue(),
    );
  }

  dynamic _getIdSelectedValue(String selected) {
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
                  children: <TextSpan>[
                    TextSpan(text: isRequired ? "" : "", style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: width ?? Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: readOnly
              ? TextField(
                  controller: TextEditingController(text: selectedItem.toString()),
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    label: Text(hintText ?? ''),
                    fillColor: neutralColor,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    prefixIconColor: greyDarkColor1,
                    suffixIconColor: greyDarkColor1,
                  ),
                )
              : _getDropDown(context),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
