class AggregationDetailModel {
  AggregationDetailModel({
    String? mpayWdrGrpPayNo,
    String? dpayDetWdrNo,
    String? mpayWdrDate,
    String? dpayDetWdrCnoteno,
    String? dpayDetWdrCnotedate,
    String? dpayDetWdrPod,
    String? dpayDUpdPodDate,
    num? dpayDShipFee,
    num? dpayDFreightCharge,
    num? dpayDInsCharge,
    num? dpayDCodFee,
    num? dpayDReturnFee,
    num? dpayDetWdrCodamount,
    num? dpayDWdrDisc,
    num? dpayDWdrFchargeAftDisc,
    num? dpayDWdrFchargeVat,
    num? dpayDPackingFee,
    num? dpayDSurcharge,
    num? dpayDWdrRtFchargeAftDisc,
    num? dpayDWdrCodFeeInclVat,
    num? dpayDWdrRtFchargeVat,
    num? dpayDNetAmt,
    String? mpayWdrGrpPayDatePaid,
    String? orderIdTmp,
    String? custName,
    String? podGroupName,
  }) {
    _mpayWdrGrpPayNo = mpayWdrGrpPayNo;
    _dpayDetWdrNo = dpayDetWdrNo;
    _mpayWdrDate = mpayWdrDate;
    _dpayDetWdrCnoteno = dpayDetWdrCnoteno;
    _dpayDetWdrCnotedate = dpayDetWdrCnotedate;
    _dpayDetWdrPod = dpayDetWdrPod;
    _dpayDUpdPodDate = dpayDUpdPodDate;
    _dpayDShipFee = dpayDShipFee;
    _dpayDFreightCharge = dpayDFreightCharge;
    _dpayDInsCharge = dpayDInsCharge;
    _dpayDCodFee = dpayDCodFee;
    _dpayDReturnFee = dpayDReturnFee;
    _dpayDetWdrCodamount = dpayDetWdrCodamount;
    _dpayDWdrDisc = dpayDWdrDisc;
    _dpayDWdrFchargeAftDisc = dpayDWdrFchargeAftDisc;
    _dpayDWdrFchargeVat = dpayDWdrFchargeVat;
    _dpayDPackingFee = dpayDPackingFee;
    _dpayDSurcharge = dpayDSurcharge;
    _dpayDWdrRtFchargeAftDisc = dpayDWdrRtFchargeAftDisc;
    _dpayDWdrCodFeeInclVat = dpayDWdrCodFeeInclVat;
    _dpayDWdrRtFchargeVat = dpayDWdrRtFchargeVat;
    _dpayDNetAmt = dpayDNetAmt;
    _mpayWdrGrpPayDatePaid = mpayWdrGrpPayDatePaid;
    _orderIdTmp = orderIdTmp;
    _custName = custName;
    _podGroupName = podGroupName;
  }

  AggregationDetailModel.fromJson(dynamic json) {
    _mpayWdrGrpPayNo = json['mpayWdrGrpPayNo'];
    _dpayDetWdrNo = json['dpayDetWdrNo'];
    _mpayWdrDate = json['mpayWdrDate'];
    _dpayDetWdrCnoteno = json['dpayDetWdrCnoteno'];
    _dpayDetWdrCnotedate = json['dpayDetWdrCnotedate'];
    _dpayDetWdrPod = json['dpayDetWdrPod'];
    _dpayDUpdPodDate = json['dpayDUpdPodDate'];
    _dpayDShipFee = json['dpayDShipFee'];
    _dpayDFreightCharge = json['dpayDFreightCharge'];
    _dpayDInsCharge = json['dpayDInsCharge'];
    _dpayDCodFee = json['dpayDCodFee'];
    _dpayDReturnFee = json['dpayDReturnFee'];
    _dpayDetWdrCodamount = json['dpayDetWdrCodamount'];
    _dpayDWdrDisc = json['dpayDWdrDisc'];
    _dpayDWdrFchargeAftDisc = json['dpayDWdrFchargeAftDisc'];
    _dpayDWdrFchargeVat = json['dpayDWdrFchargeVat'];
    _dpayDPackingFee = json['dpayDPackingFee'];
    _dpayDSurcharge = json['dpayDSurcharge'];
    _dpayDWdrRtFchargeAftDisc = json['dpayDWdrRtFchargeAftDisc'];
    _dpayDWdrCodFeeInclVat = json['dpayDWdrCodFeeInclVat'];
    _dpayDWdrRtFchargeVat = json['dpayDWdrRtFchargeVat'];
    _dpayDNetAmt = json['dpayDNetAmt'];
    _mpayWdrGrpPayDatePaid = json['mpayWdrGrpPayDatePaid'];
    _orderIdTmp = json['orderIdTmp'];
    _custName = json['custName'];
    _podGroupName = json['podGroupName'];
  }

