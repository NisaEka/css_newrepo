import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class ListPenerimaController extends BaseController {
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
    try {
      await transaction.getReceiver().then((value) => receiverList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
      var receiver = GetReceiverModel.fromJson(await storage.readData(StorageCore.receiver));
      receiverList.addAll(receiver.payload ?? []);
    }
    isLoading = false;
    update();
  }
}
