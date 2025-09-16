import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/pin/pin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final a = TextEditingController();
  final b = TextEditingController();

  String? err;
  bool busy = false;

  @override
  void onInit() {
    super.onInit();
    save();
  }

  Future<void> save() async {
    final p = a.text.trim(), q = b.text.trim();

    if (p.length < 4 || p.length > 8) {
      err = 'PIN 4–8 digit';
      update();
      return;
    }
    if (p != q) {
      err = 'PIN tidak cocok';
      update();
      return;
    }

    busy = true;
    err = null;
    update();
    await PinService.instance.setPin(p);
    busy = false;
    update();

    Get.back(result: true);
    // AppSnackBar.success(
    //     'PIN berhasil disimpan'.tr,
    //     duration: 3);
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );

  @override
  void onClose() {
    a.dispose();
    b.dispose();
    super.onClose();
  }
}