  String? _mpayWdrGrpPayNo;
  String? _dpayDetWdrNo;
  String? _mpayWdrDate;
  String? _dpayDetWdrCnoteno;
  String? _dpayDetWdrCnotedate;
  String? _dpayDetWdrPod;
  String? _dpayDUpdPodDate;
  num? _dpayDShipFee;
  num? _dpayDFreightCharge;
  num? _dpayDInsCharge;
  num? _dpayDCodFee;
  num? _dpayDReturnFee;
  num? _dpayDetWdrCodamount;
  num? _dpayDWdrDisc;
  num? _dpayDWdrFchargeAftDisc;
  num? _dpayDWdrFchargeVat;
  num? _dpayDPackingFee;
  num? _dpayDSurcharge;
  num? _dpayDWdrRtFchargeAftDisc;
  num? _dpayDWdrCodFeeInclVat;
  num? _dpayDWdrRtFchargeVat;
  num? _dpayDNetAmt;
  String? _mpayWdrGrpPayDatePaid;
  String? _orderIdTmp;
  String? _custName;
  String? _podGroupName;

  AggregationDetailModel copyWith({
    String? mpayWdrGrpPayNo,
    String? dpayDetWdrNo,
    String? mpayWdrDate,
    String? dpayDetWdrCnoteno,
    String? dpayDetWdrCnotedate,
    String? dpayDetWdrPod,
    String? dpayDUpdPodDate,
    num? dpayDShipFee,
    num? dpayDFreightCharge,
    num? dpayDInsCharge,
    num? dpayDCodFee,
    num? dpayDReturnFee,
    num? dpayDetWdrCodamount,
    num? dpayDWdrDisc,
    num? dpayDWdrFchargeAftDisc,
    num? dpayDWdrFchargeVat,
    num? dpayDPackingFee,
    num? dpayDSurcharge,
    num? dpayDWdrRtFchargeAftDisc,
    num? dpayDWdrCodFeeInclVat,
    num? dpayDWdrRtFchargeVat,
    num? dpayDNetAmt,
    String? mpayWdrGrpPayDatePaid,
    String? orderIdTmp,
    String? custName,
    String? podGroupName,
  }) =>
      AggregationDetailModel(
        mpayWdrGrpPayNo: mpayWdrGrpPayNo ?? _mpayWdrGrpPayNo,
        dpayDetWdrNo: dpayDetWdrNo ?? _dpayDetWdrNo,
        mpayWdrDate: mpayWdrDate ?? _mpayWdrDate,
        dpayDetWdrCnoteno: dpayDetWdrCnoteno ?? _dpayDetWdrCnoteno,
        dpayDetWdrCnotedate: dpayDetWdrCnotedate ?? _dpayDetWdrCnotedate,
        dpayDetWdrPod: dpayDetWdrPod ?? _dpayDetWdrPod,
        dpayDUpdPodDate: dpayDUpdPodDate ?? _dpayDUpdPodDate,
        dpayDShipFee: dpayDShipFee ?? _dpayDShipFee,
        dpayDFreightCharge: dpayDFreightCharge ?? _dpayDFreightCharge,
        dpayDInsCharge: dpayDInsCharge ?? _dpayDInsCharge,
        dpayDCodFee: dpayDCodFee ?? _dpayDCodFee,
        dpayDReturnFee: dpayDReturnFee ?? _dpayDReturnFee,
        dpayDetWdrCodamount: dpayDetWdrCodamount ?? _dpayDetWdrCodamount,
        dpayDWdrDisc: dpayDWdrDisc ?? _dpayDWdrDisc,
        dpayDWdrFchargeAftDisc:
            dpayDWdrFchargeAftDisc ?? _dpayDWdrFchargeAftDisc,
        dpayDWdrFchargeVat: dpayDWdrFchargeVat ?? _dpayDWdrFchargeVat,
        dpayDPackingFee: dpayDPackingFee ?? _dpayDPackingFee,
        dpayDSurcharge: dpayDSurcharge ?? _dpayDSurcharge,
        dpayDWdrRtFchargeAftDisc:
            dpayDWdrRtFchargeAftDisc ?? _dpayDWdrRtFchargeAftDisc,
        dpayDWdrCodFeeInclVat: dpayDWdrCodFeeInclVat ?? _dpayDWdrCodFeeInclVat,
        dpayDWdrRtFchargeVat: dpayDWdrRtFchargeVat ?? _dpayDWdrRtFchargeVat,
        dpayDNetAmt: dpayDNetAmt ?? _dpayDNetAmt,
        mpayWdrGrpPayDatePaid: mpayWdrGrpPayDatePaid ?? _mpayWdrGrpPayDatePaid,
        orderIdTmp: orderIdTmp ?? _orderIdTmp,
        custName: custName ?? _custName,
        podGroupName: podGroupName ?? _podGroupName,
      );

