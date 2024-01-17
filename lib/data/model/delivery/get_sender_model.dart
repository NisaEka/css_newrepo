import 'dart:convert';

GetSenderModel getSenderModelFromJson(String str) => GetSenderModel.fromJson(json.decode(str));

String getSenderModelToJson(GetSenderModel data) => json.encode(data.toJson());

class GetSenderModel {
  GetSenderModel({
    num? code,
    String? message,
    Sender? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetSenderModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? Sender.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  Sender? _payload;

  GetSenderModel copyWith({
    num? code,
    String? message,
    Sender? payload,
  }) =>
      GetSenderModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  Sender? get payload => _payload;

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

Sender payloadFromJson(String str) => Sender.fromJson(json.decode(str));

String payloadToJson(Sender data) => json.encode(data.toJson());

class Sender {
  Sender({
    String? name,
    String? phone,
    String? city,
    String? zipCode,
    String? address,
  }) {
    _name = name;
    _phone = phone;
    _city = city;
    _zipCode = zipCode;
    _address = address;
  }

  Sender.fromJson(dynamic json) {
    _name = json['name'];
    _phone = json['phone'];
    _city = json['city'];
    _zipCode = json['zip_code'];
    _address = json['address'];
  }

  String? _name;
  String? _phone;
  String? _city;
  String? _zipCode;
  String? _address;

  Sender copyWith({
    String? name,
    String? phone,
    String? city,
    String? zipCode,
    String? address,
  }) =>
      Sender(
        name: name ?? _name,
        phone: phone ?? _phone,
        city: city ?? _city,
        zipCode: zipCode ?? _zipCode,
        address: address ?? _address,
      );

  String? get name => _name;

  String? get phone => _phone;

  String? get city => _city;

  String? get zipCode => _zipCode;

  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phone'] = _phone;
    map['city'] = _city;
    map['zip_code'] = _zipCode;
    map['address'] = _address;
    return map;
  }
}
