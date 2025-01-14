import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';

class GetTransactionByAwbModel {
  GetTransactionByAwbModel({
    num? code,
    String? message,
    DataTransactionModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionByAwbModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null
        ? DataTransactionModel.fromJson(json['payload'])
        : null;
  }

  num? _code;
  String? _message;
  DataTransactionModel? _payload;

  GetTransactionByAwbModel copyWith({
    num? code,
    String? message,
    DataTransactionModel? payload,
  }) =>
      GetTransactionByAwbModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  DataTransactionModel? get payload => _payload;

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
