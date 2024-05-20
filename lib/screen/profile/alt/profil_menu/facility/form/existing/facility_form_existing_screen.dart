import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/existing/facility_form_existing_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormExistingScreen extends StatelessWidget {

  const FacilityFormExistingScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormExistingController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: _formAppBar(),
              bottomNavigationBar: _formBottomNavBar(controller),
              body: _formBody(controller)
            ),
            controller.showLoadingIndicator ? const LoadingDialog() : Container()
          ],
        );
      }
    );
  }

  PreferredSizeWidget _formAppBar() {
    return CustomTopBar(
      title: 'Upgrade Profil Kamu'.tr,
    );
  }

  Widget _formBottomNavBar(FacilityFormExistingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomFilledButton(
        color: redJNE,
        title: 'Simpan'.tr,
        onPressed: () => controller.onSubmit(),
      ),
    );
  }

  Widget _formBody(FacilityFormExistingController controller) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: _defaultFormPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: controller.name,
                  hintText: 'Nama'.tr,
                  helperText: 'Nama customer yang terdaftar'.tr,
                  validator: ValidationBuilder()
                    .maxLength(32)
                    .build()
                ),
                CustomTextFormField(
                  controller: controller.email,
                  hintText: 'Email'.tr,
                  helperText: 'Email terdaftar saat kerjasama'.tr,
                  inputType: TextInputType.emailAddress,
                  inputFormatters: const [],
                  validator: ValidationBuilder()
                    .email()
                    .build()
                ),
                CustomTextFormField(
                  controller: controller.phone,
                  hintText: 'No Telp'.tr,
                  helperText: 'Nomor telepon yang terdaftar di akun JNE'.tr,
                  inputType: TextInputType.phone,
                  validator: ValidationBuilder()
                    .phone()
                    .build(),
                )
              ],
            )
          )
        )
      ],
    );
  }

  EdgeInsets _defaultFormPadding() {
    return const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 16,
    );
  }

}