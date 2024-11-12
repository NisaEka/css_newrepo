class FacilityCreateExistingModel {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _facilityType = '';

  FacilityCreateExistingModel(
      {String name = '',
      String email = '',
      String phone = '',
      String facilityType = ''}) {
    _name = name;
    _email = email;
    _phone = phone;
    _facilityType = facilityType;
  }

  setName(String name) {
    _name = name;
  }

  setEmail(String email) {
    _email = email;
  }

  setPhone(String phone) {
    _phone = phone;
  }

  setFacilityType(String facilityType) {
    _facilityType = facilityType;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = _name;
    json['email'] = _email;
    json['phone'] = _phone;
    json['facility_type'] = _facilityType;
    return json;
  }
}
