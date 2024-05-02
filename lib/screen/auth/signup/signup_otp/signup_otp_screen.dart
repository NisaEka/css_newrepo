import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
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
                            Text(controller.getMail(), textAlign: TextAlign.left, style: formLabelTextStyle),
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
                                  color: controller.remainingSeconds != 0 ? greyColor : blueJNE,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            CustomFilledButton(
                              color: blueJNE,
                              title: 'Selanjutnya'.tr,
                              // radius: 50,
                              onPressed: () => controller.pinConfirmation(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
