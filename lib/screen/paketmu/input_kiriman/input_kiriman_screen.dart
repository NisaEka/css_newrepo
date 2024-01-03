import 'package:css_mobile/reusable/bar/custom_stepper.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/input_kiriman_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputKirimanScreen extends StatelessWidget {
  const InputKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputKirimanController>(
        init: InputKirimanController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Input Kiriman'.tr),
            ),
            body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  // color: blueJNE,
                  ),
              child: IKStepper(
                steps: controller.steps,
                currentStep: controller.currentStep,
                onStepContinue: () {
                  controller.currentStep = controller.currentStep + 1;
                  controller.update();
                },
                onstepCancel: () => Get.back(),
                // onStepTapped: (p0) {
                //   controller.currentStep = p0;
                //   controller.update();
                // },
              ),
              // child: CustomStepperCustomStepper(currentStep: 0, totalStep: 3),
            ),
          );
        });
  }
}
