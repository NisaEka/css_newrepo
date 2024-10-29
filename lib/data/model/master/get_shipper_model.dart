import 'dart:convert';

import 'package:css_mobile/data/model/master/get_region_model.dart';

import 'get_origin_model.dart';

Shipper shipperFromJson(String str) => Shipper.fromJson(json.decode(str));

String shipperToJson(Shipper data) => json.encode(data.toJson());

class Shipper {
  Shipper({
    String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zipCode,
    Region? region,
    String? country,
    String? contact,
    String? phone,
    bool? dropship,
    Origin? origin,
  }) {
    _name = name;
    _address = address;
    _address1 = address1;
    _address2 = address2;
    _address3 = address3;
    _city = city;
    _zipCode = zipCode;
    _region = region;
    _country = country;
    _contact = contact;
    _phone = phone;
    _dropship = dropship;
    _origin = origin;
  }

  Shipper.fromJson(dynamic json) {
    _name = json['name'] ?? json['ccrfName'];
    _address = json['address'] ?? json['ccrfAddress'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _address3 = json['address3'];
    _city = json['city'];
    _zipCode = json['zip'] ?? json['zip_code'] ?? json['ccrfZipcode'];
    _country = json['country'];
    _contact = json['contact'];
    _phone = json['phone'] ?? json['ccrfPhone'];
    _dropship = json['dropship'];
    // _zip = json['zip_code'];
    _origin = json['origin'] != null ? Origin.fromJson(json['origin']) : json['origin'];
    _region = json['region'] != null ? Region.fromJson(json['region']) : json['region'];
  }

  String? _name;
  String? _address;
  String? _address1;
  String? _address2;
  String? _address3;
  String? _city;
  String? _zipCode;
  Region? _region;
  String? _country;
  String? _contact;
  String? _phone;
  bool? _dropship;
  Origin? _origin;

  Shipper copyWith({
    String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zipCode,
    Region? region,
    String? country,
    String? contact,
    String? phone,
    bool? dropship,
    Origin? origin,
  }) =>
      Shipper(
        name: name ?? _name,
        address: address ?? _address,
        address1: address1 ?? _address1,
        address2: address2 ?? _address2,
        address3: address3 ?? _address3,
        city: city ?? _city,
        zipCode: zipCode ?? _zipCode,
        region: region ?? _region,
        country: country ?? _country,
        contact: contact ?? _contact,
        phone: phone ?? _phone,
        dropship: dropship ?? _dropship,
        origin: origin ?? _origin,
      );

  String? get name => _name;

  String? get address => _address;

  String? get address1 => _address1;

  String? get address2 => _address2;

  String? get address3 => _address3;

  String? get city => _city;

  String? get zipCode => _zipCode;

  Region? get region => _region;

  String? get country => _country;

  String? get contact => _contact;

  String? get phone => _phone;

  bool? get dropship => _dropship;

  Origin? get origin => _origin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['ccrfName'] = _name;
    map['address'] = _address;
    map['ccrfAddress'] = _address;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['address3'] = _address3;
    map['city'] = _city;
    map['zip'] = _zipCode;
    map['ccrfZipcode'] = _zipCode;
    map['country'] = _country;
    map['contact'] = _contact;
    map['phone'] = _phone;
    map['ccrfPhone'] = _phone;
    map['dropship'] = _dropship;
    map['zip_code'] = _zipCode;
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    } else {
      map['origin'] = _origin;
    }
    if (_region != null) {
      map['region'] = _region?.toJson();
    } else {
      map['region'] = _region;
    }

    return map;
  }
}
