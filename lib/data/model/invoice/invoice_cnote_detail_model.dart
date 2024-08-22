class InvoiceCnoteDetailModel {

  String? _awbNumber = "";
  String? get awbNumber => _awbNumber;

  String? _awbDate = "";
  String? get awbDate => _awbDate;

  String? _shipperName = "";
  String? get shipperName => _shipperName;

  String? _consigneeName = "";
  String? get consigneeName => _consigneeName;

  num? _quantity = 0;
  num? get quantity => _quantity;

  num? _weightKg = 0;
  num? get weightKg => _weightKg;

  String? _serviceCode = "";
  String? get serviceCode => _serviceCode;

  String? _originSysCode = "";
  String? get originSysCode => _originSysCode;

  String? _originName = "";
  String? get originName => _originName;

  String? _destinationSysCode = "";
  String? get destinationSysCode => _destinationSysCode;

  String? _destinationName = "";
  String? get destinationName => _destinationName;

  num? _originalAmountNumber = 0;
  num? get originalAmountNumber => _originalAmountNumber;

  num? _packing = 0;
  num? get packing => _packing;

  num? _surcharge = 0;
  num? get surcharge => _surcharge;

  num? _otherCharges = 0;
  num? get otherCharges => _otherCharges;

  num? _discountAmountAwb = 0;
  num? get discountAmountAwb => _discountAmountAwb;

  num? _totalAdjustedInsAmt = 0;
  num? get totalAdjustedInsAmt => _totalAdjustedInsAmt;

  num? _goodsValue = 0;
  num? get goodsValue => _goodsValue;

  num? _codAmount = 0;
  num? get codAmount => _codAmount;

  num? _persentaseCodFee = 0;
  num? get persentaseCodFee => _persentaseCodFee;

  num? _codFeeAmount = 0;
  num? get codFeeAmount => _codFeeAmount;

  String? _codFeeZone = "";
  String? get codFeeZone => _codFeeZone;

  InvoiceCnoteDetailModel.fromJson(dynamic json) {
    _awbNumber = json["awb_number"];
    _awbDate = json["awb_date"];
    _shipperName = json["shipper_name"];
    _consigneeName = json["consignee_name"];
    _quantity = json["quantity"];
    _weightKg = json["weight_kg"];
    _serviceCode = json["service_code"];
    _originSysCode = json["origin_sys_code"];
    _originName = json["origin_name"];
    _destinationSysCode = json["destination_sys_code"];
    _destinationName = json["destination_name"];
    _originalAmountNumber = json["original_amount_number"];
    _packing = json["packing"];
    _surcharge = json["surcharge"];
    _otherCharges = json["other_charges"];
    _discountAmountAwb = json["discount_amount_awb"];
    _totalAdjustedInsAmt = json["total_adjusted_ins_amt"];
    _goodsValue = json["goods_value"];
    _codAmount = json["cod_amount"];
    _persentaseCodFee = json["persentase_cod_fee"];
    _codFeeAmount = json["cod_fee_amount"];
    _codFeeZone = json["cod_fee_zone"];
  }

}