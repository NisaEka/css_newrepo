import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Edit Profil".tr,
              backgroundColor: Colors.transparent,
            ),
            body: controller.isLoading
                ? const LoadingDialog(
                    background: Colors.transparent,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: controller.formKey,
                      child: ListView(
                        children: [
                          CustomTextFormField(
                            controller: controller.brand,
                            hintText: "Nama Brand / Bisnis".tr,
                            validator: ValidationBuilder().name().build(),
                          ),
                          CustomTextFormField(
                            controller: controller.name,
                            hintText: "Nama Lengkap".tr,
                            validator: ValidationBuilder().name().build(),
                          ),
                          CustomTextFormField(
                            controller: controller.ktp,
                            hintText: "Nomor Identitas / KTP".tr,
                            readOnly: true,
                          ),
                          CustomTextFormField(
                            controller: controller.address,
                            hintText: "Alamat Lengkap".tr,
                            validator: ValidationBuilder().address().build(),
                          ),
                          CustomSearchDropdownField<Destination>(
                            asyncItems: (String filter) => controller.getDestinationList(filter),
                            itemBuilder: (context, e, b) {
                              return GestureDetector(
                                onTap: () => controller.update(),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child: Text(
                                    '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.destinationCode}',
                                  ),
                                ),
                              );
                            },
                            itemAsString: (Destination e) => '${e.cityName}; ${e.districtName}; ${e.subDistrictName}; ${e.zipCode}',
                            onChanged: (value) {
                              controller.selectedCity = value;
                              controller.update();
                            },
                            value: controller.selectedCity,
                            isRequired: controller.selectedCity == null ? true : false,
                            readOnly: false,
                            hintText: controller.isLoading ? "Loading..." : "Kota/Kecamatan/Kelurahan/Kode Pos".tr,
                            // prefixIcon: const Icon(Icons.location_city),
                            textStyle: controller.selectedCity != null ? subTitleTextStyle : hintTextStyle,
                          ),
                          CustomTextFormField(
                            controller: controller.phone,
                            hintText: "Nomor Telepon".tr,
                            readOnly: true,
                            validator: ValidationBuilder().phoneNumber().build(),
                          ),
                          CustomTextFormField(
                            controller: controller.whatsapp,
                            hintText: "Nomor Whatsapp".tr,
                            readOnly: true,
                          ),
                          CustomTextFormField(
                            controller: controller.email,
                            hintText: "Email",
                            readOnly: true,
                          ),
                          CustomFilledButton(
                            color: blueJNE,
                            title: "Edit Profil".tr,
                            onPressed: () => controller.updateData(),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
