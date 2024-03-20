import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignUpOTPController extends BaseController {
  String email = Get.arguments['email'];
  String mail = '';
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final otpPin = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: titleTextStyle.copyWith(color: redJNE),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.5, color: greyColor),
      ),
    ),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: blueJNE,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          // color: blueJNE,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  Timer? _timer;
  int remainingSeconds = -1;
  final time = '01.00'.obs;

  @override
  void onReady() {
    _startTimer(60);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  String getMail() {
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    return emailcaracter;
  }

  Future<void> pinConfirmation() async {
    isLoading = true;
    try {
      await auth.postRegistPinConfirm(InputPinconfirmModel(email: email, pin: otpPin.text)).then((value) {
        if (value.code == 201) {
          Get.to(SuccessScreen(
            message: "Selamat, kamu sudah berhasil mendaftar".tr,
            buttonTitle: "Masuk",
            nextAction: () => Get.offAll(const LoginScreen()),
          ));
        } else{
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: whiteColor,
              ),
              message: 'PIN tidak sesuai'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: errorColor,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }

  Future<void> resendPin() async {
    isLoading = true;
    try {
      await auth.postRegistPinResend(InputPinconfirmModel(email: email)).then((value) {
        if (value.code == 201) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.info,
                color: whiteColor,
              ),
              message: 'Silahkan cek email anda'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    update();
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
        update();
      }
    });
  }
}
