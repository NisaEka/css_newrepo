import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/pengaturan/pin/change_pin_state.dart';
import 'package:css_mobile/util/biometric_pin/pin_service.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends BaseController {
  final state = ChangePinState();

  Future<void> save() async {
    final oldPin = state.oldPin.text.trim();
    final newPin = state.newPin.text.trim();

    final changePin =
        await PinService.instance.changePin(oldPin: oldPin, newPin: newPin);
    update();

    if (!changePin) {
      AppSnackBar.error('PIN lama salah'.tr, duration: 3);
      update();
      return;
    }

    Get.back(result: true);

    AppSnackBar.success('PIN berhasil diubah'.tr, duration: 3);
  }

  @override
  void onClose() {
    state.oldPin.dispose();
    state.newPin.dispose();
    state.confPin.dispose();
    super.onClose();
  }

  showPin() {
    state.isObscureOldPin
        ? state.isObscureOldPin = false
        : state.isObscureOldPin = true;
    state.isObscureOldPin != false
        ? state.showIcon = const Icon(
            Icons.visibility,
          )
        : state.showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  showNewPin() {
    state.isObscureNewPin
        ? state.isObscureNewPin = false
        : state.isObscureNewPin = true;
    state.isObscureNewPin != false
        ? state.showNewIcon = const Icon(
            Icons.visibility,
          )
        : state.showNewIcon = const Icon(
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
