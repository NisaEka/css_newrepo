import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/signup/components/signup_otp_form.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignUpOTPScreen extends StatelessWidget {
  const SignUpOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpOTPController>(
        init: SignUpOTPController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                body: ListView(
                  children: const [LogoHeader(), SignupOtpForm()],
                ),
              ),
              controller.state.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
