import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  final bool isActive;
  final String? icon;
  final Icon? menuIcon;
  final EdgeInsets? padding;
  final bool isTransparent;
  final bool showContainer;
  final double? size;
  final Color? background;
  final double? radius;
  final VoidCallback? onTap;
  final Color? iconColor;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  const MenuIcon({
    super.key,
    this.isActive = false,
    this.icon,
    this.menuIcon,
    this.padding,
    this.isTransparent = false,
    this.showContainer = true,
    this.size,
    this.background,
    this.radius,
    this.onTap,
    this.iconColor,
    this.margin,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: padding ?? const EdgeInsets.all(5),
          margin: margin ?? EdgeInsets.zero,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: (showContainer
                ? (isTransparent
                    ? Colors.transparent
                    : (isActive
                        ? (AppConst.isLightTheme(context)
                            ? blueJNE
                            : bgDarkColor)
                        : AppConst.isLightTheme(context)
                            ? blueJNEna
                            : greyColor))
                : background),
            borderRadius: BorderRadius.circular(radius ?? 10),
            border: Border.all(
              width: 3,
              strokeAlign: BorderSide.strokeAlignInside,
              color: background ??
                  ((AppConst.isDarkTheme(context)
                      ? warningColor
                      : (isTransparent ? blueJNE : Colors.transparent))),
            ),
          ),
          child: menuIcon ?? Image.asset(icon ?? '', height: size ?? 50)),
    );
  }
}
