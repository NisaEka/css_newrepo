import 'dart:convert';

DataServiceModel serviceDataModelFromJson(String str) =>
    DataServiceModel.fromJson(json.decode(str));
String serviceDataModelToJson(DataServiceModel data) =>
    json.encode(data.toJson());

class DataServiceModel {
  DataServiceModel({
    String? accountId,
    String? originCode,
    String? destinationCode,
  }) {
    _accountId = accountId;
    _originCode = originCode;
    _destinationCode = destinationCode;
  }

  DataServiceModel.fromJson(dynamic json) {
    _accountId = json['account_id'];
    _originCode = json['origin_code'];
    _destinationCode = json['destination_code'];
  }
  String? _accountId;
  String? _originCode;
  String? _destinationCode;
  DataServiceModel copyWith({
    String? accountId,
    String? originCode,
    String? destinationCode,
  }) =>
      DataServiceModel(
        accountId: accountId ?? _accountId,
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
