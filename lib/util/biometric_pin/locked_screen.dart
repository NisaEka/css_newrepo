import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/biometric_pin/locked_controller.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockedScreen extends StatelessWidget {
  const LockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LockedController>(
      init: LockedController(),
      builder: (c) {
        // ignore: deprecated_member_use
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_rounded, size: 72),
                    const SizedBox(height: 12),
                    Text('CSS Terkunci'.tr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text('Verifikasi biometrik untuk melanjutkan'.tr,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    if (c.authInProgress)
                      CircularProgressIndicator(color: primaryColor(context)),
                    if (c.error != null) ...[
                      const SizedBox(height: 12),
                      Text(c.error!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 20),
                    CustomFilledButton(
                      color: primaryColor(context),
                      title: 'Coba lagi'.tr,
                      onPressed: c.authInProgress ? null : c.startAuth,
                      prefixIcon: Icons.fingerprint_rounded,
                      width: Get.width * 0.3,
                      padding: const EdgeInsets.only(right: 5),
                    ),
                    if (c.showPinButton) ...[
                      CustomFilledButton(
                        color: primaryColor(context),
                        title: 'Gunakan PIN'.tr,
                        onPressed: c.authInProgress ? null : c.onUsePin,
                        prefixIcon: Icons.password_rounded,
                        width: Get.width * 0.35,
                        padding: const EdgeInsets.only(right: 5),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
