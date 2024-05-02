import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_controller.dart';
import 'package:css_mobile/screen/auth/forgot_password/password_recovery/password_recovery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  const ForgotPasswordOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordOTPController>(
        init: ForgotPasswordOTPController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LogoHeader(),
                      Form(
                        key: controller.formKey,
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Kode OTP sudah dikirimkan ke alamat email berikut :'.tr),
                              Text(controller.getMail(),
                                  textAlign: TextAlign.left,
                                  style: formLabelTextStyle.copyWith(
                                      color: Theme.of(context).brightness == Brightness.light ? greyDarkColor2 : greyLightColor2)),
                              Pinput(
                                controller: controller.otpPin,
                                length: 6,
                                focusNode: controller.focusNode,
                                defaultPinTheme: controller.defaultPinTheme,
                                showCursor: true,
                                cursor: controller.cursor,
                                preFilledWidget: controller.preFilledWidget,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) => controller.update(),
                              ),
                              const SizedBox(height: 50),
                              Obx(
                                () => Center(
                                  child: Text(controller.remainingSeconds != 0 ? controller.time.value : '00.00'),
                                ),
                              ),
                              TextButton(
                                onPressed: () => controller.remainingSeconds == 0 ? controller.resendPin() : null,
                                child: Text(
                                  'Kirim ulang kode'.tr,
                                  style: formLabelTextStyle.copyWith(
                                      color: controller.remainingSeconds != 0
                                          ? greyColor
                                          : Theme.of(context).brightness == Brightness.light
                                              ? blueJNE
                                              : greyLightColor2),
                                ),
                              ),
                              const SizedBox(height: 60),
                              CustomFilledButton(
                                color: controller.otpPin.text.isNotEmpty && controller.otpPin.length >= 6 ? blueJNE : greyColor,
                                title: 'Selanjutnya'.tr,
                                // radius: 50,
                                onPressed: () =>
                                    controller.otpPin.text.isNotEmpty && controller.otpPin.length >= 6 ? controller.pinConfirmation() : null,
                              ),
                              CustomFilledButton(
                                color: Theme.of(context).brightness == Brightness.light ? blueJNE : whiteColor,
                                isTransparent: true,
                                title: 'Gunakan cara lain'.tr,
                                onPressed: () => Get.to(const PasswordRecoveryScreen(), arguments: {
                                  'email': controller.email,
                                  'isChange': controller.isChange,
                                }),
                              )
                            ],
                          ),
                        ),
                      )
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
