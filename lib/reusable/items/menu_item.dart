import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final String menuTitle;
  final String menuImg;
  final VoidCallback? onTap;

  const MenuItem({super.key, required this.menuTitle, required this.menuImg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(menuImg, height: Get.width / 9),
            SizedBox(
                child: Text(
                  menuTitle,
                  style: sublistTitleTextStyle,
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
