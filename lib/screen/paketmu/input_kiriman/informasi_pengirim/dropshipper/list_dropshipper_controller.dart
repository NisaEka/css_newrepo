import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  AccountNumberModel account = Get.arguments['account'];

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
      await transaction.getDropshipper().then((value) => dropshipperList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
      var dropshipper = GetDropshipperModel.fromJson(await storage.readData(StorageCore.dropshipper));
      dropshipperList.addAll(dropshipper.payload ?? []);
    }

    isLoading = false;
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
}

