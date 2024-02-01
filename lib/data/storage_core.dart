import 'dart:convert';

import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageCore {
  final storage = const FlutterSecureStorage();
  static const String localeApp = "locale";
  static const String token = 'token';
  static const String allowedMenu = 'allowed_menu';
  static const String favoriteMenu = 'favorite_menu';
  static const String shipper = 'shipper';
  static const String accounts = 'accounts';
  static const String draftTransaction = 'transaction_drafts';
  static const String dropshipper = 'dropshipper';
  static const String receiver = 'receiver';

  Future<void> writeString(String key, dynamic value) async {
    return await storage.write(key: key, value: value);
  }

  Future<String> readString(String key) async {
    return await storage.read(key: key) ?? "";
  }

  Future<void> saveData(String key, dynamic data) async {
    await storage.write(key: key, value: jsonEncode(data));
  }

  Future<dynamic> readData(String key) async {
    return jsonDecode(await storage.read(key: key) ?? '{}');
  }

  void deleteString(String key) async {
    await storage.delete(key: key);
  }

  Future<void> saveToken(String token, AllowedMenu allowedMenu) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'allowed_menu', value: jsonEncode(allowedMenu).toString());
  }

  Future<String?> readToken() async {
    var token = await storage.read(key: 'token');
    return token;
  }

  void deleteToken() async {
    await storage.delete(key: 'token');
  }
}
