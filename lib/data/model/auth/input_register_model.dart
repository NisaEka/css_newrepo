class InputRegisterModel {
  InputRegisterModel({
    String? fullName,
    String? brandName,
    String? phone,
    String? email,
    String? referralCode,
    String? originCode,
    String? alreadyUseJne,
    String? salesCounter,
  }) {
    _fullName = fullName;
    _brandName = brandName;
    _phone = phone;
    _email = email;
    _referralCode = referralCode;
    _originCode = originCode;
    _alreadyUseJne = alreadyUseJne;
    _salesCounter = salesCounter;
  }

  InputRegisterModel.fromJson(dynamic json) {
    _fullName = json['name'];
    _brandName = json['brand'];
    _phone = json['phone'];
    _email = json['email'];
    _referralCode = json['referralCode'];
    _originCode = json['originCode'];
    _alreadyUseJne = json['alreadyUseJne'];
    _salesCounter = json['counter'];
  }

  String? _fullName;
  String? _brandName;
  String? _phone;
  String? _email;
  String? _referralCode;
  String? _originCode;
  String? _alreadyUseJne;
  String? _salesCounter;

  InputRegisterModel copyWith({
    String? fullName,
    String? brandName,
    String? phone,
    String? email,
    String? referralCode,
    String? originCode,
    String? alreadyUseJne,
    String? salesCounter,
  }) =>
      InputRegisterModel(
        fullName: fullName ?? _fullName,
        brandName: brandName ?? _brandName,
        phone: phone ?? _phone,
        email: email ?? _email,
        referralCode: referralCode ?? _referralCode,
        originCode: originCode ?? _originCode,
        alreadyUseJne: alreadyUseJne ?? _alreadyUseJne,
        salesCounter: salesCounter ?? _salesCounter,
      );

  String? get fullName => _fullName;

  String? get brandName => _brandName;

  String? get phone => _phone;

  String? get email => _email;

  String? get referralCode => _referralCode;

  String? get originCode => _originCode;

  String? get alreadyUseJne => _alreadyUseJne;

  String? get salesCounter => _salesCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _fullName;
    map['brand'] = _brandName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['referralCode'] = _referralCode;
    map['originCode'] = _originCode;
    map['alreadyUseJne'] = _alreadyUseJne;
    map['counter'] = _salesCounter;
    return map;
  }
}
