class GetTransactionOfficerModel {
  GetTransactionOfficerModel({
    num? code,
    String? message,
    List<String>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionOfficerModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? json['payload'].cast<String>() : [];
  }

  num? _code;
  String? _message;
  List<String>? _payload;

  GetTransactionOfficerModel copyWith({
    num? code,
    String? message,
    List<String>? payload,
  }) =>
      GetTransactionOfficerModel(
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
