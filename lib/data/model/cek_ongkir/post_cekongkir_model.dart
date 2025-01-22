class OngkirModel {
  OngkirModel({
    String? originName,
    String? destinationName,
    String? serviceDisplay,
    String? serviceCode,
    String? goodsType,
    String? currency,
    String? price,
    String? etdFrom,
    String? etdThru,
    String? times,
    num? insuranceAmount,
  }) {
    _originName = originName;
    _destinationName = destinationName;
    _serviceDisplay = serviceDisplay;
    _serviceCode = serviceCode;
    _goodsType = goodsType;
    _currency = currency;
    _price = price;
    _etdFrom = etdFrom;
    _etdThru = etdThru;
    _times = times;
    _insuranceAmount = insuranceAmount;
  }

  OngkirModel.fromJson(dynamic json) {
    _originName = json['originName'];
    _destinationName = json['destinationName'];
    _serviceDisplay = json['serviceDisplay'];
    _serviceCode = json['serviceCode'];
    _goodsType = json['goodsType'];
    _currency = json['currency'];
    _price = json['price'];
    _etdFrom = json['etdFrom'];
    _etdThru = json['etdThru'];
    _times = json['times'];
    _insuranceAmount = json['insuranceAmount'];
  }

  String? _originName;
  String? _destinationName;
  String? _serviceDisplay;
  String? _serviceCode;
  String? _goodsType;
  String? _currency;
  String? _price;
  String? _etdFrom;
  String? _etdThru;
  String? _times;
  num? _insuranceAmount;

  OngkirModel copyWith({
    String? originName,
    String? destinationName,
    String? serviceDisplay,
    String? serviceCode,
    String? goodsType,
    String? currency,
    String? price,
    String? etdFrom,
    String? etdThru,
    String? times,
    num? insuranceAmount,
  }) =>
      OngkirModel(
        originName: originName ?? _originName,
        destinationName: destinationName ?? _destinationName,
        serviceDisplay: serviceDisplay ?? _serviceDisplay,
        serviceCode: serviceCode ?? _serviceCode,
        goodsType: goodsType ?? _goodsType,
        currency: currency ?? _currency,
        price: price ?? _price,
        etdFrom: etdFrom ?? _etdFrom,
        etdThru: etdThru ?? _etdThru,
        times: times ?? _times,
        insuranceAmount: insuranceAmount ?? _insuranceAmount,
      );

  String? get originName => _originName;

  String? get destinationName => _destinationName;

  String? get serviceDisplay => _serviceDisplay;

  String? get serviceCode => _serviceCode;

  String? get goodsType => _goodsType;

  String? get currency => _currency;

  String? get price => _price;

  String? get etdFrom => _etdFrom;

  String? get etdThru => _etdThru;

  String? get times => _times;

  num? get insuranceAmount => _insuranceAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originName'] = _originName;
    map['destinationName'] = _destinationName;
    map['serviceDisplay'] = _serviceDisplay;
    map['serviceCode'] = _serviceCode;
    map['goodsType'] = _goodsType;
    map['currency'] = _currency;
    map['price'] = _price;
    map['etdFrom'] = _etdFrom;
    map['etdThru'] = _etdThru;
    map['times'] = _times;
    map['insuranceAmount'] = _insuranceAmount;
    return map;
  }
}
