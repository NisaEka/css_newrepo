import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  bool isObscurePasswordLogin = false;
  Locale? lang;
  String? version;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    update();
  }

  void doLogin() {
    Get.offAll(DashboardScreen());
  }
}
