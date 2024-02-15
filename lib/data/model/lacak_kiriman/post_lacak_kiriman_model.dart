class PostLacakKirimanModel {
  PostLacakKirimanModel({
    Cnote? cnote,
    List<Detail>? detail,
    List<HistoryKiriman>? history,
    String? error,
    bool? status,
  }) {
    _cnote = cnote;
    _detail = detail;
    _history = history;
    _error = error;
    _status = status;
  }

  PostLacakKirimanModel.fromJson(dynamic json) {
    _cnote = json['cnote'] != null ? Cnote.fromJson(json['cnote']) : null;
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(HistoryKiriman.fromJson(v));
      });
    }
    _error = json['error'];
    _status = json['status'];
  }

  Cnote? _cnote;
  List<Detail>? _detail;
  List<HistoryKiriman>? _history;
  String? _error;
  bool? _status;

  PostLacakKirimanModel copyWith({
    Cnote? cnote,
    List<Detail>? detail,
    List<HistoryKiriman>? history,
    String? error,
    bool? status,
  }) =>
      PostLacakKirimanModel(
        cnote: cnote ?? _cnote,
        detail: detail ?? _detail,
        history: history ?? _history,
        error: error ?? _error,
        status: status ?? _status,
      );

  Cnote? get cnote => _cnote;

  List<Detail>? get detail => _detail;

  List<HistoryKiriman>? get history => _history;

  String? get error => _error;

  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cnote != null) {
      map['cnote'] = _cnote?.toJson();
    }
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['status'] = _status;
    return map;
  }
}

class HistoryKiriman {
  HistoryKiriman({
    String? date,
    String? desc,
    String? code,
    String? photo1,
    String? photo2,
    String? photo3,
    String? photo4,
    String? photo5,
  }) {
    _date = date;
    _desc = desc;
    _code = code;
    _photo1 = photo1;
    _photo2 = photo2;
    _photo3 = photo3;
    _photo4 = photo4;
    _photo5 = photo5;
  }

  HistoryKiriman.fromJson(dynamic json) {
    _date = json['date'];
    _desc = json['desc'];
    _code = json['code'];
    _photo1 = json['photo1'];
    _photo2 = json['photo2'];
    _photo3 = json['photo3'];
    _photo4 = json['photo4'];
    _photo5 = json['photo5'];
  }

  String? _date;
  String? _desc;
  String? _code;
  String? _photo1;
  String? _photo2;
  String? _photo3;
  String? _photo4;
  String? _photo5;

  HistoryKiriman copyWith({
    String? date,
    String? desc,
    String? code,
    String? photo1,
    String? photo2,
    String? photo3,
    String? photo4,
    String? photo5,
  }) =>
      HistoryKiriman(
        date: date ?? _date,
        desc: desc ?? _desc,
        code: code ?? _code,
        photo1: photo1 ?? _photo1,
        photo2: photo2 ?? _photo2,
        photo3: photo3 ?? _photo3,
        photo4: photo4 ?? _photo4,
        photo5: photo5 ?? _photo5,
      );

  String? get date => _date;

  String? get desc => _desc;

  String? get code => _code;

  String? get photo1 => _photo1;

  String? get photo2 => _photo2;

  String? get photo3 => _photo3;

  String? get photo4 => _photo4;

  String? get photo5 => _photo5;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['desc'] = _desc;
    map['code'] = _code;
    map['photo1'] = _photo1;
    map['photo2'] = _photo2;
    map['photo3'] = _photo3;
    map['photo4'] = _photo4;
    map['photo5'] = _photo5;
    return map;
  }
}

