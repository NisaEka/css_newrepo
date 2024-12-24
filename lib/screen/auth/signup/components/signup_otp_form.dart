import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignupOtpForm extends StatelessWidget {
  const SignupOtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpOTPController>(
        init: SignUpOTPController(),
        builder: (c) {
          return Form(
            key: c.state.formKey,
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Kode OTP sudah dikirimkan ke alamat email berikut :'.tr),
                  Text(c.getMail(),
                      textAlign: TextAlign.left, style: formLabelTextStyle),
                  Pinput(
                    controller: c.state.otpPin,
                    length: 6,
                    focusNode: c.state.focusNode,
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: titleTextStyle.copyWith(
                          color: secondaryColor(context)),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: greyColor),
                        ),
                      ),
                    ),
                    showCursor: true,
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 56,
                          height: 3,
                          decoration: BoxDecoration(
                            color: primaryColor(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    preFilledWidget: c.state.preFilledWidget,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => Center(
                      child: Text(c.state.remainingSeconds != 0
                          ? c.state.time.value
                          : '00.00'),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        c.state.remainingSeconds == 0 ? c.resendPin() : null,
                    child: Text(
                      'Kirim ulang kode'.tr,
                      style: formLabelTextStyle.copyWith(
                        color: c.state.remainingSeconds != 0
                            ? greyColor
                            : primaryColor(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomFilledButton(
                    color: primaryColor(context),
                    title: 'Selanjutnya'.tr,
                    // radius: 50,
                    onPressed: () => c.pinConfirmation(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
