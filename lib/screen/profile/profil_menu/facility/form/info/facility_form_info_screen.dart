import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/return/facility_form_return_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/destination_dropdown.dart';
import 'package:css_mobile/widgets/profile/image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormInfoScreen extends StatelessWidget {
  const FacilityFormInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormInfoController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: _appBarContent(controller),
              body: _bodyContent(controller, context),
              bottomNavigationBar: _nextButton(controller),
            ),
          ],
        );
      },
    );
  }

  Widget _nextButton(FacilityFormInfoController c) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: CustomFilledButton(
          color: redJNE,
          title: 'Selanjutnya'.tr,
          onPressed: () async {
            if (c.state.formKey.currentState?.validate() == true) {
              if (c.state.pickedImageUrl == null) {
                c.pickImageFailed = true;
                Get.dialog(c.imageAlertDialog());
                return;
              }
              Get.to(() => const FacilityFormReturnScreen(), arguments: {
                'data': await c.submitData(),
                'destination': c.state.selectedDestination,
              });
            }
          },
        ));
  }

  Widget _bodyContent(FacilityFormInfoController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Form(
              key: c.state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: c.state.brand,
                    hintText: 'Nama Toko / Perusahaan'.tr,
                    isRequired: true,
                    validator: ValidationBuilder().maxLength(32).build(),
                  ),
                  CustomTextFormField(
                    controller: c.state.idCardNumber,
                    hintText: 'No Identitas / KTP'.tr,
                    isRequired: true,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    validator:
                        ValidationBuilder().maxLength(16).minLength(16).build(),
                  ),
                  ImagePickerContainer(
                    containerTitle: 'Pilih Gambar Identitas / KTP'.tr,
                    pickedImagePath: c.state.pickedImageUrl,
                    onPickImage: () => c.pickImage(),
                  ),
                  CustomTextFormField(
                    controller: c.state.fullName,
                    hintText: 'Nama Lengkap'.tr,
                    isRequired: true,
                    inputType: TextInputType.name,
                    validator: ValidationBuilder().maxLength(32).build(),
                  ),
                  CustomTextFormField(
                    controller: c.state.fullAddress,
                    hintText: 'Alamat Lengkap'.tr,
                    isRequired: true,
                    inputType: TextInputType.streetAddress,
                    validator: ValidationBuilder().maxLength(128).build(),
                  ),
                  DestinationDropdown(
                    onChanged: (value) {
                      c.state.formKey.currentState?.validate();
                      c.state.selectedDestination = value;
                      c.update();
                    },
                    value: c.state.selectedDestination,
                    isRequired:
                        c.state.selectedDestination == null ? true : false,
                    readOnly: false,
                    label: c.state.isLoadDestination
                        ? "Loading..."
                        : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
                  ),
                  CustomTextFormField(
                    controller: c.state.phone,
                    hintText: 'No. Telepon'.tr,
                    inputType: TextInputType.phone,
                    isRequired: true,
                    validator:
                        ValidationBuilder().maxLength(15).phone().build(),
                  ),
                  CustomTextFormField(
                    controller: c.state.whatsAppPhone,
                    hintText: 'No. WhatsApp'.tr,
                    inputType: TextInputType.phone,
                    isRequired: true,
                    validator:
                        ValidationBuilder().maxLength(15).phone().build(),
                  ),
                  CustomTextFormField(
                    controller: c.state.email,
                    hintText: 'Email'.tr,
                    inputType: TextInputType.emailAddress,
                    isRequired: true,
                    readOnly: true,
                    inputFormatters: const [],
                    validator:
                        ValidationBuilder().maxLength(64).email().build(),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  CustomTopBar _appBarContent(FacilityFormInfoController c) {
    return CustomTopBar(
      title: 'Upgrade Profil Kamu'.tr,
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 0,
            totalStep: c.state.steps.length,
            steps: c.state.steps,
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
