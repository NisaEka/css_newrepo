import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormBankScreen extends StatelessWidget {
  const FacilityFormBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormBankController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: _formAppbar(controller),
              bottomNavigationBar: _formNavBar(controller),
              body: _formBody(context, controller),
            ),
            controller.showLoadingIndicator
                ? const LoadingDialog()
                : Container(),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _formAppbar(FacilityFormBankController controller) {
    return CustomTopBar(
      title: 'Upgrade Profil Kamu'.tr,
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 2,
            totalStep: controller.steps.length,
            steps: controller.steps,
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }

  Widget _formNavBar(FacilityFormBankController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomFilledButton(
        color: controller.buttonEnabled ? redJNE : greyColor,
        title: 'Ajukan'.tr,
        onPressed: () {
          controller.submitData();
        },
      ),
    );
  }

  Widget _formBody(
      BuildContext context, FacilityFormBankController controller) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDownFormField<BankModel>(
                  hintText: 'Pilih Nama Bank'.tr,
                  width: Get.width,
                  value: controller.selectedBank,
                  items: controller.banks.map((bank) {
                    return DropdownMenuItem(
                      value: bank,
                      child: Text(bank.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.setSelectedBank(value!);
                  },
                ),
                CustomTextFormField(
                  controller: controller.accountNumber,
                  hintText: 'Nomor Rekening'.tr,
                  inputType: TextInputType.number,
                  validator: ValidationBuilder().maxLength(15).build(),
                ),
                CustomTextFormField(
                  controller: controller.accountName,
                  hintText: 'Atas Nama'.tr,
                  validator: ValidationBuilder().maxLength(32).build(),
                ),
                Container(
                  width: Get.width,
                  height: Get.width / 2,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  child: _imagePickerContent(context, controller),
                ),
                ListTile(
                  title: Text(
                    'Saya Setuju dengan Syarat & Ketentuan Pengiriman JNE'.tr,
                    textAlign: TextAlign.start,
                    style: sublistTitleTextStyle.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? greyDarkColor2
                          : greyLightColor2,
                    ),
                  ),
                  leading: Checkbox(
                    checkColor: whiteColor,
                    activeColor: redJNE,
                    value: controller.termsAndConditionsCheck,
                    onChanged: (value) {
                      controller.onTermsAndConditionsCheck();
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _imagePickerContent(
      BuildContext context, FacilityFormBankController controller) {
    if (controller.pickedImage != null) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image(
            image: FileImage(controller.pickedImage!), fit: BoxFit.fitWidth),
      );
    } else {
      return TextButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Text(
          'Pilih Gambar Buku Rekening'.tr,
          style: sublistTitleTextStyle.copyWith(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      );
    }
  }
}
