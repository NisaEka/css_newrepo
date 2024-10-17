import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class PhoneTextFormField extends HookWidget {
  final TextEditingController controller;

  const PhoneTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      prefixIcon: const Icon(Icons.phone),
      hintText: 'No Handphone'.tr,
      isRequired: true,
      inputType: TextInputType.number,
      validator: ValidationBuilder().phoneNumber().build(),
    );
  }
}
