import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
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
  bool isFirst = false;

  CcrfProfileModel? ccrf;

  String? marqueeText = 'Data diperbaharui setiap jam 06 : 45 WIB';
  String? userName;
  String? jlcPoint;
  String? fcmToken;
  String local = '';
  String themeMode = '';
  UserModel? basic;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const AltProfileScreen(),
  ];

  List<Items> menuItems = [];
  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];
  List<BannerModel> bannerList = [];
  List<NewsModel> newsList = [];
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
  MenuModel allow = MenuModel();
}
