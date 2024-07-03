import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/bar/versionsection.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return PopScope(
            canPop: controller.pop,
            onPopInvoked: (didPop) => Get.off(const DashboardScreen()),
            child: Stack(
              children: [
                Scaffold(
                  body: SingleChildScrollView(
                    child: _bodyContent(controller, context),
                  ),
                  bottomNavigationBar: const VersionApp(),
                ),
                controller.isLoading == true ? const LoadingDialog() : Container(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(LoginController c, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisSize: MainAxisSize.max,
      children: [
        const LogoHeader(),
        Form(
          key: c.formKey,
          onChanged: () => c.initData(),
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
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  controller: c.emailTextField,
                  hintText: "Alamat email".tr,
                  prefixIcon: const Icon(Icons.person),
                  isRequired: true,
                  // focusNode: controller.emailFocus,
                  onSubmit: (_) {},
                  validator: ValidationBuilder(localeName: c.lang).email().minLength(10).maxLength(50).build(),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(text: newValue.text.toLowerCase());
                    })
                  ],
                ),
                CustomTextFormField(
                  controller: c.passwordTextField,
                  hintText: "Kata Sandi".tr,
                  // focusNode: controller.passwordField,
                  prefixIcon: const Icon(Icons.lock),
                  isRequired: true,
                  // validator: ValidationBuilder().password().build(),
                  isObscure: c.isObscurePasswordLogin,
                  multiLine: false,
                  inputFormatters: const [],
                  // focusNode: controller.passFocus,
                  suffixIcon: IconButton(
                    icon: c.showIcon,
                    onPressed: () => c.showPassword(),
                  ),
                  onSubmit: (value) => (c.formKey.currentState?.validate() == true) ? c.doLogin(context) : null,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => c.forgotPassword(),
                    child: Text("Lupa kata sandi?".tr, style: listTitleTextStyle.copyWith(color: infoColor)),
                  ),
                ),
                CustomFilledButton(
                  color: blueJNE,
                  title: 'Masuk'.tr,
                  onPressed: () async {
                    if (c.formKey.currentState?.validate() == true) c.doLogin(context);
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
                  child: Text("Belum punya akun?".tr, style: listTitleTextStyle),
                ),
                CustomFilledButton(
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  isTransparent: true,
                  title: "Daftar".tr,
                  onPressed: () => c.register(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
