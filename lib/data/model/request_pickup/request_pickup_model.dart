class RequestPickupModel {
  String _awb = "";
  String get awb => _awb;

  String _petugasEntry = "";
  String get petugasEntry => _petugasEntry;

  String _shipperName = "";
  String get shipperName => _shipperName;

  String _shipperCity = "";
  String get shipperCity => _shipperCity;

  String _receiverName = "";
  String get receiverName => _receiverName;

  String _createdDateSearch = "";
  String get createdDateSearch => _createdDateSearch;

  String _apiType = "";
  String get apiType => _apiType;

  String _serviceCode = "";
  String get serviceCode => _serviceCode;

  String _status = "";
  String get status => _status;

  num _qty = 0;
  num get qty => _qty;

  num _weight = 0;
  num get weight => _weight;

  RequestPickupModel.fromJson(dynamic json) {
    _awb = json["awb"];
    _petugasEntry = json["petugasEntry"] ?? "";
    _shipperName = json["shipperName"];
    _shipperCity = json["shipperCity"];
    _receiverName = json["receiverName"];
    _createdDateSearch = json["createdDateSearch"];
    _apiType = json["apiType"];
    _serviceCode = json["serviceCode"];
    _status = json["status"];
    _qty = json["qty"];
    _weight = json["weight"];
  }
}
