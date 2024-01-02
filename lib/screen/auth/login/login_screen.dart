import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/reusable/forms/customfilledbutton.dart';
import 'package:css_mobile/reusable/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: Get.height / 5),
                  Center(
                    child: Image.asset(ImageConstant.logoCSS, height: 67),
                  ),
                  // CustomFilledButton(color: Colors.blue, title: "en", onPressed: () => Get.updateLocale(Locale("en", "US")),),
                  // SizedBox(height: 20,),
                  // CustomFill edButton(color: Colors.blue, title: "id", onPressed: () => Get.updateLocale(Locale("id", "ID")),),
                  Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            controller: controller.emailTextField,
                            hintText: "Alamat email / Nama pengguna".tr,
                            prefixIcon: const Icon(Icons.person),
                            isRequired: true,
                            validator: ValidationBuilder().email().minLength(10).build(),
                          ),
                          CustomTextFormField(
                            controller: controller.passwordTextField,
                            hintText: "Kata Sandi".tr,
                            prefixIcon: const Icon(Icons.lock),
                            isRequired: true,
                            validator: ValidationBuilder().password().build(),
                            isObscure: controller.isObscurePasswordLogin,
                            multiLine: false,
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
                              // onPressed: () => Get.to(const ForgotPasswordScreen()),
                              onPressed: () {},
                              child: Text("Lupa kata sandi?".tr,
                                  style: listTitleTextStyle.copyWith(color: infoColor, decoration: TextDecoration.underline)),
                            ),
                          ),
                          CustomFilledButton(
                            color: blueJNE,
                            radius: 20,
                            title: 'Masuk'.tr,
                            onPressed: () async {
                              // if (controller.formKey.currentState?.validate() == true) controller.doLogin();
                              controller.doLogin();
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text("Belum punya akun?".tr, style: listTitleTextStyle),
                          ),
                          CustomFilledButton(
                            color: Colors.transparent,
                            borderColor: blueJNE,
                            fontColor: blueJNE,
                            radius: 20,
                            title: "Daftar".tr,
                            onPressed: () {},
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SizedBox(height: 135, child: SvgPicture.asset(ImageConstant.vector1, fit: BoxFit.fill,)),
          );
        });
  }
}
