import 'package:css_mobile/data/model/notification/get_notification_model.dart';

abstract class NotificationRepository {
  Future<GetNotificationModel> getNotificationsList();
}
