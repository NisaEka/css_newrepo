class RequestPickupModel {
  String _awb = "";
  String get awb => _awb;

  String _officerEntry = "";
  String get officerEntry => _officerEntry;

  String _shipperName = "";
  String get shipperName => _shipperName;

  String _shipperCity = "";
  String get shipperCity => _shipperCity;

  String _receiverName = "";
  String get receiverName => _receiverName;

  String _date = "";
  String get date => _date;

  String _type = "";
  String get type => _type;

  String _serviceCode = "";
  String get serviceCode => _serviceCode;

  String _status = "";
  String get status => _status;

  RequestPickupModel.fromJson(dynamic json) {
    _awb = json["awb"];
    _officerEntry = json["officer_entry"];
    _shipperName = json["shipper_name"];
    _shipperCity = json["shipper_city"];
    _receiverName = json["receiver_name"];
    _date = json["date"];
    _type = json["type"];
    _serviceCode = json["service_code"];
    _status = json["status"];
  }
}
