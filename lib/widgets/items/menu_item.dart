import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final String menuTitle;
  final String? menuImg;
  final Icon? menuIcon;
  final VoidCallback? onTap;
  final bool isActive;

  const MenuItem({
    super.key,
    required this.menuTitle,
    this.menuImg,
    this.onTap,
    this.menuIcon,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isActive ? blueJNE : blueJNE.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              // child: Icon(Icons.more_horiz),
              child: menuIcon ??
                  Image.asset(
                    menuImg ?? '',
                    height: Get.width / 9,
                  ),
            ),
            SizedBox(
              // width: 65,
              child: Text(
                menuTitle.splitMapJoin(' ', onMatch: (p0) => '\n'),
                style: sublistTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
