class GetTransactionCountModel {
  GetTransactionCountModel({
    num? code,
    String? message,
    TransactionCount? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionCountModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null
        ? TransactionCount.fromJson(json['payload'])
        : null;
  }

  num? _code;
  String? _message;
  TransactionCount? _payload;

  GetTransactionCountModel copyWith({
    num? code,
    String? message,
    TransactionCount? payload,
  }) =>
      GetTransactionCountModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  TransactionCount? get payload => _payload;

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

class TransactionCount {
  TransactionCount({
    num? total,
    num? cod,
    num? nonCod,
    num? codOngkir,
  }) {
    _total = total;
    _cod = cod;
    _nonCod = nonCod;
    _codOngkir = codOngkir;
  }

  TransactionCount.fromJson(dynamic json) {
    _total = json['total'];
    _cod = json['cod'];
    _nonCod = json['non_cod'];
    _codOngkir = json['cod_ongkir'];
  }

  num? _total;
  num? _cod;
  num? _nonCod;
  num? _codOngkir;

  TransactionCount copyWith({
    num? total,
    num? cod,
    num? nonCod,
    num? codOngkir,
  }) =>
      TransactionCount(
        total: total ?? _total,
        cod: cod ?? _cod,
        nonCod: nonCod ?? _nonCod,
        codOngkir: codOngkir ?? _codOngkir,
      );

  num? get total => _total;

  num? get cod => _cod;

  num? get nonCod => _nonCod;

  num? get codOngkir => _codOngkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['cod'] = _cod;
    map['non_cod'] = _nonCod;
    map['cod_ongkir'] = _codOngkir;
    return map;
  }
}
