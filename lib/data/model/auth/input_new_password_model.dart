class InputNewPasswordModel {
  InputNewPasswordModel({
    String? password,
    String? token,
  }) {
    _password = password;
    _token = token;
  }

  InputNewPasswordModel.fromJson(dynamic json) {
    _password = json['password'];
    _token = json['token'];
  }

  String? _password;
  String? _token;

  InputNewPasswordModel copyWith({
    String? password,
    String? token,
  }) =>
      InputNewPasswordModel(
        password: password ?? _password,
        token: token ?? _token,
      );

  String? get password => _password;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = _password;
    map['token'] = _token;
    return map;
  }
}
