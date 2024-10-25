import 'dart:convert';

GetServiceModel getServiceModelFromJson(String str) =>
    GetServiceModel.fromJson(json.decode(str));
String getServiceModelToJson(GetServiceModel data) =>
    json.encode(data.toJson());

class GetServiceModel {
  GetServiceModel({
    num? code,
    String? message,
    List<ServiceModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetServiceModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(ServiceModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<ServiceModel>? _payload;

  GetServiceModel copyWith({
    num? code,
    String? message,
    List<ServiceModel>? payload,
  }) =>
      GetServiceModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<ServiceModel>? get payload => _payload;

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

ServiceModel payloadFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String payloadToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    String? serviceDisplay,
    String? serviceCode,
    String? goodsType,
    String? currency,
    String? price,
  }) {
    _serviceDisplay = serviceDisplay;
    _serviceCode = serviceCode;
    _goodsType = goodsType;
    _currency = currency;
    _price = price;
  }

  ServiceModel.fromJson(dynamic json) {
    _serviceDisplay = json['service_display'];
    _serviceCode = json['service_code'];
    _goodsType = json['goods_type'];
    _currency = json['currency'];
    _price = json['price'];
  }
  String? _serviceDisplay;
  String? _serviceCode;
  String? _goodsType;
  String? _currency;
  String? _price;

  ServiceModel copyWith({
    String? serviceDisplay,
    String? serviceCode,
    String? goodsType,
    String? currency,
    String? price,
  }) =>
      ServiceModel(
        serviceDisplay: serviceDisplay ?? _serviceDisplay,
        serviceCode: serviceCode ?? _serviceCode,
        goodsType: goodsType ?? _goodsType,
        currency: currency ?? _currency,
        price: price ?? _price,
      );
  String? get serviceDisplay => _serviceDisplay;
  String? get serviceCode => _serviceCode;
  String? get goodsType => _goodsType;
  String? get currency => _currency;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_display'] = _serviceDisplay;
    map['service_code'] = _serviceCode;
    map['goods_type'] = _goodsType;
    map['currency'] = _currency;
    map['price'] = _price;
    return map;
  }
}
