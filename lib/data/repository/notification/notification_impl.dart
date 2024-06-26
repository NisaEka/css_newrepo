import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/notification/notification_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class NotificationRepositoryImpl extends NotificationRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();
}