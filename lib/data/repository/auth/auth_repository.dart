abstract class AuthRepository {
  Future postLogin(String username, String password, {String? accessToken, String? refreshToken, String? email});
}
