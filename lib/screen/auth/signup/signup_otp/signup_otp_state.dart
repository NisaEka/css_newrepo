import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupOtpState {
  String email = Get.arguments['email'];
  bool? isActivation = Get.arguments['isActivation'];
  String mail = '';
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final otpPin = TextEditingController();
  final focusNode = FocusNode();

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
