import 'package:css_mobile/data/connection_test.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/aggregasi/aggregasi_impl.dart';
import 'package:css_mobile/data/repository/aggregasi/aggregasi_repository.dart';
import 'package:css_mobile/data/repository/auth/auth_impl.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/repository/bank/bank_impl.dart';
import 'package:css_mobile/data/repository/bank/bank_repository.dart';
import 'package:css_mobile/data/repository/eclaim/eclaim_impl.dart';
import 'package:css_mobile/data/repository/eclaim/eclaim_repository.dart';
import 'package:css_mobile/data/repository/facility/facility_impl.dart';
import 'package:css_mobile/data/repository/facility/facility_repository.dart';
import 'package:css_mobile/data/repository/invoice/invoice_impl.dart';
import 'package:css_mobile/data/repository/invoice/invoice_repository.dart';
import 'package:css_mobile/data/repository/jlc/jlc_impl.dart';
import 'package:css_mobile/data/repository/jlc/jlc_repository.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_impl.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_repository.dart';
import 'package:css_mobile/data/repository/laporanku/laporanku_impl.dart';
import 'package:css_mobile/data/repository/laporanku/laporanku_repository.dart';
import 'package:css_mobile/data/repository/master/master_impl.dart';
import 'package:css_mobile/data/repository/master/master_repository.dart';
import 'package:css_mobile/data/repository/notification/notification_impl.dart';
import 'package:css_mobile/data/repository/notification/notification_repository.dart';
import 'package:css_mobile/data/repository/pantau_paketmu/pantau_paketmu_impl.dart';
import 'package:css_mobile/data/repository/pantau_paketmu/pantau_paketmu_repository.dart';
import 'package:css_mobile/data/repository/pengaturan/pengaturan_impl.dart';
import 'package:css_mobile/data/repository/pengaturan/pengaturan_repository.dart';
import 'package:css_mobile/data/repository/profil/profil_impl.dart';
import 'package:css_mobile/data/repository/profil/profil_repository.dart';
import 'package:css_mobile/data/repository/request_pickup/request_pickup_impl.dart';
import 'package:css_mobile/data/repository/request_pickup/request_pickup_repository.dart';
import 'package:css_mobile/data/repository/storage/storage_impl.dart';
import 'package:css_mobile/data/repository/storage/storage_repository.dart';
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
    Get.put<TransactionRepository>(TransactionRepositoryImpl(),
        permanent: true);
    Get.put<ConnectionTest>(ConnectionTest(), permanent: true);
    Get.put<ProfilRepository>(ProfilRepositoryImpl(), permanent: true);
    Get.put<LacakKirimanRepository>(LacakKirimanRepositoryImpl(),
        permanent: false);
    Get.put<JLCRepository>(JLCRepositoryImpl(), permanent: false);
    Get.put<PengaturanRepository>(PengaturanRepositoryImpl(), permanent: true);
    Get.put<FacilityRepository>(FacilityImpl(), permanent: true);
    Get.put<BankRepository>(BankImpl(), permanent: true);
    Get.put<StorageRepository>(StorageImpl(), permanent: true);
    Get.put<AggregasiRepository>(AggregasiRepositoryImpl(), permanent: true);
    Get.put<RequestPickupRepository>(RequestPickupImpl(), permanent: true);
    Get.put<NotificationRepository>(NotificationRepositoryImpl(),
        permanent: true);
    Get.put<LaporankuRepository>(LaporankuRepositoryImpl(), permanent: true);
    Get.put<InvoiceRepository>(InvoiceImpl(), permanent: true);
    Get.put<MasterRepository>(MasterRepositoryImpl(), permanent: true);
    Get.put<EclaimRepository>(EclaimRepositoryImpl(), permanent: true);
    Get.put<PantauPaketmuRepository>(PantauPaketmuRepositoryImpl(),
        permanent: true);
  }
}
