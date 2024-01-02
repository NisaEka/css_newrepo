import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageCore {
  final storage = const FlutterSecureStorage();
  static const String localeApp = "locale";

  Future<void> writeString(String key, dynamic value) async {
    return await storage.write(key: key, value: value);
  }

  Future<String> readString(String key) async {
    return await storage.read(key: key) ?? "";
  }
}