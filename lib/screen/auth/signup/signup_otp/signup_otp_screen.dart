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
                body: _bodyContent(controller, context),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }

  Widget _bodyContent(SignUpOTPController c, BuildContext context) {
    return ListView(
      children: [
        const LogoHeader(),
        Form(
          key: c.formKey,
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Kode OTP sudah dikirimkan ke alamat email berikut :'.tr),
                Text(c.getMail(), textAlign: TextAlign.left, style: formLabelTextStyle),
                Pinput(
                  controller: c.otpPin,
                  length: 6,
                  focusNode: c.focusNode,
                  defaultPinTheme: c.defaultPinTheme,
                  showCursor: true,
                  cursor: c.cursor,
                  preFilledWidget: c.preFilledWidget,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 50),
                Obx(
                  () => Center(
                    child: Text(c.remainingSeconds != 0 ? c.time.value : '00.00'),
                  ),
                ),
                TextButton(
                  onPressed: () => c.remainingSeconds == 0 ? c.resendPin() : null,
                  child: Text(
                    'Kirim ulang kode'.tr,
                    style: formLabelTextStyle.copyWith(
                      color: c.remainingSeconds != 0 ? greyColor : blueJNE,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                CustomFilledButton(
                  color: blueJNE,
                  title: 'Selanjutnya'.tr,
                  // radius: 50,
                  onPressed: () => c.pinConfirmation(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
