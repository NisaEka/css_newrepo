class RequestPickupFilterModel {
  int _page = 1;
  int get page => _page;

  int _limit = 10;
  int get limit => _limit;

  String _date = "";
  String get date => _date;

  String _pickupStatus = "";
  String get pickupStatus => _pickupStatus;

  String _transactionType = "";
  String get transactionType => _transactionType;

  String _city = "";
  String get city => _city;

  RequestPickupFilterModel(
      {int page = 1,
      int limit = 10,
      String date = "",
      String pickupStatus = "",
      String transactionType = "",
      String city = ""}) {
    _page = page;
    _limit = limit;
    _date = date;
    _pickupStatus = pickupStatus;
    _transactionType = transactionType;
    _city = city;
  }

  setDate(String newDate) {
    _date = newDate;
  }

  setPickupStatus(String newStatus) {
    _pickupStatus = newStatus;
  }

  setTransactionType(String newType) {
    _transactionType = newType;
  }

  setTransactionCity(String newCity) {
    _city = newCity;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['page'] = _page;
    json['limit'] = _limit;
    json['date'] = _date;
    json['pickup_status'] = _pickupStatus;
    json['transaction_type'] = _transactionType;
    json['city'] = _city;

    return json;
  }
}
