import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: blueJNE)),
          child: Image.asset(
            ImageConstant.userPic,
            height: 50,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("JONI J", style: listTitleTextStyle.copyWith(fontSize: 16)),
            Text("ALEX COLLECTION", style: sublistTitleTextStyle),
            Text("user@mail.com", style: sublistTitleTextStyle),
            Text(
              "Pemilik".tr,
              style: listTitleTextStyle,
            )
          ],
        )
      ],
    );
  }
}
