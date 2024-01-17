import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/delivery/get_dropshipper_model.dart';
import 'package:get/get.dart';

class ListDropshipperController extends BaseController {
  List<Dropshipper> dropshipperList = [];

  Dropshipper? selectedDropshipper;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      await delivery.getDropshipper().then((value) => dropshipperList.addAll(value.payload ?? []));
    } catch (e) {
      e.printError();
    }
    update();
  }
}