class Detail {
  Detail({
    String? cnoteNo,
    String? cnoteDate,
    String? cnoteWeight,
    String? cnoteOrigin,
    String? cnoteShipperName,
    String? cnoteShipperAddr1,
    String? cnoteShipperAddr2,
    String? cnoteShipperAddr3,
    String? cnoteShipperCity,
    String? cnoteReceiverName,
    String? cnoteReceiverAddr1,
    String? cnoteReceiverAddr2,
    String? cnoteReceiverAddr3,
    String? cnoteReceiverCity,
  }) {
    _cnoteNo = cnoteNo;
    _cnoteDate = cnoteDate;
    _cnoteWeight = cnoteWeight;
    _cnoteOrigin = cnoteOrigin;
    _cnoteShipperName = cnoteShipperName;
    _cnoteShipperAddr1 = cnoteShipperAddr1;
    _cnoteShipperAddr2 = cnoteShipperAddr2;
    _cnoteShipperAddr3 = cnoteShipperAddr3;
    _cnoteShipperCity = cnoteShipperCity;
    _cnoteReceiverName = cnoteReceiverName;
    _cnoteReceiverAddr1 = cnoteReceiverAddr1;
    _cnoteReceiverAddr2 = cnoteReceiverAddr2;
    _cnoteReceiverAddr3 = cnoteReceiverAddr3;
    _cnoteReceiverCity = cnoteReceiverCity;
  }

  Detail.fromJson(dynamic json) {
    _cnoteNo = json['cnote_no'];
    _cnoteDate = json['cnote_date'];
    _cnoteWeight = json['cnote_weight'];
    _cnoteOrigin = json['cnote_origin'];
    _cnoteShipperName = json['cnote_shipper_name'];
    _cnoteShipperAddr1 = json['cnote_shipper_addr1'];
    _cnoteShipperAddr2 = json['cnote_shipper_addr2'];
    _cnoteShipperAddr3 = json['cnote_shipper_addr3'];
    _cnoteShipperCity = json['cnote_shipper_city'];
    _cnoteReceiverName = json['cnote_receiver_name'];
    _cnoteReceiverAddr1 = json['cnote_receiver_addr1'];
    _cnoteReceiverAddr2 = json['cnote_receiver_addr2'];
    _cnoteReceiverAddr3 = json['cnote_receiver_addr3'];
    _cnoteReceiverCity = json['cnote_receiver_city'];
  }

  String? _cnoteNo;
  String? _cnoteDate;
  String? _cnoteWeight;
  String? _cnoteOrigin;
  String? _cnoteShipperName;
  String? _cnoteShipperAddr1;
  String? _cnoteShipperAddr2;
  String? _cnoteShipperAddr3;
  String? _cnoteShipperCity;
  String? _cnoteReceiverName;
  String? _cnoteReceiverAddr1;
  String? _cnoteReceiverAddr2;
  String? _cnoteReceiverAddr3;
  String? _cnoteReceiverCity;

  Detail copyWith({
    String? cnoteNo,
    String? cnoteDate,
    String? cnoteWeight,
    String? cnoteOrigin,
    String? cnoteShipperName,
    String? cnoteShipperAddr1,
    String? cnoteShipperAddr2,
    String? cnoteShipperAddr3,
    String? cnoteShipperCity,
    String? cnoteReceiverName,
    String? cnoteReceiverAddr1,
    String? cnoteReceiverAddr2,
    String? cnoteReceiverAddr3,
    String? cnoteReceiverCity,
  }) =>
      Detail(
        cnoteNo: cnoteNo ?? _cnoteNo,
        cnoteDate: cnoteDate ?? _cnoteDate,
        cnoteWeight: cnoteWeight ?? _cnoteWeight,
        cnoteOrigin: cnoteOrigin ?? _cnoteOrigin,
        cnoteShipperName: cnoteShipperName ?? _cnoteShipperName,
        cnoteShipperAddr1: cnoteShipperAddr1 ?? _cnoteShipperAddr1,
        cnoteShipperAddr2: cnoteShipperAddr2 ?? _cnoteShipperAddr2,
        cnoteShipperAddr3: cnoteShipperAddr3 ?? _cnoteShipperAddr3,
        cnoteShipperCity: cnoteShipperCity ?? _cnoteShipperCity,
        cnoteReceiverName: cnoteReceiverName ?? _cnoteReceiverName,
        cnoteReceiverAddr1: cnoteReceiverAddr1 ?? _cnoteReceiverAddr1,
        cnoteReceiverAddr2: cnoteReceiverAddr2 ?? _cnoteReceiverAddr2,
        cnoteReceiverAddr3: cnoteReceiverAddr3 ?? _cnoteReceiverAddr3,
        cnoteReceiverCity: cnoteReceiverCity ?? _cnoteReceiverCity,
      );

