import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/biometric_pin/pin_service.dart';
import 'package:css_mobile/screen/pengaturan/pin/pin_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends BaseController {
  final state = PinState();

  Future<void> savePin() async {
    await PinService.instance.setPin(state.pin.text.trim());
    update();

    Get.back(result: true);
  }

  Future<void> verifyPin() async {
    final verified =
        await PinService.instance.verify(state.inputPin.text.trim());
    Get.back(result: verified);
  }

  @override
  void onClose() {
    state.pin.dispose();
    state.confirmPIN.dispose();
    super.onClose();
  }

  showPin() {
    state.isObscurePin ? state.isObscurePin = false : state.isObscurePin = true;
    state.isObscurePin != false
        ? state.showIcon = const Icon(
            Icons.visibility,
          )
        : state.showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  showConfirmPin() {
    state.isObscurePinConfirm
        ? state.isObscurePinConfirm = false
        : state.isObscurePinConfirm = true;
    state.isObscurePinConfirm != false
        ? state.showConfirmIcon = const Icon(
            Icons.visibility,
          )
        : state.showConfirmIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }
}
