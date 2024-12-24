import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : bgDarkColor,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            ImageConstant.logoCSS,
            height: 30,
            width: Get.width,
            color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
          ),
          const SizedBox(height: 5),
          Text(
            'Akses Terbatas'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: regular),
            // style: TextStyle(
            //     color: AppConst.isLightTheme(context)
            //         ? greyDarkColor2
            //         : greyLightColor2)),
          )
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          textAlign: TextAlign.center,
          'access_denied'.tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: regular),
        ),
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFilledButton(
              radius: 50,
              margin: EdgeInsets.zero,
              isTransparent: true,
              color: primaryColor(context),
              title: 'Daftar'.tr,
              onPressed: () {
                Get.off(() => const SignUpScreen());
              },
            ),
            CustomFilledButton(
              radius: 50,
              color: primaryColor(context),
              title: 'Masuk'.tr,
              onPressed: () {
                Get.off(() => const LoginScreen());
              },
            ),
          ],
        ),
        // TextButton(
        //     style: TextButton.styleFrom(
        //       textStyle: Theme.of(context).textTheme.labelLarge,
        //     ),
        //     onPressed: onBack ?? () => Get.back(),
        //     child: Text(
        //       'Tidak'.tr,
        //       style: TextStyle(
        //           color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
        //     )),
        // TextButton(
        //   style: TextButton.styleFrom(
        //     textStyle: Theme.of(context).textTheme.labelLarge,
        //   ),
        //   onPressed: onLogout,
        //   child: Text(
        //     'Keluar'.tr,
        //     style: TextStyle(
        //         color: AppConst.isLightTheme(context) ? blueJNE : infoColor),
        //   ),
        // ),
      ],
    );
  }
}
