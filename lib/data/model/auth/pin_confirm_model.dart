class PinConfirmModel {
  PinConfirmModel({
    String? token,
  }) {
    _token = token;
  }

  PinConfirmModel.fromJson(dynamic json) {
    _token = json['token'];
  }

  String? _token;

  PinConfirmModel copyWith({
    String? token,
  }) =>
      PinConfirmModel(
        token: token ?? _token,
      );

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    return map;
  }
}
