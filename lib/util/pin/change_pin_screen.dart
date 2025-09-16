// lib/screens/change_pin_screen.dart
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/pin/change_pin_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePinController>(
      init: ChangePinController(),
      builder: (c) => Scaffold(
        appBar: AppBar(title: const Text('Ubah PIN')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: c.oldC,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(labelText: 'PIN lama'),
              ),
              TextField(
                controller: c.newC,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(labelText: 'PIN baru'),
              ),
              TextField(
                controller: c.confC,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(labelText: 'Ulangi PIN baru'),
              ),
              if (c.err != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child:
                      Text(c.err!, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 12),
              CustomFilledButton(
                color: primaryColor(context),
                title: 'Simpan'.tr,
                onPressed: c.busy ? null : c.submit,
                width: Get.width * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
