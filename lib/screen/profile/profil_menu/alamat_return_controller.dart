import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/util/logger.dart';

class AlamatReturnController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  CcrfProfileModel? ccrfProfil;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      String? token = await storage.readAccessToken();
      AppLogger.i('token : $token');
      isLogin = token != null;

      await profil.getCcrfProfil().then(
            (value) => ccrfProfil = value.data,
          );
    } catch (e, i) {
      AppLogger.e('error initData alamat return $e, $i');
    }

    isLoading = false;
    update();
  }
}
