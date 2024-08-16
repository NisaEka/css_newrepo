class InvoiceModel {

  String? _invoiceNoEncoded = "";
  String? get invoiceNoEncoded => _invoiceNoEncoded;

  String? _invoiceNo = "";
  String? get invoiceNo => _invoiceNo;

  String? _invoiceDate = "";
  String? get invoiceDate => _invoiceDate;

  String? _invoiceStartDate = "";
  String? get invoiceStartDate => _invoiceStartDate;

  String? _invoiceEndDate = "";
  String? get invoiceEndDate => _invoiceEndDate;

  String? _invoiceStatus = "";
  String? get invoiceStatus => _invoiceStatus;

  num _invoiceTotalAmount = 0;
  num get invoiceTotalAmount => _invoiceTotalAmount;

  InvoiceModel.fromJson(dynamic json) {
    _invoiceNoEncoded = json["invoice_number_encoded"];
    _invoiceNo = json["invoice_number"];
    _invoiceDate = json["invoice_date"];
    _invoiceStartDate = json["invoice_start_date"];
    _invoiceEndDate = json["invoice_end_date"];
    _invoiceStatus = json["invoice_status"];
    _invoiceTotalAmount = json["invoice_total_amount"];
  }

}