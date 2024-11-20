class RequestPickupCreateResponseModel {
  int _successCount = 0;
  int get successCount => _successCount;

  int _errorCount = 0;
  int get errorCount => _errorCount;

  List<RequestPickupCreateErrorDetailsResponseModel> _errorDetails = [];
  List<RequestPickupCreateErrorDetailsResponseModel> get errorDetails =>
      _errorDetails;

  RequestPickupCreateResponseModel.fromJson(dynamic json) {
    _successCount = json["successCount"];
    _errorCount = json["errorCount"];
    if (json['errorDetails'] != null) {
      _errorDetails = (json['errorDetails'] as List)
          .map((e) => RequestPickupCreateErrorDetailsResponseModel.fromJson(e))
          .toList();
    }
  }
}

class RequestPickupCreateErrorDetailsResponseModel {
  String _awb = "";
  String get awb => _awb;

  String _status = "";
  String get status => _status;

  String _reason = "";
  String get reason => _reason;

  RequestPickupCreateErrorDetailsResponseModel.fromJson(dynamic json) {
    _awb = json["awb"];
    _status = json["status"];
    _reason = json["reason"];
  }
}
