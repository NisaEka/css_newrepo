import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
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
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)
                              ),
                              child: TextButton(
                                onPressed: () {
                                  controller.pickImage();
                                },
                                child: const Text('Pilih Gambar'),
                              ),
                            ),
                            CustomTextFormField(
                              controller: controller.fullName,
                              hintText: 'Nama Lengkap',
                            ),
                            CustomTextFormField(
                              controller: controller.fullAddress,
                              hintText: 'Alamat Lengkap',
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

}