  String? get cnoteNo => _cnoteNo;

  String? get cnoteDate => _cnoteDate;

  String? get cnoteWeight => _cnoteWeight;

  String? get cnoteOrigin => _cnoteOrigin;

  String? get cnoteShipperName => _cnoteShipperName;

  String? get cnoteShipperAddr1 => _cnoteShipperAddr1;

  String? get cnoteShipperAddr2 => _cnoteShipperAddr2;

  String? get cnoteShipperAddr3 => _cnoteShipperAddr3;

  String? get cnoteShipperCity => _cnoteShipperCity;

  String? get cnoteReceiverName => _cnoteReceiverName;

  String? get cnoteReceiverAddr1 => _cnoteReceiverAddr1;

  String? get cnoteReceiverAddr2 => _cnoteReceiverAddr2;

  String? get cnoteReceiverAddr3 => _cnoteReceiverAddr3;

  String? get cnoteReceiverCity => _cnoteReceiverCity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cnote_no'] = _cnoteNo;
    map['cnote_date'] = _cnoteDate;
    map['cnote_weight'] = _cnoteWeight;
    map['cnote_origin'] = _cnoteOrigin;
    map['cnote_shipper_name'] = _cnoteShipperName;
    map['cnote_shipper_addr1'] = _cnoteShipperAddr1;
    map['cnote_shipper_addr2'] = _cnoteShipperAddr2;
    map['cnote_shipper_addr3'] = _cnoteShipperAddr3;
    map['cnote_shipper_city'] = _cnoteShipperCity;
    map['cnote_receiver_name'] = _cnoteReceiverName;
    map['cnote_receiver_addr1'] = _cnoteReceiverAddr1;
    map['cnote_receiver_addr2'] = _cnoteReceiverAddr2;
    map['cnote_receiver_addr3'] = _cnoteReceiverAddr3;
    map['cnote_receiver_city'] = _cnoteReceiverCity;
    return map;
  }
}

class Cnote {
  Cnote({
    String? cnoteNo,
    String? referenceNumber,
    String? cnoteOrigin,
    String? cnoteDestination,
    String? cnoteServicesCode,
    String? servicetype,
    String? cnoteCustNo,
    String? cnoteDate,
    String? cnotePodReceiver,
    String? cnoteReceiverName,
    String? cityName,
    String? cnotePodDate,
    String? podStatus,
    String? lastStatus,
    String? custType,
    String? cnoteAmount,
    String? cnoteWeight,
    String? podCode,
    String? keterangan,
    String? cnoteGoodsDescr,
    String? freightCharge,
    String? shippingcost,
    String? insuranceamount,
    String? priceperkg,
    String? signature,
    String? photo,
    String? long,
    String? lat,
    String? estimateDelivery,
  }) {
    _cnoteNo = cnoteNo;
    _referenceNumber = referenceNumber;
    _cnoteOrigin = cnoteOrigin;
    _cnoteDestination = cnoteDestination;
    _cnoteServicesCode = cnoteServicesCode;
    _servicetype = servicetype;
    _cnoteCustNo = cnoteCustNo;
    _cnoteDate = cnoteDate;
    _cnotePodReceiver = cnotePodReceiver;
    _cnoteReceiverName = cnoteReceiverName;
    _cityName = cityName;
    _cnotePodDate = cnotePodDate;
    _podStatus = podStatus;
    _lastStatus = lastStatus;
    _custType = custType;
    _cnoteAmount = cnoteAmount;
    _cnoteWeight = cnoteWeight;
    _podCode = podCode;
    _keterangan = keterangan;
    _cnoteGoodsDescr = cnoteGoodsDescr;
    _freightCharge = freightCharge;
    _shippingcost = shippingcost;
    _insuranceamount = insuranceamount;
    _priceperkg = priceperkg;
    _signature = signature;
    _photo = photo;
    _long = long;
    _lat = lat;
    _estimateDelivery = estimateDelivery;
  }

