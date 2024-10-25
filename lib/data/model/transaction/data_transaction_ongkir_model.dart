class DataTransactionOngkirModel {
  DataTransactionOngkirModel({
    num? goodsAmount,
    bool? isIsr,
    num? ongkir,
    String? accountNumber,
    bool? isCod,
    num? codFee,
    bool? isCongkir,
    bool? isPrefix3,
  }) {
    _goodsAmount = goodsAmount;
    _isIsr = isIsr;
    _ongkir = ongkir;
    _accountNumber = accountNumber;
    _isCod = isCod;
    _codFee = codFee;
    _isCongkir = isCongkir;
    _isPrefix3 = isPrefix3;
  }

  DataTransactionOngkirModel.fromJson(dynamic json) {
    _goodsAmount = json['goodsAmount'];
    _isIsr = json['isInsurance'];
    _ongkir = json['ongkir'];
    _accountNumber = json['account'];
    _isCod = json['isCod'];
    _codFee = json['codFee'];
    _isCongkir = json['isCongkit'];
    _isPrefix3 = json['isPrefix3'];
  }

  num? _goodsAmount;
  bool? _isIsr;
  num? _ongkir;
  String? _accountNumber;
  bool? _isCod;
  num? _codFee;
  bool? _isCongkir;
  bool? _isPrefix3;

  DataTransactionOngkirModel copyWith({
    num? goodsAmount,
    bool? isIsr,
    num? ongkir,
    String? accountNumber,
    bool? isCod,
    num? codFee,
    bool? isCongkir,
    bool? isPrefix3,
  }) =>
      DataTransactionOngkirModel(
        goodsAmount: goodsAmount ?? _goodsAmount,
        isIsr: isIsr ?? _isIsr,
        ongkir: ongkir ?? _ongkir,
        accountNumber: accountNumber ?? _accountNumber,
        isCod: isCod ?? _isCod,
        codFee: codFee ?? _codFee,
        isCongkir: isCongkir ?? _isCongkir,
        isPrefix3: isPrefix3 ?? _isPrefix3,
      );

  num? get goodsAmount => _goodsAmount;

  bool? get isIsr => _isIsr;

  num? get ongkir => _ongkir;

  String? get accountNumber => _accountNumber;

  bool? get isCod => _isCod;

  num? get codFee => _codFee;

  bool? get isCongkir => _isCongkir;

  bool? get isPrefix3 => _isPrefix3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['goodsAmount'] = _goodsAmount;
    map['isInsurance'] = _isIsr;
    map['ongkir'] = _ongkir;
    map['account'] = _accountNumber;
    map['isCod'] = _isCod;
    map['codFee'] = _codFee;
    map['isCongkit'] = _isCongkir;
    map['isPrefix3'] = _isPrefix3;
    return map;
  }
}
