import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/screen/auth/forgot_password/new_password/new_password_screen.dart';
import 'package:css_mobile/screen/auth/forgot_password/password_recovery/password_recovery_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordOTPController extends BaseController {
  String email = Get.arguments['email'];
  bool? isChange = Get.arguments['isChange'];
  bool isLoading = false;
  bool isLogin = false;
  final formKey = GlobalKey<FormState>();
  final otpPin = TextEditingController();
  final focusNode = FocusNode();

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
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
    _startTimer(120);
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
    cekToken();
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
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
        update();
      }
    });
  }

  String getMail() {
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    return emailcaracter;
  }

  Future<void> pinConfirmation() async {
    isLoading = true;
    update();
    try {
      await auth
          .postPasswordPinConfirm(InputPinconfirmModel(
        email: email,
        pin: otpPin.text,
      ))
          .then((value) {
        if (value.code == 201) {
          Get.to(
            () => const NewPasswordScreen(),
            arguments: {
              'token': value.data?.token ?? '',
              'isChange': isChange,
            },
          );
        } else {
          AppSnackBar.error('PIN tidak sesuai'.tr);
        }
      });
    } catch (e) {
      AppLogger.e('error pinConfirmation $e');
    }

    isLoading = false;
    update();
  }

  Future<void> resendPin() async {
    otpPin.clear();
    isLoading = true;
    update();
    _startTimer(120);

    try {
      await auth.postEmailForgotPassword(email).then((value) {
        if (value.code == 201) {
          AppSnackBar.success('Silahkan cek email anda'.tr);
        }
      });
    } catch (e) {
      AppLogger.e('error resendPin $e');
    }

    isLoading = false;
    update();
  }

  Future<bool> cekToken() async {
    String? token = await storage.readAccessToken();
    // AppLogger.i('token : $token');
    isLogin = token != null;
    update();

    return isLogin;
  }

  Future<void> useOtherMethod(BuildContext context) async {
    isLoading = true;
    update();
    if (isLogin) {
      var basic = await profil.getBasicProfil();

      if ((basic.data?.user?.emailRecovery?.isNotEmpty ?? false)) {
        Get.off(() => const PasswordRecoveryScreen(), arguments: {
          'email': basic.data?.user?.emailRecovery,
          'isChange': isChange,
        });
      } else {
        Get.dialog(
          const InfoDialog(
            infoText: "Akun recovery belum tersedia",
          ),
        );
      }
    } else {}

    isLoading = false;
    update();
  }
}
