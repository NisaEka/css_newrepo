import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/count_card_model.dart';
import 'package:css_mobile/data/model/transaction/dashboard_kiriman_kamu_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardState {
  bool? isFromLogin = Get.arguments?['isFromLogin'];
  final selectedIndex = 0.obs;
  final nomorResi = TextEditingController();
  DateTime? currentBackPressTime;

  bool isLogin = false;
  bool isLoading = false;
  bool isOnline = false;
  bool isCcrf = true;
  bool isFirstInstall = false;
  bool isFirstLogin = false;

  CcrfProfileModel? ccrf;

  String? marqueeText = 'Data diperbaharui setiap jam 06 : 45 WIB';
  String? userName;
  String? jlcPoint;
  String? fcmToken;
  String local = '';
  String themeMode = '';
  UserModel? basic;
  TransactionSummaryModel? transSummary;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  List<Items> menuItems = [];
  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];
  List<BannerModel> bannerList = [];
  List<NewsModel> newsList = [];
  List<CountCardModel> transCountList = [];
  List<CountCardModel> transCountCodList = [];
  List<NotificationModel> unreadNotifList = [];
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

  List<String> transCountCod = [
    'Total Kiriman COD',
    'Terkumpul dari Pembeli',
    'Belum Terkumpul Dari Pembeli',
    'Butuh Dicek',
    'Sudah Dikembalikan',
    'Dalam Peninjauan',
    'Dibatalkan Oleh Kamu',
  ];
  var bannerIndex = 0.obs;
  MenuModel allow = MenuModel();

  // Kiriman Kamu
  bool isLoadingKiriman = false;
  bool isLoadingKirimanCOD = true;
  DashboardKirimanKamuModel kirimanKamu = DashboardKirimanKamuModel();
  DashboardKirimanKamuModel kirimanKamuCOD = DashboardKirimanKamuModel();
  AggregationModel? aggregationModel;
  AggregationMinusModel? aggregationMinus;
}
