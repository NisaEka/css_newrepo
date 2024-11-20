import 'package:css_mobile/base/bottombar_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

class ProfileState {
  final HideNavbar bottom = HideNavbar();

  bool isLogin = false;
  bool isEdit = false;
  bool pop = false;
  bool isLoading = false;

  UserModel? basicProfile;
  String? version;
  MenuModel menuModel = MenuModel();
  CcrfProfileModel? ccrf;
  bool isCcrf = false;
}
