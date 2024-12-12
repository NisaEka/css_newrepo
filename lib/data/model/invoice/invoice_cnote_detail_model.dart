class InvoiceCnoteDetailModel {
  String? _pickUpOrderId = "";
  String? get picuUpOrderId => _pickUpOrderId;

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
    _awbNumber = json["awbNumber"];
    _awbDate = json["awbDate"];
    _shipperName = json["shipperName"];
    _consigneeName = json["consigneeName"];
    _quantity = json["quantity"];
    _weightKg = json["weightKg"];
    _serviceCode = json["serviceCode"];
    _originSysCode = json["originSysCode"];
    _originName = json["originName"];
    _destinationSysCode = json["destinationSysCode"];
    _destinationName = json["destinationName"];
    _originalAmountNumber = json["originalAmountNumber"];
    _packing = json["packing"];
    _surcharge = json["surcharge"];
    _otherCharges = json["otherCharges"];
    _discountAmountAwb = json["discountAmountAwb"];
    _totalAdjustedInsAmt = json["totalAdjustedInsAmt"];
    _goodsValue = json["goodsValue"];
    _codAmount = json["codAmount"];
    _persentaseCodFee = json["persentaseCodFee"];
    _codFeeAmount = json["codFeeAmount"];
    _codFeeZone = json["codFeeZone"];
    _pickUpOrderId = json["pickUpOrderId"];
  }
}
