import 'dart:convert';

DataTransactionFeeModel transactionFeeDataModelFromJson(String str) => DataTransactionFeeModel.fromJson(json.decode(str));

String transactionFeeDataModelToJson(DataTransactionFeeModel data) => json.encode(data.toJson());

class DataTransactionFeeModel {
  DataTransactionFeeModel({
    String? originCode,
    String? destinationCode,
    String? serviceCode,
    num? weight,
    String? custNo,
    String? type,
  }) {
    _originCode = originCode;
    _destinationCode = destinationCode;
    _serviceCode = serviceCode;
    _weight = weight;
    _custNo = custNo;
    _type = type;
  }

  DataTransactionFeeModel.fromJson(dynamic json) {
    _originCode = json['origin_code'];
    _destinationCode = json['destination_code'];
    _serviceCode = json['service_code'];
    _weight = json['weight'];
    _custNo = json['cust_no'];
    _type = json['type'];
  }

  String? _originCode;
  String? _destinationCode;
  String? _serviceCode;
  num? _weight;
  String? _custNo;
  String? _type;

  DataTransactionFeeModel copyWith({
    String? originCode,
    String? destinationCode,
    String? serviceCode,
    num? weight,
    String? custNo,
    String? type,
  }) =>
      DataTransactionFeeModel(
        originCode: originCode ?? _originCode,
        destinationCode: destinationCode ?? _destinationCode,
        serviceCode: serviceCode ?? _serviceCode,
        weight: weight ?? _weight,
        custNo: custNo ?? _custNo,
        type: type ?? _type,
      );

  String? get originCode => _originCode;

  String? get destinationCode => _destinationCode;

  String? get serviceCode => _serviceCode;

  num? get weight => _weight;

  String? get custNo => _custNo;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_code'] = _originCode;
    map['destination_code'] = _destinationCode;
    map['service_code'] = _serviceCode;
    map['weight'] = _weight;
    map['cust_no'] = _custNo;
    map['type'] = _type;
    return map;
  }
}
