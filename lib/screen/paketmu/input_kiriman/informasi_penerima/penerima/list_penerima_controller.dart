import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:get/get.dart';

class ListPenerimaController extends BaseController {
  bool isLoading = false;

  List<ReceiverModel> receiverList = [];

  ReceiverModel? selectedReceiver;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    receiverList = [];
    try {
      await transaction.getReceiver().then((value) => receiverList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }
    isLoading = false;
    update();
  }
}
