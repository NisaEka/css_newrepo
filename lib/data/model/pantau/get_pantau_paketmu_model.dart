class GetPantauPaketmuModel {
  final num? statusCode;
  final String? error;
  final List<PantauPaketmuModel>? data;

  GetPantauPaketmuModel({
    this.statusCode,
    this.error,
    this.data,
  });

  // Named constructor to handle JSON parsing
  factory GetPantauPaketmuModel.fromJson(Map<String, dynamic> json) {
    return GetPantauPaketmuModel(
      statusCode: json['statusCode'],
      error: json['error'],
      data: json['data'] != null
          ? List<PantauPaketmuModel>.from(
              json['data'].map((x) => PantauPaketmuModel.fromJson(x)))
          : null,
    );
  }

  // Copy constructor
  GetPantauPaketmuModel copyWith({
    num? statusCode,
    String? error,
    List<PantauPaketmuModel>? data,
  }) {
    return GetPantauPaketmuModel(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'error': error,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class PantauPaketmuModel {
  final String? petugasEntry;
  final String? custNo;
  final String? custName;
  final String? orderId;
  final String? awbNo;
  final String? awbRefno;
  final String? awbType;
  final String? cnoteReceiverPhone;
  final String? awbDate;
  final String? hoCourierDate;
  final String? puLastAttempStatusDate;
  final String? cnoteShipperName;
  final String? receiverName;
  final String? cnoteReceiverAddr1;
  final String? cnoteReceiverAddr2;
  final String? cnoteReceiverAddr3;
  final String? destinationName;
  final String? service;
  final num? weightAwb;
  final String? awbGoodsDescr;
  final String? awbSpecialIns;
  final num? awbAmount;
  final num? awbInsuranceValue;
  final num? codAmount;
  final String? statusPod;
  final String? tglReceived;
  final String? codingPod;
  final String? receivedReason;
  final String? repcssPaymentDate;
  final String? repcssPaymentReffid;
  final String? podlEpodUrlPic;
  final String? podlEpodUrl;
  final String? statusAwb;

  PantauPaketmuModel({
    this.petugasEntry,
    this.custNo,
    this.custName,
    this.orderId,
    this.awbNo,
    this.awbRefno,
    this.awbType,
    this.cnoteReceiverPhone,
    this.awbDate,
    this.hoCourierDate,
    this.puLastAttempStatusDate,
    this.cnoteShipperName,
    this.receiverName,
    this.cnoteReceiverAddr1,
    this.cnoteReceiverAddr2,
    this.cnoteReceiverAddr3,
    this.destinationName,
    this.service,
    this.weightAwb,
    this.awbGoodsDescr,
    this.awbSpecialIns,
    this.awbAmount,
    this.awbInsuranceValue,
    this.codAmount,
    this.statusPod,
    this.tglReceived,
    this.codingPod,
    this.receivedReason,
    this.repcssPaymentDate,
    this.repcssPaymentReffid,
    this.podlEpodUrlPic,
    this.podlEpodUrl,
    this.statusAwb,
  });

  // Named constructor for JSON parsing
  factory PantauPaketmuModel.fromJson(Map<String, dynamic> json) {
    return PantauPaketmuModel(
      petugasEntry: json['petugasEntry'],
      custNo: json['custNo'],
      custName: json['custName'],
      orderId: json['orderId'],
      awbNo: json['awbNo'],
      awbRefno: json['awbRefno'],
      awbType: json['awbType'],
      cnoteReceiverPhone: json['cnoteReceiverPhone'],
      awbDate: json['awbDate'],
      hoCourierDate: json['hoCourierDate'],
      puLastAttempStatusDate: json['puLastAttempStatusDate'],
      cnoteShipperName: json['cnoteShipperName'],
      receiverName: json['receiverName'],
      cnoteReceiverAddr1: json['cnoteReceiverAddr1'],
      cnoteReceiverAddr2: json['cnoteReceiverAddr2'],
      cnoteReceiverAddr3: json['cnoteReceiverAddr3'],
      destinationName: json['destinationName'],
      service: json['service'],
      weightAwb: json['weightAwb'],
      awbGoodsDescr: json['awbGoodsDescr'],
      awbSpecialIns: json['awbSpecialIns'],
      awbAmount: json['awbAmount'],
      awbInsuranceValue: json['awbInsuranceValue'],
      codAmount: json['codAmount'],
      statusPod: json['statusPod'],
      tglReceived: json['tglReceived'],
      codingPod: json['codingPod'],
      receivedReason: json['receivedReason'],
      repcssPaymentDate: json['repcssPaymentDate'],
      repcssPaymentReffid: json['repcssPaymentReffid'],
      podlEpodUrlPic: json['podlEpodUrlPic'],
      podlEpodUrl: json['podlEpodUrl'],
      statusAwb: json['statusAwb'],
    );
  }

  // Copy constructor
  PantauPaketmuModel copyWith({
    String? petugasEntry,
    String? custNo,
    String? custName,
    String? orderId,
    String? awbNo,
    String? awbRefno,
    String? awbType,
    String? cnoteReceiverPhone,
    String? awbDate,
    String? hoCourierDate,
    String? puLastAttempStatusDate,
    String? cnoteShipperName,
    String? receiverName,
    String? cnoteReceiverAddr1,
    String? cnoteReceiverAddr2,
    String? cnoteReceiverAddr3,
    String? destinationName,
    String? service,
    num? weightAwb,
    String? awbGoodsDescr,
    String? awbSpecialIns,
    num? awbAmount,
    num? awbInsuranceValue,
    num? codAmount,
    String? statusPod,
    String? tglReceived,
    String? codingPod,
    String? receivedReason,
    String? repcssPaymentDate,
    String? repcssPaymentReffid,
    String? podlEpodUrlPic,
    String? podlEpodUrl,
    String? statusAwb,
  }) {
    return PantauPaketmuModel(
      petugasEntry: petugasEntry ?? this.petugasEntry,
      custNo: custNo ?? this.custNo,
      custName: custName ?? this.custName,
      orderId: orderId ?? this.orderId,
      awbNo: awbNo ?? this.awbNo,
      awbRefno: awbRefno ?? this.awbRefno,
      awbType: awbType ?? this.awbType,
      cnoteReceiverPhone: cnoteReceiverPhone ?? this.cnoteReceiverPhone,
      awbDate: awbDate ?? this.awbDate,
      hoCourierDate: hoCourierDate ?? this.hoCourierDate,
      puLastAttempStatusDate:
          puLastAttempStatusDate ?? this.puLastAttempStatusDate,
      cnoteShipperName: cnoteShipperName ?? this.cnoteShipperName,
      receiverName: receiverName ?? this.receiverName,
      cnoteReceiverAddr1: cnoteReceiverAddr1 ?? this.cnoteReceiverAddr1,
      cnoteReceiverAddr2: cnoteReceiverAddr2 ?? this.cnoteReceiverAddr2,
      cnoteReceiverAddr3: cnoteReceiverAddr3 ?? this.cnoteReceiverAddr3,
      destinationName: destinationName ?? this.destinationName,
      service: service ?? this.service,
      weightAwb: weightAwb ?? this.weightAwb,
      awbGoodsDescr: awbGoodsDescr ?? this.awbGoodsDescr,
      awbSpecialIns: awbSpecialIns ?? this.awbSpecialIns,
      awbAmount: awbAmount ?? this.awbAmount,
      awbInsuranceValue: awbInsuranceValue ?? this.awbInsuranceValue,
      codAmount: codAmount ?? this.codAmount,
      statusPod: statusPod ?? this.statusPod,
      tglReceived: tglReceived ?? this.tglReceived,
      codingPod: codingPod ?? this.codingPod,
      receivedReason: receivedReason ?? this.receivedReason,
      repcssPaymentDate: repcssPaymentDate ?? this.repcssPaymentDate,
      repcssPaymentReffid: repcssPaymentReffid ?? this.repcssPaymentReffid,
      podlEpodUrlPic: podlEpodUrlPic ?? this.podlEpodUrlPic,
      podlEpodUrl: podlEpodUrl ?? this.podlEpodUrl,
      statusAwb: statusAwb ?? this.statusAwb,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'petugasEntry': petugasEntry,
      'custNo': custNo,
      'custName': custName,
      'orderId': orderId,
      'awbNo': awbNo,
      'awbRefno': awbRefno,
      'awbType': awbType,
      'cnoteReceiverPhone': cnoteReceiverPhone,
      'awbDate': awbDate,
      'hoCourierDate': hoCourierDate,
      'puLastAttempStatusDate': puLastAttempStatusDate,
      'cnoteShipperName': cnoteShipperName,
      'receiverName': receiverName,
      'cnoteReceiverAddr1': cnoteReceiverAddr1,
      'cnoteReceiverAddr2': cnoteReceiverAddr2,
      'cnoteReceiverAddr3': cnoteReceiverAddr3,
      'destinationName': destinationName,
      'service': service,
      'weightAwb': weightAwb,
      'awbGoodsDescr': awbGoodsDescr,
      'awbSpecialIns': awbSpecialIns,
      'awbAmount': awbAmount,
      'awbInsuranceValue': awbInsuranceValue,
      'codAmount': codAmount,
      'statusPod': statusPod,
      'tglReceived': tglReceived,
      'codingPod': codingPod,
      'receivedReason': receivedReason,
      'repcssPaymentDate': repcssPaymentDate,
      'repcssPaymentReffid': repcssPaymentReffid,
      'podlEpodUrlPic': podlEpodUrlPic,
      'podlEpodUrl': podlEpodUrl,
      'statusAwb': statusAwb,
    };
  }
}
