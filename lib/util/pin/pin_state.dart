import 'package:flutter/material.dart';

class PinState {
  final formKey = GlobalKey<FormState>();
  final pin = TextEditingController();
  final confirmPIN = TextEditingController();

  bool isObscurePin = true;
  bool isObscurePinConfirm = true;

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );
  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
  );
}
