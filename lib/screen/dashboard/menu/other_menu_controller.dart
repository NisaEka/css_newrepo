import 'dart:convert';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class OtherMenuCotroller extends BaseController {
  List filterList = ['Semua', 'Paketmu', 'Cek Ongkir'];
  String selectedFilter = "Semua";

  List<Items> favoritList = [];
  List<Items> paketmuList = [];
  List<Items> otherList = [];

  MenuItemModel? menuData;

  bool isLogin = false;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    isLogin = token != null;
    update();
    return isLogin;
  }

  Future<void> initData() async {
    favoritList = [];
    cekToken();
    try {
      var menu = MenuItemModel.fromJson(await storage.readData(StorageCore.favoriteMenu));
      favoritList.addAll(menu.items ?? []);
      update();
    } catch (e) {
      e.printError();
    }

    paketmuList = [
      Items(
        title: "Input Kirimanmu",
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Input Kirimanmu").isNotEmpty,
        isEdit: isEdit,
        route: "/inputKiriman",
      ),
      Items(
        title: "Riwayat Kiriman",
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Riwayat Kiriman").isNotEmpty,
        isEdit: isEdit,
        route: "/riwayatKiriman",
      ),
      Items(
        title: "Draft Transaksi",
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Draft Transaksi").isNotEmpty,
        isEdit: isEdit,
        route: "/draftTransaksi",
      ),
      Items(
        title: "Lacak Kiriman",
        icon: ImageConstant.paketmuIcon,
        isAuth: false,
        isFavorite: favoritList.where((e) => e.title == "Lacak Kiriman").isNotEmpty,
        isEdit: isEdit,
        route: "/lacakKiriman",
      ),
    ];

    otherList = [
      Items(
        title: "Cek Ongkir",
        icon: ImageConstant.cekOngkirIcon,
        isAuth: false,
        isFavorite: favoritList.where((e) => e.title == "Cek Ongkir").isNotEmpty,
        isEdit: isEdit,
        route: "/cekOngkir",
      ),
    ];

    update();
  }

  void removeFavorit(int i) {
    paketmuList.where((e) => e.title == favoritList[i].title).isNotEmpty
        ? paketmuList.where((e) => e.title == favoritList[i].title).first.isFavorite = false
        : null;
    otherList.where((e) => e.title == favoritList[i].title).isNotEmpty
        ? otherList.where((e) => e.title == favoritList[i].title).first.isFavorite = false
        : null;

    favoritList.removeAt(i);
    update();
  }

  void addFavorit(int i, Items menu) {
    if (favoritList.where((e) => e.title == menu.title).isEmpty) {
      paketmuList.where((e) => e == menu).isNotEmpty ? paketmuList.where((e) => e == menu).first.isFavorite = true : null;
      otherList.where((e) => e == menu).isNotEmpty ? otherList.where((e) => e == menu).first.isFavorite = true : null;
      update();
      favoritList.add(menu);
    } else {
      paketmuList.where((e) => e == menu).isNotEmpty ? paketmuList.where((e) => e == menu).first.isFavorite = false : null;
      otherList.where((e) => e == menu).isNotEmpty ? otherList.where((e) => e == menu).first.isFavorite = false : null;
      update();

      favoritList.removeWhere((e) => e.title == menu.title);
    }

    update();
  }

  void saveChanges() async {
    if (isEdit == false) {
      isEdit = true;
      update();
    } else {
      isEdit = false;
      update();
      var data = '{"items" : ${jsonEncode(favoritList)}}';
      menuData = MenuItemModel.fromJson(jsonDecode(data));
      update();
      await storage.saveData(StorageCore.favoriteMenu, menuData).then((value) {
        initData();
      });
    }
    update();
  }
}