  Cnote.fromJson(dynamic json) {
    _cnoteNo = json['cnote_no'];
    _referenceNumber = json['reference_number'];
    _cnoteOrigin = json['cnote_origin'];
    _cnoteDestination = json['cnote_destination'];
    _cnoteServicesCode = json['cnote_services_code'];
    _servicetype = json['servicetype'];
    _cnoteCustNo = json['cnote_cust_no'];
    _cnoteDate = json['cnote_date'];
    _cnotePodReceiver = json['cnote_pod_receiver'];
    _cnoteReceiverName = json['cnote_receiver_name'];
    _cityName = json['city_name'];
    _cnotePodDate = json['cnote_pod_date'];
    _podStatus = json['pod_status'];
    _lastStatus = json['last_status'];
    _custType = json['cust_type'];
    _cnoteAmount = json['cnote_amount'];
    _cnoteWeight = json['cnote_weight'];
    _podCode = json['pod_code'];
    _keterangan = json['keterangan'];
    _cnoteGoodsDescr = json['cnote_goods_descr'];
    _freightCharge = json['freight_charge'];
    _shippingcost = json['shippingcost'];
    _insuranceamount = json['insuranceamount'];
    _priceperkg = json['priceperkg'];
    _signature = json['signature'];
    _photo = json['photo'];
    _long = json['long'];
    _lat = json['lat'];
    _estimateDelivery = json['estimate_delivery'];
  }

  String? _cnoteNo;
  String? _referenceNumber;
  String? _cnoteOrigin;
  String? _cnoteDestination;
  String? _cnoteServicesCode;
  String? _servicetype;
  String? _cnoteCustNo;
  String? _cnoteDate;
  String? _cnotePodReceiver;
  String? _cnoteReceiverName;
  String? _cityName;
  String? _cnotePodDate;
  String? _podStatus;
  String? _lastStatus;
  String? _custType;
  String? _cnoteAmount;
  String? _cnoteWeight;
  String? _podCode;
  String? _keterangan;
  String? _cnoteGoodsDescr;
  String? _freightCharge;
  String? _shippingcost;
  String? _insuranceamount;
  String? _priceperkg;
  String? _signature;
  String? _photo;
  String? _long;
  String? _lat;
  String? _estimateDelivery;

  Cnote copyWith({
    String? cnoteNo,
    String? referenceNumber,
    String? cnoteOrigin,
    String? cnoteDestination,
    String? cnoteServicesCode,
    String? servicetype,
    String? cnoteCustNo,
    String? cnoteDate,
    String? cnotePodReceiver,
    String? cnoteReceiverName,
    String? cityName,
    String? cnotePodDate,
    String? podStatus,
    String? lastStatus,
    String? custType,
    String? cnoteAmount,
    String? cnoteWeight,
    String? podCode,
    String? keterangan,
    String? cnoteGoodsDescr,
    String? freightCharge,
    String? shippingcost,
    String? insuranceamount,
    String? priceperkg,
    String? signature,
    String? photo,
    String? long,
    String? lat,
    String? estimateDelivery,
  }) =>
      Cnote(
        cnoteNo: cnoteNo ?? _cnoteNo,
        referenceNumber: referenceNumber ?? _referenceNumber,
        cnoteOrigin: cnoteOrigin ?? _cnoteOrigin,
        cnoteDestination: cnoteDestination ?? _cnoteDestination,
        cnoteServicesCode: cnoteServicesCode ?? _cnoteServicesCode,
        servicetype: servicetype ?? _servicetype,
        cnoteCustNo: cnoteCustNo ?? _cnoteCustNo,
        cnoteDate: cnoteDate ?? _cnoteDate,
        cnotePodReceiver: cnotePodReceiver ?? _cnotePodReceiver,
        cnoteReceiverName: cnoteReceiverName ?? _cnoteReceiverName,
        cityName: cityName ?? _cityName,
        cnotePodDate: cnotePodDate ?? _cnotePodDate,
        podStatus: podStatus ?? _podStatus,
        lastStatus: lastStatus ?? _lastStatus,
        custType: custType ?? _custType,
        cnoteAmount: cnoteAmount ?? _cnoteAmount,
        cnoteWeight: cnoteWeight ?? _cnoteWeight,
        podCode: podCode ?? _podCode,
        keterangan: keterangan ?? _keterangan,
        cnoteGoodsDescr: cnoteGoodsDescr ?? _cnoteGoodsDescr,
        freightCharge: freightCharge ?? _freightCharge,
        shippingcost: shippingcost ?? _shippingcost,
        insuranceamount: insuranceamount ?? _insuranceamount,
        priceperkg: priceperkg ?? _priceperkg,
        signature: signature ?? _signature,
        photo: photo ?? _photo,
        long: long ?? _long,
        lat: lat ?? _lat,
        estimateDelivery: estimateDelivery ?? _estimateDelivery,
      );

