import 'package:css_mobile/screen/dashboard/components/dashboard_body.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/onboarding/ob1_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar4.dart';
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
          return const Ob1Screen();
        } else {
          return PopScope(
            canPop: controller.pop,
            onPopInvokedWithResult: (didPop, result) => controller.onPop(),
            child: const Scaffold(
              body: DashboardBody(),
              bottomNavigationBar: BottomBar4(menu: 0),
            ),
          );
        }
      },
    );
  }
}
