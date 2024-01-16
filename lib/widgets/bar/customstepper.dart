import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalStep;
  final List<String>? steps;

  const CustomStepper({super.key, required this.currentStep, required this.totalStep, this.steps});

  @override
  Widget build(BuildContext context) {
    List color = [blueJNE, greyColor];

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
                    // margin: const EdgeInsets.all(10),
                    // padding: EdgeInsets.all(10),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: currentStep >= index ? blueJNE : greyColor,
                        borderRadius: BorderRadius.circular(50),
                        // border: Border.all(
                        //   color: currentStep >= index ? Colors.transparent : whiteColor,
                        // ),
                        boxShadow: const [
                          BoxShadow(
                            color: redJNE,
                            spreadRadius: 1,
                            offset: Offset(3, 3),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: listTitleTextStyle.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
                  index < (totalStep - 1)
                      ? Container(
                          width: Get.width / totalStep - 20,
                          height: 1,
                          decoration: BoxDecoration(
                            color: currentStep > index ? blueJNE : greyColor,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
