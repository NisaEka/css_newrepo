import 'package:flutter/material.dart';

class ChangePinState {
  final formKey = GlobalKey<FormState>();
  final oldPin = TextEditingController();
  final newPin = TextEditingController();
  final confPin = TextEditingController();

  bool isObscureOldPin = true;
  bool isObscureNewPin = true;
  bool isObscurePinConfirm = true;

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );

  Widget showNewIcon = const Icon(
    Icons.remove_red_eye,
  );

  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
  );
}
