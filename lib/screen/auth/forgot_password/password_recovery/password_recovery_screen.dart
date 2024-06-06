import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/screen/auth/forgot_password/password_recovery/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordRecoveryController>(
        init: PasswordRecoveryController(),
        builder: (controller) {
          return Scaffold(
            body: _bodyContent(controller, context),
          );
        });
  }
  Widget _bodyContent(PasswordRecoveryController controller, BuildContext context){
    return Column(
      children: [
        const LogoHeader(),
        Container(
          margin: const EdgeInsets.all(14),
          child: Text(
            "Akun Pemulihan".tr,
            style: appTitleTextStyle.copyWith(color: greyColor),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.recovery == 1 ? blueJNE : greyColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: 1,
                  groupValue: controller.recovery,
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: Get.width / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kode OTP akan dikirimkan ke alamat email berikut :'.tr),
                      Text(controller.getMail(), textAlign: TextAlign.left, style: formLabelTextStyle),
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            controller.recovery = 1;
            controller.update();
            Get.to(
              const ForgotPasswordOTPScreen(),
              arguments: {
                'email': controller.email,
              },
            );
          },
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.recovery == 2 ? blueJNE : greyColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: 2,
                  groupValue: controller.recovery,
                  onChanged: (value) {},
                ),
                SizedBox(width: Get.width / 1.5, child: Text('Hubungi sales cabang kota anda'.tr))
              ],
            ),
          ),
          onTap: () {
            controller.recovery = 2;
            controller.update();
          },
        ),
      ],
    );
  }
}
