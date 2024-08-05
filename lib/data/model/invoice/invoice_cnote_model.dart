class InvoiceCnoteModel {

  String _awbDate = "";
  String get awbDate => _awbDate;

  String _awbNumber = "";
  String get awbNumber => _awbNumber;

  String _consigneeName = "";
  String get consigneeName => _consigneeName;

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