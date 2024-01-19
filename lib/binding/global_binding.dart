import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_impl.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/repository/transaction/transaction_impl.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkCore>(NetworkCore(), permanent: true);
    Get.put<StorageCore>(StorageCore(), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImpl(), permanent: true);
    Get.put<TransactionRepository>(TransactionRepositoryImpl(), permanent: true);
  }
}
