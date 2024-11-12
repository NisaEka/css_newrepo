class PostTransactionOngkirModel {
  PostTransactionOngkirModel({
    num? ongkir,
    num? codFee,
    num? goodsAmount,
    num? insurance,
    num? codFeeAmount,
    num? codAmountMinimum,
    num? codOngkirAmount,
    num? totalOngkir,
  }) {
    _ongkir = ongkir;
    _codFee = codFee;
    _goodsAmount = goodsAmount;
    _insurance = insurance;
    _codFeeAmount = codFeeAmount;
    _codAmountMinimum = codAmountMinimum;
    _codOngkirAmount = codOngkirAmount;
    _totalOngkir = totalOngkir;
  }

  PostTransactionOngkirModel.fromJson(dynamic json) {
    _ongkir = json['ongkir'];
    _codFee = json['codFee'];
    _goodsAmount = json['goodsAmount'];
    _insurance = json['insurance'];
    _codFeeAmount = json['codFeeAmount'];
    _codAmountMinimum = json['codAmountMinimum'];
    _codOngkirAmount = json['codOngkirAmount'];
    _totalOngkir = json['totalOngkir'];
  }

  num? _ongkir;
  num? _codFee;
  num? _goodsAmount;
  num? _insurance;
  num? _codFeeAmount;
  num? _codAmountMinimum;
  num? _codOngkirAmount;
  num? _totalOngkir;

  PostTransactionOngkirModel copyWith({
    num? ongkir,
    num? codFee,
    num? goodsAmount,
    num? insurance,
    num? codFeeAmount,
    num? codAmountMinimum,
    num? codOngkirAmount,
    num? totalOngkir,
  }) =>
      PostTransactionOngkirModel(
        ongkir: ongkir ?? _ongkir,
        codFee: codFee ?? _codFee,
        goodsAmount: goodsAmount ?? _goodsAmount,
        insurance: insurance ?? _insurance,
        codFeeAmount: codFeeAmount ?? _codFeeAmount,
        codAmountMinimum: codAmountMinimum ?? _codAmountMinimum,
        codOngkirAmount: codOngkirAmount ?? _codOngkirAmount,
        totalOngkir: totalOngkir ?? _totalOngkir,
      );

  num? get ongkir => _ongkir;

  num? get codFee => _codFee;

  num? get goodsAmount => _goodsAmount;

  num? get insurance => _insurance;

  num? get codFeeAmount => _codFeeAmount;

  num? get codAmountMinimum => _codAmountMinimum;

  num? get codOngkirAmount => _codOngkirAmount;

  num? get totalOngkir => _totalOngkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ongkir'] = _ongkir;
    map['codFee'] = _codFee;
    map['goodsAmount'] = _goodsAmount;
    map['insurance'] = _insurance;
    map['codFeeAmount'] = _codFeeAmount;
    map['codAmountMinimum'] = _codAmountMinimum;
    map['codOngkirAmount'] = _codOngkirAmount;
    map['totalOngkir'] = _totalOngkir;
    return map;
  }
}
