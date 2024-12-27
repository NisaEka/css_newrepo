import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_state.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/items/registration_info_item.dart';
import 'package:get/get.dart';

class SignUpOTPController extends BaseController {
  final state = SignupOtpState();

  @override
  void onReady() {
    _startTimer(120);
    if (state.isActivation == true) {
      resendPin();
    }
    super.onReady();
  }

  @override
  void onClose() {
    if (state.timer != null) {
      state.timer!.cancel();
    }
    super.onClose();
  }

  String getMail() {
    var nameuser = state.email.split("@");
    var emailcaracter = state.email
        .replaceRange(2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    return emailcaracter;
  }

  Future<void> pinConfirmation() async {
    state.isLoading = true;
    try {
      await auth
          .postRegistPinConfirm(
              InputPinconfirmModel(email: state.email, pin: state.otpPin.text))
          .then((value) {
        if (value.code == 201) {
          Get.to(
            () => SuccessScreen(
              message: "Selamat, kamu sudah berhasil mendaftar".tr,
              customInfo: RegistrationInfoItem(
                data: state.userData,
              ),
              thirdButtonTitle: "Masuk".tr,
              onThirdAction: () => Get.offAll(() => const LoginScreen()),
            ),
          );
        } else {
          AppSnackBar.error('PIN tidak sesuai'.tr);
        }
      });
    } catch (e) {
      AppLogger.e('error signup $e');
    }

    state.isLoading = false;
    update();
  }

  Future<void> resendPin() async {
    state.isLoading = true;
    state.otpPin.clear();
    _startTimer(120);
    try {
      await auth
          .postRegistPinResend(InputPinconfirmModel(email: state.email))
          .then((value) {
        if (value.code == 201) {
          AppSnackBar.success('Silahkan cek email anda'.tr);
        } else {
          AppSnackBar.error(value.message);
        }
      });
    } catch (e, i) {
      AppLogger.e('error resend pin $e, $i');
    }

    state.isLoading = false;
    update();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    state.remainingSeconds = seconds;
    update();
    state.timer = Timer.periodic(duration, (Timer timer) {
      if (state.remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = state.remainingSeconds ~/ 60;
        int seconds = (state.remainingSeconds % 60);
        state.time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        state.remainingSeconds--;
        update();
      }
    });
  }
}
