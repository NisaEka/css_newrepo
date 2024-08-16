class InvoiceCnoteModel {

  String? _awbDate = "";
  String? get awbDate => _awbDate;

  String? _awbNumber = "";
  String? get awbNumber => _awbNumber;

  String? _consigneeName = "";
  String? get consigneeName => _consigneeName;

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

  InvoiceCnoteModel.fromJson(dynamic json) {
    _awbDate = json["awb_date"];
    _awbNumber = json["awb_number"];
    _consigneeName = json["consignee_name"];
    _originalAmountNumber = json["original_amount_number"];
    _packing = json["packing"];
    _surcharge = json["surcharge"];
    _otherCharges = json["other_charges"];
    _discountAmountAwb = json["discount_amount_awb"];
    _totalAdjustedInsAmt = json["total_adjusted_ins_amt"];
  }

}