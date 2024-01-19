import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  List<DropshipperModel> dropshipperList = [];

  DropshipperModel? selectedDropshipper;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      await transaction.getDropshipper().then((value) => dropshipperList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }
    update();
  }
}
