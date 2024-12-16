import 'package:css_mobile/routes/route_page.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_screen.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_screen.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_screen.dart';
import 'package:css_mobile/screen/invoice/invoice_screen.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregation_minus_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_screen.dart';
import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_screen.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_card_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(
        name: Routes.inputKiriman, page: () => const InformasiPengirimScreen()),
    GetPage(name: Routes.cekOngkir, page: () => const CekOngkirScreen()),
    GetPage(
        name: Routes.draftTransaksi, page: () => const DraftTransaksiScreen()),
    GetPage(
        name: Routes.riwayatKiriman, page: () => const RiwayatKirimanScreen()),
    GetPage(name: Routes.lacakKiriman, page: () => const LacakKirimanScreen()),
    GetPage(
        name: Routes.pembayaranAggregasi,
        page: () => const PembayaranAggergasiScreen()),
    GetPage(
        name: Routes.aggregasiMinus,
        page: () => const AggregationMinusScreen()),
    GetPage(name: Routes.uangCODKamu, page: () => const UangCODScreen()),
    GetPage(name: Routes.profileGeneral, page: () => const DataUmumScreen()),
    GetPage(
        name: Routes.requestPickup, page: () => const RequestPickupScreen()),
    GetPage(name: Routes.notification, page: () => const NotificationScreen()),
    GetPage(name: Routes.pantauPaketmu, page: () => const PantauCardScreen()),
    GetPage(name: Routes.laporanku, page: () => const LaporankuScreen()),
    GetPage(name: Routes.eclaim, page: () => const EclaimScreen()),
    GetPage(name: Routes.invoice, page: () => const InvoiceScreen())
  ];
}
