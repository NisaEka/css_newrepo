import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregasi_minus_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_screen.dart';
import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
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
      theme: ThemeData(
        // primaryColor: blueJNE,
        colorScheme: const ColorScheme.light(
          primary: blueJNE,
          secondary: greyLightColor1,
          background: whiteColor,
        ),
        useMaterial3: true,
        fontFamily: 'Ubuntu',
        // backgroundColor: baseColor,
        appBarTheme: AppBarTheme(
          backgroundColor: blueJNE,
          elevation: 0,
          titleTextStyle: appTitleTextStyle,
          iconTheme: const IconThemeData(color: whiteColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: whiteColor,
          labelStyle: hintTextStyle.copyWith(color: greyDarkColor1),
          hintStyle: hintTextStyle,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: neutralColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: greyDarkColor1,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              minimumSize: const Size(100, 40),
              // side: const BorderSide(color: infoColor),
              // foregroundColor: infoColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return 0;
                  }
                  return 0; // Defer to the widget's default.
                },
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
        ),
      ),
      getPages: [
        GetPage(name: "/inputKiriman", page: () => const InformasiPengirimScreen()),
        GetPage(name: "/cekOngkir", page: () => const CekOngkirScreen()),
        GetPage(name: "/draftTransaksi", page: () => const DraftTransaksiScreen()),
        GetPage(name: "/riwayatKiriman", page: () => const RiwayatKirimanScreen()),
        GetPage(name: "/lacakKiriman", page: () => const LacakKirimanScreen()),
        GetPage(name: "/pembayaranAggregasi", page: () => const PembayaranAggergasiScreen()),
        GetPage(name: "/aggregasiMinus", page: () => const AggregasiMinusScreen()),
        GetPage(name: "/uangCODKamu", page: () => const UangCODScreen()),
      ],
      // home: const LoginScreen(),
      home: const DashboardScreen(),
    );
  }
}
