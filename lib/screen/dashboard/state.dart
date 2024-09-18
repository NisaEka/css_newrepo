import 'package:carousel_slider/carousel_controller.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/dashboard/count_card_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/screen/dashboard/screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardState {
  final selectedIndex = 0.obs;
  final nomorResi = TextEditingController();
  DateTime? currentBackPressTime;

  bool isLogin = false;
  bool isLoading = false;
  bool isOnline = false;
  bool isCcrf = true;

  CcrfProfilModel? ccrf;

  String? marqueeText = 'Data diperbaharui setiap jam 06 : 45 WIB';
  String? userName;
  String? jlcPoint;
  String? fcmToken;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const AltProfileScreen(),
  ];

  List<Items> menuItems = [];
  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];
  List<Widget> bannerList = [
    const Text('for commercial banner 1'),
    const Text('for commercial banner 2'),
    const Text('for commercial banner 3'),
  ];
  List<CountCardModel> transCountList = [];
  List<String> transType = [
    'Jumlah Transaksi',
    'Masih Dikamu',
    'Sudah Dijemput',
    'Dalam Perjalanan',
    'Sukses Diterima',
    'Sudah Dikembalikan',
    'Dalam Peninjauan',
    'Dibatalkan Oleh Kamu'
  ];
  var bannerIndex = 0.obs;
  CarouselController commercialCarousel = CarouselController();
  AllowedMenu allow = AllowedMenu();
}
