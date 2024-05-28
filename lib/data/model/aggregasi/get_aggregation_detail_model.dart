class GetAggregationDetailModel {
  GetAggregationDetailModel({
    num? code,
    String? message,
    List<AggregationDetailModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetAggregationDetailModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(AggregationDetailModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<AggregationDetailModel>? _payload;

  GetAggregationDetailModel copyWith({
    num? code,
    String? message,
    List<AggregationDetailModel>? payload,
  }) =>
      GetAggregationDetailModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<AggregationDetailModel>? get payload => _payload;

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

class AggregationDetailModel {
  AggregationDetailModel({
    String? aggDocNo,
    String? aggPayReff,
    String? aggDocDate,
    String? cnoteNo,
    String? cnoteDate,
    String? podCode,
    String? podDateSys,
    num? shipmentFee,
    num? freightCharge,
    num? insuranceCharge,
    num? codFee,
    num? returnFee,
    num? codAmount,
    num? discount,
    num? fchargeDisc,
    num? fchargeVat,
    num? packingFee,
    num? surcharge,
    num? rtfChargeDisc,
    num? rtfChargeVat,
    num? codFeeVat,
    num? netAwbAmt,
    String? paidDate,
    String? orderIdTmp,
    String? custName,
    String? podGroupName,
  }) {
    _aggDocNo = aggDocNo;
    _aggPayReff = aggPayReff;
    _aggDocDate = aggDocDate;
    _cnoteNo = cnoteNo;
    _cnoteDate = cnoteDate;
    _podCode = podCode;
    _podDateSys = podDateSys;
    _shipmentFee = shipmentFee;
    _freightCharge = freightCharge;
    _insuranceCharge = insuranceCharge;
    _codFee = codFee;
    _returnFee = returnFee;
    _codAmount = codAmount;
    _discount = discount;
    _fchargeDisc = fchargeDisc;
    _fchargeVat = fchargeVat;
    _packingFee = packingFee;
    _surcharge = surcharge;
    _rtfChargeDisc = rtfChargeDisc;
    _rtfChargeVat = rtfChargeVat;
    _codFeeVat = codFeeVat;
    _netAwbAmt = netAwbAmt;
    _paidDate = paidDate;
    _orderIdTmp = orderIdTmp;
    _custName = custName;
    _podGroupName = podGroupName;
  }

  AggregationDetailModel.fromJson(dynamic json) {
    _aggDocNo = json['agg_doc_no'];
    _aggPayReff = json['agg_pay_reff'];
    _aggDocDate = json['agg_doc_date'];
    _cnoteNo = json['cnote_no'];
    _cnoteDate = json['cnote_date'];
    _podCode = json['pod_code'];
    _podDateSys = json['pod_date_sys'];
    _shipmentFee = json['shipment_fee'];
    _freightCharge = json['freight_charge'];
    _insuranceCharge = json['insurance_charge'];
    _codFee = json['cod_fee'];
    _returnFee = json['return_fee'];
    _codAmount = json['cod_amount'];
    _discount = json['discount'];
    _fchargeDisc = json['fcharge_disc'];
    _fchargeVat = json['fcharge_vat'];
    _packingFee = json['packing_fee'];
    _surcharge = json['surcharge'];
    _rtfChargeDisc = json['rtfCharge_disc'];
    _rtfChargeVat = json['rtfCharge_vat'];
    _codFeeVat = json['cod_fee_vat'];
    _netAwbAmt = json['net_awb_amt'];
    _paidDate = json['paid_date'];
    _orderIdTmp = json['order_id_tmp'];
    _custName = json['cust_name'];
    _podGroupName = json['pod_group_name'];
  }

  String? _aggDocNo;
  String? _aggPayReff;
  String? _aggDocDate;
  String? _cnoteNo;
  String? _cnoteDate;
  String? _podCode;
  String? _podDateSys;
  num? _shipmentFee;
  num? _freightCharge;
  num? _insuranceCharge;
  num? _codFee;
  num? _returnFee;
  num? _codAmount;
  num? _discount;
  num? _fchargeDisc;
  num? _fchargeVat;
  num? _packingFee;
  num? _surcharge;
  num? _rtfChargeDisc;
  num? _rtfChargeVat;
  num? _codFeeVat;
  num? _netAwbAmt;
  String? _paidDate;
  String? _orderIdTmp;
  String? _custName;
  String? _podGroupName;

  AggregationDetailModel copyWith({
    String? aggDocNo,
    String? aggPayReff,
    String? aggDocDate,
    String? cnoteNo,
    String? cnoteDate,
    String? podCode,
    String? podDateSys,
    num? shipmentFee,
    num? freightCharge,
    num? insuranceCharge,
    num? codFee,
    num? returnFee,
    num? codAmount,
    num? discount,
    num? fchargeDisc,
    num? fchargeVat,
    num? packingFee,
    num? surcharge,
    num? rtfChargeDisc,
    num? rtfChargeVat,
    num? codFeeVat,
    num? netAwbAmt,
    String? paidDate,
    String? orderIdTmp,
    String? custName,
    String? podGroupName,
  }) =>
      AggregationDetailModel(
        aggDocNo: aggDocNo ?? _aggDocNo,
        aggPayReff: aggPayReff ?? _aggPayReff,
        aggDocDate: aggDocDate ?? _aggDocDate,
        cnoteNo: cnoteNo ?? _cnoteNo,
        cnoteDate: cnoteDate ?? _cnoteDate,
        podCode: podCode ?? _podCode,
        podDateSys: podDateSys ?? _podDateSys,
        shipmentFee: shipmentFee ?? _shipmentFee,
        freightCharge: freightCharge ?? _freightCharge,
        insuranceCharge: insuranceCharge ?? _insuranceCharge,
        codFee: codFee ?? _codFee,
        returnFee: returnFee ?? _returnFee,
        codAmount: codAmount ?? _codAmount,
        discount: discount ?? _discount,
        fchargeDisc: fchargeDisc ?? _fchargeDisc,
        fchargeVat: fchargeVat ?? _fchargeVat,
        packingFee: packingFee ?? _packingFee,
        surcharge: surcharge ?? _surcharge,
        rtfChargeDisc: rtfChargeDisc ?? _rtfChargeDisc,
        rtfChargeVat: rtfChargeVat ?? _rtfChargeVat,
        codFeeVat: codFeeVat ?? _codFeeVat,
        netAwbAmt: netAwbAmt ?? _netAwbAmt,
        paidDate: paidDate ?? _paidDate,
        orderIdTmp: orderIdTmp ?? _orderIdTmp,
        custName: custName ?? _custName,
        podGroupName: podGroupName ?? _podGroupName,
      );

  String? get aggDocNo => _aggDocNo;

  String? get aggPayReff => _aggPayReff;

  String? get aggDocDate => _aggDocDate;

  String? get cnoteNo => _cnoteNo;

  String? get cnoteDate => _cnoteDate;

  String? get podCode => _podCode;

  String? get podDateSys => _podDateSys;

  num? get shipmentFee => _shipmentFee;

  num? get freightCharge => _freightCharge;

  num? get insuranceCharge => _insuranceCharge;

  num? get codFee => _codFee;

  num? get returnFee => _returnFee;

  num? get codAmount => _codAmount;

  num? get discount => _discount;

  num? get fchargeDisc => _fchargeDisc;

  num? get fchargeVat => _fchargeVat;

  num? get packingFee => _packingFee;

  num? get surcharge => _surcharge;

  num? get rtfChargeDisc => _rtfChargeDisc;

  num? get rtfChargeVat => _rtfChargeVat;

  num? get codFeeVat => _codFeeVat;

  num? get netAwbAmt => _netAwbAmt;

  String? get paidDate => _paidDate;

  String? get orderIdTmp => _orderIdTmp;

  String? get custName => _custName;

  String? get podGroupName => _podGroupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agg_doc_no'] = _aggDocNo;
    map['agg_pay_reff'] = _aggPayReff;
    map['agg_doc_date'] = _aggDocDate;
    map['cnote_no'] = _cnoteNo;
    map['cnote_date'] = _cnoteDate;
    map['pod_code'] = _podCode;
    map['pod_date_sys'] = _podDateSys;
    map['shipment_fee'] = _shipmentFee;
    map['freight_charge'] = _freightCharge;
    map['insurance_charge'] = _insuranceCharge;
    map['cod_fee'] = _codFee;
    map['return_fee'] = _returnFee;
    map['cod_amount'] = _codAmount;
    map['discount'] = _discount;
    map['fcharge_disc'] = _fchargeDisc;
    map['fcharge_vat'] = _fchargeVat;
    map['packing_fee'] = _packingFee;
    map['surcharge'] = _surcharge;
    map['rtfCharge_disc'] = _rtfChargeDisc;
    map['rtfCharge_vat'] = _rtfChargeVat;
    map['cod_fee_vat'] = _codFeeVat;
    map['net_awb_amt'] = _netAwbAmt;
    map['paid_date'] = _paidDate;
    map['order_id_tmp'] = _orderIdTmp;
    map['cust_name'] = _custName;
    map['pod_group_name'] = _podGroupName;
    return map;
  }
}
