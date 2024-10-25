import 'dart:convert';

DataServiceModel serviceDataModelFromJson(String str) => DataServiceModel.fromJson(json.decode(str));

String serviceDataModelToJson(DataServiceModel data) => json.encode(data.toJson());

class DataServiceModel {
  DataServiceModel({
    String? accountId,
    String? originCode,
    String? destinationCode,
    num? weight,
  }) {
    _accountId = accountId;
    _originCode = originCode;
    _destinationCode = destinationCode;
    _weight = weight;
  }

  DataServiceModel.fromJson(dynamic json) {
    _accountId = json['accountNumber'];
    _originCode = json['originCode'];
    _destinationCode = json['destinationCode'];
    _weight = json['weight'];
  }

  String? _accountId;
  String? _originCode;
  String? _destinationCode;
  num? _weight;

  DataServiceModel copyWith({
    String? accountId,
    String? originCode,
    String? destinationCode,
    num? weight,
  }) =>
      DataServiceModel(
        accountId: accountId ?? _accountId,
        originCode: originCode ?? _originCode,
        destinationCode: destinationCode ?? _destinationCode,
        weight: weight ?? _weight,
      );

  String? get accountId => _accountId;

  String? get originCode => _originCode;

  String? get destinationCode => _destinationCode;

  num? get weigth => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountNumber'] = _accountId;
    map['originCode'] = _originCode;
    map['destinationCode'] = _destinationCode;
    if (_weight != null) {
      map['weight'] = _weight;
    }

    return map;
  }
}
