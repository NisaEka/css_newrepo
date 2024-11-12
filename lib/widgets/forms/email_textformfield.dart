import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import 'customtextformfield.dart';

class EmailTextformfield extends HookWidget {
  final TextEditingController controller;

  const EmailTextformfield({
    super.key,
    required this.controller,
  });

  Future<String> getLocale() async {
    final storage = Get.find<StorageCore>();
    var locale = await storage.readString(StorageCore.localeApp);
    return locale;
  }

  @override
  Widget build(BuildContext context) {
    String locale = 'en';
    getLocale().then(
      (value) => locale = value,
    );

    return CustomTextFormField(
      controller: controller,
      prefixIcon: const Icon(Icons.mail_outline),
      hintText: 'Email'.tr,
      isRequired: true,
      validator: ValidationBuilder(localeName: locale)
          .email()
          .minLength(10)
          .maxLength(50)
          .build(),
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          return newValue.copyWith(text: newValue.text.toLowerCase());
        })
      ],
    );
  }
}
