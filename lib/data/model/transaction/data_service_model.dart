import 'dart:convert';

DataServiceModel serviceDataModelFromJson(String str) =>
    DataServiceModel.fromJson(json.decode(str));

String serviceDataModelToJson(DataServiceModel data) =>
    json.encode(data.toJson());

class DataServiceModel {
  DataServiceModel({
    String? accountNumber,
    String? originCode,
    String? destinationCode,
    num? weight,
  }) {
    _accountNumber = accountNumber;
    _originCode = originCode;
    _destinationCode = destinationCode;
    _weight = weight;
  }

  DataServiceModel.fromJson(dynamic json) {
    _accountNumber = json['accountNumber'];
    _originCode = json['originCode'];
    _destinationCode = json['destinationCode'];
    _weight = json['weight'];
  }

  String? _accountNumber;
  String? _originCode;
  String? _destinationCode;
  num? _weight;

  DataServiceModel copyWith({
    String? accountNumber,
    String? originCode,
    String? destinationCode,
    num? weight,
  }) =>
      DataServiceModel(
        accountNumber: accountNumber ?? _accountNumber,
        originCode: originCode ?? _originCode,
        destinationCode: destinationCode ?? _destinationCode,
        weight: weight ?? _weight,
      );

  String? get accountNumber => _accountNumber;

  String? get originCode => _originCode;

  String? get destinationCode => _destinationCode;

  num? get weigth => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountNumber'] = _accountNumber;
    map['originCode'] = _originCode;
    map['destinationCode'] = _destinationCode;
    if (_weight != null) {
      map['weight'] = _weight;
    }

    return map;
  }
}
