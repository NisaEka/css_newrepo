import 'dart:convert';
GetDestinationModel getDestinationModelFromJson(String str) => GetDestinationModel.fromJson(json.decode(str));
String getDestinationModelToJson(GetDestinationModel data) => json.encode(data.toJson());
class GetDestinationModel {
  GetDestinationModel({
    num? code,
    String? message,
    List<Destination>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetDestinationModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(Destination.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<Destination>? _payload;

  GetDestinationModel copyWith({
    num? code,
    String? message,
    List<Destination>? payload,
  }) =>
      GetDestinationModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<Destination>? get payload => _payload;

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

Destination payloadFromJson(String str) => Destination.fromJson(json.decode(str));

String payloadToJson(Destination data) => json.encode(data.toJson());

class Destination {
  Destination({
    num? id,
    String? destinationCode,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subDistrictName,
    String? zipCode,
  }) {
    _id = id;
    _destinationCode = destinationCode;
    _countryName = countryName;
    _provinceName = provinceName;
    _cityName = cityName;
    _districtName = districtName;
    _subDistrictName = subDistrictName;
    _zipCode = zipCode;
  }

  Destination.fromJson(dynamic json) {
    _id = json['id'];
    _destinationCode = json['destination_code'] ?? json['code'];
    _countryName = json['country_name'];
    _provinceName = json['province_name'];
    _cityName = json['city_name'] ?? json['desc'];
    _districtName = json['district_name'];
    _subDistrictName = json['sub_district_name'];
    _zipCode = json['zip_code'];
  }

  num? _id;
  String? _destinationCode;
  String? _countryName;
  String? _provinceName;
  String? _cityName;
  String? _districtName;
  String? _subDistrictName;
  String? _zipCode;

  Destination copyWith({
    num? id,
    String? destinationCode,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subDistrictName,
    String? zipCode,
  }) =>
      Destination(
        id: id ?? _id,
        destinationCode: destinationCode ?? _destinationCode,
        countryName: countryName ?? _countryName,
        provinceName: provinceName ?? _provinceName,
        cityName: cityName ?? _cityName,
        districtName: districtName ?? _districtName,
        subDistrictName: subDistrictName ?? _subDistrictName,
        zipCode: zipCode ?? _zipCode,
      );

  num? get id => _id;

  String? get destinationCode => _destinationCode;

  String? get countryName => _countryName;

  String? get provinceName => _provinceName;

  String? get cityName => _cityName;

  String? get districtName => _districtName;

  String? get subDistrictName => _subDistrictName;

  String? get zipCode => _zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['destination_code'] = _destinationCode;
    map['code'] = _destinationCode;
    map['country_name'] = _countryName;
    map['province_name'] = _provinceName;
    map['city_name'] = _cityName;
    map['desc'] = _cityName;
    map['district_name'] = _districtName;
    map['sub_district_name'] = _subDistrictName;
    map['zip_code'] = _zipCode;
    return map;
  }
}