import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityFormInfoScreen extends StatelessWidget {

  const FacilityFormInfoScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormInfoController(),
      builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Upgrade Profil Kamu'.tr,
                  flexibleSpace: Column(
                    children: [
                      CustomStepper(
                        currentStep: 0,
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
                      Get.to(const FacilityFormReturnScreen());
                    },
                  )
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: controller.brand,
                              hintText: 'Nama Toko / Perusahaan',
                            ),
                            CustomTextFormField(
                              controller: controller.idCardNumber,
                              hintText: 'No Identitas / KTP',
                            ),
                            Container(
                              width: Get.width,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)
                              ),
                              child: _imagePickerContent(controller)
                            ),
                            CustomTextFormField(
                              controller: controller.fullName,
                              hintText: 'Nama Lengkap',
                            ),
                            CustomTextFormField(
                              controller: controller.fullAddress,
                              hintText: 'Alamat Lengkap',
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
                              controller: controller.phone,
                              hintText: 'No. Telp',
                            ),
                            CustomTextFormField(
                              controller: controller.whatsAppPhone,
                              hintText: 'No. WhatsApp',
                            ),
                            CustomTextFormField(
                              controller: controller.email,
                              hintText: 'Email',
                            )
                          ],
                        ),
                      )
                    )
                  ],
                )
              )
            ],
          );
      },
    );
  }

  Widget _imagePickerContent(FacilityFormInfoController controller) {
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
        child: const Text('Pilih Gambar Identitas / KTP'),
      );
    }
  }

}