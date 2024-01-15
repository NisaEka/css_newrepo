import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';

abstract class AuthRepository {
  Future<LoginModel> postLogin(String username, String password, InputLoginModel loginData,
      {String? accessToken, String? refreshToken, String? email});
}
