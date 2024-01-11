import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final Size? height;
  final double elevation;
  final Widget? flexibleSpace;

  const CustomTopBar({
    Key? key,
    this.title,
    this.leading,
    this.action,
    this.height,
    this.elevation = 0,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: greyLightColor1),
        backgroundColor: greyLightColor1,
        toolbarHeight: 100,
        // centerTitle: true,
        // title: title,
        leading: leading ?? const CustomBackButton(),
        actions: action ??
            [
              Transform.flip(
                flipY: true,
                child: SvgPicture.asset(ImageConstant.vector4),
              ),
            ],
        // flexibleSpace: Container(
        //   margin: const EdgeInsets.only(top: 50, left: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text('title', style: titleTextStyle.copyWith(color: greyDarkColor1, fontWeight: regular)),
        //       // flexibleSpace ?? const SizedBox()
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
