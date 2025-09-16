// lib/controllers/change_pin_controller.dart
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/pin/pin_service.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends BaseController {
  final oldC = TextEditingController();
  final newC = TextEditingController();
  final confC = TextEditingController();

  String? err;
  bool busy = false;

  Future<void> submit() async {
    final oldPin = oldC.text.trim();
    final newPin = newC.text.trim();
    final conf = confC.text.trim();

    // validasi ringkas
    if (newPin.length < 4 || newPin.length > 8) {
      err = 'PIN baru harus 4–8 digit';
      update();
      return;
    }
    if (newPin != conf) {
      err = 'Konfirmasi PIN baru tidak sama';
      update();
      return;
    }
    if (newPin == oldPin) {
      err = 'PIN baru tidak boleh sama dengan PIN lama';
      update();
      return;
    }

    busy = true;
    err = null;
    update();

    // pastikan sudah ada PIN lama
    final hasPin = await PinService.instance.hasPin();
    if (!hasPin) {
      busy = false;
      update();
      Get.snackbar('Belum ada PIN',
          'Silakan set PIN terlebih dahulu di menu pengaturan.');
      return;
    }

    // verifikasi lama + set baru
    final ok =
        await PinService.instance.changePin(oldPin: oldPin, newPin: newPin);
    busy = false;
    update();

    if (!ok) {
      err = 'PIN lama salah';
      update();
      return;
    }

    Get.back(result: true);

    AppSnackBar.success('PIN berhasil diubah'.tr, duration: 3);
  }

  @override
  void onClose() {
    oldC.dispose();
    newC.dispose();
    confC.dispose();
    super.onClose();
  }
}
