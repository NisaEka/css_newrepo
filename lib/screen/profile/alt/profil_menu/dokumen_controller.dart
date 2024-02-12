import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:get/get.dart';

class DokumenController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  CcrfProfilModel? ccrfProfil;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await profil.getCcrfProfil().then(
            (value) => ccrfProfil = value.payload,
          );
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
  }
}
