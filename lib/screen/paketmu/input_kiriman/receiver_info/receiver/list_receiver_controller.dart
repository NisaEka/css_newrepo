import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:css_mobile/widgets/items/contact_radio_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListPenerimaController extends BaseController {
  final search = TextEditingController();

  bool isLoading = false;
  bool isOnline = false;
  ReceiverModel? selectedReceiver;

  final PagingController<int, ReceiverModel> pagingController =
      PagingController(firstPageKey: Constant.defaultPage);

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

    pagingController.addPageRequestListener((pageKey) {
      fetchReceiverData(pageKey);
    });
  }

  Future<void> checkConnectionStatus() async {
    isOnline = await connection.isOnline();
    update();
  }

  Future<void> fetchReceiverData(int page) async {
    isLoading = true;
    try {
      var response = await master
          .getReceivers(QueryModel(search: search.text, page: page));
      final payload = response.data ?? List.empty();
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(payload);
        AppLogger.i("pagingController, $pagingController");
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
        AppLogger.i("pagingController, $pagingController");
      }
      await storage.saveData(StorageCore.receiver, response);
    } catch (e) {
      AppLogger.e("getReceivers error: $e");
      pagingController.error = e;
      var receiver = BaseResponse<List<ReceiverModel>>.fromJson(
        await storage.readData(StorageCore.receiver),
        (json) => json is List<dynamic>
            ? json
                .map<ReceiverModel>(
                    (i) => ReceiverModel.fromJson(i as Map<String, dynamic>))
                .toList()
            : List.empty(),
      );
      pagingController.itemList = receiver.data ?? [];
    }
    //   receiverList.addAll(value.data ?? []);
    //   await storage.saveData(StorageCore.receiver, value);
    // } catch (e) {
    //   AppLogger.e('error getReceiver $e');
    //   var receiver = BaseResponse<List<ReceiverModel>>.fromJson(
    //     await storage.readData(StorageCore.receiver),
    //     (json) => json is List<dynamic>
    //         ? json
    //             .map<ReceiverModel>(
    //                 (i) => ReceiverModel.fromJson(i as Map<String, dynamic>))
    //             .toList()
    //         : List.empty(),
    //   );
    //   receiverList.addAll(receiver.data ?? []);
    // }
    isLoading = false;
    update();
  }

  Future<void> initData() async {
    await checkConnectionStatus();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  // Future<void> initData() async {
  //   isLoading = true;
  //   receiverList = [];
  //   connection.isOnline().then((value) => isOnline = value);

  //   update();
  //   try {
  //     await master
  //         .getReceivers(QueryParamModel(search: search.text))
  //         .then((value) async {
  //       receiverList.addAll(value.data ?? []);
  //       await storage.saveData(StorageCore.receiver, value);
  //     });
  //   } catch (e) {
  //     AppLogger.e('error getReceiver $e');
  //     var receiver = BaseResponse<List<ReceiverModel>>.fromJson(
  //         await storage.readData(StorageCore.receiver),
  //         (json) => json is List<dynamic>
  //             ? json
  //                 .map<ReceiverModel>(
  //                   (i) => ReceiverModel.fromJson(i as Map<String, dynamic>),
  //                 )
  //                 .toList()
  //             : List.empty());
  //     receiverList.addAll(receiver.data ?? []);
  //   }
  //   isLoading = false;
  //   update();
  // }

  void delete(ReceiverModel data) async {
    try {
      await master.deleteReceiver(data.idReceive ?? '').then(
            (value) => value.code == 200
                ? AppSnackBar.success('Data Dihapus'.tr)
                : AppSnackBar.error('Bad Request'.tr),
          );
    } catch (e) {
      AppLogger.e('error deleteReceiver $e');
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
      onTap: () => Get.back(result: e),
      // onChanged: (value) {
      //   selectedReceiver = value as ReceiverModel?;
      //   update();
      //   Get.back(
      //     result: selectedReceiver,
      //   );
      // },
      onDelete: (value) => showDialog(
        context: context,
        builder: (context) => DefaultAlertDialog(
          title: 'Data akan dihapus'.tr,
          subtitle: 'Anda yakin menghapus data ini ?'.tr,
          confirmButtonTitle: 'Hapus'.tr,
          backButtonTitle: 'Tidak'.tr,
          onConfirm: () {
            delete(e);
            Get.back();
          },
          onBack: () {
            Get.back();
            initData();
          },
        ),
        //     DeleteAlertDialog(
        //   onDelete: () {
        //     delete(e);
        //     Get.back();
        //   },
        //   onBack: () {
        //     Get.back();
        //     initData();
        //   },
        // ),
      ),
    );
  }
}
