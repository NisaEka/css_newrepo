import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                        Get.to(const FacilityFormBankScreen());
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
                            CustomTextFormField(
                              controller: controller.returnAddress,
                              hintText: 'Alamat Pelanggan'.tr,
                            ),
                            CustomTextFormField(
                              controller: controller.returnPhone,
                              hintText: 'No. Telepon',
                            ),
                            CustomTextFormField(
                              controller: controller.returnWhatsAppNumber,
                              hintText: 'No. WhatsApp',
                            ),
                            CustomTextFormField(
                              controller: controller.returnResponsibleName,
                              hintText: 'Nama Penanggung Jawab',
                            ),
                            CustomDropDownField(
                              hintText: 'Jenis NPWP'.tr,
                              width: Get.width,
                              value: controller.npwpType.text,
                              items: [
                                DropdownMenuItem(
                                  value: 'PRIBADI'.tr,
                                  child: Text('Pribadi'.tr),
                                ),
                                DropdownMenuItem(
                                  value: 'PERUSAHAAN'.tr,
                                  child: Text('Perusahaan'.tr)
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
                            ),
                            CustomTextFormField(
                              controller: controller.npwpName,
                              hintText: 'Nama NPWP'.tr,
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
        });
  }

}