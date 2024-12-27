import 'package:css_mobile/base/base_controller.dart';
import 'package:get/get.dart';

class UangCODController extends BaseController {
  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;
  String dateFilter = '0';
  String? date;

  void resetFilter() {
    startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    isFiltered = false;
    dateFilter = '0';

    update();
    Get.back();
  }

  applyFilter() {
    if (startDate != null || endDate != null) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        date =
            "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
      }
      update();
      // pagingController.refresh();
      update();
      Get.back();
    }
  }
}
