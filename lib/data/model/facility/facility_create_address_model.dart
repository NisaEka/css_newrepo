class FacilityCreateAddressModel {
  String _address = '';
  String get address => _address;

  String _province = '';
  String get province => _province;

  String _city = '';
  String get city => _city;

  String _district = '';
  String get district => _district;

  String _subDistrict = '';
  String get subDistrict => _subDistrict;

  String _zipCode = '';
  String get zipCode => _zipCode;

  String _phone = '';
  String get phone => _phone;

  String _handphone = '';
  String get handphone => _handphone;

  setAddress(String address) {
    _address = address;
  }

  setProvince(String province) {
    _province = province;
  }

  setCity(String city) {
    _city = city;
  }

  setDistrict(String district) {
    _district = district;
  }

  setSubDistrict(String subDistrict) {
    _subDistrict = subDistrict;
  }

  setZipCode(String zipCode) {
    _zipCode = zipCode;
  }

  setPhone(String phone) {
    _phone = phone;
  }

  setHandPhone(String handPhone) {
    _handphone = handPhone;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['address'] = _address;
    json['province'] = _province;
    json['city'] = _city;
    json['district'] = _district;
    json['sub_district'] = _subDistrict;
    json['zip_code'] = _zipCode;
    json['phone'] = _phone;
    json['handphone'] = _handphone;

    return json;
  }
}
