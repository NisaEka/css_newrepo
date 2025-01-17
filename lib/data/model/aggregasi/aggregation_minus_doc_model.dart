class AggregationMinusDocModel {
  String? _dAggMinDoc = "";

  String? get dAggMinDoc => _dAggMinDoc;

  String? _dDocDate = "";

  String? get dDocDate => _dDocDate;

  String? _dAggPayRef = "";

  String? get dAggPayRef => _dAggPayRef;

  String? _dCustGroupId = "";

  String? get dCustGroupId => _dCustGroupId;

  String? _dCustId = "";

  String? get dCustId => _dCustId;

  String? _dCustName = "";

  String? get dCustName => _dCustName;

  num? _dNetAggAmt = 0;

  num? get dNetAggAmt => _dNetAggAmt;

  String? _dCodType = "";

  String? get dCodType => _dCodType;

  String? _dPayType = "";

  String? get dPayType => _dPayType;

  String? _dAggDate = "";

  String? get dAggDate => _dAggDate;

  String? _dCnoteNo = "";

  String? get dCnoteNo => _dCnoteNo;

  String? _dCnoteDate = "";

  String? get dCnoteDate => _dCnoteDate;

  String? _dOrderid = "";

  String? get dOrderid => _dOrderid;

  String? _dAggPeriod = "";

  String? get dAggPeriod => _dAggPeriod;

  String? _dPodCode = "";

  String? get dPodCode => _dPodCode;

  String? _dPodDateSys = "";

  String? get dPodDateSys => _dPodDateSys;

  num? _dShipFee = 0;

  num? get dShipFee => _dShipFee;

  num? _dInsCharge = 0;

  num? get dInsCharge => _dInsCharge;

  num? _dCodFee = 0;

  num? get dCodFee => _dCodFee;

  num? _dReturnFee = 0;

  num? get dReturnFee => _dReturnFee;

  num? _dCodAmt = 0;

  num? get dCodAmt => _dCodAmt;

  num? _dDiscount = 0;

  num? get dDiscount => _dDiscount;

  num? _dFchargeAftDisc = 0;

  num? get dFchargeAftDisc => _dFchargeAftDisc;

  num? _dFchargeVat = 0;

  num? get dFchargeVat => _dFchargeVat;

  num? _dPackingFee = 0;

  num? get dPackingFee => _dPackingFee;

  num? _dSurcharge = 0;

  num? get dSurcharge => _dSurcharge;

  num? _dRtFchargeAftDisc = 0;

  num? get dRtFchargeAftDisc => _dRtFchargeAftDisc;

  num? _dRtFchargeVat = 0;

  num? get dRtFchargeVat => _dRtFchargeVat;

  num? _dCodfeeInclvat = 0;

  num? get dCodfeeInclvat => _dCodfeeInclvat;

  num? _dNetAwbAmt = 0;

  num? get dNetAwbAmt => _dNetAwbAmt;

  String? _createddtm = "";

  String? get createddtm => _createddtm;

  String? _createdby = "";

  String? get createdby => _createdby;

  String? _lastupddtm = "";

  String? get lastupddtm => _lastupddtm;

  String? _lastupdby = "";

  String? get lastupdby => _lastupdby;

  String? _lastupdprocess = "";

  String? get lastupdprocess => _lastupdprocess;

  AggregationMinusDocModel.fromJson(dynamic json) {
    _dAggMinDoc = json["dAggMinDoc"];
    _dDocDate = json["dDocDate"];
    _dAggPayRef = json["dAggPayRef"];
    _dCustGroupId = json["dCustGroupId"];
    _dCustId = json["dCustId"];
    _dCustName = json["dCustName"];
    _dNetAggAmt = json["dNetAggAmt"];
    _dCodType = json["dCodType"];
    _dPayType = json["dPayType"];
    _dAggDate = json["dAggDate"];
    _dCnoteNo = json["dCnoteNo"];
    _dCnoteDate = json["dCnoteDate"];
    _dOrderid = json["dOrderid"];
    _dAggPeriod = json["dAggPeriod"];
    _dPodCode = json["dPodCode"];
    _dPodDateSys = json["dPodDateSys"];
    _dShipFee = json["dShipFee"];
    _dInsCharge = json["dInsCharge"];
    _dCodFee = json["dCodFee"];
    _dReturnFee = json["dReturnFee"];
    _dCodAmt = json["dCodAmt"];
    _dDiscount = json["dDiscount"];
    _dFchargeAftDisc = json["dFchargeAftDisc"];
    _dFchargeVat = json["dFchargeVat"];
    _dPackingFee = json["dPackingFee"];
    _dSurcharge = json["dSurcharge"];
    _dRtFchargeAftDisc = json["dRtFchargeAftDisc"];
    _dRtFchargeVat = json["dRtFchargeVat"];
    _dCodfeeInclvat = json["dCodfeeInclvat"];
    _dNetAwbAmt = json["dNetAwbAmt"];
    _createddtm = json["createddtm"];
    _createdby = json["createdby"];
    _lastupddtm = json["lastupddtm"];
    _lastupdby = json["lastupdby"];
    _lastupdprocess = json["lastupdprocess"];
  }
}
