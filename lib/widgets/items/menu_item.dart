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
  final bool? isFavorite;
  final bool isEdit;
  final VoidCallback? onEdit;

  const MenuItem({
    super.key,
    required this.menuTitle,
    this.menuImg,
    this.onTap,
    this.menuIcon,
    this.isActive = true,
    this.isFavorite,
    this.isEdit = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                    menuTitle.splitMapJoin(' ', onMatch: (p0) => '\n').splitMapJoin('_', onMatch: (p0) => ' '),
                    style: sublistTitleTextStyle.copyWith(
                      color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : whiteColor,

                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        isEdit
            ? Positioned(
                top: -14,
                right: 3,
                child: IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    isFavorite == true ? Icons.remove_circle : Icons.add_circle_rounded,
                    color: isFavorite == true ? errorColor : successColor,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
