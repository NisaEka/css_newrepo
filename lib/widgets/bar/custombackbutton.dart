import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBackButton<T> extends StatelessWidget {
  const CustomBackButton({Key? key, this.result, this.onPressed}) : super(key: key);

  final T? result;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // return IconButton(
    //     onPressed: onPressed ?? ()=> Get.back(),
    //     icon: const Icon(
    //       Icons.arrow_circle_left,
    //       color: blueJNE,
    //       size: 40,
    //     ));
    return GestureDetector(
      onTap: onPressed ?? () => Get.back(),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          IconsConstant.arrowCircle,
          color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
        ),
      ),
    );
  }
}
