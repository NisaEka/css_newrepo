import 'package:css_mobile/data/model/master/get_origin_model.dart';

class GetBasicProfilModel {
  GetBasicProfilModel({
    num? code,
    String? message,
    BasicProfilModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetBasicProfilModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? BasicProfilModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  BasicProfilModel? _payload;

  GetBasicProfilModel copyWith({
    num? code,
    String? message,
    BasicProfilModel? payload,
  }) =>
      GetBasicProfilModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  BasicProfilModel? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

class BasicProfilModel {
  BasicProfilModel({
    String? id,
    String? name,
    String? brand,
    String? phone,
    String? address,
    String? username,
    String? email,
    String? userType,
    String? emailRecovery,
    Origin? origin,
    String? zipCode,
  }) {
    _id = id;
    _name = name;
    _brand = brand;
    _phone = phone;
    _address = address;
    _username = username;
    _email = email;
    _userType = userType;
    _emailRecovery = emailRecovery;
    _origin = origin;
    _zipCode = zipCode;
  }

  BasicProfilModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _brand = json['brand'];
    _phone = json['phone'];
    _address = json['address'];
    _username = json['username'];
    _email = json['email'];
    _userType = json['user_type'];
    _emailRecovery = json['email_recovery'];
    _origin = json['origin'] != null ? Origin.fromJson(json['origin']) : null;
    _zipCode = json['zip_code'];
  }

  String? _id;
  String? _name;
  String? _brand;
  String? _phone;
  String? _address;
  String? _username;
  String? _email;
  String? _userType;
  String? _emailRecovery;
  Origin? _origin;
  String? _zipCode;

  BasicProfilModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? phone,
    String? address,
    String? username,
    String? email,
    String? userType,
    String? emailRecovery,
    Origin? origin,
    String? zipCode,
  }) =>
      BasicProfilModel(
        id: id ?? _id,
        name: name ?? _name,
        brand: brand ?? _brand,
        phone: phone ?? _phone,
        address: address ?? _address,
        username: username ?? _username,
        email: email ?? _email,
        userType: userType ?? _userType,
        emailRecovery: emailRecovery ?? _emailRecovery,
        origin: origin ?? _origin,
        zipCode: zipCode ?? _zipCode,
      );

  String? get id => _id;

  String? get name => _name;

  String? get brand => _brand;

  String? get phone => _phone;

  String? get address => _address;

  String? get username => _username;

  String? get email => _email;

  String? get userType => _userType;

  String? get emailRecovery => _emailRecovery;

  Origin? get origin => _origin;

  String? get zipCode => _zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['brand'] = _brand;
    map['phone'] = _phone;
    map['address'] = _address;
    map['username'] = _username;
    map['email'] = _email;
    map['user_type'] = _userType;
    map['email_recovery'] = _emailRecovery;
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    map['zip_code'] = _zipCode;
    return map;
  }
}
