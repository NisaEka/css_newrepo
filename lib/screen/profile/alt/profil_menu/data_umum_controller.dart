import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';

class DataUmumController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  CcrfProfileModel? ccrfProfil;
  UserModel? basicProfil;
  bool isCcrf = false;

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
      await profil
          .getBasicProfil()
          .then((value) => basicProfil = value.data?.user);
      update();
      await profil.getCcrfProfil().then((value) {
        if (value.data != null) {
          ccrfProfil = value.data;
        } else {
          ccrfProfil ??= CcrfProfileModel(
            generalInfo: GeneralInfo(
              name: basicProfil?.name,
              brand: basicProfil?.brand,
              address: basicProfil?.address,
              email: basicProfil?.email,
              phone: basicProfil?.phone,
            ),
          );
        }

        isCcrf = true;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error initData data umum $e, $i');

      var basic =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));

      ccrfProfil = CcrfProfileModel(
        generalInfo: GeneralInfo(
          name: basic.name,
          brand: basic.brand,
          address: basic.address,
          email: basic.email,
          phone: basic.phone,
        ),
      );
    }

    isLoading = false;
    update();
  }
}
