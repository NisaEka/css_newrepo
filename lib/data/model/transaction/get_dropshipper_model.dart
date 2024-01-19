import 'dart:convert';

GetDropshipperModel getDropshipperModelFromJson(String str) => GetDropshipperModel.fromJson(json.decode(str));

String getDropshipperModelToJson(GetDropshipperModel data) => json.encode(data.toJson());

class GetDropshipperModel {
  GetDropshipperModel({
    num? code,
    String? message,
    List<DropshipperModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetDropshipperModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(DropshipperModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<DropshipperModel>? _payload;

  GetDropshipperModel copyWith({
    num? code,
    String? message,
    List<DropshipperModel>? payload,
  }) =>
      GetDropshipperModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<DropshipperModel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

DropshipperModel payloadFromJson(String str) => DropshipperModel.fromJson(json.decode(str));

String payloadToJson(DropshipperModel data) => json.encode(data.toJson());

class DropshipperModel {
  DropshipperModel({
    String? id,
    String? name,
    String? phone,
    String? zipCode,
    String? city,
    String? address,
    String? origin,
  }) {
    _id = id;
    _name = name;
    _phone = phone;
    _zipCode = zipCode;
    _city = city;
    _address = address;
    _origin = origin;
  }

  DropshipperModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _zipCode = json['zip_code'];
    _city = json['city'];
    _address = json['address'];
    _origin = json['origin'];
  }

  String? _id;
  String? _name;
  String? _phone;
  String? _zipCode;
  String? _city;
  String? _address;
  String? _origin;

  DropshipperModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? zipCode,
    String? city,
    String? address,
    String? origin,
  }) =>
      DropshipperModel(
        id: id ?? _id,
        name: name ?? _name,
        phone: phone ?? _phone,
        zipCode: zipCode ?? _zipCode,
        city: city ?? _city,
        address: address ?? _address,
        origin: origin ?? _origin,
      );

  String? get id => _id;

  String? get name => _name;

  String? get phone => _phone;

  String? get zipCode => _zipCode;

  String? get city => _city;

  String? get address => _address;

  String? get origin => _origin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['zip_code'] = _zipCode;
    map['city'] = _city;
    map['address'] = _address;
    map['origin'] = _origin;
    return map;
  }
}
