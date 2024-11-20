class GetServiceModel {
  GetServiceModel({
    String? originName,
    String? destinationName,
    String? originCode,
    String? destinationCode,
    num? weightExpress,
    num? weightJtr,
    bool? isInsurance,
    num? insuranceAmount,
    List<ServiceModel>? resultExpress,
    List<ServiceModel>? resultJtr,
  }) {
    _originName = originName;
    _destinationName = destinationName;
    _originCode = originCode;
    _destinationCode = destinationCode;
    _weightExpress = weightExpress;
    _weightJtr = weightJtr;
    _isInsurance = isInsurance;
    _insuranceAmount = insuranceAmount;
    _resultExpress = resultExpress;
    _resultJtr = resultJtr;
  }

  GetServiceModel.fromJson(dynamic json) {
    _originName = json['originName'];
    _destinationName = json['destinationName'];
    _originCode = json['originCode'];
    _destinationCode = json['destinationCode'];
    _weightExpress = json['weightExpress'];
    _weightJtr = json['weightJtr'];
    _isInsurance = json['isInsurance'];
    _insuranceAmount = json['insuranceAmount'];
    if (json['resultExpress'] != null) {
      _resultExpress = [];
      json['resultExpress'].forEach((v) {
        _resultExpress?.add(ServiceModel.fromJson(v));
      });
    }
    if (json['resultJtr'] != null) {
      _resultJtr = [];
      json['resultJtr'].forEach((v) {
        _resultJtr?.add(ServiceModel.fromJson(v));
      });
    }
  }

  String? _originName;
  String? _destinationName;
  String? _originCode;
  String? _destinationCode;
  num? _weightExpress;
  num? _weightJtr;
  bool? _isInsurance;
  num? _insuranceAmount;
  List<ServiceModel>? _resultExpress;
  List<ServiceModel>? _resultJtr;

  GetServiceModel copyWith({
    String? originName,
    String? destinationName,
    String? originCode,
    String? destinationCode,
    num? weightExpress,
    num? weightJtr,
    bool? isInsurance,
    num? insuranceAmount,
    List<ServiceModel>? resultExpress,
    List<ServiceModel>? resultJtr,
  }) =>
      GetServiceModel(
        originName: originName ?? _originName,
        destinationName: destinationName ?? _destinationName,
        originCode: originCode ?? _originCode,
        destinationCode: destinationCode ?? _destinationCode,
        weightExpress: weightExpress ?? _weightExpress,
        weightJtr: weightJtr ?? _weightJtr,
        isInsurance: isInsurance ?? _isInsurance,
        insuranceAmount: insuranceAmount ?? _insuranceAmount,
        resultExpress: resultExpress ?? _resultExpress,
        resultJtr: resultJtr ?? _resultJtr,
      );

  String? get originName => _originName;

  String? get destinationName => _destinationName;

  String? get originCode => _originCode;

  String? get destinationCode => _destinationCode;

  num? get weightExpress => _weightExpress;

  num? get weightJtr => _weightJtr;

  bool? get isInsurance => _isInsurance;

  num? get insuranceAmount => _insuranceAmount;

  List<ServiceModel>? get resultExpress => _resultExpress;

  List<ServiceModel>? get resultJtr => _resultJtr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originName'] = _originName;
    map['destinationName'] = _destinationName;
    map['originCode'] = _originCode;
    map['destinationCode'] = _destinationCode;
    map['weightExpress'] = _weightExpress;
    map['weightJtr'] = _weightJtr;
    map['isInsurance'] = _isInsurance;
    map['insuranceAmount'] = _insuranceAmount;
    if (_resultExpress != null) {
      map['resultExpress'] = _resultExpress?.map((v) => v.toJson()).toList();
    }
    if (_resultJtr != null) {
      map['resultJtr'] = _resultJtr?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


class ServiceModel {
  ServiceModel({
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

  ServiceModel.fromJson(dynamic json) {
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

  ServiceModel copyWith({
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
      ServiceModel(
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
