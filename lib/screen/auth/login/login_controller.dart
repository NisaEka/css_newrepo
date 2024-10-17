import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  FocusNode? emailFocus = FocusNode();
  FocusNode? passFocus = FocusNode();
  final emailFieldKey = GlobalKey<FormFieldState>();
  final passFieldKey = GlobalKey<FormFieldState>();

  bool isObscurePasswordLogin = true;
  bool isLoading = false;
  bool pop = false;
  String? lang;
  String? fcmToken;

  DateTime? currentBackPressTime;

  // @override
  // void onClose() {
  //   super.onClose();
  //   emailTextField.dispose();
  //   passwordTextField.dispose();
  //   emailFocus?.dispose();
  //   passFocus?.dispose();
  // }

  @override
  void onInit() async {
    super.onInit();
    initData();
    emailTextField.text;
    passwordTextField.text;
  }

  Future<void> initData() async {
    lang = await storage.readString(StorageCore.localeApp);
    fcmToken = await storage.readString(StorageCore.fcmToken);
    update();
    ValidationBuilder.setLocale(lang!);
  }

  bool onPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.info,
            color: whiteColor,
          ),
          message: 'Double click back button to exit',
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: greyColor.withOpacity(0.8),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        ),
      );
      pop = false;
      update();
      return false;
    }
    pop = true;
    update();
    Get.off(const DashboardScreen());
    return true;
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );

  Future<void> doLogin(BuildContext context) async {
    isLoading = true;
    update();
    try {
      await auth
          .postLogin(
        InputLoginModel(
          email: emailTextField.text,
          password: passwordTextField.text,
          device: await getDeviceinfo(fcmToken ?? ''),
          coordinate: await getCurrentLocation(),
        ),
      )
          .then((value) async {
        if (value.code == 201) {
          await storage
              .saveToken(
                value.data?.token?.accessToken ?? '',
                value.data?.menu ?? MenuModel(),
                value.data?.token?.refreshToken ?? '',
              )
              .then((_) async => auth
                  .postFcmToken(
                    await getDeviceinfo(fcmToken ?? '') ?? Device(),
                  )
                  .then((value) async => value.code == 201
                      ? await auth.updateDeviceInfo(
                          await getDeviceinfo(fcmToken ?? '') ?? Device(),
                        )
                      : null))
              .then((_) => Get.delete<DashboardController>())
              .then((_) => Get.offAll(const DashboardScreen()));
        } else if (value.code == 403) {
          showDialog(
            context: context,
            builder: (context) => InfoDialog(
              infoText: "Silahkan aktivasi akun terlebih dahulu".tr,
              nextButton: () => Get.off(const SignUpOTPScreen(), arguments: {
                'email': emailTextField.text,
                'isActivation': true,
              }),
            ),
          );
        } else if (value.code == 401) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.error,
                color: whiteColor,
              ),
              message: "login_failed".tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.error,
                color: whiteColor,
              ),
              message: value.message,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
      Get.showSnackbar(
        const GetSnackBar(
          icon: Icon(
            Icons.error,
            color: whiteColor,
          ),
          message: 'Connection times out',
          isDismissible: true,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
    isLoading = false;
    update();
    // Get.offAll(DashboardScreen());
  }

  Future<Device?> getDeviceinfo(String token) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var systemName = iosDeviceInfo.systemName;
      var version = iosDeviceInfo.systemVersion;

      return Device(
        fcmToken: token,
        deviceId: iosDeviceInfo.identifierForVendor,
        deviceVersion: '$systemName $version',
      );
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var release = androidDeviceInfo.version.release;
      return Device(
        fcmToken: token,
        deviceId: androidDeviceInfo.id,
        deviceVersion: 'Android $release',
      );
    }
    return null;
  }

  Future cekToken() async {
    isLoading = true;
    update();
    String? token = await storage.readToken();
    debugPrint("token : $token");
    if (token != null) {
      Get.offAll(const DashboardScreen());
      // String all = await storage.readString(StorageCore.allowedMenu);
      // AllowedMenu menu = AllowedMenu.fromJson(jsonDecode(all));
      // print(menu.beranda);
    }
    isLoading = false;
    update();
  }

  Future<Coordinate> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, lng: position.longitude);
  }

  showPassword() {
    isObscurePasswordLogin ? isObscurePasswordLogin = false : isObscurePasswordLogin = true;
    isObscurePasswordLogin != false
        ? showIcon = const Icon(
            Icons.visibility,
          )
        : showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  forgotPassword() {
    // Get.delete<LoginController>();
    emailTextField.clear();
    passwordTextField.clear();
    Get.to(
      const InputEmailScreen(),
      arguments: {'isChange': false},
    );
  }

  register() {
    emailTextField.clear();
    passwordTextField.clear();
    Get.to(const SignUpScreen())?.then(
      (_) => formKey.currentState?.reset(),
    );
  }
}