  String? get cnoteNo => _cnoteNo;

  String? get referenceNumber => _referenceNumber;

  String? get cnoteOrigin => _cnoteOrigin;

  String? get cnoteDestination => _cnoteDestination;

  String? get cnoteServicesCode => _cnoteServicesCode;

  String? get servicetype => _servicetype;

  String? get cnoteCustNo => _cnoteCustNo;

  String? get cnoteDate => _cnoteDate;

  String? get cnotePodReceiver => _cnotePodReceiver;

  String? get cnoteReceiverName => _cnoteReceiverName;

  String? get cityName => _cityName;

  String? get cnotePodDate => _cnotePodDate;

  String? get podStatus => _podStatus;

  String? get lastStatus => _lastStatus;

  String? get custType => _custType;

  String? get cnoteAmount => _cnoteAmount;

  String? get cnoteWeight => _cnoteWeight;

  String? get podCode => _podCode;

  String? get keterangan => _keterangan;

  String? get cnoteGoodsDescr => _cnoteGoodsDescr;

  String? get freightCharge => _freightCharge;

  String? get shippingcost => _shippingcost;

  String? get insuranceamount => _insuranceamount;

  String? get priceperkg => _priceperkg;

  String? get signature => _signature;

  String? get photo => _photo;

  String? get long => _long;

  String? get lat => _lat;

  String? get estimateDelivery => _estimateDelivery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cnote_no'] = _cnoteNo;
    map['reference_number'] = _referenceNumber;
    map['cnote_origin'] = _cnoteOrigin;
    map['cnote_destination'] = _cnoteDestination;
    map['cnote_services_code'] = _cnoteServicesCode;
    map['servicetype'] = _servicetype;
    map['cnote_cust_no'] = _cnoteCustNo;
    map['cnote_date'] = _cnoteDate;
    map['cnote_pod_receiver'] = _cnotePodReceiver;
    map['cnote_receiver_name'] = _cnoteReceiverName;
    map['city_name'] = _cityName;
    map['cnote_pod_date'] = _cnotePodDate;
    map['pod_status'] = _podStatus;
    map['last_status'] = _lastStatus;
    map['cust_type'] = _custType;
    map['cnote_amount'] = _cnoteAmount;
    map['cnote_weight'] = _cnoteWeight;
    map['pod_code'] = _podCode;
    map['keterangan'] = _keterangan;
    map['cnote_goods_descr'] = _cnoteGoodsDescr;
    map['freight_charge'] = _freightCharge;
    map['shippingcost'] = _shippingcost;
    map['insuranceamount'] = _insuranceamount;
    map['priceperkg'] = _priceperkg;
    map['signature'] = _signature;
    map['photo'] = _photo;
    map['long'] = _long;
    map['lat'] = _lat;
    map['estimate_delivery'] = _estimateDelivery;
    return map;
  }
}
