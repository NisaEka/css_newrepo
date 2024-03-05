import 'package:css_mobile/data/connection_test.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_impl.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_impl.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_repository.dart';
import 'package:css_mobile/data/repository/jlc/jlc_impl.dart';
import 'package:css_mobile/data/repository/jlc/jlc_repository.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_impl.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_repository.dart';
import 'package:css_mobile/data/repository/profil/profil_impl.dart';
import 'package:css_mobile/data/repository/profil/profil_repository.dart';
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
    Get.put<ConnectionTest>(ConnectionTest(), permanent: true);
    Get.put<ProfilRepository>(ProfilRepositoryImpl(), permanent: true);
    Get.put<CekOngkirRepository>(CekOngkirRepositoryImpl(), permanent: false);
    Get.put<LacakKirimanRepository>(LacakKirimanRepositoryImpl(), permanent: false);
    Get.put<JLCRepository>(JLCRepositoryImpl(), permanent: false);
  }
}
