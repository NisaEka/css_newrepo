import 'dart:convert';

import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/util/logger.dart';
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
  static const String readMessage = "read_message";
  static const String isFirstInstall = "first_install";
  static const String isFirstLogin = "first_login";
  static const String transactionTemp = "transaction_temp";
  static const String themeMode = "theme";
  static const String hiddenPhoneShipper = "hidden_phone_shipper";
  static const String isCopyLabel = "copy_label";
  static const String lastAgg = "last_aggregation_payment_date";
  static const String failedLoginAttempts = "failed_login_attempts";
  static const String loginLockedUntil = "login_locked_until";

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
    // var accessToken = await storage.read(key: token);
    // return accessToken;
    try {
      return await storage.read(key: token);
    } catch (e) {
      AppLogger.e('readAccessToken failed: $e');
      // await storage.deleteAll();
      return null;
    }
  }

  Future<String?> readRefreshToken() async {
    var rToken = await storage.read(key: refreshToken);
    return rToken;
  }

  Future<void> writeInt(String key, int value) async {
    await storage.write(key: key, value: value.toString());
  }

  Future<int?> readInt(String key) async {
    final val = await storage.read(key: key);
    if (val == null) return null;
    return int.tryParse(val);
  }

  Future<void> deleteKey(String key) async {
    await storage.delete(key: key);
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
    await storage.delete(key: readMessage);
    deleteString(StorageCore.favoriteMenu);
  }
}
