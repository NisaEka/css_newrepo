import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'get_origin_model.dart';

import 'dart:convert';

ShipperModel payloadFromJson(String str) =>
    ShipperModel.fromJson(json.decode(str));

class ShipperModel {
  ShipperModel({
    this.name,
    this.address,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.zipCode,
    this.region,
    this.country,
    this.contact,
    this.phone,
    this.dropship = false,
    this.origin,
  });

  ShipperModel.fromJson(dynamic json)
      : name = json['name'] ?? json['ccrfName'],
        address = json['address'] ?? json['ccrfAddress'],
        address1 = json['address1'],
        address2 = json['address2'],
        address3 = json['address3'],
        city = json['city'],
        zipCode = json['zip'] ?? json['zip_code'] ?? json['ccrfZipcode'],
        country = json['country'],
        contact = json['contact'],
        phone = json['phone'] ?? json['ccrfPhone'],
        dropship = json['dropship'] ?? false,
        origin = json['origin'] != null
            ? OriginModel.fromJson(json['origin'])
            : null,
        region = json['region'] != null
            ? RegionModel.fromJson(json['region'])
            : null;

  /// Shipper attributes
  String? name;
  String? address;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? zipCode;
  RegionModel? region;
  String? country;
  String? contact;
  String? phone;
  bool dropship;
  OriginModel? origin;

  /// Copy with method
  ShipperModel copyWith({
    String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zipCode,
    RegionModel? region,
    String? country,
    String? contact,
    String? phone,
    bool? dropship,
    OriginModel? origin,
  }) {
    return ShipperModel(
      name: name ?? this.name,
      address: address ?? this.address,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      region: region ?? this.region,
      country: country ?? this.country,
      contact: contact ?? this.contact,
      phone: phone ?? this.phone,
      dropship: dropship ?? this.dropship,
      origin: origin ?? this.origin,
    );
  }

  /// Getters
  String? get getName => name;
  String? get getAddress => address;
  String? get getAddress1 => address1;
  String? get getAddress2 => address2;
  String? get getAddress3 => address3;
  String? get getCity => city;
  String? get getZipCode => zipCode;
  RegionModel? get getRegion => region;
  String? get getCountry => country;
  String? get getContact => contact;
  String? get getPhone => phone;
  bool get isDropship => dropship;
  OriginModel? get getOrigin => origin;

  /// toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ccrfName': name,
      'address': address,
      'ccrfAddress': address,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'city': city,
      'zip_code': zipCode,
      'ccrfZipcode': zipCode,
      'zip': zipCode,
      'country': country,
      'contact': contact,
      'phone': phone,
      'ccrfPhone': phone,
      'dropship': dropship,
      'origin': origin?.toJson(),
      'region': region?.toJson(),
    };
  }
}
