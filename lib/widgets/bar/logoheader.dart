import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 190,
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(ImageConstant.vector2),
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: Image.asset(ImageConstant.logoCSS_blue, height: 67),
        ),
      ],
    );
  }
}
