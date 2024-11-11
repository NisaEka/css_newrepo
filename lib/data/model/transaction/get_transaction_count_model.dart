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
    _nonCod = json['nonCod'];
    _codOngkir = json['codOngkir'];
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
    map['nonCod'] = _nonCod;
    map['codOngkir'] = _codOngkir;
    return map;
  }
}
