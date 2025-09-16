import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:css_mobile/data/storage_core.dart';

class PinService {
  PinService._();
  static final instance = PinService._();
  final _s = StorageCore();

  Future<bool> hasPin() async =>
      (await _s.readString(StorageCore.pinHash)).isNotEmpty;

  Future<void> setPin(String pin) async {
    final salt = base64UrlEncode(
        List<int>.generate(16, (_) => Random.secure().nextInt(256)));
    final hash = _hash(pin, salt);
    await _s.writeString(StorageCore.pinSalt, salt);
    await _s.writeString(StorageCore.pinHash, hash);
  }

  Future<bool> verify(String pin) async {
    final salt = await _s.readString(StorageCore.pinSalt);
    final saved = await _s.readString(StorageCore.pinHash);
    if (salt.isEmpty || saved.isEmpty) return false;
    return _hash(pin, salt) == saved;
  }

  Future<bool> changePin(
      {required String oldPin, required String newPin}) async {
    final ok = await verify(oldPin);
    if (!ok) return false;
    await setPin(newPin);
    return true;
  }

  String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt:$pin')).toString();
}
