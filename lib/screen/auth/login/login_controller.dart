import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  final emailFieldKey = GlobalKey<FormFieldState>();
  final passFieldKey = GlobalKey<FormFieldState>();

  bool isObscurePasswordLogin = true;
  bool isLoading = false;
  Locale? lang;
  DateTime? currentBackPressTime;

  @override
  void onClose() {
    super.onClose();
    emailTextField.dispose();
    passwordTextField.dispose();
    emailFocus.dispose();
    passFocus.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    emailTextField.dispose();
    passwordTextField.dispose();
    emailFocus.dispose();
    passFocus.dispose();
  }

  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Get.showSnackbar(GetSnackBar(
  //       message: exit_warning,
  //     ));
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );

  Future<void> doLogin() async {
    isLoading = true;
    update();
    try {
      await auth
          .postLogin(
        InputLoginModel(
          email: emailTextField.text,
          password: passwordTextField.text,
          device: await getDeviceinfo(),
          coordinate: await getCurrentLocation(),
        ),
      )
          .then((value) async {
        if (value.code == 200) {
          await storage
              .saveToken(
                value.payload?.token ?? '',
                value.payload?.allowedMenu ?? AllowedMenu(),
              )
              .then((_) => Get.delete<DashboardController>())
              .then((_) => Get.offAll(const DashboardScreen()));

          // Get.showSnackbar(
          //   GetSnackBar(
          //     icon: const Icon(
          //       Icons.info,
          //       color: Colors.white,
          //     ),
          //     message: value.message.toString(),
          //     isDismissible: true,
          //     duration: const Duration(seconds: 3),
          //     backgroundColor: successColor,
          //   ),
          // );
        } else {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.error,
                color: Colors.white,
              ),
              message: value.message.toString(),
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     icon: Icon(
      //       Icons.error,
      //       color: Colors.white,
      //     ),
      //     message: 'Email or Password is not valid',
      //     isDismissible: true,
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
    isLoading = false;
    update();
    // Get.offAll(DashboardScreen());
  }

  Future<Device?> getDeviceinfo() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var systemName = iosDeviceInfo.systemName;
      var version = iosDeviceInfo.systemVersion;

      return Device(
        deviceId: iosDeviceInfo.identifierForVendor,
        deviceVersion: '$systemName $version',
      );
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var release = androidDeviceInfo.version.release;
      return Device(
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, lng: position.longitude);
  }
}
