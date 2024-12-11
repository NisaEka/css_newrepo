import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/onboarding/ob1_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming task (e.g., loading data) for the splash screen.
    // Replace this with your actual data loading logic.
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offAll(() => const Ob1Screen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              ImageConstant.logoCSS,
              width: Get.width - 100,
              color: AppConst.isDarkTheme(context) ? redJNE : blueJNE,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Powered By ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Image.asset(
                  ImageConstant.logoJNE,
                  width: 50,
                  color: AppConst.isDarkTheme(context) ? whiteColor : null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
