import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/items/contact_radio_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  Account account = Get.arguments['account'];
  bool isOfficer = Get.arguments['isOfficer'];

  final search = TextEditingController();
  bool isLoading = false;
  bool isOnline = false;
  List<DropshipperModel> dropshipperList = [];

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
      await master.getDropshippers(QueryModel(search: search.text)).then(
        (value) async {
          dropshipperList.addAll(value.data ?? []);
          await storage.saveData(StorageCore.dropshipper, value);
        },
      );
      update();
    } catch (e) {
      AppLogger.e('error get dropshipper $e');
      dropshipperList.clear();
      var dropshipper = BaseResponse<List<DropshipperModel>>.fromJson(
        await storage.readData(StorageCore.dropshipper),
        (json) => json is List<dynamic>
            ? json
                .map<DropshipperModel>(
                  (i) => DropshipperModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
      dropshipperList.addAll(dropshipper.data ?? []);
    }

    isLoading = false;
    update();
  }

  void delete(DropshipperModel data) async {
    try {
      await master.deleteDropshipper(data.id ?? '').then((value) =>
          value.code == 200
              ? AppSnackBar.success('Data Dihapus'.tr)
              : AppSnackBar.error('Bad Request'.tr));
    } catch (e) {
      AppLogger.e('error delete dropshipper $e');
    }
    initData();
  }

  Widget dropshipperItem(DropshipperModel e, int i, BuildContext context) {
    return ContactRadioListItem(
      isLoading: isLoading,
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
