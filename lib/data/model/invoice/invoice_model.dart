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
    _invoiceNoEncoded = json["invoiceNo"];
    _invoiceNo = json["invoiceNo"];
    _invoiceDate = json["invoiceDate"];
    _invoiceStartDate = json["invoiceStartDate"];
    _invoiceEndDate = json["invoiceEndDate"];
    _invoiceStatus = json["invoiceStatus"];
    _invoiceTotalAmount = json["invoiceTotalAmount"];
  }
}
