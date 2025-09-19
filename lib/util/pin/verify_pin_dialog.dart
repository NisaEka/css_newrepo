import 'package:css_mobile/util/pin/pin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPinDialog extends StatefulWidget {
  const VerifyPinDialog({super.key});

  @override
  State<VerifyPinDialog> createState() => _VerifyPinDialogState();
}

class _VerifyPinDialogState extends State<VerifyPinDialog> {
  final t = TextEditingController();
  String? err;
  bool busy = false;

  Future<void> ok() async {
    setState(() => busy = true);
    final v = await PinService.instance.verify(t.text.trim());
    if (mounted) setState(() => busy = false);
    Get.back(result: v);
  }

  @override
  Widget build(BuildContext c) => AlertDialog(
        title: Text('Masukkan PIN'.tr),
        content: TextField(
            controller: t,
            obscureText: true,
            maxLength: 8,
            keyboardType: TextInputType.number),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(
                'Batal'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: busy ? null : ok,
              child: Text(
                'Verifikasi'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        ],
      );
}
