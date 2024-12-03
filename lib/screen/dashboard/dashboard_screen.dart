import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_body.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/onboarding/splash_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar5.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
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
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        if (controller.state.isFirst) {
          return const SplashScreen();
        } else {
          return PopScope(
            canPop: controller.pop,
            onPopInvokedWithResult: (didPop, result) => controller.onPop(),
            child: Scaffold(
              body: const DashboardBody(),
              bottomNavigationBar: const BottomBar5(menu: 0),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniStartDocked,
              floatingActionButton: MenuIcon(
                icon: IconsConstant.add,
                margin: EdgeInsets.only(left: Get.width * 0.09, bottom: 29),
                radius: 100,
                background:
                    AppConst.isLightTheme(context) ? redJNE : warningColor,
                showContainer: false,
                onTap: () => controller.state.isLogin
                    ? Get.to(const InformasiPengirimScreen(), arguments: {})
                    : showDialog(
                        context: context,
                        builder: (context) => const LoginAlertDialog(),
                      ),
              ),
            ),
          );
        }
      },
    );
  }
}
