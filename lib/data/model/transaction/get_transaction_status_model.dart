class GetTransactionStatusModel {
  GetTransactionStatusModel({
    num? code,
    String? message,
    List<String>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionStatusModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? json['payload'].cast<String>() : [];
  }

  num? _code;
  String? _message;
  List<String>? _payload;

  GetTransactionStatusModel copyWith({
    num? code,
    String? message,
    List<String>? payload,
  }) =>
      GetTransactionStatusModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<String>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['payload'] = _payload;
    return map;
  }
}
