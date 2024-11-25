import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuIcon extends StatelessWidget {
  final bool isActive;
  final String? icon;
  final Icon? menuIcon;
  final EdgeInsets? padding;
  final bool isTransparent;

  const MenuIcon({
    super.key,
    this.isActive = false,
    this.icon,
    this.menuIcon,
    this.padding,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isTransparent
            ? Colors.transparent
            : (isActive
                ? (AppConst.isLightTheme(context) ? blueJNE : bgDarkColor)
                : AppConst.isLightTheme(context)
                    ? blueJNEna
                    : greyColor),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 3,
          strokeAlign: BorderSide.strokeAlignInside,
          color: (AppConst.isDarkTheme(context)
              ? infoColor
              : (isTransparent ? blueJNE : Colors.transparent)),
        ),
      ),
      child: menuIcon ??
          Stack(
            children: [
              Icon(
                CupertinoIcons.cube,
                size: 50,
                color: AppConst.isLightTheme(context)
                    ? (isTransparent ? blueJNE : whiteColor)
                    : infoColor,
              ),
              Positioned(
                bottom: 3,
                right: 0,
                child: Container(
                  width: 20,
                  height: 22,
                  color: isActive
                      ? (AppConst.isLightTheme(context)
                          ? (isTransparent ? whiteColor : blueJNE)
                          : bgDarkColor)
                      : AppConst.isLightTheme(context)
                          ? (isTransparent ? whiteColor : blueJNEna)
                          : greyColor,
                  child: SvgPicture.asset(
                    icon ?? '_',
                    //   IconData( int.parse('0xE04F'), fontFamily: 'MaterialIcons'),
                    color: AppConst.isLightTheme(context)
                        ? (isTransparent ? blueJNE : whiteColor)
                        : infoColor,
                  ),
                ),
              )
            ],
          ),
    );
  }
}
