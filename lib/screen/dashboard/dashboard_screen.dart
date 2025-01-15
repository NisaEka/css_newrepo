import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_body.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/onboarding/splash_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar5.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double leftPadding = screenWidth < 400
        ? Get.width * 0.08
        : screenWidth >= 400 && screenWidth < 500
            ? Get.width * 0.09
            : Get.width * 0.1;
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        if (controller.state.isFirstInstall) {
          return const SplashScreen();
        } else {
          return PopScope(
            canPop: controller.pop,
            onPopInvokedWithResult: (didPop, result) => controller.onPop(),
            child: Scaffold(
              body: const DashboardBody(),
              bottomNavigationBar: BottomBar5(
                menu: 0,
                allow: controller.state.allow,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniStartDocked,
              resizeToAvoidBottomInset: false,
              floatingActionButton: (controller.state.allow.paketmuInput ==
                              "Y" &&
                          MediaQuery.of(context).viewInsets.bottom == 0) ||
                      !controller.state.isLogin
                  ? MenuIcon(
                      // icon: IconsConstant.add,
                      icon: ImageConstant.paketmuIcon,
                      margin: EdgeInsets.only(left: leftPadding, bottom: 29),
                      radius: 100,
                      height: 65,
                      width: 65,
                      background: (AppConst.isLightTheme(context)
                          ? (controller.state.isLogin
                              ? redJNE
                              : errorLightColor2)
                          : (controller.state.isLogin
                              ? warningColor
                              : warningLightColor2)),
                      showContainer: false,
                      onTap: () => controller.onAddTransaction(context),
                    )
                  : const SizedBox(),
            ),
          );
        }
      },
    );
  }
}
