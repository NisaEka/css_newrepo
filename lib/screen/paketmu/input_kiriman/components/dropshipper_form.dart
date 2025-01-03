import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/dropshipper/add/add_dropshipper_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class DropshipperForm extends StatelessWidget {
  const DropshipperForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDropshipperController>(
        init: AddDropshipperController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: c.formKey,
                onChanged: () {
                  c.update();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: c.dropshipperName,
                      hintText: "Nama Pengirim".tr,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.person_2_rounded),
                      validator: ValidationBuilder().name().build(),
                    ),
                    CustomTextFormField(
                      controller: c.dropshipperPhone,
                      hintText: "Nomor Telepon".tr,
                      inputType: TextInputType.number,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.phone_rounded),
                      validator: ValidationBuilder().phoneNumber().build(),
                    ),
                    OriginDropdown(
                      label: "Kota Pengirim".tr,
                      onChanged: (value) {
                        c.selectedOrigin = value;
                        c.dropshipperOrigin.text =
                            c.selectedOrigin?.originName ?? '';
                        c.update();
                      },
                      isOfficer: c.isOfficer,
                      // branchCode: c.account.accountCategory == "LOKAL" ? c.account.accountBranch : null,
                      originCode: (c.account.accountCategory == "LOKAL")
                          ? c.userBasic?.origin?.originCode
                          : null,
                      value: c.selectedOrigin,
                      selectedItem: c.dropshipperOrigin.text,
                      prefixIcon: const Icon(Icons.trip_origin_rounded),
                      readOnly: false,
                      isRequired: true,
                    ),
                    CustomTextFormField(
                      controller: c.dropshipperZipCode,
                      hintText: "Kode Pos".tr,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.markunread_mailbox_rounded),
                      validator: ValidationBuilder().zipCode().build(),
                      inputType: TextInputType.number,
                    ),
                    CustomTextFormField(
                      controller: c.dropshipperAddress,
                      hintText: "Alamat".tr,
                      isRequired: true,
                      multiLine: true,
                      prefixIcon: const Icon(Icons.home_work_rounded),
                      validator: ValidationBuilder().address().build(),
                    ),
                    CustomFilledButton(
                        color: c.formKey.currentState?.validate() ?? false
                            ? primaryColor(context)
                            : greyColor,
                        title: "Simpan Data Dropshipper".tr,
                        // radius: 20,
                        onPressed: () =>
                            c.formKey.currentState?.validate() == true
                                ? c.saveDropshipper()
                                : null),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
