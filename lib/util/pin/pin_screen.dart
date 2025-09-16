import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/pin/pin_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(
      init: PinController(),
      builder: (c) => Scaffold(
        appBar: AppBar(title: const Text('Setel PIN')),
        body: Form(
          key: c.formKey,
          onChanged: () => c.save(),
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: c.a,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  decoration: const InputDecoration(labelText: 'PIN'),
                ),
                TextField(
                  controller: c.b,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  decoration: const InputDecoration(labelText: 'Ulangi PIN'),
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
                  onPressed: c.busy ? null : c.save,
                  width: Get.width * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
