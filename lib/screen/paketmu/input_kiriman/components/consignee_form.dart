import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/destination_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../receiver_info/receiver/add/add_receiver_controller.dart';

class ConsigneeForm extends StatelessWidget {
  const ConsigneeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReceiverController>(
        init: AddReceiverController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Container(
              // padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(30),
              child: Form(
                key: c.formKey,
                onChanged: () {
                  c.formKey.currentState?.validate();
                  c.update();
                },
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: c.receiverName,
                      hintText: "Nama Penerima".tr,
                      prefixIcon: const Icon(Icons.person),
                      isRequired: true,
                      validator: ValidationBuilder().name().build(),
                    ),
                    CustomTextFormField(
                      controller: c.receiverPhone,
                      hintText: "Nomor Telepon".tr,
                      inputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.phone),
                      isRequired: true,
                      validator: ValidationBuilder().phoneNumber().build(),
                    ),
                    DestinationDropdown(
                      label: "Kota Tujuan".tr,
                      onChanged: (value) {
                        c.selectedDestination = value;
                        c.update();
                      },
                      value: c.selectedDestination,
                      isRequired: c.selectedDestination == null,
                      readOnly: false,
                      prefixIcon: const Icon(Icons.location_city),
                    ),
                    CustomTextFormField(
                      controller: c.receiverAddress,
                      hintText: "Alamat".tr,
                      prefixIcon: const Icon(Icons.location_city),
                      multiLine: true,
                      isRequired: true,
                      validator: ValidationBuilder().address().build(),
                    ),
                    CustomFilledButton(
                      color: c.formKey.currentState?.validate() == true
                          ? blueJNE
                          : greyColor,
                      title: 'Simpan Data Penerima'.tr,
                      onPressed: () =>
                          c.formKey.currentState?.validate() == true
                              ? c.saveReceiver()
                              : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
