class Destination {
  Destination({
    num? id,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subdistrictName,
    String? zipCode,
    String? destinationCode,
    String? status,
    String? facilityCode,
    String? cityZone,
  }) {
    _id = id;
    _countryName = countryName;
    _provinceName = provinceName;
    _cityName = cityName;
    _districtName = districtName;
    _subdistrictName = subdistrictName;
    _zipCode = zipCode;
    _destinationCode = destinationCode;
    _status = status;
    _facilityCode = facilityCode;
    _cityZone = cityZone;
  }

  Destination.fromJson(dynamic json) {
    _id = json['id'];
    _countryName = json['countryName'];
    _provinceName = json['provinceName'];
    _cityName = json['cityName'];
    _districtName = json['districtName'];
    _subdistrictName = json['subdistrictName'];
    _zipCode = json['zipCode'];
    _destinationCode = json['tariffCode'];
    _status = json['status'];
    _facilityCode = json['facilityCode'];
    _cityZone = json['cityZone'];
  }
  num? _id;
  String? _countryName;
  String? _provinceName;
  String? _cityName;
  String? _districtName;
  String? _subdistrictName;
  String? _zipCode;
  String? _destinationCode;
  String? _status;
  String? _facilityCode;
  String? _cityZone;
  Destination copyWith({
    num? id,
    String? countryName,
    String? provinceName,
    String? cityName,
    String? districtName,
    String? subdistrictName,
    String? zipCode,
    String? destinationCode,
    String? status,
    String? facilityCode,
    String? cityZone,
  }) =>
      Destination(
        id: id ?? _id,
        countryName: countryName ?? _countryName,
        provinceName: provinceName ?? _provinceName,
        cityName: cityName ?? _cityName,
        districtName: districtName ?? _districtName,
        subdistrictName: subdistrictName ?? _subdistrictName,
        zipCode: zipCode ?? _zipCode,
        destinationCode: destinationCode ?? _destinationCode,
        status: status ?? _status,
        facilityCode: facilityCode ?? _facilityCode,
        cityZone: cityZone ?? _cityZone,
      );
  num? get id => _id;
  String? get countryName => _countryName;
  String? get provinceName => _provinceName;
  String? get cityName => _cityName;
  String? get districtName => _districtName;
  String? get subdistrictName => _subdistrictName;
  String? get zipCode => _zipCode;
  String? get destinationCode => _destinationCode;
  String? get status => _status;
  String? get facilityCode => _facilityCode;
  String? get cityZone => _cityZone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countryName'] = _countryName;
    map['provinceName'] = _provinceName;
    map['cityName'] = _cityName;
    map['districtName'] = _districtName;
    map['subdistrictName'] = _subdistrictName;
    map['zipCode'] = _zipCode;
    map['tariffCode'] = _destinationCode;
    map['status'] = _status;
    map['facilityCode'] = _facilityCode;
    map['cityZone'] = _cityZone;
    return map;
  }
}
