import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_terms_and_conditions_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/profile/image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
            controller.pickImageFailed
                ? MessageInfoDialog(
                    message:
                        'Gagal mengambil gambar. Periksa kembali ukuran file gambar. File tidak bisa lebih dari 2MB'
                            .tr,
                    onClickAction: () => controller.onRefreshPickImageState(),
                  )
                : Container(),
            controller.postDataFailed
                ? MessageInfoDialog(
                    message: 'Gagal menyimpan data.',
                    onClickAction: () => controller.onRefreshPostDataState(),
                  )
                : Container(),
            controller.postFileFailed
                ? MessageInfoDialog(
                    message: 'Gagal menyimpan file.',
                    onClickAction: () => controller.onRefreshPostDataState(),
                  )
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
                ImagePickerContainer(
                  containerTitle: 'Pilih Gambar Buku Rekening',
                  pickedImagePath: controller.pickedImagePath,
                  onPickImage: () => controller.pickImage(),
                ),
                ListTile(
                  onTap: () => Get.to(
                    () => FacilityTermsAndConditionsScreen(
                      contentText: controller.termsAndConditions,
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: 'Saya Setuju dengan ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Syarat & Ketentuan',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: redJNE),
                        ),
                        TextSpan(
                          text: ' Pengiriman JNE',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
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
}
