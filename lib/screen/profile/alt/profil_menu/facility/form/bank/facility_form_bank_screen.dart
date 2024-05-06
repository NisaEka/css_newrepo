import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/bank/facility_form_bank_controller.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityFormBankScreen extends StatelessWidget {

  const FacilityFormBankScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormBankController(),
      builder: (controller)  {
        return Stack(
          children: [
            Scaffold(
              appBar: CustomTopBar(
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
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomFilledButton(
                  color: redJNE,
                  title: 'Ajukan'.tr,
                  onPressed: () {
                    // TODO: Handle button action
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
                            controller: controller.accountNumber,
                            hintText: 'Nomor Rekening',
                          ),
                          CustomTextFormField(
                            controller: controller.accountName,
                            hintText: 'Atas Nama',
                          ),
                        ],
                      )
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