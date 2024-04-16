import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends BaseController {
  String email = Get.arguments['email'];
  bool? isChange = Get.arguments['isChange'];

  final formKey = GlobalKey<FormState>();

  int? recovery;

  String getMail() {
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    return emailcaracter;
  }
}
