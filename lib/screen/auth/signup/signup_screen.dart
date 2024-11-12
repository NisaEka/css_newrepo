import 'package:css_mobile/screen/auth/signup/components/signup_appbar.dart';
import 'package:css_mobile/screen/auth/signup/components/signup_form.dart';
import 'package:css_mobile/screen/auth/signup/signup_controller.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Stack(
            children: [
              const Scaffold(
                appBar: SignupAppbar(
                  child: SizedBox(),
                ),
                body: SignupForm(),
              ),
              controller.state.isLoading
                  ? const LoadingDialog()
                  : const SizedBox()
            ],
          );
        });
  }
}
