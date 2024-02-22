class GetTransactionCountModel {
  GetTransactionCountModel({
    num? code,
    String? message,
    Payload? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionCountModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  Payload? _payload;

  GetTransactionCountModel copyWith({
    num? code,
    String? message,
    Payload? payload,
  }) =>
      GetTransactionCountModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  Payload? get payload => _payload;

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

class Payload {
  Payload({
    num? total,
    num? cod,
    num? nonCod,
  }) {
    _total = total;
    _cod = cod;
    _nonCod = nonCod;
  }

  Payload.fromJson(dynamic json) {
    _total = json['total'];
    _cod = json['cod'];
    _nonCod = json['non_cod'];
  }

  num? _total;
  num? _cod;
  num? _nonCod;

  Payload copyWith({
    num? total,
    num? cod,
    num? nonCod,
  }) =>
      Payload(
        total: total ?? _total,
        cod: cod ?? _cod,
        nonCod: nonCod ?? _nonCod,
      );

  num? get total => _total;

  num? get cod => _cod;

  num? get nonCod => _nonCod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['cod'] = _cod;
    map['non_cod'] = _nonCod;
    return map;
  }
}
