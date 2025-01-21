import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/bar/logoheader.dart';
import 'package:css_mobile/screen/auth/forgot_password/password_recovery/password_recovery_controller.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordRecoveryController>(
        init: PasswordRecoveryController(),
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

  Widget _bodyContent(PasswordRecoveryController c, BuildContext context) {
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
                color: c.recovery == 1 ? primaryColor(context) : greyColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: 1,
                  groupValue: c.recovery,
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: Get.width / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Kode OTP akan dikirimkan ke alamat email berikut :'
                              .tr,
                          style: Theme.of(context).textTheme.titleSmall),
                      Text(
                        c.getMail(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppConst.isLightTheme(context)
                              ? greyDarkColor1
                              : greyLightColor1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            c.recovery = 1;
            c.update();
            c.sendEmail();
          },
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: c.recovery == 2 ? primaryColor(context) : greyColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: 2,
                  groupValue: c.recovery,
                  onChanged: (value) {},
                ),
                SizedBox(
                    width: Get.width / 1.5,
                    child: Text('Hubungi sales cabang kota anda'.tr,
                        style: Theme.of(context).textTheme.titleSmall))
              ],
            ),
          ),
          onTap: () {
            c.recovery = 2;
            c.update();
          },
        ),
      ],
    );
  }
}
