import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/util/input_formatter/npwp_separator_input_formater.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/profile/image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormReturnScreen extends StatelessWidget {
  const FacilityFormReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormReturnController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: _appBarContent(controller),
              body: _bodyContent(controller, context),
              bottomNavigationBar: _nextButton(controller),
            ),
            controller.pickImageFailed
                ? MessageInfoDialog(
                    message: 'Gagal mengambil gambar. Periksa kembali ukuran file gambar. File tidak bisa lebih dari 2MB'.tr,
                    onClickAction: () => controller.onRefreshPickImageState(),
                  )
                : Container()
          ],
        );
      },
    );
  }

  Widget _nextButton(FacilityFormReturnController c) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomFilledButton(
        color: redJNE,
        title: 'Selanjutnya'.tr,
        onPressed: () {
          Get.to(const FacilityFormBankScreen(), arguments: {'data': c.submitData()});
        },
      ),
    );
  }

  Widget _bodyContent(FacilityFormReturnController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Ceklis bila informasi pengembalian barang sama dengan data pemohon',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                leading: Checkbox(
                  checkColor: whiteColor,
                  activeColor: redJNE,
                  value: c.sameWithOwner,
                  onChanged: (value) {
                    c.onAddressSameCheck();
                  },
                ),
              ),
              CustomTextFormField(
                controller: c.returnAddress,
                hintText: 'Alamat Pelanggan'.tr,
                validator: ValidationBuilder().maxLength(128).build(),
                readOnly: c.addressSectionReadOnly,
              ),
              // CustomSearchDropdownField<Destination>(
              //   asyncItems: (String filter) => c.getDestinationList(filter),
              //   itemBuilder: (context, e, b) {
              //     return GestureDetector(
              //       onTap: () => c.update(),
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(
              //           vertical: 12,
              //           horizontal: 16,
              //         ),
              //         child: Text(e.asFacilityFormFormat()),
              //       ),
              //     );
              //   },
              //   itemAsString: (Destination e) => e.asFacilityFormFormat(),
              //   onChanged: (value) {
              //     c.selectedDestination = value;
              //     c.update();
              //   },
              //   value: c.selectedDestination,
              //   selectedItem: c.selectedDestination?.asFacilityFormFormat(),
              //   isRequired: c.selectedDestination == null ? true : false,
              //   readOnly: c.addressSectionReadOnly,
              //   hintText: c.isLoadDestination ? "Loading..." : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
              //   textStyle: c.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
              // ),
              CustomTextFormField(
                controller: c.returnPhone,
                hintText: 'No. Telepon',
                validator: ValidationBuilder().phone().build(),
                readOnly: c.addressSectionReadOnly,
              ),
              CustomTextFormField(
                controller: c.returnWhatsAppNumber,
                hintText: 'No. WhatsApp',
                validator: ValidationBuilder().phone().build(),
                readOnly: c.addressSectionReadOnly,
              ),
              CustomTextFormField(
                controller: c.returnResponsibleName,
                hintText: 'Nama Penanggung Jawab',
                validator: ValidationBuilder().maxLength(32).build(),
              ),
              CustomDropDownFormField(
                hintText: 'Jenis NPWP'.tr,
                width: Get.width,
                value: c.npwpType.text,
                items: [
                  DropdownMenuItem(
                    value: 'PRIBADI'.tr,
                    child: Text('Pribadi'.tr),
                  ),
                  DropdownMenuItem(
                    value: 'BADAN USAHA'.tr,
                    child: Text('Badan Usaha'.tr),
                  )
                ],
                onChanged: (value) {
                  c.npwpType.text = value!;
                  c.update();
                },
              ),
              CustomTextFormField(
                controller: c.npwpNumber,
                hintText: 'Nomor NPWP'.tr,
                inputType: TextInputType.number,
                validator: ValidationBuilder().minLength(15).build(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  NpwpSeparatorInputFormatter(),
                ],
              ),
              CustomTextFormField(
                controller: c.npwpName,
                hintText: 'Nama NPWP'.tr,
                validator: ValidationBuilder().maxLength(32).build(),
              ),
              CustomTextFormField(
                controller: c.npwpAddress,
                hintText: 'Alamat NPWP'.tr,
                validator: ValidationBuilder().minLength(4).build(),
              ),
              ImagePickerContainer(
                containerTitle: 'Pilih Gambar NPWP',
                pickedImagePath: c.pickedImageUrl,
                onPickImage: () => c.pickImage(),
              )
            ],
          ),
        ))
      ],
    );
  }

  CustomTopBar _appBarContent(FacilityFormReturnController c) {
    return CustomTopBar(
      title: 'Upgrade Profil Kamu'.tr,
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 1,
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
