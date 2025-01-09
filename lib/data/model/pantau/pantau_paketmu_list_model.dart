class PantauPaketmuListModel {
  PantauPaketmuListModel({
    String? awbNo,
    String? awbDate,
    String? awbRefno,
    String? custNo,
    String? custName,
    String? cnoteReceiverPhone,
    dynamic hoCourierDate,
    dynamic puLastAttempStatusDate,
    String? cnoteShipperName,
    String? receiverName,
    String? cnoteReceiverAddr1,
    dynamic cnoteReceiverAddr2,
    dynamic cnoteReceiverAddr3,
    String? destinationName,
    String? service,
    num? weightAwb,
    String? awbGoodsDescr,
    String? awbSpecialIns,
    num? awbAmount,
    num? awbInsuranceValue,
    num? codAmount,
    dynamic statusPod,
    dynamic tglReceived,
    dynamic codingPod,
    dynamic receivedReason,
    dynamic repcssPaymentDate,
    dynamic repcssPaymentReffid,
    dynamic podlEpodUrlPic,
    dynamic podlEpodUrl,
    String? petugasEntry,
    String? orderId,
    String? awbType,
    String? statusawb,
    String? type,
  }) {
    _awbNo = awbNo;
    _awbDate = awbDate;
    _awbRefno = awbRefno;
    _custNo = custNo;
    _custName = custName;
    _cnoteReceiverPhone = cnoteReceiverPhone;
    _hoCourierDate = hoCourierDate;
    _puLastAttempStatusDate = puLastAttempStatusDate;
    _cnoteShipperName = cnoteShipperName;
    _receiverName = receiverName;
    _cnoteReceiverAddr1 = cnoteReceiverAddr1;
    _cnoteReceiverAddr2 = cnoteReceiverAddr2;
    _cnoteReceiverAddr3 = cnoteReceiverAddr3;
    _destinationName = destinationName;
    _service = service;
    _weightAwb = weightAwb;
    _awbGoodsDescr = awbGoodsDescr;
    _awbSpecialIns = awbSpecialIns;
    _awbAmount = awbAmount;
    _awbInsuranceValue = awbInsuranceValue;
    _codAmount = codAmount;
    _statusPod = statusPod;
    _tglReceived = tglReceived;
    _codingPod = codingPod;
    _receivedReason = receivedReason;
    _repcssPaymentDate = repcssPaymentDate;
    _repcssPaymentReffid = repcssPaymentReffid;
    _podlEpodUrlPic = podlEpodUrlPic;
    _podlEpodUrl = podlEpodUrl;
    _petugasEntry = petugasEntry;
    _orderId = orderId;
    _awbType = awbType;
    _statusawb = statusawb;
    _type = type;
  }

  PantauPaketmuListModel.fromJson(dynamic json) {
    _awbNo = json['awbNo'];
    _awbDate = json['awbDate'];
    _awbRefno = json['awbRefno'];
    _custNo = json['custNo'];
    _custName = json['custName'];
    _cnoteReceiverPhone = json['cnoteReceiverPhone'];
    _hoCourierDate = json['hoCourierDate'];
    _puLastAttempStatusDate = json['puLastAttempStatusDate'];
    _cnoteShipperName = json['cnoteShipperName'];
    _receiverName = json['receiverName'];
    _cnoteReceiverAddr1 = json['cnoteReceiverAddr1'];
    _cnoteReceiverAddr2 = json['cnoteReceiverAddr2'];
    _cnoteReceiverAddr3 = json['cnoteReceiverAddr3'];
    _destinationName = json['destinationName'];
    _service = json['service'];
    _weightAwb = json['weightAwb'];
    _awbGoodsDescr = json['awbGoodsDescr'];
    _awbSpecialIns = json['awbSpecialIns'];
    _awbAmount = json['awbAmount'];
    _awbInsuranceValue = json['awbInsuranceValue'];
    _codAmount = json['codAmount'];
    _statusPod = json['statusPod'];
    _tglReceived = json['tglReceived'];
    _codingPod = json['codingPod'];
    _receivedReason = json['receivedReason'];
    _repcssPaymentDate = json['repcssPaymentDate'];
    _repcssPaymentReffid = json['repcssPaymentReffid'];
    _podlEpodUrlPic = json['podlEpodUrlPic'];
    _podlEpodUrl = json['podlEpodUrl'];
    _petugasEntry = json['petugasEntry'];
    _orderId = json['orderId'];
    _awbType = json['awbType'];
    _statusawb = json['statusawb'];
    _type = json['type'];
  }
  String? _awbNo;
  String? _awbDate;
  String? _awbRefno;
  String? _custNo;
  String? _custName;
  String? _cnoteReceiverPhone;
  dynamic _hoCourierDate;
  dynamic _puLastAttempStatusDate;
  String? _cnoteShipperName;
  String? _receiverName;
  String? _cnoteReceiverAddr1;
  dynamic _cnoteReceiverAddr2;
  dynamic _cnoteReceiverAddr3;
  String? _destinationName;
  String? _service;
  num? _weightAwb;
  String? _awbGoodsDescr;
  String? _awbSpecialIns;
  num? _awbAmount;
  num? _awbInsuranceValue;
  num? _codAmount;
  dynamic _statusPod;
  dynamic _tglReceived;
  dynamic _codingPod;
  dynamic _receivedReason;
  dynamic _repcssPaymentDate;
  dynamic _repcssPaymentReffid;
  dynamic _podlEpodUrlPic;
  dynamic _podlEpodUrl;
  String? _petugasEntry;
  String? _orderId;
  String? _awbType;
  String? _statusawb;
  String? _type;
  PantauPaketmuListModel copyWith({
    String? awbNo,
    String? awbDate,
    String? awbRefno,
    String? custNo,
    String? custName,
    String? cnoteReceiverPhone,
    dynamic hoCourierDate,
    dynamic puLastAttempStatusDate,
    String? cnoteShipperName,
    String? receiverName,
    String? cnoteReceiverAddr1,
    dynamic cnoteReceiverAddr2,
    dynamic cnoteReceiverAddr3,
    String? destinationName,
    String? service,
    num? weightAwb,
    String? awbGoodsDescr,
    String? awbSpecialIns,
    num? awbAmount,
    num? awbInsuranceValue,
    num? codAmount,
    dynamic statusPod,
    dynamic tglReceived,
    dynamic codingPod,
    dynamic receivedReason,
    dynamic repcssPaymentDate,
    dynamic repcssPaymentReffid,
    dynamic podlEpodUrlPic,
    dynamic podlEpodUrl,
    String? petugasEntry,
    String? orderId,
    String? awbType,
    String? statusawb,
    String? type,
  }) =>
      PantauPaketmuListModel(
        awbNo: awbNo ?? _awbNo,
        awbDate: awbDate ?? _awbDate,
        awbRefno: awbRefno ?? _awbRefno,
        custNo: custNo ?? _custNo,
        custName: custName ?? _custName,
        cnoteReceiverPhone: cnoteReceiverPhone ?? _cnoteReceiverPhone,
        hoCourierDate: hoCourierDate ?? _hoCourierDate,
        puLastAttempStatusDate:
            puLastAttempStatusDate ?? _puLastAttempStatusDate,
        cnoteShipperName: cnoteShipperName ?? _cnoteShipperName,
        receiverName: receiverName ?? _receiverName,
        cnoteReceiverAddr1: cnoteReceiverAddr1 ?? _cnoteReceiverAddr1,
        cnoteReceiverAddr2: cnoteReceiverAddr2 ?? _cnoteReceiverAddr2,
        cnoteReceiverAddr3: cnoteReceiverAddr3 ?? _cnoteReceiverAddr3,
        destinationName: destinationName ?? _destinationName,
        service: service ?? _service,
        weightAwb: weightAwb ?? _weightAwb,
        awbGoodsDescr: awbGoodsDescr ?? _awbGoodsDescr,
        awbSpecialIns: awbSpecialIns ?? _awbSpecialIns,
        awbAmount: awbAmount ?? _awbAmount,
        awbInsuranceValue: awbInsuranceValue ?? _awbInsuranceValue,
        codAmount: codAmount ?? _codAmount,
        statusPod: statusPod ?? _statusPod,
        tglReceived: tglReceived ?? _tglReceived,
        codingPod: codingPod ?? _codingPod,
        receivedReason: receivedReason ?? _receivedReason,
        repcssPaymentDate: repcssPaymentDate ?? _repcssPaymentDate,
        repcssPaymentReffid: repcssPaymentReffid ?? _repcssPaymentReffid,
        podlEpodUrlPic: podlEpodUrlPic ?? _podlEpodUrlPic,
        podlEpodUrl: podlEpodUrl ?? _podlEpodUrl,
        petugasEntry: petugasEntry ?? _petugasEntry,
        orderId: orderId ?? _orderId,
        awbType: awbType ?? _awbType,
        statusawb: statusawb ?? _statusawb,
        type: type ?? _type,
      );
  String? get awbNo => _awbNo;
  String? get awbDate => _awbDate;
  String? get awbRefno => _awbRefno;
  String? get custNo => _custNo;
  String? get custName => _custName;
  String? get cnoteReceiverPhone => _cnoteReceiverPhone;
  dynamic get hoCourierDate => _hoCourierDate;
  dynamic get puLastAttempStatusDate => _puLastAttempStatusDate;
  String? get cnoteShipperName => _cnoteShipperName;
  String? get receiverName => _receiverName;
  String? get cnoteReceiverAddr1 => _cnoteReceiverAddr1;
  dynamic get cnoteReceiverAddr2 => _cnoteReceiverAddr2;
  dynamic get cnoteReceiverAddr3 => _cnoteReceiverAddr3;
  String? get destinationName => _destinationName;
  String? get service => _service;
  num? get weightAwb => _weightAwb;
  String? get awbGoodsDescr => _awbGoodsDescr;
  String? get awbSpecialIns => _awbSpecialIns;
  num? get awbAmount => _awbAmount;
  num? get awbInsuranceValue => _awbInsuranceValue;
  num? get codAmount => _codAmount;
  dynamic get statusPod => _statusPod;
  dynamic get tglReceived => _tglReceived;
  dynamic get codingPod => _codingPod;
  dynamic get receivedReason => _receivedReason;
  dynamic get repcssPaymentDate => _repcssPaymentDate;
  dynamic get repcssPaymentReffid => _repcssPaymentReffid;
  dynamic get podlEpodUrlPic => _podlEpodUrlPic;
  dynamic get podlEpodUrl => _podlEpodUrl;
  String? get petugasEntry => _petugasEntry;
  String? get orderId => _orderId;
  String? get awbType => _awbType;
  String? get statusawb => _statusawb;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awbNo'] = _awbNo;
    map['awbDate'] = _awbDate;
    map['awbRefno'] = _awbRefno;
    map['custNo'] = _custNo;
    map['custName'] = _custName;
    map['cnoteReceiverPhone'] = _cnoteReceiverPhone;
    map['hoCourierDate'] = _hoCourierDate;
    map['puLastAttempStatusDate'] = _puLastAttempStatusDate;
    map['cnoteShipperName'] = _cnoteShipperName;
    map['receiverName'] = _receiverName;
    map['cnoteReceiverAddr1'] = _cnoteReceiverAddr1;
    map['cnoteReceiverAddr2'] = _cnoteReceiverAddr2;
    map['cnoteReceiverAddr3'] = _cnoteReceiverAddr3;
    map['destinationName'] = _destinationName;
    map['service'] = _service;
    map['weightAwb'] = _weightAwb;
    map['awbGoodsDescr'] = _awbGoodsDescr;
    map['awbSpecialIns'] = _awbSpecialIns;
    map['awbAmount'] = _awbAmount;
    map['awbInsuranceValue'] = _awbInsuranceValue;
    map['codAmount'] = _codAmount;
    map['statusPod'] = _statusPod;
    map['tglReceived'] = _tglReceived;
    map['codingPod'] = _codingPod;
    map['receivedReason'] = _receivedReason;
    map['repcssPaymentDate'] = _repcssPaymentDate;
    map['repcssPaymentReffid'] = _repcssPaymentReffid;
    map['podlEpodUrlPic'] = _podlEpodUrlPic;
    map['podlEpodUrl'] = _podlEpodUrl;
    map['petugasEntry'] = _petugasEntry;
    map['orderId'] = _orderId;
    map['awbType'] = _awbType;
    map['statusawb'] = _statusawb;
    map['type'] = _type;
    return map;
  }
}
