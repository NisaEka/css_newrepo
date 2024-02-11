import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AltUserInfoCard extends StatelessWidget {
  final String name;
  final String brand;
  final String mail;
  final String type;

  const AltUserInfoCard({
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
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: listTitleTextStyle.copyWith(fontSize: 16)),
              Text(brand, style: sublistTitleTextStyle),
              Text(mail, style: sublistTitleTextStyle),
              Text(type.tr, style: listTitleTextStyle,
              )
            ],
        ),
      ],
    );
  }
}
