import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/biometric/app_session.dart';
import 'package:css_mobile/util/biometric/biometric_service.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CssLockedScreen extends StatefulWidget {
  const CssLockedScreen({super.key});

  @override
  State<CssLockedScreen> createState() => _CssLockedScreenState();
}

class _CssLockedScreenState extends State<CssLockedScreen> {
  final storage = Get.find<StorageCore>();
  bool _authInProgress = false;
  String? _error;
  String local = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cekLocalLanguage();
      _startAuth();
    });
  }

  Future<void> _startAuth() async {
    if (_authInProgress) return;
    setState(() {
      _authInProgress = true;
      _error = null;
    });

    try {
      await BiometricService.instance.stopAuth();
      await Future.delayed(const Duration(milliseconds: 120));

      final ok = await BiometricService.instance.authenticate(
        reason: 'Verifikasi biometrik untuk membuka CSS'.tr,
      );

      if (ok) {
        AppSession.lockCheckedThisRun = true;
        Get.offAll(() => const DashboardScreen());
      } else {
        setState(() {
          _error = 'Autentikasi dibatalkan/gagal. Coba lagi.'.tr;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _authInProgress = false;
        });
      }
    }
  }

  Future<void> cekLocalLanguage() async {
    final stored = await storage.readString(StorageCore.localeApp);
    final device = Get.deviceLocale ?? const Locale('id', 'ID');

    String targetCode;
    Locale targetLocale;

    if (stored.isEmpty || stored == 'id_ID' || stored == 'en_US') {
      if (device.languageCode == 'id') {
        targetCode = 'id';
        targetLocale = const Locale('id', 'ID');
      } else {
        targetCode = 'en';
        targetLocale = const Locale('en', 'US');
      }
    } else if (stored == 'id') {
      targetCode = 'id';
      targetLocale = const Locale('id', 'ID');
    } else {
      targetCode = 'en';
      targetLocale = const Locale('en', 'US');
    }

    await storage.writeString(StorageCore.localeApp, targetCode);
    Get.updateLocale(targetLocale);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  if (_authInProgress)
                    CircularProgressIndicator(color: primaryColor(context)),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    color: primaryColor(context),
                    title: 'Coba lagi'.tr,
                    onPressed: _authInProgress ? null : _startAuth,
                    prefixIcon: Icons.fingerprint_rounded,
                    width: Get.width * 0.3,
                    padding: const EdgeInsets.only(right: 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
