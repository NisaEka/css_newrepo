import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  // final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final Size? height;
  final double elevation;
  final Widget? flexibleSpace;
  final String? title;
  final Color? backgroundColor;
  final bool? isOnline;

  const CustomTopBar({
    Key? key,
    // this.title,
    this.leading,
    this.action,
    this.height,
    this.elevation = 0,
    this.flexibleSpace,
    this.title,
    this.backgroundColor,
    this.isOnline,
  }) : super(key: key);

  @override
  Size get preferredSize => flexibleSpace != null
      ? const Size.fromHeight(215)
      : action?.isNotEmpty ?? false
          ? const Size.fromHeight(150)
          : const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? greyLightColor2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading ?? const CustomBackButton(),
              Transform.flip(
                flipY: true,
                child: SvgPicture.asset(ImageConstant.vector4),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 20),
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title != null ? Text(title!.tr, style: subappTitleTextStyle.copyWith(color: greyDarkColor1)) : const SizedBox(),
                Row(
                  children: action?.toList() ?? [],
                )
              ],
            ),
          ),
          flexibleSpace ?? const SizedBox(),
        ],
      ),
    );
  }
}
