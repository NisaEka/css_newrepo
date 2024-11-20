import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';

class AkunBankController extends BaseController {
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
      await profil.getCcrfProfil().then(
            (value) => ccrfProfil = value.data,
          );
    } catch (e, i) {
      AppLogger.e('error initData akun bank $e, $i');
      ccrfProfil = CcrfProfileModel.fromJson(await storage.readData(StorageCore.ccrfProfile));

    }

    isLoading = false;
    update();
  }
}
