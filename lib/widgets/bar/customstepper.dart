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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              totalStep,
              (index) => Container(
                // height: 100,
                // color: Colors.blue,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                offset: Offset(2, 0),
                              )
                            ],
                          ),
                          child: Center(
                            child: currentStep <= index
                                ? Text(
                                    '${index + 1}',
                                    style: listTitleTextStyle.copyWith(color: whiteColor),
                                  )
                                : const Icon(
                                    Icons.check,
                                    color: whiteColor,
                                  ),
                          ),
                        ),
                        index < (totalStep - 1)
                            ? Container(
                                width: Get.width / totalStep - 10,
                                height: 2,
                                margin: const EdgeInsets.only(left: 3),
                                decoration: BoxDecoration(
                                  color: currentStep > index ? blueJNE : greyColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: currentStep > index ? redJNE : Colors.transparent,
                                      spreadRadius: 1,
                                      offset: const Offset(1, -1),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              totalStep,
              (index) => Container(
                margin: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    steps?[index].tr ?? '',
                    style: sublistTitleTextStyle.copyWith(
                      color: currentStep == index
                          ? Theme.of(context).brightness == Brightness.light
                              ? blueJNE
                              : whiteColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
