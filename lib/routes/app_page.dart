import 'package:css_mobile/screen/cek_ongkir/screen.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_screen.dart';
import 'package:css_mobile/screen/invoice/invoice_screen.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregation_minus_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_screen.dart';
import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_screen.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_card_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: "/inputKiriman", page: () => const InformasiPengirimScreen()),
    GetPage(name: "/cekOngkir", page: () => const CekOngkirScreen()),
    GetPage(name: "/draftTransaksi", page: () => const DraftTransaksiScreen()),
    GetPage(name: "/riwayatKiriman", page: () => const RiwayatKirimanScreen()),
    GetPage(name: "/lacakKiriman", page: () => const LacakKirimanScreen()),
    GetPage(name: "/pembayaranAggregasi", page: () => const PembayaranAggergasiScreen()),
    GetPage(name: "/aggregasiMinus", page: () => const AggregationMinusScreen()),
    GetPage(name: "/uangCODKamu", page: () => const UangCODScreen()),
    GetPage(name: "/profileGeneral", page: () => const DataUmumScreen()),
    GetPage(name: "/requestPickup", page: () => const RequestPickupScreen()),
    GetPage(name: "/notification", page: () => const NotificationScreen()),
    GetPage(name: "/pantauPaketmu", page: () => const PantauCardScreen()),
    // GetPage(name: "/pantauPaketmu", page: () => const PantauPaketmuScreen()),
    GetPage(name: "/laporanku", page: () => const LaporankuScreen()),
    GetPage(name: "/invoice", page: () => const InvoiceScreen())
  ];
}
