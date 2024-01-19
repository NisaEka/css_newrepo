import 'dart:convert';
ServiceDataModel serviceDataModelFromJson(String str) => ServiceDataModel.fromJson(json.decode(str));
String serviceDataModelToJson(ServiceDataModel data) => json.encode(data.toJson());
class ServiceDataModel {
  ServiceDataModel({
      String? accountId, 
      String? originCode, 
      String? destinationCode,}){
    _accountId = accountId;
    _originCode = originCode;
    _destinationCode = destinationCode;
}

  ServiceDataModel.fromJson(dynamic json) {
    _accountId = json['account_id'];
    _originCode = json['origin_code'];
    _destinationCode = json['destination_code'];
  }
  String? _accountId;
  String? _originCode;
  String? _destinationCode;
ServiceDataModel copyWith({  String? accountId,
  String? originCode,
  String? destinationCode,
}) => ServiceDataModel(  accountId: accountId ?? _accountId,
  originCode: originCode ?? _originCode,
  destinationCode: destinationCode ?? _destinationCode,
);
  String? get accountId => _accountId;
  String? get originCode => _originCode;
  String? get destinationCode => _destinationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_id'] = _accountId;
    map['origin_code'] = _originCode;
    map['destination_code'] = _destinationCode;
    return map;
  }

}