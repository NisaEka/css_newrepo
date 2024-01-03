import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalStep;
  final List<String>? steps;

  const CustomStepper(
      {super.key,
      required this.currentStep,
      required this.totalStep,
      this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalStep,
        (index) => SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: currentStep >= index ? redJNE : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: currentStep >= index
                              ? Colors.transparent
                              : whiteColor),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: listTitleTextStyle.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
                  index < (totalStep - 1)
                      ? Container(
                          width: 50,
                          height: 1,
                          decoration: BoxDecoration(color: whiteColor),
                        )
                      : SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
