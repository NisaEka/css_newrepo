import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  void doLogout() async {
    storage.deleteToken();
    Get.offAll(const LoginScreen());
  }
}
