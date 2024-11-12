import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/items/contact_radio_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPenerimaController extends BaseController {
  final search = TextEditingController();

  bool isLoading = false;
  bool isOnline = false;
  List<ReceiverModel> receiverList = [];
  ReceiverModel? selectedReceiver;

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
    receiverList = [];
    connection.isOnline().then((value) => isOnline = value);

    update();
    try {
      await master
          .getReceivers(QueryParamModel(search: search.text))
          .then((value) async {
        receiverList.addAll(value.data ?? []);
        await storage.saveData(StorageCore.receiver, value);
      });
    } catch (e) {
      e.printError();
      var receiver = BaseResponse<List<ReceiverModel>>.fromJson(
          await storage.readData(StorageCore.receiver),
          (json) => json is List<dynamic>
              ? json
                  .map<ReceiverModel>(
                    (i) => ReceiverModel.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
              : List.empty());
      receiverList.addAll(receiver.data ?? []);
    }
    isLoading = false;
    update();
  }

  void delete(ReceiverModel data) async {
    try {
      await master.deleteReceiver(data.idReceive ?? '').then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: Icon(
                  value.code == 200 ? Icons.info : Icons.warning,
                  color: whiteColor,
                ),
                message:
                    value.code == 200 ? 'Data Dihapus'.tr : "Bad Request".tr,
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 200 ? successColor : errorColor,
              ),
            ),
          );
    } catch (e) {
      e.printError();
    }
    initData();
  }

  Widget receiverItem(ReceiverModel e, int i, BuildContext context) {
    return ContactRadioListItem(
      isLoading: isLoading,
      index: i,
      value: e,
      name: e.name,
      phone: e.phone,
      city: e.city,
      address: e.address,
      groupValue: selectedReceiver,
      isSelected: e == selectedReceiver ? true : false,
      onChanged: (value) {
        selectedReceiver = value as ReceiverModel?;
        update();
        Get.back(
          result: selectedReceiver,
        );
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
