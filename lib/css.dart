import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/routes/app_page.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
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
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_screen.dart';
import 'package:css_mobile/util/lang/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

class CSS extends StatelessWidget {
  const CSS({super.key});

  @override
  Widget build(BuildContext context) {
    String env = FlavorConfig.instance.name ?? "PROD";
    if (env == "DEV" || env == "STG") {
      return const FlavorBanner(
        location: BannerLocation.topEnd,
        child: App(),
      );
    }

    return const App();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      // navigatorKey: NavigationUtil.navigationKey,
      translations: AppTranslation(),
      fallbackLocale: const Locale("id", "ID"),
      debugShowCheckedModeBanner: false,
      title: 'CSS',
      themeMode: ThemeMode.dark,
      darkTheme: CustomTheme.dark,
      theme: CustomTheme.light,
      getPages: AppPages.routes,
      // home: const LoginScreen(),
      home: const DashboardScreen(),
    );
  }
}
