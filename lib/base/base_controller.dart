import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final authRepository = Get.find<AuthRepository>();
  final transaction = Get.find<TransactionRepository>();
  final storage = Get.find<StorageCore>();

}