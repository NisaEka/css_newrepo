import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  bool isObscurePasswordLogin = false;
  Locale? lang;

  @override
  void onInit() {
    super.onInit();
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );


  void doLogin(){
    print("login");
  }

}