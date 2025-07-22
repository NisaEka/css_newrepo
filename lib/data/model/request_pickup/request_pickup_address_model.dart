class RequestPickupAddressModel {
  String _pickupDataId = "";
  String get pickupDataId => _pickupDataId;

  String _pickupDataName = "";
  String get pickupDataName => _pickupDataName;

  String _pickupDataPhone = "";
  String get pickupDataPhone => _pickupDataPhone;

  String _pickupDataAddress = "";
  String get pickupDataAddress => _pickupDataAddress;

  String _pickupDataZipCode = "";
  String get pickupDataZipCode => _pickupDataZipCode;

  String _pickupDataSubdistrict = "";
  String get pickupDataSubdistrict => _pickupDataSubdistrict;

  String _pickupDataDistrict = "";
  String get pickupDataDistrict => _pickupDataDistrict;

  String _pickupDataCity = "";
  String get pickupDataCity => _pickupDataCity;

  String _pickupDataRegion = "";
  String get pickupDataRegion => _pickupDataRegion;

  String _pickupDataLatitude = "";
  String get pickupDataLatitude => _pickupDataLatitude;

  String _pickupDataLongitude = "";
  String get pickupDataLongitude => _pickupDataLongitude;

  RequestPickupAddressModel.fromJson(dynamic json) {
    _pickupDataId = json["pickupDataId"];
    _pickupDataName = json["pickupDataName"];
    _pickupDataPhone = json["pickupDataPhone"];
    _pickupDataAddress = json["pickupDataAddress"];
    _pickupDataZipCode = json["pickupDataZipCode"];
    _pickupDataSubdistrict = json["pickupDataSubdistrict"];
    _pickupDataDistrict = json["pickupDataDistrict"];
    _pickupDataCity = json["pickupDataCity"];
    _pickupDataRegion = json["pickupDataRegion"];
    _pickupDataLatitude = json["pickupDataLatitude"] ?? "";
    _pickupDataLongitude = json["pickupDataLongitude"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["pickupDataId"] = _pickupDataId;
    map["pickupDataName"] = _pickupDataName;
    map["pickupDataPhone"] = _pickupDataPhone;
    map["pickupDataAddress"] = _pickupDataAddress;
    map["pickupDataZipCode"] = _pickupDataZipCode;
    map["pickupDataSubdistrict"] = _pickupDataSubdistrict;
    map["pickupDataDistrict"] = _pickupDataDistrict;
    map["pickupDataCity"] = _pickupDataCity;
    map["pickupDataRegion"] = _pickupDataRegion;
    map["pickupDataLatitude"] = _pickupDataLatitude;
    map["pickupDataLongitude"] = _pickupDataLongitude;
    return map;
  }
}
