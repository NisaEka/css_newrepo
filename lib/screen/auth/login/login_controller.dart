import 'dart:async';
import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/auth_body_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_screen.dart';
import 'package:css_mobile/screen/auth/login/login_state.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final state = LoginState();
  var isFirst = true.obs;
  Timer? _lockCheckTimer;

  @override
  void onInit() async {
    super.onInit();
    initData();
    state.emailTextField.text;
    state.passwordTextField.text;
  }

  Future<void> initData() async {
    await isLoginLocked();
    state.lang = await storage.readString(StorageCore.localeApp);
    state.fcmToken = await storage.readString(StorageCore.fcmToken);
    update();
    storage.deleteLogin();
    ValidationBuilder.setLocale(state.lang!);
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );

  Future<void> doLogin(BuildContext context) async {
    if (await isLoginLocked()) return;

    state.isLoading = true;
    update();
    try {
      await auth
          .postLogin(
        AuthBodyModel(
          email: state.emailTextField.text,
          password: state.passwordTextField.text,
          device: await auth.getDeviceinfo(/*state.fcmToken ?? ''*/),
          // this location service sometimes cause error in emulator
          // NOTE: uncomment this line if you want to use location service
          coordinate: await auth.getCurrentLocation(),
        ),
      )
          .then((value) async {
        if (value.code == HttpStatus.created) {
          await resetLoginAttempts();
          await storage
              .saveToken(
                value.data?.token?.accessToken,
                value.data?.menu ?? MenuModel(),
                value.data?.token?.refreshToken,
              )
              .then((_) => Get.delete<DashboardController>())
              .then((_) => Get.offAll(() => const DashboardScreen(), arguments: {'isFromLogin': true}));
        } else if (value.code == HttpStatus.forbidden) {
          Get.dialog(
            InfoDialog(
              infoText: "Silahkan aktivasi akun terlebih dahulu".tr,
              nextButton: () => Get.off(() => const SignUpOTPScreen(), arguments: {
                'email': state.emailTextField.text,
                'isActivation': true,
              }),
            ),
          );
        } else if (value.code == HttpStatus.unauthorized) {
          await handleFailedLogin();
        } else if (value.message == "Email not verified") {
          try {
            await auth.postRegistPinResend(InputPinconfirmModel(email: state.emailTextField.text)).then((value) {
              if (value.code == HttpStatus.created) {
                AppSnackBar.success('Silahkan cek email anda'.tr);
                Get.to(() => const SignUpOTPScreen(), arguments: {
                  'email': state.emailTextField.text,
                  'isActivation': true,
                });
              }
            });
          } catch (e) {
            AppLogger.e('error resend pin $e');
          }
        } else {
          AppSnackBar.error(value.message ?? value.error ?? "Bad Request".tr);
        }
      });
    } catch (e) {
      AppLogger.e('error login $e');
      AppSnackBar.error('Login failed: ${'check_connection'.tr}');
    }
    state.isLoading = false;
    update();
  }



  Future<bool> isLoginLocked() async {
    final lockedUntil = await storage.readInt(StorageCore.loginLockedUntil);
    if (lockedUntil != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now < lockedUntil) {
        state.isLoginLocked = true;
        update();

        _lockCheckTimer?.cancel();
        _lockCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
          final current = DateTime.now().millisecondsSinceEpoch;
          if (current >= lockedUntil) {
            state.isLoginLocked = false;
            await storage.deleteKey(StorageCore.loginLockedUntil);
            await storage.deleteKey(StorageCore.failedLoginAttempts);
            update();
            timer.cancel();
          }
        });

        return true;
      } else {
        await storage.deleteKey(StorageCore.loginLockedUntil);
        await storage.deleteKey(StorageCore.failedLoginAttempts);
        state.isLoginLocked = false;
        update();
      }
    } else {
      state.isLoginLocked = false;
      update();
    }
    return false;
  }

  Future<void> handleFailedLogin() async {
    int attempts = await storage.readInt(StorageCore.failedLoginAttempts) ?? 0;
    attempts++;

    if (attempts >= 5) {
      final lockUntil = DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch;
      await storage.writeInt(StorageCore.loginLockedUntil, lockUntil);
      await storage.writeInt(StorageCore.failedLoginAttempts, 0);
      await isLoginLocked();
      AppSnackBar.error("Terlalu banyak percobaan gagal. Coba lagi dalam 5 menit.".tr, duration: 3);
    } else {
      await storage.writeInt(StorageCore.failedLoginAttempts, attempts);
      AppSnackBar.error("${'Login gagal'.tr} ($attempts/${'5 percobaan'.tr}).", duration: 3);
    }
  }

  Future<void> resetLoginAttempts() async {
    await storage.deleteKey(StorageCore.failedLoginAttempts);
    await storage.deleteKey(StorageCore.loginLockedUntil);
  }

  showPassword() {
    state.isObscurePasswordLogin ? state.isObscurePasswordLogin = false : state.isObscurePasswordLogin = true;
    state.isObscurePasswordLogin != false
        ? showIcon = const Icon(
            Icons.visibility,
          )
        : showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  forgotPassword() {
    state.emailTextField.clear();
    state.passwordTextField.clear();
    Get.to(
      () => const InputEmailScreen(),
      arguments: {'isChange': false},
    );
  }

  register() {
    state.emailTextField.clear();
    state.passwordTextField.clear();
    Get.to(() => const SignUpScreen())?.then(
      (_) => state.formKey.currentState?.reset(),
    );
  }
}
