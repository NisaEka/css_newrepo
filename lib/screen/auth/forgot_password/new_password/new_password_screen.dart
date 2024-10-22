import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/components/new_pw_form.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
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
                  controller.isLoading ? const LoadingDialog() : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }


}
