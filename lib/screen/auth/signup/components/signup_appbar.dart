import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupAppbar extends PreferredSize {
  const SignupAppbar({
    super.key,
    super.preferredSize = const Size.fromHeight(200),
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          const Positioned(
            left: 10,
            top: 40,
            child: CustomBackButton(),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: Get.height / 4,
              alignment: Alignment.topLeft,
              child: Transform.flip(
                flipX: true,
                child: SvgPicture.asset(ImageConstant.vector2),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Image.asset(
              ImageConstant.logoCSS,
              height: 67,
              color: CustomTheme().logoColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
