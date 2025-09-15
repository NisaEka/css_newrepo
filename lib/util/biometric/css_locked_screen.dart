import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/biometric/app_session.dart';
import 'package:css_mobile/util/biometric/biometric_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CssLockedScreen extends StatefulWidget {
  const CssLockedScreen({super.key});

  @override
  State<CssLockedScreen> createState() => _CssLockedScreenState();
}

class _CssLockedScreenState extends State<CssLockedScreen> {
  bool _authInProgress = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAuth());
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
                  if (_authInProgress) const CircularProgressIndicator(),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _authInProgress ? null : _startAuth,
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: Text('Coba Lagi'.tr),
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
