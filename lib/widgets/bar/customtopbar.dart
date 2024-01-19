import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final Size? height;
  final double elevation;
  final Widget? flexibleSpace;
  final String? screenTittle;

  const CustomTopBar({
    Key? key,
    this.title,
    this.leading,
    this.action,
    this.height,
    this.elevation = 0,
    this.flexibleSpace,
    this.screenTittle,
  }) : super(key: key);

  @override
  Size get preferredSize => flexibleSpace != null ? Size.fromHeight(215) : Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      title: title,
      leading: leading ?? const CustomBackButton(),
      actions: action ??
          [
            Transform.flip(
              flipY: true,
              child: SvgPicture.asset(ImageConstant.vector4),
            ),
          ],
      flexibleSpace: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100, left: 20),
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: screenTittle != null
                ? Text(screenTittle!.tr, style: appTitleTextStyle.copyWith(color: greyDarkColor1))
                : SizedBox(),
          ),
          flexibleSpace ?? const SizedBox(),

        ],
      ),
    );
  }
}
