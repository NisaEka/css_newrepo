import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';

class JLCPointWidget extends StatelessWidget {
  const JLCPointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: redJNE,
            spreadRadius: 1,
            offset: Offset(-2, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstant.logoJLC, height: 14),
          const Text(' 1.000 Point'),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8),
          //   child: Icon(
          //     Icons.storefront_rounded,
          //     color: whiteColor,
          //   ),
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Joni Store".tr,
          //       style: sublistTitleTextStyle.copyWith(color: whiteColor),
          //     ),
          //     Text(
          //       "Pemilik".tr,
          //       style: listTitleTextStyle.copyWith(color: whiteColor),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
