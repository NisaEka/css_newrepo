import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOTPForm extends StatelessWidget {
  const ForgotPasswordOTPForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordOTPController>(
        init: ForgotPasswordOTPController(),
        builder: (c) {
          return Form(
            key: c.formKey,
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Kode OTP sudah dikirimkan ke alamat email berikut :'.tr),
                  Text(c.getMail(),
                      textAlign: TextAlign.left,
                      style: formLabelTextStyle.copyWith(
                          color: AppConst.isLightTheme(context)
                              ? greyDarkColor2
                              : greyLightColor2)),
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
                    onChanged: (value) => c.update(),
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => Center(
                      child: Text(
                          c.remainingSeconds != 0 ? c.time.value : '00.00'),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        c.remainingSeconds == 0 ? c.resendPin() : null,
                    child: Text(
                      'Kirim ulang kode'.tr,
                      style: formLabelTextStyle.copyWith(
                        color: c.remainingSeconds != 0
                            ? greyColor
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomFilledButton(
                    color: c.otpPin.text.isNotEmpty && c.otpPin.length >= 6
                        ? blueJNE
                        : greyColor,
                    title: 'Selanjutnya'.tr,
                    // radius: 50,
                    onPressed: () =>
                        c.otpPin.text.isNotEmpty && c.otpPin.length >= 6
                            ? c.pinConfirmation()
                            : null,
                  ),
                  c.isLogin
                      ? CustomFilledButton(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                          isTransparent: true,
                          title: 'Gunakan cara lain'.tr,
                          onPressed: () => c.useOtherMethod(context),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
  }
}
