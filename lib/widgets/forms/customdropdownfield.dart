import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class CustomDropDownField<T> extends StatelessWidget {
  CustomDropDownField(
      {super.key,
      required this.items,
      this.label,
      this.value,
      this.hintText,
      this.readOnly = false,
      this.onChanged,
      this.isRequired = false,
      this.validator,
      this.selectedItem,
      this.width}) {
    if (isRequired) {
      validator ??=
          ValidationBuilder().required().build() as FormFieldValidator<T>?;
    }
  }

  final String? label;
  final String? hintText;
  final String? selectedItem;
  final bool readOnly;
  T? value;
  final ValueChanged<T?>? onChanged;
  bool isRequired;
  FormFieldValidator<T>? validator;
  final double? width;
  final List<DropdownMenuItem<T>>? items;

  _getDropDown(BuildContext context) {
    if (items == null) {
      return const SizedBox();
    }
    return DropdownButtonFormField(
      dropdownColor: dropDownColor(context),
      validator: validator,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
      icon: const Icon(Icons.keyboard_arrow_down),
      hint: Text(
        hintText ?? label ?? '',
        style: Theme.of(context).inputDecorationTheme.labelStyle,
      ),
      value: value,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: regular),
      isExpanded: true,
      items: items,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? '',
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          width: width ?? Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: readOnly
              ? TextField(
                  controller:
                      TextEditingController(text: selectedItem.toString()),
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                  decoration: const InputDecoration(
                    fillColor: whiteColor,
                  ),
                )
              : _getDropDown(context),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
