import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/items/contact_radio_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  Account account = Get.arguments['account'];

  final search = TextEditingController();
  bool isLoading = false;
  bool isOnline = false;
  List<DropshipperModel> dropshipperList = [];
  List<DropshipperModel> searchResultList = [];

  DropshipperModel? selectedDropshipper;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        isOnline = value && (result != ConnectivityResult.none);
        update();
      });
      update();
    }));
  }

  Future<void> initData() async {
    isLoading = true;
    dropshipperList = [];

    connection.isOnline().then((value) => isOnline = value);
    update();

    try {
      await transaction.getDropshipper().then((value) => dropshipperList.addAll(value.payload ?? []));
      update();
    } catch (e) {
      e.printError();
      var dropshipper = GetDropshipperModel.fromJson(await storage.readData(StorageCore.dropshipper));
      dropshipperList.addAll(dropshipper.payload ?? []);
    }

    isLoading = false;
    update();
  }

  void searchDropshipper(String text) {
    searchResultList = [];
    if (text.isEmpty) {
      searchResultList = [];
      update();
    } else {
      dropshipperList.forEach((dropshipper) {
        if (dropshipper.name?.contains(text) ?? false) {
          searchResultList.add(dropshipper);
          update();
        }
      });
      update();
    }

    print('droppp : ${searchResultList.length}');
    update();
  }

  void delete(DropshipperModel data) async {
    try {
      await transaction.deleteDropshipper(data.id ?? '').then(
            (value) => null,
          );
    } catch (e) {
      e.printError();
    }
    initData();
  }

  Widget dropshipperItem(DropshipperModel e, int i, BuildContext context) {
    return ContactRadioListItem(
      index: i,
      groupValue: dropshipperList,
      value: e,
      name: e.name,
      phone: e.phone,
      city: e.city,
      address: e.address,
      onChanged: (value) {
        selectedDropshipper = value as DropshipperModel?;
        update();
        Get.back(result: selectedDropshipper);
      },
      onDelete: (value) => showDialog(
        context: context,
        builder: (context) => DeleteAlertDialog(
          onDelete: () {
            delete(e);
            Get.back();
          },
          onBack: () {
            Get.back();
            initData();
          },
        ),
      ),
    );
  }
}
