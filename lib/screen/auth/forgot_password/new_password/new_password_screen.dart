import 'package:css_mobile/screen/auth/forgot_password/components/new_pw_form.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
        init: NewPasswordController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  const NewPasswordForm(),
                  controller.isLoading
                      ? const LoadingDialog()
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}
