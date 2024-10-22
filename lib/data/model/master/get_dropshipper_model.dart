import 'dart:convert';

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
    _id = json['id'] ?? json['dropshipperId'];
    _name = json['name'] ?? json['dropshipperName'];
    _phone = json['phone'] ?? json['dropshipperPhone'];
    _zipCode = json['zip_code'] ?? json['dropshipperZip'];
    _city = json['city'] ?? json['dropshipperCity'];
    _address = json['address'] ?? json['dropshipperAddress'];
    _origin = json['origin_code'] ?? json['dropshipperOrigin'] ?? json['origin'];
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
    map['dropshipperId'] = _id;
    map['dropshipperName'] = _name;
    map['dropshipperPhone'] = _phone;
    map['dropshipperZip'] = _zipCode;
    map['dropshipperCity'] = _city;
    map['dropshipperAddress'] = _address;
    map['dropshipperOrigin'] = _origin;
    map['origin_code'] = _origin;
    return map;
  }
}
