import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class IKStepper extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final void Function(int)? onStepTapped;
  final VoidCallback? onStepContinue;
  final VoidCallback? onstepCancel;
  final StepperType type;

  const IKStepper(
      {super.key,
      required this.steps,
      required this.currentStep,
      this.onStepTapped,
      this.onStepContinue,
      this.onstepCancel,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // canvasColor: blueJNE,,
        colorScheme: const ColorScheme.light(
          primary: redJNE,
          secondary: greyLightColor1,
          background: whiteColor,
        ),
      ),
      child: Stepper(
        steps: steps,
        currentStep: currentStep,
        type: type,
        onStepTapped: onStepTapped,
        onStepContinue: onStepContinue,
        onStepCancel: onstepCancel,
        stepIconBuilder: (stepIndex, stepState) {
          return null;
        },
      ),
    );
  }
}
