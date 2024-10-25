class AggregationMinusDocModel {
  String? _aggMinDoc = "";
  String? get aggMinDoc => _aggMinDoc;

  String? _docDate = "";
  String? get docDate => _docDate;

  String? _aggPayRef = "";
  String? get aggPayRef => _aggPayRef;

  String? _custGroupId = "";
  String? get custGroupId => _custGroupId;

  String? _custId = "";
  String? get custId => _custId;

  String? _custName = "";
  String? get custName => _custName;

  num? _netAggAmount = 0;
  num? get netAggAmount => _netAggAmount;

  String? _codType = "";
  String? get codType => _codType;

  String? _payType = "";
  String? get payType => _payType;

  String? _aggDate = "";
  String? get aggDate => _aggDate;

  String? _cnoteNo = "";
  String? get cnoteNo => _cnoteNo;

  String? _cnoteDate = "";
  String? get cnoteDate => _cnoteDate;

  String? _orderId = "";
  String? get orderId => _orderId;

  String? _aggPeriod = "";
  String? get aggPeriod => _aggPeriod;

  String? _podCode = "";
  String? get podCode => _podCode;

  String? _podDateSys = "";
  String? get podDateSys => _podDateSys;

  num? _shipFee = 0;
  num? get shipFee => _shipFee;

  num? _insuranceCharge = 0;
  num? get insuranceCharge => _insuranceCharge;

  num? _codFee = 0;
  num? get codFee => _codFee;

  num? _returnFee = 0;
  num? get returnFee => _returnFee;

  num? _codAmount = 0;
  num? get codAmount => _codAmount;

  num? _discount = 0;
  num? get discount => _discount;

  num? _freightChargeAfterDisc = 0;
  num? get freightChargeAfterDisc => _freightChargeAfterDisc;

  num? _freightChargeVat = 0;
  num? get freightChargeVat => _freightChargeVat;

  num? _packingFee = 0;
  num? get packingFee => _packingFee;

  num? _surcharge = 0;
  num? get surcharge => _surcharge;

  num? _returnFreightChargeAfterDisc = 0;
  num? get returnFreightChargeAfterDisc => _returnFreightChargeAfterDisc;

  num? _returnFreightChargeVat = 0;
  num? get returnFreightChargeVat => _returnFreightChargeVat;

  num? _codFeeIncludeVat = 0;
  num? get codFeeIncludeVat => _codFeeIncludeVat;

  num? _netAwbAmount = 0;
  num? get netAwbAmount => _netAwbAmount;

  String? _createdDate = "";
  String? get createdDate => _createdDate;

  String? _createdBy = "";
  String? get createdBy => _createdBy;

  String? _lastUpdateDate = "";
  String? get lastUpdateDate => _lastUpdateDate;

  String? _lastUpdateBy = "";
  String? get lastUpdateBy => _lastUpdateBy;

  String? _lastUpdateProcess = "";
  String? get lastUpdateProcess => _lastUpdateProcess;

  AggregationMinusDocModel.fromJson(dynamic json) {
    _aggMinDoc = json["agg_min_doc"];
    _docDate = json["doc_date"];
    _aggPayRef = json["agg_pay_ref"];
    _custGroupId = json["cust_group_id"];
    _custId = json["cust_id"];
    _custName = json["cust_name"];
    _netAggAmount = json["net_agg_amount"];
    _codType = json["cod_type"];
    _payType = json["pay_type"];
    _aggDate = json["agg_date"];
    _cnoteNo = json["cnote_no"];
    _cnoteDate = json["cnote_date"];
    _orderId = json["order_id"];
    _aggPeriod = json["agg_period"];
    _podCode = json["pod_code"];
    _podDateSys = json["pod_date_sys"];
    _shipFee = json["ship_fee"];
    _insuranceCharge = json["insurance_charge"];
    _codFee = json["cod_fee"];
    _returnFee = json["return_fee"];
    _codAmount = json["cod_amount"];
    _discount = json["discount"];
    _freightChargeAfterDisc = json["freight_charge_after_disc"];
    _freightChargeVat = json["freight_charge_vat"];
    _packingFee = json["packing_fee"];
    _surcharge = json["surcharge"];
    _returnFreightChargeAfterDisc = json["return_freight_charge_after_disc"];
    _returnFreightChargeVat = json["return_freight_charge_vat"];
    _codFeeIncludeVat = json["cod_fee_include_vat"];
    _netAwbAmount = json["net_awb_amount"];
    _createdDate = json["created_date"];
    _createdBy = json["created_by"];
    _lastUpdateDate = json["last_update_date"];
    _lastUpdateBy = json["last_update_by"];
    _lastUpdateProcess = json["last_update_process"];
  }
}
