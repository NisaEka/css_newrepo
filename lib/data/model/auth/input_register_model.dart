import 'auth_body_model.dart';
import 'get_device_info_model.dart';

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
    DeviceInfoModel? device,
    Coordinate? coordinate,
  }) {
    _fullName = fullName;
    _brandName = brandName;
    _phone = phone;
    _email = email;
    _referralCode = referralCode;
    _originCode = originCode;
    _alreadyUseJne = alreadyUseJne;
    _salesCounter = salesCounter;
    _device = device;
    _coordinate = coordinate;
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
    _device = json['device'] != null
        ? DeviceInfoModel.fromJson(json['device'])
        : json['deviceInfo'] != null
            ? DeviceInfoModel.fromJson(json['deviceInfo'])
            : null;
    _coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : json['longlat'] != null
            ? Coordinate.fromString(json['longlat'])
            : null;
  }

  String? _fullName;
  String? _brandName;
  String? _phone;
  String? _email;
  String? _referralCode;
  String? _originCode;
  String? _alreadyUseJne;
  String? _salesCounter;
  DeviceInfoModel? _device;
  Coordinate? _coordinate;

  InputRegisterModel copyWith({
    String? fullName,
    String? brandName,
    String? phone,
    String? email,
    String? referralCode,
    String? originCode,
    String? alreadyUseJne,
    String? salesCounter,
    DeviceInfoModel? device,
    Coordinate? coordinate,
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
        device: device ?? _device,
        coordinate: coordinate ?? _coordinate,
      );

  String? get fullName => _fullName;

  String? get brandName => _brandName;

  String? get phone => _phone;

  String? get email => _email;

  String? get referralCode => _referralCode;

  String? get originCode => _originCode;

  String? get alreadyUseJne => _alreadyUseJne;

  String? get salesCounter => _salesCounter;

  DeviceInfoModel? get device => _device;

  Coordinate? get coordinate => _coordinate;

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
    if (_device != null) {
      map['device'] = _device?.toJson();
      map['deviceInfo'] = _device?.toJson();
    }
    if (_coordinate != null) {
      map['coordinate'] = _coordinate?.toJson();
      map['longlat'] = _coordinate?.toLongLatString();
    }
    return map;
  }
}
