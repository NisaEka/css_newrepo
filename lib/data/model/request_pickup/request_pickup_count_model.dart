class RequestPickupCountModel {
  String _status = "";
  String get status => _status;

  num _count = 0;
  num get count => _count;

  RequestPickupCountModel.fromJson(dynamic json) {
    _status = json["status"];
    _count = json["count"];
  }
}
