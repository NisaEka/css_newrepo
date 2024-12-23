import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/return/facility_form_return_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/profile/image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';

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
            controller.pickImageFailed
                ? DefaultAlertDialog(
                    title: 'Gagal mengambil gambar.'.tr,
                    subtitle:
                        'Periksa kembali ukuran file gambar KTP. File tidak boleh kosong atau lebih dari 2MB'
                            .tr,
                    confirmButtonTitle: 'OK'.tr,
                    onConfirm: () => controller.onRefreshUploadState(),
                  )
                : Container(),
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
            if (c.pickedImageUrl == null) {
              c.pickImageFailed = true;
              return;
            }

            Get.to(const FacilityFormReturnScreen(), arguments: {
              'data': await c.submitData(),
              'destination': c.selectedDestination
            });
          },
        ));
  }

  Widget _bodyContent(FacilityFormInfoController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: c.brand,
                  hintText: 'Nama Toko / Perusahaan',
                  isRequired: true,
                  validator: ValidationBuilder().maxLength(32).build(),
                ),
                CustomTextFormField(
                  controller: c.idCardNumber,
                  hintText: 'No Identitas / KTP',
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
                  containerTitle: 'Pilih Gambar Identitas / KTP',
                  pickedImagePath: c.pickedImageUrl,
                  onPickImage: () => c.pickImage(),
                ),
                CustomTextFormField(
                  controller: c.fullName,
                  hintText: 'Nama Lengkap',
                  isRequired: true,
                  inputType: TextInputType.name,
                  validator: ValidationBuilder().maxLength(32).build(),
                ),
                CustomTextFormField(
                  controller: c.fullAddress,
                  hintText: 'Alamat Lengkap',
                  isRequired: true,
                  inputType: TextInputType.streetAddress,
                  validator: ValidationBuilder().maxLength(128).build(),
                ),
                CustomSearchDropdownField<Destination>(
                  asyncItems: (String filter) => c.getDestinationList(filter),
                  itemBuilder: (context, e, b) {
                    return GestureDetector(
                      onTap: () => c.update(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(e.asFacilityFormFormat(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: textColor(context),
                                )),
                      ),
                    );
                  },
                  itemAsString: (Destination e) => e.asFacilityFormFormat(),
                  onChanged: (value) {
                    c.selectedDestination = value;
                    c.update();
                  },
                  value: c.selectedDestination,
                  isRequired: c.selectedDestination == null ? true : false,
                  readOnly: false,
                  hintText: c.isLoadDestination
                      ? "Loading..."
                      : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? Colors.black
                            : warningColor,
                      ),
                ),
                // textStyle: Theme.of(context).textTheme.titleSmall),
                CustomTextFormField(
                  controller: c.phone,
                  hintText: 'No. Telp'.tr,
                  inputType: TextInputType.phone,
                  isRequired: true,
                  validator: ValidationBuilder().maxLength(15).phone().build(),
                ),
                CustomTextFormField(
                  controller: c.whatsAppPhone,
                  hintText: 'No. WhatsApp'.tr,
                  inputType: TextInputType.phone,
                  isRequired: true,
                  validator: ValidationBuilder().maxLength(15).phone().build(),
                ),
                CustomTextFormField(
                  controller: c.email,
                  hintText: 'Email'.tr,
                  inputType: TextInputType.emailAddress,
                  isRequired: true,
                  inputFormatters: const [],
                  validator: ValidationBuilder().maxLength(64).email().build(),
                )
              ],
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
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
