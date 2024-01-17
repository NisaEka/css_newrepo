import 'dart:convert';

GetDestinationModel getDestinationModelFromJson(String str) => GetDestinationModel.fromJson(json.decode(str));

String getDestinationModelToJson(GetDestinationModel data) => json.encode(data.toJson());

class GetDestinationModel {
  GetDestinationModel({
    num? code,
    String? message,
    List<DestinationModel>? payload,
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
        _payload?.add(DestinationModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<DestinationModel>? _payload;

  GetDestinationModel copyWith({
    num? code,
    String? message,
    List<DestinationModel>? payload,
  }) =>
      GetDestinationModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<DestinationModel>? get payload => _payload;

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

DestinationModel payloadFromJson(String str) => DestinationModel.fromJson(json.decode(str));

String payloadToJson(DestinationModel data) => json.encode(data.toJson());

class DestinationModel {
  DestinationModel({
    String? id,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subDistrictName,
    String? zipCode,
    String? tariffCode,
  }) {
    _id = id;
    _countryName = countryName;
    _provinceName = provinceName;
    _cityName = cityName;
    _districtName = districtName;
    _subDistrictName = subDistrictName;
    _zipCode = zipCode;
    _tariffCode = tariffCode;
  }

  DestinationModel.fromJson(dynamic json) {
    _id = json['id'];
    _countryName = json['country_name'];
    _provinceName = json['province_name'];
    _cityName = json['city_name'];
    _districtName = json['district_name'];
    _subDistrictName = json['sub_district_name'];
    _zipCode = json['zip_code'];
    _tariffCode = json['tariff_code'];
  }

  String? _id;
  String? _countryName;
  String? _provinceName;
  String? _cityName;
  String? _districtName;
  String? _subDistrictName;
  String? _zipCode;
  String? _tariffCode;

  DestinationModel copyWith({
    String? id,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subDistrictName,
    String? zipCode,
    String? tariffCode,
  }) =>
      DestinationModel(
        id: id ?? _id,
        countryName: countryName ?? _countryName,
        provinceName: provinceName ?? _provinceName,
        cityName: cityName ?? _cityName,
        districtName: districtName ?? _districtName,
        subDistrictName: subDistrictName ?? _subDistrictName,
        zipCode: zipCode ?? _zipCode,
        tariffCode: tariffCode ?? _tariffCode,
      );

  String? get id => _id;

  String? get countryName => _countryName;

  String? get provinceName => _provinceName;

  String? get cityName => _cityName;

  String? get districtName => _districtName;

  String? get subDistrictName => _subDistrictName;

  String? get zipCode => _zipCode;

  String? get tariffCode => _tariffCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country_name'] = _countryName;
    map['province_name'] = _provinceName;
    map['city_name'] = _cityName;
    map['district_name'] = _districtName;
    map['sub_district_name'] = _subDistrictName;
    map['zip_code'] = _zipCode;
    map['tariff_code'] = _tariffCode;
    return map;
  }
}
