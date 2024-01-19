import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/profile/profil_list_model.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  List<ProfilListModel> profilList = [
    ProfilListModel(
      leading: IconsConstant.openAccount,
      title: 'Lihat Akun',
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.dataUser,
      title: 'Data Umum',
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.addressBook,
      title: 'Alamat Pengiriman',
      isShow: false,
    ),
    ProfilListModel(
      leading: IconsConstant.documentInfo,
      title: 'Dokumen',
      isShow: false,
    ),
  ];

  void doLogout() async {
    storage.deleteToken();
    Get.offAll(const LoginScreen());
  }
}
