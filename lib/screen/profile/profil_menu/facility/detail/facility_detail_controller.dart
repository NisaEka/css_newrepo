import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:get/get.dart';

class FacilityDetailController extends BaseController {
  FacilityModel facilityArgs = Get.arguments['facility'];

  bool buttonEnabled = true;
  String buttonText = 'Gunakan'.tr;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_initState()]);
  }

  Future<void> _initState() async {
    if (!facilityArgs.canUse) {
      buttonEnabled = false;
    }

    if (facilityArgs.enabled) {
      buttonText = 'Info';
    }
  }
}
