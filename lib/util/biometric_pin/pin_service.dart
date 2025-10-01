import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:css_mobile/data/storage_core.dart';

class PinService {
  PinService._();
  static final instance = PinService._();
  final storage = StorageCore();

  Future<bool> hasPin() async =>
      (await storage.readString(StorageCore.pinHash)).isNotEmpty;

  Future<void> setPin(String pin) async {
    final salt = base64UrlEncode(
        List<int>.generate(16, (_) => Random.secure().nextInt(256)));
    final hash = _hash(pin, salt);
    await storage.writeString(StorageCore.pinSalt, salt);
    await storage.writeString(StorageCore.pinHash, hash);
  }

  Future<bool> verify(String pin) async {
    final salt = await storage.readString(StorageCore.pinSalt);
    final saved = await storage.readString(StorageCore.pinHash);
    if (salt.isEmpty || saved.isEmpty) return false;
    return _hash(pin, salt) == saved;
  }

  Future<bool> changePin(
      {required String oldPin, required String newPin}) async {
    final changePin = await verify(oldPin);
    if (!changePin) return false;
    await setPin(newPin);
    return true;
  }

  String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt:$pin')).toString();
}