  String? get mpayWdrGrpPayNo => _mpayWdrGrpPayNo;

  String? get dpayDetWdrNo => _dpayDetWdrNo;

  String? get mpayWdrDate => _mpayWdrDate;

  String? get dpayDetWdrCnoteno => _dpayDetWdrCnoteno;

  String? get dpayDetWdrCnotedate => _dpayDetWdrCnotedate;

  String? get dpayDetWdrPod => _dpayDetWdrPod;

  String? get dpayDUpdPodDate => _dpayDUpdPodDate;

  num? get dpayDShipFee => _dpayDShipFee;

  num? get dpayDFreightCharge => _dpayDFreightCharge;

  num? get dpayDInsCharge => _dpayDInsCharge;

  num? get dpayDCodFee => _dpayDCodFee;

  num? get dpayDReturnFee => _dpayDReturnFee;

  num? get dpayDetWdrCodamount => _dpayDetWdrCodamount;

  num? get dpayDWdrDisc => _dpayDWdrDisc;

  num? get dpayDWdrFchargeAftDisc => _dpayDWdrFchargeAftDisc;

  num? get dpayDWdrFchargeVat => _dpayDWdrFchargeVat;

  num? get dpayDPackingFee => _dpayDPackingFee;

  num? get dpayDSurcharge => _dpayDSurcharge;

  num? get dpayDWdrRtFchargeAftDisc => _dpayDWdrRtFchargeAftDisc;

  num? get dpayDWdrCodFeeInclVat => _dpayDWdrCodFeeInclVat;

  num? get dpayDWdrRtFchargeVat => _dpayDWdrRtFchargeVat;

  num? get dpayDNetAmt => _dpayDNetAmt;

  String? get mpayWdrGrpPayDatePaid => _mpayWdrGrpPayDatePaid;

  String? get orderIdTmp => _orderIdTmp;

  String? get custName => _custName;

  String? get podGroupName => _podGroupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mpayWdrGrpPayNo'] = _mpayWdrGrpPayNo;
    map['dpayDetWdrNo'] = _dpayDetWdrNo;
    map['mpayWdrDate'] = _mpayWdrDate;
    map['dpayDetWdrCnoteno'] = _dpayDetWdrCnoteno;
    map['dpayDetWdrCnotedate'] = _dpayDetWdrCnotedate;
    map['dpayDetWdrPod'] = _dpayDetWdrPod;
    map['dpayDUpdPodDate'] = _dpayDUpdPodDate;
    map['dpayDShipFee'] = _dpayDShipFee;
    map['dpayDFreightCharge'] = _dpayDFreightCharge;
    map['dpayDInsCharge'] = _dpayDInsCharge;
    map['dpayDCodFee'] = _dpayDCodFee;
    map['dpayDReturnFee'] = _dpayDReturnFee;
    map['dpayDetWdrCodamount'] = _dpayDetWdrCodamount;
    map['dpayDWdrDisc'] = _dpayDWdrDisc;
    map['dpayDWdrFchargeAftDisc'] = _dpayDWdrFchargeAftDisc;
    map['dpayDWdrFchargeVat'] = _dpayDWdrFchargeVat;
    map['dpayDPackingFee'] = _dpayDPackingFee;
    map['dpayDSurcharge'] = _dpayDSurcharge;
    map['dpayDWdrRtFchargeAftDisc'] = _dpayDWdrRtFchargeAftDisc;
    map['dpayDWdrCodFeeInclVat'] = _dpayDWdrCodFeeInclVat;
    map['dpayDWdrRtFchargeVat'] = _dpayDWdrRtFchargeVat;
    map['dpayDNetAmt'] = _dpayDNetAmt;
    map['mpayWdrGrpPayDatePaid'] = _mpayWdrGrpPayDatePaid;
    map['orderIdTmp'] = _orderIdTmp;
    map['custName'] = _custName;
    map['podGroupName'] = _podGroupName;
    return map;
  }
}
