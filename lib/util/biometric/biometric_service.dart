import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  BiometricService._();
  static final instance = BiometricService._();
  final _auth = LocalAuthentication();

  Future<bool> isSupported() async {
    final supported = await _auth.isDeviceSupported();
    final canCheck = await _auth.canCheckBiometrics;
    return supported && canCheck;
  }

  Future<bool> authenticate(
      {String reason = 'Verifikasi biometrik diperlukan'}) async {
    try {
      final result = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      debugPrint("Biometric result: $result");
      return result;
    } on PlatformException catch (e) {
      debugPrint(
          "Biometric PlatformException: code=${e.code}, message=${e.message}");
      return false;
    } catch (e) {
      debugPrint("Biometric unknown error: $e");
      return false;
    }
  }

  Future<void> stopAuth() async {
    try {
      await _auth.stopAuthentication();
    } catch (_) {}
  }
}
