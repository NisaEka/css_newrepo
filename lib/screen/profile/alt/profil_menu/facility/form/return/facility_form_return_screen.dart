import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/util/input_formatter/npwp_separator_input_formater.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
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
              )
            ],
          );
        });
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
                  style: sublistTitleTextStyle.copyWith(
                    color: Theme.of(context).brightness == Brightness.light ? greyDarkColor2 : greyLightColor2,
                  ),
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
              ),
              CustomSearchDropdownField<Destination>(
                asyncItems: (String filter) => c.getDestinationList(filter),
                itemBuilder: (context, e, b) {
                  return GestureDetector(
                    onTap: () => c.update(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text(e.asFacilityFormFormat()),
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
                hintText: c.isLoadDestination ? "Loading..." : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
                textStyle: c.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
              ),
              CustomTextFormField(
                controller: c.returnPhone,
                hintText: 'No. Telepon',
                validator: ValidationBuilder().phone().build(),
              ),
              CustomTextFormField(
                controller: c.returnWhatsAppNumber,
                hintText: 'No. WhatsApp',
                validator: ValidationBuilder().phone().build(),
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
                  DropdownMenuItem(value: 'BADAN USAHA'.tr, child: Text('Badan Usaha'.tr))
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
              Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    ),
                  ),
                  child: _imagePickerContent(context, c)),
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

  Widget _imagePickerContent(BuildContext context, FacilityFormReturnController controller) {
    if (controller.pickedImage != null) {
      return Container(
        width: Get.width,
        height: Get.width / 2,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image(image: FileImage(controller.pickedImage!), fit: BoxFit.fitWidth),
      );
    } else {
      return TextButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Text(
          'Pilih Gambar NPWP',
          style: sublistTitleTextStyle.copyWith(
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
      );
    }
  }
}
