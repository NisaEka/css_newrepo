class PostTransactionOngkirModel {
  PostTransactionOngkirModel({
    num? insurance,
    num? codAmountMinimum,
    num? codFee,
    num? codAmount,
    num? congkirAmount,
    num? totalOngkir,
  }) {
    _insurance = insurance;
    _codAmountMinimum = codAmountMinimum;
    _codFee = codFee;
    _codAmount = codAmount;
    _congkirAmount = congkirAmount;
    _totalOngkir = totalOngkir;
  }

  PostTransactionOngkirModel.fromJson(dynamic json) {
    _insurance = json['insurance'];
    _codAmountMinimum = json['cod_amount_minimum'];
    _codFee = json['cod_fee'];
    _codAmount = json['cod_amount'];
    _congkirAmount = json['congkir_amount'];
    _totalOngkir = json['total_ongkir'];
  }

  num? _insurance;
  num? _codAmountMinimum;
  num? _codFee;
  num? _codAmount;
  num? _congkirAmount;
  num? _totalOngkir;

  PostTransactionOngkirModel copyWith({
    num? insurance,
    num? codAmountMinimum,
    num? codFee,
    num? codAmount,
    num? congkirAmount,
    num? totalOngkir,
  }) =>
      PostTransactionOngkirModel(
        insurance: insurance ?? _insurance,
        codAmountMinimum: codAmountMinimum ?? _codAmountMinimum,
        codFee: codFee ?? _codFee,
        codAmount: codAmount ?? _codAmount,
        congkirAmount: congkirAmount ?? _congkirAmount,
        totalOngkir: totalOngkir ?? _totalOngkir,
      );

  num? get insurance => _insurance;

  num? get codAmountMinimum => _codAmountMinimum;

  num? get codFee => _codFee;

  num? get codAmount => _codAmount;

  num? get congkirAmount => _congkirAmount;

  num? get totalOngkir => _totalOngkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['insurance'] = _insurance;
    map['cod_amount_minimum'] = _codAmountMinimum;
    map['cod_fee'] = _codFee;
    map['cod_amount'] = _codAmount;
    map['congkir_amount'] = _congkirAmount;
    map['total_ongkir'] = _totalOngkir;
    return map;
  }
}
