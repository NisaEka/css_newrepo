import 'dart:io';
import 'dart:js';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  bool isObscurePasswordLogin = false;
  Locale? lang;
  String? deviceID;
  String? deviceVersion;
  double? lat;
  double? lng;
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );

  Future<void> doLogin() async {
    getDeviceinfo();
    // getCurrentPosition();
    try {} catch (e) {}
    // Get.offAll(DashboardScreen());
  }

  Future<void> getDeviceinfo() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var systemName = iosDeviceInfo.systemName;
      var version = iosDeviceInfo.systemVersion;
      var name = iosDeviceInfo.name;
      var model = iosDeviceInfo.model;

      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = '$systemName $version';
      // return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var release = androidDeviceInfo.version.release;
      var sdkInt = androidDeviceInfo.version.sdkInt;
      var manufacturer = androidDeviceInfo.manufacturer;
      var model = androidDeviceInfo.model;

      deviceID = androidDeviceInfo.id;
      deviceVersion = 'Android $release';
      // return androidDeviceInfo.id; // unique ID on Android
    }
    update();

    deviceID.printInfo(info: 'deviceID');
    deviceVersion.printInfo(info: 'deviceVersion');

  }

  // Future<void> getCurrentPosition() async {
  //   final hasPermission = await handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     currentPosition = position;
  //     lat = currentPosition?.latitude;
  //     lng = currentPosition?.longitude;
  //     update();
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  //   update();
  //   lat.printInfo(info: 'lat');
  //   lng.printInfo(info: 'lng');
  // }
  //
  // Future<bool> handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
  //     //     content: Text('Location services are disabled. Please enable the services')));
  //     // return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // ScaffoldMessenger.of(context as BuildContext)
  //       //     .showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
  //     //     content:
  //     //         Text('Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }
}
