import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/pin/pin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final pin = TextEditingController();
  final confirmPIN = TextEditingController();
  bool busy = false;
  bool isObscurePin = true;
  bool isObscurePinConfirm = true;

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );
  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
  );

  Future<void> savePin() async {
    await PinService.instance.setPin(pin.text.trim());
    update();

    Get.back(result: true);
  }

  @override
  void onClose() {
    pin.dispose();
    confirmPIN.dispose();
    super.onClose();
  }

  showPin() {
    isObscurePin ? isObscurePin = false : isObscurePin = true;
    isObscurePin != false
        ? showIcon = const Icon(
            Icons.visibility,
          )
        : showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  showConfirmPin() {
    isObscurePinConfirm
        ? isObscurePinConfirm = false
        : isObscurePinConfirm = true;
    isObscurePinConfirm != false
        ? showConfirmIcon = const Icon(
            Icons.visibility,
          )
        : showConfirmIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }
}
