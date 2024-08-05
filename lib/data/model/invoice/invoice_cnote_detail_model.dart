class InvoiceCnoteDetailModel {

  String _awbNumber = "";
  String get awbNumber => _awbNumber;

  String _awbDate = "";
  String get awbDate => _awbDate;

  String _shipperName = "";
  String get shipperName => _shipperName;

  String _consigneeName = "";
  String get consigneeName => _consigneeName;

  int _quantity = 0;
  int get quantity => _quantity;

  int _weightKg = 0;
  int get weightKg => _weightKg;

  String _serviceCode = "";
  String get serviceCode => _serviceCode;

  String _originSysCode = "";
  String get originSysCode => _originSysCode;

  String _originName = "";
  String get originName => _originName;

  String _destinationSysCode = "";
  String get destinationSysCode => _destinationSysCode;

  String _destinationName = "";
  String get destinationName => _destinationName;

  int _originalAmountNumber = 0;
  int get originalAmountNumber => _originalAmountNumber;

  int _packing = 0;
  int get packing => _packing;

  int _surcharge = 0;
  int get surcharge => _surcharge;

  int _otherCharges = 0;
  int get otherCharges => _otherCharges;

  int _discountAmountAwb = 0;
  int get discountAmountAwb => _discountAmountAwb;

  int _totalAdjustedInsAmt = 0;
  int get totalAdjustedInsAmt => _totalAdjustedInsAmt;

  int _goodsValue = 0;
  int get goodsValue => _goodsValue;

  int _codAmount = 0;
  int get codAmount => _codAmount;

  int _persentaseCodFee = 0;
  int get persentaseCodFee => _persentaseCodFee;

  int _codFeeAmount = 0;
  int get codFeeAmount => _codFeeAmount;

  String _codFeeZone = "";
  String get codFeeZone => _codFeeZone;

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