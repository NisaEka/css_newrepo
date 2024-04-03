class PostCekongkirModel {
  PostCekongkirModel({
    List<Ongkir>? ongkir,
  }) {
    _ongkir = ongkir;
  }

  PostCekongkirModel.fromJson(dynamic json) {
    if (json['price'] != null) {
      _ongkir = [];
      json['price'].forEach((v) {
        _ongkir?.add(Ongkir.fromJson(v));
      });
    }
  }

  List<Ongkir>? _ongkir;

  PostCekongkirModel copyWith({
    List<Ongkir>? ongkir,
  }) =>
      PostCekongkirModel(
        ongkir: ongkir ?? _ongkir,
      );

  List<Ongkir>? get ongkir => _ongkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_ongkir != null) {
      map['price'] = _ongkir?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ongkir {
  Ongkir({
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
  }

  Ongkir.fromJson(dynamic json) {
    _originName = json['origin_name'];
    _destinationName = json['destination_name'];
    _serviceDisplay = json['service_display'];
    _serviceCode = json['service_code'];
    _goodsType = json['goods_type'];
    _currency = json['currency'];
    _price = json['price'];
    _etdFrom = json['etd_from'];
    _etdThru = json['etd_thru'];
    _times = json['times'];
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

  Ongkir copyWith({
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
  }) =>
      Ongkir(
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_name'] = _originName;
    map['destination_name'] = _destinationName;
    map['service_display'] = _serviceDisplay;
    map['service_code'] = _serviceCode;
    map['goods_type'] = _goodsType;
    map['currency'] = _currency;
    map['price'] = _price;
    map['etd_from'] = _etdFrom;
    map['etd_thru'] = _etdThru;
    map['times'] = _times;
    return map;
  }
}
