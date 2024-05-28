import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormReturnScreen extends StatelessWidget {

  const FacilityFormReturnScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FacilityFormReturnController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Upgrade Profil Kamu'.tr,
                  flexibleSpace: Column(
                    children: [
                      CustomStepper(
                        currentStep: 1,
                        totalStep: controller.steps.length,
                        steps: controller.steps,
                      ),
                      const SizedBox(height: 8)
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomFilledButton(
                    color: redJNE,
                    title: 'Selanjutnya'.tr,
                    onPressed: () {
                      Get.to(const FacilityFormBankScreen(), arguments: {
                        'data': controller.submitData()
                      });
                    },
                  ),
                ),
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16
                        ),
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
                                value: controller.sameWithOwner,
                                onChanged: (value) {
                                  controller.onAddressSameCheck();
                                },
                              ),
                            ),
                            CustomTextFormField(
                              controller: controller.returnAddress,
                              hintText: 'Alamat Pelanggan'.tr,
                              validator: ValidationBuilder()
                                .maxLength(128)
                                .build(),
                            ),
                            CustomSearchDropdownField<Destination>(
                              asyncItems: (String filter) => controller.getDestinationList(filter),
                              itemBuilder: (context, e, b) {
                                return GestureDetector(
                                  onTap: () => controller.update(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text(e.asFacilityFormFormat()),
                                  ),
                                );
                              },
                              itemAsString: (Destination e) => e.asFacilityFormFormat(),
                              onChanged: (value) {
                                controller.selectedDestination = value;
                                controller.update();
                              },
                              value: controller.selectedDestination,
                              isRequired: controller.selectedDestination == null ? true : false,
                              readOnly: false,
                              hintText: controller.isLoadDestination ? "Loading..." : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
                              textStyle: controller.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
                            ),
                            CustomTextFormField(
                              controller: controller.returnPhone,
                              hintText: 'No. Telepon',
                              validator: ValidationBuilder()
                                .phone()
                                .build(),
                            ),
                            CustomTextFormField(
                              controller: controller.returnWhatsAppNumber,
                              hintText: 'No. WhatsApp',
                              validator: ValidationBuilder()
                                .phone()
                                .build(),
                            ),
                            CustomTextFormField(
                              controller: controller.returnResponsibleName,
                              hintText: 'Nama Penanggung Jawab',
                              validator: ValidationBuilder()
                                .maxLength(32)
                                .build(),
                            ),
                            CustomDropDownFormField(
                              hintText: 'Jenis NPWP'.tr,
                              width: Get.width,
                              value: controller.npwpType.text,
                              items: [
                                DropdownMenuItem(
                                  value: 'PRIBADI'.tr,
                                  child: Text('Pribadi'.tr),
                                ),
                                DropdownMenuItem(
                                  value: 'BADAN USAHA'.tr,
                                  child: Text('Badan Usaha'.tr)
                                )
                              ],
                              onChanged: (value) {
                                controller.npwpType.text = value!;
                                controller.update();
                              },
                            ),
                            CustomTextFormField(
                              controller: controller.npwpNumber,
                              hintText: 'Nomor NPWP'.tr,
                              inputType: TextInputType.number,
                              validator: ValidationBuilder()
                                .minLength(15)
                                .maxLength(15)
                                .build(),
                            ),
                            CustomTextFormField(
                              controller: controller.npwpName,
                              hintText: 'Nama NPWP'.tr,
                              validator: ValidationBuilder()
                                .maxLength(32)
                                .build()
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
                                child: _imagePickerContent(context, controller)
                            ),
                          ],
                        ),
                      )
                    )
                  ],
                )
              )
            ],
          );
        });
  }

  Widget _imagePickerContent(BuildContext context, FacilityFormReturnController controller) {
    if (controller.pickedImage != null) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Image(
            image: FileImage(controller.pickedImage!),
            fit: BoxFit.fitWidth
        ),
      );
    } else {
      return TextButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Text(
          'Pilih Gambar NPWP',
          style:  sublistTitleTextStyle.copyWith(
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
      );
    }
  }

}