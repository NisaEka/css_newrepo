import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PengaturanController extends BaseController {
  bool isLogin = false;
  String? version;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;

    String? token = await storage.readToken();
    isLogin = token != null;

    update();
  }

  void doLogout() async {
    storage.deleteToken();

    Get.offAll(const LoginScreen());
  }
}
