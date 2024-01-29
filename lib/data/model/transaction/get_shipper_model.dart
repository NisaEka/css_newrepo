import 'dart:convert';
GetShipperModel getShipperModelFromJson(String str) => GetShipperModel.fromJson(json.decode(str));
String getShipperModelToJson(GetShipperModel data) => json.encode(data.toJson());
class GetShipperModel {
  GetShipperModel({
      num? code,
      String? message,
      ShipperModel? payload,}){
    _code = code;
    _message = message;
    _payload = payload;
}

  GetShipperModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? ShipperModel.fromJson(json['payload']) : null;
  }
  num? _code;
  String? _message;
  ShipperModel? _payload;
GetShipperModel copyWith({  num? code,
  String? message,
  ShipperModel? payload,
}) => GetShipperModel(  code: code ?? _code,
  message: message ?? _message,
  payload: payload ?? _payload,
);
  num? get code => _code;
  String? get message => _message;
  ShipperModel? get payload => _payload;

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

ShipperModel payloadFromJson(String str) => ShipperModel.fromJson(json.decode(str));
String payloadToJson(ShipperModel data) => json.encode(data.toJson());
class ShipperModel {
  ShipperModel({
      String? name,
      String? phone,
      String? zipCode,
      String? address,
      ShipperOrigin? origin,
      Region? region,}){
    _name = name;
    _phone = phone;
    _zipCode = zipCode;
    _address = address;
    _origin = origin;
    _region = region;
}

  ShipperModel.fromJson(dynamic json) {
    _name = json['name'];
    _phone = json['phone'];
    _zipCode = json['zip_code'];
    _address = json['address'];
    _origin = json['origin'] != null ? ShipperOrigin.fromJson(json['origin']) : null;
    _region = json['region'] != null ? Region.fromJson(json['region']) : null;
  }
  String? _name;
  String? _phone;
  String? _zipCode;
  String? _address;
  ShipperOrigin? _origin;
  Region? _region;
ShipperModel copyWith({  String? name,
  String? phone,
  String? zipCode,
  String? address,
  ShipperOrigin? origin,
  Region? region,
}) => ShipperModel(  name: name ?? _name,
  phone: phone ?? _phone,
  zipCode: zipCode ?? _zipCode,
  address: address ?? _address,
  origin: origin ?? _origin,
  region: region ?? _region,
);
  String? get name => _name;
  String? get phone => _phone;
  String? get zipCode => _zipCode;
  String? get address => _address;
  ShipperOrigin? get origin => _origin;
  Region? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phone'] = _phone;
    map['zip_code'] = _zipCode;
    map['address'] = _address;
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    if (_region != null) {
      map['region'] = _region?.toJson();
    }
    return map;
  }

}

Region regionFromJson(String str) => Region.fromJson(json.decode(str));
String regionToJson(Region data) => json.encode(data.toJson());
class Region {
  Region({
      String? code,
      String? name,}){
    _code = code;
    _name = name;
}

  Region.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }
  String? _code;
  String? _name;
Region copyWith({  String? code,
  String? name,
}) => Region(  code: code ?? _code,
  name: name ?? _name,
);
  String? get code => _code;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }

}

ShipperOrigin originFromJson(String str) => ShipperOrigin.fromJson(json.decode(str));
String originToJson(ShipperOrigin data) => json.encode(data.toJson());
class ShipperOrigin {
  ShipperOrigin({
      String? originCode,
      String? originName,
      String? branchCode,}){
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
}

  ShipperOrigin.fromJson(dynamic json) {
    _originCode = json['origin_code'];
    _originName = json['origin_name'];
    _branchCode = json['branch_code'];
  }
  String? _originCode;
  String? _originName;
  String? _branchCode;
ShipperOrigin copyWith({  String? originCode,
  String? originName,
  String? branchCode,
}) => ShipperOrigin(  originCode: originCode ?? _originCode,
  originName: originName ?? _originName,
  branchCode: branchCode ?? _branchCode,
);
  String? get originCode => _originCode;
  String? get originName => _originName;
  String? get branchCode => _branchCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_code'] = _originCode;
    map['origin_name'] = _originName;
    map['branch_code'] = _branchCode;
    return map;
  }

}