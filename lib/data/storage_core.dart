import 'dart:convert';

import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageCore {
  final storage = const FlutterSecureStorage();
  static const String localeApp = "locale";
  static const String token = 'token';
  static const String refreshToken = 'refresh_token';
  static const String userMenu = 'user_menu';
  static const String allowedMenu = 'allowed_menu';
  static const String favoriteMenu = 'favorite_menu';
  static const String shipper = 'shipper';
  static const String accounts = 'accounts';
  static const String draftTransaction = 'transaction_drafts';
  static const String dropshipper = 'dropshipper';
  static const String receiver = 'receiver';
  static const String basicProfile = 'user_profil';
  static const String ccrfProfile = 'ccrf_profil';
  static const String officerProfile = 'officer_profil';
  static const String transactionLabel = "transaction_label";
  static const String shippingCost = "shipping_const";
  static const String fcmToken = "fcm_token";
  static const String unreadMessage = "unread_message";
  static const String isFirst = "first_install";
  static const String transactionTemp = "transaction_temp";
  static const String themeMode = "theme";

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

  Future<void> saveToken(
    String? t,
    MenuModel? m,
    String? rt,
  ) async {
    await storage.write(key: token, value: t);
    await storage.write(key: refreshToken, value: rt);
    await storage.write(key: userMenu, value: jsonEncode(m));
  }

  Future<String?> readAccessToken() async {
    var accessToken = await storage.read(key: token);
    return accessToken;
  }

  Future<String?> readRefreshToken() async {
    var rToken = await storage.read(key: refreshToken);
    return rToken;
  }

  void deleteLogin() async {
    await storage.delete(key: token);
    await storage.delete(key: allowedMenu);
    await storage.delete(key: userMenu);
    await storage.delete(key: refreshToken);
    await storage.delete(key: shipper);
    await storage.delete(key: accounts);
    await storage.delete(key: draftTransaction);
    await storage.delete(key: dropshipper);
    await storage.delete(key: receiver);
    await storage.delete(key: basicProfile);
    await storage.delete(key: transactionLabel);
    await storage.delete(key: shippingCost);
    await storage.delete(key: ccrfProfile);
    await storage.delete(key: unreadMessage);
    // await storage.delete(key: isFirst);
    deleteString(StorageCore.favoriteMenu);
  }
}
