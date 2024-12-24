import 'dart:async';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignupOtpState {
  String email = Get.arguments['email'];
  bool? isActivation = Get.arguments['isActivation'];
  UserModel userData = Get.arguments['userData'];
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

  Timer? timer;
  int remainingSeconds = -1;
  final time = '01.00'.obs;
}
