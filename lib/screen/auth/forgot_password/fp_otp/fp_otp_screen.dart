import 'package:css_mobile/screen/auth/forgot_password/components/fp_otp_form.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  const ForgotPasswordOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordOTPController>(
        init: ForgotPasswordOTPController(),
        builder: (controller) {
          return Stack(
            children: [
              const Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      LogoHeader(),
                      ForgotPasswordOTPForm(),
                    ],
                  ),
                ),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
