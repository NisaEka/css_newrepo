import 'dart:convert';

import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';

ShipperModel payloadFromJson(String str) =>
    ShipperModel.fromJson(json.decode(str));

String payloadToJson(ShipperModel data) => json.encode(data.toJson());

class ShipperModel {
  ShipperModel({
    String? name,
    String? phone,
    String? zipCode,
    String? address,
    Origin? origin,
    Region? region,
  }) {
    _name = name;
    _phone = phone;
    _zipCode = zipCode;
    _address = address;
    _origin = origin;
    _region = region;
  }

  ShipperModel.fromJson(dynamic json) {
    _name = json['name'] ?? json['ccrfName'];
    _phone = json['phone'] ?? json['ccrfPhone'];
    _zipCode = json['zip_code'] ?? json['ccrfZipcode'] ?? json['zipCode'];
    _address = json['address'] ?? json['ccrfAddress'];
    _origin = json['origin'] != null ? Origin.fromJson(json['origin']) : null;
    _region = json['region'] != null ? Region.fromJson(json['region']) : null;
  }

  String? _name;
  String? _phone;
  String? _zipCode;
  String? _address;
  Origin? _origin;
  Region? _region;

  ShipperModel copyWith({
    String? name,
    String? phone,
    String? zipCode,
    String? address,
    Origin? origin,
    Region? region,
  }) =>
      ShipperModel(
        name: name ?? _name,
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

  Origin? get origin => _origin;

  Region? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phone'] = _phone;
    map['zip_code'] = _zipCode;
    map['zipCode'] = _zipCode;
    map['address'] = _address;
    map['ccrfName'] = _name;
    map['ccrfPhone'] = _phone;
    map['ccrfZipcode'] = _zipCode;
    map['ccrfAddress'] = _address;

    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    if (_region != null) {
      map['region'] = _region?.toJson();
    }
    return map;
  }
}
