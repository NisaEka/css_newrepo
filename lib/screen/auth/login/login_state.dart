import 'package:flutter/material.dart';

class LoginState {
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
  bool rememberMe = false;
  bool isLoginLocked = false;
  String? lang;
  String? fcmToken;

  DateTime? currentBackPressTime;
}
