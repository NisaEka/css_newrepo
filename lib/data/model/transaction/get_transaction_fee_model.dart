import 'dart:convert';

GetTransactionFeeModel getTransactionFeeModelFromJson(String str) => GetTransactionFeeModel.fromJson(json.decode(str));

String getTransactionFeeModelToJson(GetTransactionFeeModel data) => json.encode(data.toJson());

class GetTransactionFeeModel {
  GetTransactionFeeModel({
    num? code,
    String? message,
    TransactionFeeModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionFeeModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? TransactionFeeModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  TransactionFeeModel? _payload;

  GetTransactionFeeModel copyWith({
    num? code,
    String? message,
    TransactionFeeModel? payload,
  }) =>
      GetTransactionFeeModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  TransactionFeeModel? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

TransactionFeeModel payloadFromJson(String str) => TransactionFeeModel.fromJson(json.decode(str));

String payloadToJson(TransactionFeeModel data) => json.encode(data.toJson());

class TransactionFeeModel {
  TransactionFeeModel({
    int? flatRate,
    int? freightCharge,
  }) {
    _flatRate = flatRate;
    _freightCharge = freightCharge;
  }

  TransactionFeeModel.fromJson(dynamic json) {
    _flatRate = json['flat_rate'];
    _freightCharge = json['freight_charge'];
  }

  int? _flatRate;
  int? _freightCharge;

  TransactionFeeModel copyWith({
    int? flatRate,
    int? freightCharge,
  }) =>
      TransactionFeeModel(
        flatRate: flatRate ?? _flatRate,
        freightCharge: freightCharge ?? _freightCharge,
      );

  int? get flatRate => _flatRate;

  int? get freightCharge => _freightCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flat_rate'] = _flatRate;
    map['freight_charge'] = _freightCharge;
    return map;
  }
}
