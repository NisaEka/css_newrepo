import 'package:css_mobile/screen/auth/login/components/login_form.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return PopScope(
            canPop: controller.state.pop,
            onPopInvokedWithResult: (bool didPop, Object? result) =>
                Get.offAll(() => const DashboardScreen()),
            child: Stack(
              children: [
                const Scaffold(
                  body: SingleChildScrollView(
                    child: LoginForm(),
                  ),
                  bottomNavigationBar: VersionApp(),
                ),
                controller.state.isLoading == true
                    ? const LoadingDialog()
                    : Container(),
              ],
            ),
          );
        });
  }
}
