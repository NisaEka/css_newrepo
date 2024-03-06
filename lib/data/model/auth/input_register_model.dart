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
    _fullName = json['full_name'];
    _brandName = json['brand_name'];
    _phone = json['phone'];
    _email = json['email'];
    _referralCode = json['referral_code'];
    _originCode = json['origin_code'];
    _alreadyUseJne = json['already_use_jne'];
    _salesCounter = json['sales_counter'];
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
    map['full_name'] = _fullName;
    map['brand_name'] = _brandName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['referral_code'] = _referralCode;
    map['origin_code'] = _originCode;
    map['already_use_jne'] = _alreadyUseJne;
    map['sales_counter'] = _salesCounter;
    return map;
  }
}
