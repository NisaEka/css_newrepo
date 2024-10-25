class RequestPickupAddressModel {
  String _id = "";
  String get id => _id;

  String _name = "";
  String get name => _name;

  String _phone = "";
  String get phone => _phone;

  String _address = "";
  String get address => _address;

  String _zipCode = "";
  String get zipCode => _zipCode;

  String _subDistrict = "";
  String get subDistrict => _subDistrict;

  String _district = "";
  String get district => _district;

  String _city = "";
  String get city => _city;

  String _region = "";
  String get region => _region;

  num _lat = 0.0;
  num get lat => _lat;

  num _lng = 0.0;
  num get lng => _lng;

  RequestPickupAddressModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
    _zipCode = json["zip_code"];
    _subDistrict = json["sub_district"];
    _district = json["district"];
    _city = json["city"];
    _region = json["region"];
    _lat = json["lat"];
    _lng = json["lng"];
  }
}
