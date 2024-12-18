class PantauPaketmuCountModel {
  PantauPaketmuCountModel({
    String? status,
    num? totalCod,
    num? codAmount,
    num? ongkirCodAmount,
    num? totalCodOngkir,
    num? codOngkirAmount,
    num? totalNonCod,
    num? ongkirNonCodAmount,
    num? totalCodPercentage,
    num? codAmountPercentage,
    num? ongkirCodAmountPercentage,
    num? totalCodOngkirPercentage,
    num? codOngkirAmountPercentage,
    num? totalNonCodPercentage,
    num? ongkirNonCodAmountPercentage,
  }) {
    _status = status;
    _totalCod = totalCod;
    _codAmount = codAmount;
    _ongkirCodAmount = ongkirCodAmount;
    _totalCodOngkir = totalCodOngkir;
    _codOngkirAmount = codOngkirAmount;
    _totalNonCod = totalNonCod;
    _ongkirNonCodAmount = ongkirNonCodAmount;
    _totalCodPercentage = totalCodPercentage;
    _codAmountPercentage = codAmountPercentage;
    _ongkirCodAmountPercentage = ongkirCodAmountPercentage;
    _totalCodOngkirPercentage = totalCodOngkirPercentage;
    _codOngkirAmountPercentage = codOngkirAmountPercentage;
    _totalNonCodPercentage = totalNonCodPercentage;
    _ongkirNonCodAmountPercentage = ongkirNonCodAmountPercentage;
  }

  PantauPaketmuCountModel.fromJson(dynamic json) {
    _status = json['status'];
    _totalCod = json['totalCod'];
    _codAmount = json['codAmount'];
    _ongkirCodAmount = json['ongkirCodAmount'];
    _totalCodOngkir = json['totalCodOngkir'];
    _codOngkirAmount = json['codOngkirAmount'];
    _totalNonCod = json['totalNonCod'];
    _ongkirNonCodAmount = json['ongkirNonCodAmount'];
    _totalCodPercentage = json['totalCodPercentage'];
    _codAmountPercentage = json['codAmountPercentage'];
    _ongkirCodAmountPercentage = json['ongkirCodAmountPercentage'];
    _totalCodOngkirPercentage = json['totalCodOngkirPercentage'];
    _codOngkirAmountPercentage = json['codOngkirAmountPercentage'];
    _totalNonCodPercentage = json['totalNonCodPercentage'];
    _ongkirNonCodAmountPercentage = json['ongkirNonCodAmountPercentage'];
  }

  String? _status;
  num? _totalCod;
  num? _codAmount;
  num? _ongkirCodAmount;
  num? _totalCodOngkir;
  num? _codOngkirAmount;
  num? _totalNonCod;
  num? _ongkirNonCodAmount;
  num? _totalCodPercentage;
  num? _codAmountPercentage;
  num? _ongkirCodAmountPercentage;
  num? _totalCodOngkirPercentage;
  num? _codOngkirAmountPercentage;
  num? _totalNonCodPercentage;
  num? _ongkirNonCodAmountPercentage;

  PantauPaketmuCountModel copyWith({
    String? status,
    num? totalCod,
    num? codAmount,
    num? ongkirCodAmount,
    num? totalCodOngkir,
    num? codOngkirAmount,
    num? totalNonCod,
    num? ongkirNonCodAmount,
    num? totalCodPercentage,
    num? codAmountPercentage,
    num? ongkirCodAmountPercentage,
    num? totalCodOngkirPercentage,
    num? codOngkirAmountPercentage,
    num? totalNonCodPercentage,
    num? ongkirNonCodAmountPercentage,
  }) =>
      PantauPaketmuCountModel(
        status: status ?? _status,
        totalCod: totalCod ?? _totalCod,
        codAmount: codAmount ?? _codAmount,
        ongkirCodAmount: ongkirCodAmount ?? _ongkirCodAmount,
        totalCodOngkir: totalCodOngkir ?? _totalCodOngkir,
        codOngkirAmount: codOngkirAmount ?? _codOngkirAmount,
        totalNonCod: totalNonCod ?? _totalNonCod,
        ongkirNonCodAmount: ongkirNonCodAmount ?? _ongkirNonCodAmount,
        totalCodPercentage: totalCodPercentage ?? _totalCodPercentage,
        codAmountPercentage: codAmountPercentage ?? _codAmountPercentage,
        ongkirCodAmountPercentage:
            ongkirCodAmountPercentage ?? _ongkirCodAmountPercentage,
        totalCodOngkirPercentage:
            totalCodOngkirPercentage ?? _totalCodOngkirPercentage,
        codOngkirAmountPercentage:
            codOngkirAmountPercentage ?? _codOngkirAmountPercentage,
        totalNonCodPercentage: totalNonCodPercentage ?? _totalNonCodPercentage,
        ongkirNonCodAmountPercentage:
            ongkirNonCodAmountPercentage ?? _ongkirNonCodAmountPercentage,
      );

  String? get status => _status;

  num? get totalCod => _totalCod;

  num? get codAmount => _codAmount;

  num? get ongkirCodAmount => _ongkirCodAmount;

  num? get totalCodOngkir => _totalCodOngkir;

  num? get codOngkirAmount => _codOngkirAmount;

  num? get totalNonCod => _totalNonCod;

  num? get ongkirNonCodAmount => _ongkirNonCodAmount;

  num? get totalCodPercentage => _totalCodPercentage;

  num? get codAmountPercentage => _codAmountPercentage;

  num? get ongkirCodAmountPercentage => _ongkirCodAmountPercentage;

  num? get totalCodOngkirPercentage => _totalCodOngkirPercentage;

  num? get codOngkirAmountPercentage => _codOngkirAmountPercentage;

  num? get totalNonCodPercentage => _totalNonCodPercentage;

  num? get ongkirNonCodAmountPercentage => _ongkirNonCodAmountPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalCod'] = _totalCod;
    map['codAmount'] = _codAmount;
    map['ongkirCodAmount'] = _ongkirCodAmount;
    map['totalCodOngkir'] = _totalCodOngkir;
    map['codOngkirAmount'] = _codOngkirAmount;
    map['totalNonCod'] = _totalNonCod;
    map['ongkirNonCodAmount'] = _ongkirNonCodAmount;
    map['totalCodPercentage'] = _totalCodPercentage;
    map['codAmountPercentage'] = _codAmountPercentage;
    map['ongkirCodAmountPercentage'] = _ongkirCodAmountPercentage;
    map['totalCodOngkirPercentage'] = _totalCodOngkirPercentage;
    map['codOngkirAmountPercentage'] = _codOngkirAmountPercentage;
    map['totalNonCodPercentage'] = _totalNonCodPercentage;
    map['ongkirNonCodAmountPercentage'] = _ongkirNonCodAmountPercentage;
    return map;
  }
}
