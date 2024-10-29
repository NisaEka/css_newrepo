class Dropshipper {
  Dropshipper({
    String? id,
    String? name,
    String? phone,
    String? zipCode,
    String? city,
    String? address,
    String? registrationId,
    String? createdDate,
    String? originCode,
  }) {
    _id = id;
    _name = name;
    _phone = phone;
    _zipCode = zipCode;
    _city = city;
    _address = address;
    _registrationId = registrationId;
    _createdDate = createdDate;
    _originCode = originCode;
  }

  Dropshipper.fromJson(dynamic json) {
    _id = json['dropshipperId'];
    _name = json['dropshipperName'];
    _phone = json['dropshipperPhone'];
    _zipCode = json['dropshipperZip'];
    _city = json['dropshipperCity'];
    _address = json['dropshipperAddress'];
    _registrationId = json['registrationId'];
    _createdDate = json['createdDate'];
    _originCode = json['dropshipperOrigin'];
  }

  String? _id;
  String? _name;
  String? _phone;
  String? _zipCode;
  String? _city;
  String? _address;
  String? _registrationId;
  String? _createdDate;
  String? _originCode;

  Dropshipper copyWith({
    String? id,
    String? name,
    String? phone,
    String? zipCode,
    String? city,
    String? address,
    String? registrationId,
    String? createdDate,
    String? originCode,
  }) =>
      Dropshipper(
        id: id ?? _id,
        name: name ?? _name,
        phone: phone ?? _phone,
        zipCode: zipCode ?? _zipCode,
        city: city ?? _city,
        address: address ?? _address,
        registrationId: registrationId ?? _registrationId,
        createdDate: createdDate ?? _createdDate,
        originCode: originCode ?? _originCode,
      );

  String? get id => _id;

  String? get name => _name;

  String? get phone => _phone;

  String? get zipCode => _zipCode;

  String? get city => _city;

  String? get address => _address;

  String? get registrationId => _registrationId;

  String? get createdDate => _createdDate;

  String? get originCode => _originCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dropshipperId'] = _id;
    map['dropshipperName'] = _name;
    map['dropshipperPhone'] = _phone;
    map['dropshipperZip'] = _zipCode;
    map['dropshipperCity'] = _city;
    map['dropshipperAddress'] = _address;
    map['registrationId'] = _registrationId;
    map['createdDate'] = _createdDate;
    map['dropshipperOrigin'] = _originCode;
    return map;
  }
}
