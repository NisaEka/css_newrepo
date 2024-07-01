class GetPantauPaketmuModel {
  GetPantauPaketmuModel({
    num? code,
    String? message,
    List<PantauPaketmuModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetPantauPaketmuModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(PantauPaketmuModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<PantauPaketmuModel>? _payload;

  GetPantauPaketmuModel copyWith({
    num? code,
    String? message,
    List<PantauPaketmuModel>? payload,
  }) =>
      GetPantauPaketmuModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<PantauPaketmuModel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PantauPaketmuModel {
  PantauPaketmuModel({
    String? petugasEntry,
    String? custNo,
    String? orderId,
    String? awbNo,
    String? awbReffNo,
    String? awbType,
    String? receiverPhone,
    String? awbDate,
    String? courierDate,
    String? puLastAttempStatusDate,
    String? shipperName,
    String? receiverName,
    String? receiverAddr1,
    String? receiverAddr2,
    String? receiverAddr3,
    String? destName,
    String? service,
    num? goodsWeight,
    String? goodsDescr,
    String? specialIns,
    num? awbAmount,
    num? awbInsurance,
    num? codAmount,
    String? statusPod,
    String? tglReceived,
    String? codingPod,
    String? receivedReason,
    String? paymentDate,
    String? paymentReffId,
    String? podUrlPic,
    String? podUrl,
  }) {
    _petugasEntry = petugasEntry;
    _custNo = custNo;
    _orderId = orderId;
    _awbNo = awbNo;
    _awbReffNo = awbReffNo;
    _awbType = awbType;
    _receiverPhone = receiverPhone;
    _awbDate = awbDate;
    _courierDate = courierDate;
    _puLastAttempStatusDate = puLastAttempStatusDate;
    _shipperName = shipperName;
    _receiverName = receiverName;
    _receiverAddr1 = receiverAddr1;
    _receiverAddr2 = receiverAddr2;
    _receiverAddr3 = receiverAddr3;
    _destName = destName;
    _service = service;
    _goodsWeight = goodsWeight;
    _goodsDescr = goodsDescr;
    _specialIns = specialIns;
    _awbAmount = awbAmount;
    _awbInsurance = awbInsurance;
    _codAmount = codAmount;
    _statusPod = statusPod;
    _tglReceived = tglReceived;
    _codingPod = codingPod;
    _receivedReason = receivedReason;
    _paymentDate = paymentDate;
    _paymentReffId = paymentReffId;
    _podUrlPic = podUrlPic;
    _podUrl = podUrl;
  }

  PantauPaketmuModel.fromJson(dynamic json) {
    _petugasEntry = json['petugas_entry'];
    _custNo = json['cust_no'];
    _orderId = json['order_id'];
    _awbNo = json['awb_no'];
    _awbReffNo = json['awb_reff_no'];
    _awbType = json['awb_type'];
    _receiverPhone = json['receiver_phone'];
    _awbDate = json['awb_date'];
    _courierDate = json['courier_date'];
    _puLastAttempStatusDate = json['pu_last_attemp_status_date'];
    _shipperName = json['shipper_name'];
    _receiverName = json['receiver_name'];
    _receiverAddr1 = json['receiver_addr1'];
    _receiverAddr2 = json['receiver_addr2'];
    _receiverAddr3 = json['receiver_addr3'];
    _destName = json['dest_name'];
    _service = json['service'];
    _goodsWeight = json['goods_weight'];
    _goodsDescr = json['goods_descr'];
    _specialIns = json['special_ins'];
    _awbAmount = json['awb_amount'];
    _awbInsurance = json['awb_insurance'];
    _codAmount = json['cod_amount'];
    _statusPod = json['status_pod'];
    _tglReceived = json['tgl_received'];
    _codingPod = json['coding_pod'];
    _receivedReason = json['received_reason'];
    _paymentDate = json['payment_date'];
    _paymentReffId = json['payment_reff_id'];
    _podUrlPic = json['pod_url_pic'];
    _podUrl = json['pod_url'];
  }

  String? _petugasEntry;
  String? _custNo;
  String? _orderId;
  String? _awbNo;
  String? _awbReffNo;
  String? _awbType;
  String? _receiverPhone;
  String? _awbDate;
  String? _courierDate;
  String? _puLastAttempStatusDate;
  String? _shipperName;
  String? _receiverName;
  String? _receiverAddr1;
  String? _receiverAddr2;
  String? _receiverAddr3;
  String? _destName;
  String? _service;
  num? _goodsWeight;
  String? _goodsDescr;
  String? _specialIns;
  num? _awbAmount;
  num? _awbInsurance;
  num? _codAmount;
  String? _statusPod;
  String? _tglReceived;
  String? _codingPod;
  String? _receivedReason;
  String? _paymentDate;
  String? _paymentReffId;
  String? _podUrlPic;
  String? _podUrl;

  PantauPaketmuModel copyWith({
    String? petugasEntry,
    String? custNo,
    String? orderId,
    String? awbNo,
    String? awbReffNo,
    String? awbType,
    String? receiverPhone,
    String? awbDate,
    String? courierDate,
    String? puLastAttempStatusDate,
    String? shipperName,
    String? receiverName,
    String? receiverAddr1,
    String? receiverAddr2,
    String? receiverAddr3,
    String? destName,
    String? service,
    num? goodsWeight,
    String? goodsDescr,
    String? specialIns,
    num? awbAmount,
    num? awbInsurance,
    num? codAmount,
    String? statusPod,
    String? tglReceived,
    String? codingPod,
    String? receivedReason,
    String? paymentDate,
    String? paymentReffId,
    String? podUrlPic,
    String? podUrl,
  }) =>
      PantauPaketmuModel(
        petugasEntry: petugasEntry ?? _petugasEntry,
        custNo: custNo ?? _custNo,
        orderId: orderId ?? _orderId,
        awbNo: awbNo ?? _awbNo,
        awbReffNo: awbReffNo ?? _awbReffNo,
        awbType: awbType ?? _awbType,
        receiverPhone: receiverPhone ?? _receiverPhone,
        awbDate: awbDate ?? _awbDate,
        courierDate: courierDate ?? _courierDate,
        puLastAttempStatusDate: puLastAttempStatusDate ?? _puLastAttempStatusDate,
        shipperName: shipperName ?? _shipperName,
        receiverName: receiverName ?? _receiverName,
        receiverAddr1: receiverAddr1 ?? _receiverAddr1,
        receiverAddr2: receiverAddr2 ?? _receiverAddr2,
        receiverAddr3: receiverAddr3 ?? _receiverAddr3,
        destName: destName ?? _destName,
        service: service ?? _service,
        goodsWeight: goodsWeight ?? _goodsWeight,
        goodsDescr: goodsDescr ?? _goodsDescr,
        specialIns: specialIns ?? _specialIns,
        awbAmount: awbAmount ?? _awbAmount,
        awbInsurance: awbInsurance ?? _awbInsurance,
        codAmount: codAmount ?? _codAmount,
        statusPod: statusPod ?? _statusPod,
        tglReceived: tglReceived ?? _tglReceived,
        codingPod: codingPod ?? _codingPod,
        receivedReason: receivedReason ?? _receivedReason,
        paymentDate: paymentDate ?? _paymentDate,
        paymentReffId: paymentReffId ?? _paymentReffId,
        podUrlPic: podUrlPic ?? _podUrlPic,
        podUrl: podUrl ?? _podUrl,
      );

  String? get petugasEntry => _petugasEntry;

  String? get custNo => _custNo;

  String? get orderId => _orderId;

  String? get awbNo => _awbNo;

  String? get awbReffNo => _awbReffNo;

  String? get awbType => _awbType;

  String? get receiverPhone => _receiverPhone;

  String? get awbDate => _awbDate;

  String? get courierDate => _courierDate;

  String? get puLastAttempStatusDate => _puLastAttempStatusDate;

  String? get shipperName => _shipperName;

  String? get receiverName => _receiverName;

  String? get receiverAddr1 => _receiverAddr1;

  String? get receiverAddr2 => _receiverAddr2;

  String? get receiverAddr3 => _receiverAddr3;

  String? get destName => _destName;

  String? get service => _service;

  num? get goodsWeight => _goodsWeight;

  String? get goodsDescr => _goodsDescr;

  String? get specialIns => _specialIns;

  num? get awbAmount => _awbAmount;

  num? get awbInsurance => _awbInsurance;

  num? get codAmount => _codAmount;

  String? get statusPod => _statusPod;

  String? get tglReceived => _tglReceived;

  String? get codingPod => _codingPod;

  String? get receivedReason => _receivedReason;

  String? get paymentDate => _paymentDate;

  String? get paymentReffId => _paymentReffId;

  String? get podUrlPic => _podUrlPic;

  String? get podUrl => _podUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['petugas_entry'] = _petugasEntry;
    map['cust_no'] = _custNo;
    map['order_id'] = _orderId;
    map['awb_no'] = _awbNo;
    map['awb_reff_no'] = _awbReffNo;
    map['awb_type'] = _awbType;
    map['receiver_phone'] = _receiverPhone;
    map['awb_date'] = _awbDate;
    map['courier_date'] = _courierDate;
    map['pu_last_attemp_status_date'] = _puLastAttempStatusDate;
    map['shipper_name'] = _shipperName;
    map['receiver_name'] = _receiverName;
    map['receiver_addr1'] = _receiverAddr1;
    map['receiver_addr2'] = _receiverAddr2;
    map['receiver_addr3'] = _receiverAddr3;
    map['dest_name'] = _destName;
    map['service'] = _service;
    map['goods_weight'] = _goodsWeight;
    map['goods_descr'] = _goodsDescr;
    map['special_ins'] = _specialIns;
    map['awb_amount'] = _awbAmount;
    map['awb_insurance'] = _awbInsurance;
    map['cod_amount'] = _codAmount;
    map['status_pod'] = _statusPod;
    map['tgl_received'] = _tglReceived;
    map['coding_pod'] = _codingPod;
    map['received_reason'] = _receivedReason;
    map['payment_date'] = _paymentDate;
    map['payment_reff_id'] = _paymentReffId;
    map['pod_url_pic'] = _podUrlPic;
    map['pod_url'] = _podUrl;
    return map;
  }
}
