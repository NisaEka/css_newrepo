class FacilityCreateAddressModel {
  String _address = '';

  String get address => _address;

  String _country = '';

  String get country => _country;

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

  FacilityCreateAddressModel({
    String? address,
    String? country,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? handphone,
  }) {
    _address = address ?? '';
    _country = country ?? '';
    _province = province ?? '';
    _city = city ?? '';
    _district = district ?? '';
    _subDistrict = subDistrict ?? '';
    _zipCode = zipCode ?? '';
    _phone = phone ?? '';
    _handphone = handphone ?? '';
  }

  setAddress(String address) {
    _address = address;
  }

  setCountry(String country) {
    _country = country;
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
    json['country'] = _country;
    json['province'] = _province;
    json['city'] = _city;
    json['district'] = _district;
    json['subDistrict'] = _subDistrict;
    json['zipCode'] = _zipCode;
    json['phone'] = _phone;
    json['handphone'] = _handphone;

    return json;
  }

  FacilityCreateAddressModel.fromJson(dynamic json) {
    _address = json['address'];
    _country = json['country'];
    _province = json['province'];
    _city = json['city'];
    _district = json['district'];
    _subDistrict = json['subDistrict'];
    _zipCode = json['zipCode'];
    _phone = json['phone'];
    _handphone = json['handphone'];
  }
}
