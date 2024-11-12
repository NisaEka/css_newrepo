import 'dart:convert';

TransactionFeeModel payloadFromJson(String str) =>
    TransactionFeeModel.fromJson(json.decode(str));

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
