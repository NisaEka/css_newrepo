import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  AccountNumberModel account = Get.arguments['account'];

  bool isLoading = false;
  List<DropshipperModel> dropshipperList = [];

  DropshipperModel? selectedDropshipper;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    dropshipperList = [];

    try {
      await transaction.getDropshipper().then((value) => dropshipperList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}
