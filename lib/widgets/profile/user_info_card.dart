import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String brand;
  final String mail;
  final String type;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.brand,
    required this.mail,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: primaryColor(context))),
          child: Image.asset(
            ImageConstant.userPic,
            height: 50,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: listTitleTextStyle.copyWith(fontSize: 16)),
            Text(brand, style: sublistTitleTextStyle),
            Text(mail, style: sublistTitleTextStyle),
            Text(
              type.tr,
              style: listTitleTextStyle,
            )
          ],
        )
      ],
    );
  }
}
