import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

class DetailLaporankuController extends BaseController {
  bool isLoading = false;

  Future<void> updateStatus(String id) async {
    isLoading = true;
    update();
    id.printInfo(info: "TicketID");

    try {
      await laporanku.putTicket(id, "Closed").then(
            (value) => value.code == 200
                ? Get.back()
                : AppSnackBar.error(value.message?.tr),
          );
    } catch (e) {
      AppLogger.e('error updateStatus $e');
      e.printError();
    }

    isLoading = false;
    update();
  }
}
