class InputPinconfirmModel {
  InputPinconfirmModel({
    String? email,
    String? pin,
  }) {
    _email = email;
    _pin = pin;
  }

  InputPinconfirmModel.fromJson(dynamic json) {
    _email = json['email'];
    _pin = json['pin'];
  }

  String? _email;
  String? _pin;

  InputPinconfirmModel copyWith({
    String? email,
    String? pin,
  }) =>
      InputPinconfirmModel(
        email: email ?? _email,
        pin: pin ?? _pin,
      );

  String? get email => _email;

  String? get pin => _pin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['pin'] = _pin;
    return map;
  }
}
