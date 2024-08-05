class InvoiceDetailModel {

  String _invoiceNumber = "";
  String get invoiceNumber => _invoiceNumber;

  String _invoiceDate = "";
  String get invoiceDate => _invoiceDate;

  String _top = "";
  String get top => _top;

  String _description = "";
  String get description => _description;

  String _dueDate = "";
  String get dueDate => _dueDate;

  String _period = "";
  String get period => _period;

  String _invoiceStatus = "";
  String get invoiceStatus => _invoiceStatus;

  String _invoiceReference = "";
  String get invoiceReference => _invoiceReference;

  String _customerId = "";
  String get customerId => _customerId;

  String _customerName = "";
  String get customerName => _customerName;

  String _address = "";
  String get address => _address;

  String _zipCode = "";
  String get zipCode => _zipCode;

  String _phone = "";
  String get phone => _phone;

  String _email = "";
  String get email => _email;

  String _taxNumber = "";
  String get taxNumber => _taxNumber;

  String _npwpId = "";
  String get npwpId => _npwpId;

  String _npwpName = "";
  String get npwpName => _npwpName;

  String _npwpAddress = "";
  String get npwpAddress => _npwpAddress;

  int _grossTotal = 0;
  int get grossTotal => _grossTotal;

  int _discount = 0;
  int get discount => _discount;

  int _reward = 0;
  int get reward => _reward;

  int _totalAfterDiscount = 0;
  int get totalAfterDiscount => _totalAfterDiscount;

  int _vat = 0;
  int get vat => _vat;

  int _commissionFee = 0;
  int get commissionFee => _commissionFee;

  int _vatCommissionFee = 0;
  int get vatCommissionFee => _vatCommissionFee;

  int _insurance = 0;
  int get insurance => _insurance;

  int _stamp = 0;
  int get stamp => _stamp;

  int _totalPaid = 0;
  int get totalPaid => _totalPaid;

  InvoiceDetailModel.fromJson(dynamic json) {
    _invoiceNumber = json["invoice_number"];
    _invoiceDate = json["invoice_date"];
    _top = json["top"];
    _description = json["description"];
    _dueDate = json["due_date"];
    _period = json["period"];
    _invoiceStatus = json["invoice_status"];
    _invoiceReference = json["invoice_referencee"];
    _customerId = json["customer_id"];
    _customerName = json["customer_name"];
    _address = json["address"];
    _zipCode = json["zip_code"];
    _phone = json["phone"];
    _email = json["email"];
    _taxNumber = json["tax_number"];
    _npwpId = json["npwp_id"];
    _npwpName = json["npwp_name"];
    _npwpAddress = json["npwp_address"];
    _grossTotal = json["gross_total"];
    _discount = json["discount"];
    _reward = json["reward"];
    _totalAfterDiscount = json["total_after_discount"];
    _vat = json["vat"];
    _commissionFee = json["commission_fee"];
    _vatCommissionFee = json["vat_commission_fee"];
    _insurance = json["insurance"];
    _stamp = json["stamp"];
    _totalPaid = json["total_paid"];
  }

}