class PostLacakKirimanModel {
  Cnote? cnote;
  List<Detail>? detail;
  List<HistoryKiriman>? history;

  PostLacakKirimanModel({
    this.cnote,
    this.detail,
    this.history,
  });

  factory PostLacakKirimanModel.fromJson(Map<String, dynamic> json) {
    return PostLacakKirimanModel(
      cnote: json['cnote'] != null ? Cnote.fromJson(json['cnote']) : null,
      detail: json['detail'] != null ? List<Detail>.from(json['detail'].map((x) => Detail.fromJson(x))) : null,
      history: json['history'] != null ? List<HistoryKiriman>.from(json['history'].map((x) => HistoryKiriman.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnote': cnote?.toJson(),
      'detail': detail?.map((x) => x.toJson()).toList(),
      'history': history?.map((x) => x.toJson()).toList(),
    };
  }

  PostLacakKirimanModel copyWith({
    Cnote? cnote,
    List<Detail>? detail,
    List<HistoryKiriman>? history,
  }) =>
      PostLacakKirimanModel(
        cnote: cnote,
        detail: detail,
        history: history,
      );
}

class HistoryKiriman {
  String? date;
  String? desc;
  String? code;
  List<String?> photos;

  HistoryKiriman({
    this.date,
    this.desc,
    this.code,
    List<String?>? photos,
  }) : photos = photos ?? List.filled(5, null);

  factory HistoryKiriman.fromJson(Map<String, dynamic> json) {
    return HistoryKiriman(
      date: json['date'],
      desc: json['desc'],
      code: json['code'],
      photos: [
        json['photo1'],
        json['photo2'],
        json['photo3'],
        json['photo4'],
        json['photo5'],
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'desc': desc,
      'code': code,
      'photo1': photos[0],
      'photo2': photos[1],
      'photo3': photos[2],
      'photo4': photos[3],
      'photo5': photos[4],
    };
  }
}

class Detail {
  String? cnoteNo;
  String? cnoteDate;
  String? cnoteWeight;
  String? cnoteOrigin;
  String? cnoteShipperName;
  List<String?> shipperAddresses;
  String? cnoteShipperCity;
  String? cnoteReceiverName;
  List<String?> receiverAddresses;
  String? cnoteReceiverCity;

  Detail({
    this.cnoteNo,
    this.cnoteDate,
    this.cnoteWeight,
    this.cnoteOrigin,
    this.cnoteShipperName,
    List<String?>? shipperAddresses,
    this.cnoteShipperCity,
    this.cnoteReceiverName,
    List<String?>? receiverAddresses,
    this.cnoteReceiverCity,
  })  : shipperAddresses = shipperAddresses ?? List.filled(3, null),
        receiverAddresses = receiverAddresses ?? List.filled(3, null);

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      cnoteNo: json['cnoteNo'],
      cnoteDate: json['cnoteDate'],
      cnoteWeight: json['cnoteWeight'],
      cnoteOrigin: json['cnoteOrigin'],
      cnoteShipperName: json['cnoteShipperName'],
      shipperAddresses: [
        json['cnoteShipperAddr1'],
        json['cnoteShipperAddr2'],
        json['cnoteShipperAddr3'],
      ],
      cnoteShipperCity: json['cnoteShipperCity'],
      cnoteReceiverName: json['cnoteReceiverName'],
      receiverAddresses: [
        json['cnoteReceiverAddr1'],
        json['cnoteReceiverAddr2'],
        json['cnoteReceiverAddr3'],
      ],
      cnoteReceiverCity: json['cnoteReceiverCity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnoteNo': cnoteNo,
      'cnoteDate': cnoteDate,
      'cnoteWeight': cnoteWeight,
      'cnoteOrigin': cnoteOrigin,
      'cnoteShipperName': cnoteShipperName,
      'cnoteShipperAddr1': shipperAddresses[0],
      'cnoteShipperAddr2': shipperAddresses[1],
      'cnoteShipperAddr3': shipperAddresses[2],
      'cnoteShipperCity': cnoteShipperCity,
      'cnoteReceiverName': cnoteReceiverName,
      'cnoteReceiverAddr1': receiverAddresses[0],
      'cnoteReceiverAddr2': receiverAddresses[1],
      'cnoteReceiverAddr3': receiverAddresses[2],
      'cnoteReceiverCity': cnoteReceiverCity,
    };
  }
}

class Cnote {
  String? cnoteNo;
  String? referenceNumber;
  String? cnoteOrigin;
  String? cnoteDestination;
  String? cnoteServicesCode;
  String? servicetype;
  String? cnoteCustNo;
  String? cnoteDate;
  String? cnotePodReceiver;
  String? cnoteReceiverName;
  String? cityName;
  String? cnotePodDate;
  String? podStatus;
  String? lastStatus;
  String? custType;
  String? cnoteAmount;
  String? cnoteWeight;
  String? podCode;
  String? keterangan;
  String? cnoteGoodsDescr;
  String? freightCharge;
  String? shippingcost;
  String? insuranceamount;
  String? priceperkg;
  String? signature;
  String? photo;
  String? long;
  String? lat;
  String? estimateDelivery;

  Cnote({
    this.cnoteNo,
    this.referenceNumber,
    this.cnoteOrigin,
    this.cnoteDestination,
    this.cnoteServicesCode,
    this.servicetype,
    this.cnoteCustNo,
    this.cnoteDate,
    this.cnotePodReceiver,
    this.cnoteReceiverName,
    this.cityName,
    this.cnotePodDate,
    this.podStatus,
    this.lastStatus,
    this.custType,
    this.cnoteAmount,
    this.cnoteWeight,
    this.podCode,
    this.keterangan,
    this.cnoteGoodsDescr,
    this.freightCharge,
    this.shippingcost,
    this.insuranceamount,
    this.priceperkg,
    this.signature,
    this.photo,
    this.long,
    this.lat,
    this.estimateDelivery,
  });

  factory Cnote.fromJson(Map<String, dynamic> json) {
    return Cnote(
      cnoteNo: json['cnoteNo'],
      referenceNumber: json['referenceNumber'],
      cnoteOrigin: json['cnoteOrigin'],
      cnoteDestination: json['cnoteDestination'],
      cnoteServicesCode: json['cnoteServicesCode'],
      servicetype: json['servicetype'],
      cnoteCustNo: json['cnoteCustNo'],
      cnoteDate: json['cnoteDate'],
      cnotePodReceiver: json['cnotePodReceiver'],
      cnoteReceiverName: json['cnoteReceiverName'],
      cityName: json['cityName'],
      cnotePodDate: json['cnotePodDate'],
      podStatus: json['podStatus'],
      lastStatus: json['lastStatus'],
      custType: json['custType'],
      cnoteAmount: json['cnoteAmount'],
      cnoteWeight: json['cnoteWeight'],
      podCode: json['podCode'],
      keterangan: json['keterangan'],
      cnoteGoodsDescr: json['cnoteGoodsDescr'],
      freightCharge: json['freightCharge'],
      shippingcost: json['shippingcost'],
      insuranceamount: json['insuranceamount'],
      priceperkg: json['priceperkg'],
      signature: json['signature'],
      photo: json['photo'],
      long: json['long'],
      lat: json['lat'],
      estimateDelivery: json['estimateDelivery'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnoteNo': cnoteNo,
      'referenceNumber': referenceNumber,
      'cnoteOrigin': cnoteOrigin,
      'cnoteDestination': cnoteDestination,
      'cnoteServicesCode': cnoteServicesCode,
      'servicetype': servicetype,
      'cnoteCustNo': cnoteCustNo,
      'cnoteDate': cnoteDate,
      'cnotePodReceiver': cnotePodReceiver,
      'cnoteReceiverName': cnoteReceiverName,
      'cityName': cityName,
      'cnotePodDate': cnotePodDate,
      'podStatus': podStatus,
      'lastStatus': lastStatus,
      'custType': custType,
      'cnoteAmount': cnoteAmount,
      'cnoteWeight': cnoteWeight,
      'podCode': podCode,
      'keterangan': keterangan,
      'cnoteGoodsDescr': cnoteGoodsDescr,
      'freightCharge': freightCharge,
      'shippingcost': shippingcost,
      'insuranceamount': insuranceamount,
      'priceperkg': priceperkg,
      'signature': signature,
      'photo': photo,
      'long': long,
      'lat': lat,
      'estimateDelivery': estimateDelivery,
    };
  }



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
        cnoteNo: cnoteNo,
        referenceNumber: referenceNumber,
        cnoteOrigin: cnoteOrigin,
        cnoteDestination: cnoteDestination,
        cnoteServicesCode: cnoteServicesCode,
        servicetype: servicetype,
        cnoteCustNo: cnoteCustNo,
        cnoteDate: cnoteDate,
        cnotePodReceiver: cnotePodReceiver,
        cnoteReceiverName: cnoteReceiverName,
        cityName: cityName,
        cnotePodDate: cnotePodDate,
        podStatus: podStatus,
        lastStatus: lastStatus,
        custType: custType,
        cnoteAmount: cnoteAmount,
        cnoteWeight: cnoteWeight,
        podCode: podCode,
        keterangan: keterangan,
        cnoteGoodsDescr: cnoteGoodsDescr,
        freightCharge: freightCharge,
        shippingcost: shippingcost,
        insuranceamount: insuranceamount,
        priceperkg: priceperkg,
        signature: signature,
        photo: photo,
        long: long,
        lat: lat,
        estimateDelivery: estimateDelivery,
      );
}
