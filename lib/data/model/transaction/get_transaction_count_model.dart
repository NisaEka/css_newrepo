class TransactionCount {
  TransactionCount({
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    String? status,
  }) {
    _total = total;
    _totalCod = totalCod;
    _totalNonCod = totalNonCod;
    _totalCodOngkir = totalCodOngkir;
    _status = status;
  }

  TransactionCount.fromJson(dynamic json) {
    _total = json['total'];
    _totalCod = json['totalCod'];
    _totalNonCod = json['totalNonCod'];
    _totalCodOngkir = json['totalCodOngkir'];
    _status = json['status'];
  }

  num? _total;
  num? _totalCod;
  num? _totalNonCod;
  num? _totalCodOngkir;
  String? _status;

  TransactionCount copyWith({
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    String? status,
  }) =>
      TransactionCount(
        total: total ?? _total,
        totalCod: totalCod ?? _totalCod,
        totalNonCod: totalNonCod ?? _totalNonCod,
        totalCodOngkir: totalCodOngkir ?? _totalCodOngkir,
        status: status ?? _status,
      );

  num? get total => _total;

  num? get totalCod => _totalCod;

  num? get totalNonCod => _totalNonCod;

  num? get totalCodOngkir => _totalCodOngkir;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['totalCod'] = _totalCod;
    map['totalNonCod'] = _totalNonCod;
    map['totalCodOngkir'] = _totalCodOngkir;
    map['status'] = _status;
    return map;
  }
}
