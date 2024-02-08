import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      const LogoHeader(),
                      // CustomFilledButton(color: Colors.blue, title: "en", onPressed: () => Get.updateLocale(Locale("en", "US")),),
                      // SizedBox(height: 20,),
                      // CustomFill edButton(color: Colors.blue, title: "id", onPressed: () => Get.updateLocale(Locale("id", "ID")),),
                      Form(
                        key: controller.formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text(
                                'Masuk ke akun anda'.tr,
                                style: listTitleTextStyle,
                              )),
                              const SizedBox(height: 25),
                              CustomTextFormField(
                                controller: controller.emailTextField,
                                hintText: "Alamat email".tr,
                                prefixIcon: const Icon(Icons.person),
                                isRequired: true,
                                focusNode: controller.emailFocus,
                                onSubmit: (_) {},
                                validator: ValidationBuilder().email().minLength(10).build(),
                              ),
                              CustomTextFormField(
                                controller: controller.passwordTextField,
                                hintText: "Kata Sandi".tr,

                                // focusNode: controller.passwordField,
                                prefixIcon: const Icon(Icons.lock),
                                isRequired: true,
                                validator: ValidationBuilder().password().build(),
                                isObscure: controller.isObscurePasswordLogin,
                                multiLine: false,
                                focusNode: controller.passFocus,
                                suffixIcon: IconButton(
                                  icon: controller.showIcon,
                                  onPressed: () {
                                    controller.isObscurePasswordLogin
                                        ? controller.isObscurePasswordLogin = false
                                        : controller.isObscurePasswordLogin = true;
                                    controller.isObscurePasswordLogin != false
                                        ? controller.showIcon = const Icon(
                                            Icons.visibility,
                                            color: greyDarkColor1,
                                          )
                                        : controller.showIcon = const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black,
                                          );
                                    controller.update();
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Get.to(const ForgotPasswordOTPScreen()),
                                  child: Text("Lupa kata sandi?".tr, style: listTitleTextStyle.copyWith(color: infoColor)),
                                ),
                              ),
                              CustomFilledButton(
                                color: blueJNE,
                                title: 'Masuk'.tr,
                                onPressed: () async {
                                  if (controller.formKey.currentState?.validate() == true) controller.doLogin();

                                  // Get.to(const DashboardScreen());
                                },
                              ),
                              // CustomFilledButton(
                              //   color: Colors.transparent,
                              //   borderColor: blueJNE,
                              //   fontColor: blueJNE,
                              //   title: 'Masuk Tanpa Login'.tr,
                              //   onPressed: () async {
                              //     Get.offAll(const DashboardScreen());
                              //   },
                              // ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 60),
                                child: Text("Belum punya akun?".tr, style: listTitleTextStyle),
                              ),
                              CustomFilledButton(
                                // color: blueJNE,
                                color: Colors.transparent,
                                borderColor: blueJNE,
                                fontColor: blueJNE,
                                title: "Daftar".tr,
                                onPressed: () => Get.to(const SignUpScreen())?.then((_) => controller.formKey.currentState?.reset()),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: const VersionApp(),
                // bottomNavigationBar: SizedBox(
                //     height: 135,
                //     child: SvgPicture.asset(
                //       ImageConstant.vector1,
                //       fit: BoxFit.fill,
                //     )),
              ),
              controller.isLoading == true ? const LoadingDialog() : Container(),
            ],
          );
        });
  }
}
