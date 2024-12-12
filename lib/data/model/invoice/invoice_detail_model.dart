class InvoiceDetailModel {
  String? _invoiceNumberEncoded = "";
  String? get invoiceNumberEncoded => _invoiceNumberEncoded;

  String? _invoiceNumber = "";
  String? get invoiceNumber => _invoiceNumber;

  String? _invoiceDate = "";
  String? get invoiceDate => _invoiceDate;

  String? _invoiceType = "";
  String? get invoiceType => _invoiceType;

  String? _top = "";
  String? get top => _top;

  String? _description = "";
  String? get description => _description;

  String? _dueDate = "";
  String? get dueDate => _dueDate;

  String? _period = "";
  String? get period => _period;

  String? _invoiceStatus = "";
  String? get invoiceStatus => _invoiceStatus;

  String? _invoiceReference = "";
  String? get invoiceReference => _invoiceReference;

  String? _customerId = "";
  String? get customerId => _customerId;

  String? _customerName = "";
  String? get customerName => _customerName;

  String? _address = "";
  String? get address => _address;

  String? _zipCode = "";
  String? get zipCode => _zipCode;

  String? _phone = "";
  String? get phone => _phone;

  String? _email = "";
  String? get email => _email;

  String? _taxNumber = "";
  String? get taxNumber => _taxNumber;

  String? _npwpId = "";
  String? get npwpId => _npwpId;

  String? _npwpName = "";
  String? get npwpName => _npwpName;

  String? _npwpAddress = "";
  String? get npwpAddress => _npwpAddress;

  num? _grossTotal = 0;
  num? get grossTotal => _grossTotal;

  num? _discount = 0;
  num? get discount => _discount;

  num? _reward = 0;
  num? get reward => _reward;

  num? _totalAfterDiscount = 0;
  num? get totalAfterDiscount => _totalAfterDiscount;

  num? _vat = 0;
  num? get vat => _vat;

  num? _commissionFee = 0;
  num? get commissionFee => _commissionFee;

  num? _vatCommissionFee = 0;
  num? get vatCommissionFee => _vatCommissionFee;

  num? _insurance = 0;
  num? get insurance => _insurance;

  num? _stamp = 0;
  num? get stamp => _stamp;

  num? _totalPaid = 0;
  num? get totalPaid => _totalPaid;

  InvoiceDetailModel.fromJson(dynamic json) {
    _invoiceNumberEncoded = json["invoiceNumberEncoded"];
    _invoiceNumber = json["invoiceNumber"];
    _invoiceDate = json["invoiceDate"];
    _top = json["top"];
    _description = json["description"];
    _dueDate = json["dueDate"];
    _period = json["period"];
    _invoiceStatus = json["invoiceStatus"];
    _invoiceReference = json["invoiceReferencee"];
    _customerId = json["customerId"];
    _customerName = json["customerName"];
    _address = json["address"];
    _zipCode = json["zipCode"];
    _phone = json["phone"];
    _email = json["email"];
    _taxNumber = json["taxNumber"];
    _npwpId = json["npwpId"];
    _npwpName = json["npwpName"];
    _npwpAddress = json["npwpAddress"];
    _grossTotal = json["grossTotal"] ?? 0;
    _discount = json["discount"] ?? 0;
    _reward = json["reward"] ?? 0;
    _totalAfterDiscount = json["totalAfterDiscount"] ?? 0;
    _vat = json["vat"] ?? 0;
    _commissionFee = json["commissionFee"] ?? 0;
    _vatCommissionFee = json["vatCommissionFee"] ?? 0;
    _insurance = json["insurance"] ?? 0;
    _stamp = json["stamp"] ?? 0;
    _totalPaid = json["totalPaid"] ?? 0;
    _invoiceType = json["invoiceType"] ?? 0;
  }
}
