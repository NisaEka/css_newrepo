import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/notification/notification_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class NotificationRepositoryImpl extends NotificationRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetNotificationModel> getNotificationsList() async {
    try {
      Response response = await network.base.get(
        "/apps-notification",
      );

      return GetNotificationModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetNotificationModel.fromJson(e.response?.data);
    }
  }
}
